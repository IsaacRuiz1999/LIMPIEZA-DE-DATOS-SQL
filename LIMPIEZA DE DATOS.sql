create database clean_project;

use clean_project;

select * from inventario;


ALTER TABLE inventario CHANGE COLUMN `ï»¿Id?empleado` id_emp varchar (20) null;
ALTER TABLE inventario CHANGE COLUMN `gÃ©nero` gender  varchar (20) null;


select id_emp, COUNT(*) as id_duplicados
from inventario
GROUP BY id_emp
HAVING COUNT(*) > 1;

select COUNT(*) as id_duplicados
from (
select id_emp, COUNT(*) as id_duplicados
from inventario
GROUP BY id_emp
HAVING COUNT(*) > 1
) as subquery;

RENAME TABLE inventario TO duplicados;

CREATE TEMPORARY TABLE temp_limp AS
SELECT DISTINCT * FROM duplicados;

SELECT COUNT(*) FROM duplicados;
SELECT COUNT(*) FROM temp_limp;

CREATE TABLE inventario AS SELECT * FROM temp_limp;

DROP TABLE duplicados;


SET sql_safe_updates = 0;


ALTER TABLE inventario CHANGE COLUMN Apellido Last_n varchar (50) null;
ALTER TABLE inventario CHANGE COLUMN star_date Start_date  varchar (50) null;



SELECT NAME FROM inventario
WHERE length(NAME) - length(trim(name)) >0;

SELECT name, trim(name) AS name
FROM inventario
WHERE length(NAME) - length(trim(name)) >0;

UPDATE inventario SET NAME = TRIM(NAME)
WHERE length(NAME) - length(trim(name)) >0;

SELECT last_n, trim(last_n) AS last_name
FROM inventario
WHERE length(last_n) - length(trim(last_n)) >0;

UPDATE inventario SET last_n = TRIM(last_n)
WHERE length(last_n) - length(trim(last_n)) >0;



SELECT gender,
CASE
	when gender = 'hombre' then 'male'
    when gender = 'mujer' then 'female'
    else 'other'
END AS gender1
from inventario;

UPDATE inventario SET GENDER = CASE
	when gender = 'hombre' then 'male'
    when gender = 'mujer' then 'female'
    else 'other'
END;



ALTER TABLE inventario MODIFY COLUMN type text;

SELECT type,
CASE
	WHEN TYPE = 0 THEN 'HYBRID'
    WHEN TYPE = 1 THEN 'REMOTE'
    ELSE 'OTHER'
END AS type1
from inventario;

UPDATE inventario
SET TYPE = CASE
	WHEN TYPE = 0 THEN 'HYBRID'
    WHEN TYPE = 1 THEN 'REMOTE'
    ELSE 'OTHER'
END;




select salary, 
	CAST(trim(replace(replace(salary, '$',''), ',','')) as decimal (15,2)) AS salary1 
from inventario;

UPDATE inventario set salary = CAST(trim(replace(replace(salary, '$',''), ',','')) as decimal (15,2));
	
alter table inventario modify column salary int null;

describe inventario;

select * from inventario;




ALTER TABLE inventario ADD COLUMN new_birth_date DATE;

UPDATE inventario
SET new_birth_date = STR_TO_DATE(birth_date, '%m/%d/%Y');

SELECT birth_date, new_birth_date FROM inventario;

ALTER TABLE inventario DROP COLUMN birth_date;

ALTER TABLE inventario CHANGE COLUMN new_birth_date birth_date DATE;

ALTER TABLE inventario MODIFY COLUMN birth_date DATE AFTER last_n;




ALTER TABLE inventario ADD COLUMN  star_date_1 DATE;

UPDATE inventario
SET star_date_1 = STR_TO_DATE(star_date, '%m/%d/%Y');

SELECT star_date, star_date_1 FROM inventario;

ALTER TABLE inventario DROP COLUMN star_date;

ALTER TABLE inventario CHANGE COLUMN star_date_1 start_date DATE;

ALTER TABLE inventario MODIFY COLUMN start_date DATE AFTER salary;





ALTER TABLE inventario ADD COLUMN finish DATEtime;

SELECT finish_date
FROM inventario
WHERE STR_TO_DATE(finish_date, '%m/%d/%Y %H:%i:%s') IS NULL
OR finish_date = '';

UPDATE inventario
SET finish_date = TRIM(REPLACE(finish_date, ' UTC', ''))
WHERE finish_date LIKE '% UTC';

UPDATE inventario
SET finish_date = NULL
WHERE finish_date = '';





UPDATE inventario
SET finish_date = TRIM(finish_date)
WHERE finish_date IS NOT NULL AND finish_date != '';


UPDATE inventario
SET finish_date = REPLACE(finish_date, ' UTC', '')
WHERE finish_date LIKE '% UTC';



select * from inventario;

UPDATE inventario
SET finish = STR_TO_DATE(finish_date, '%Y-%m-%d %H:%i:%s')
WHERE finish_date IS NOT NULL AND finish_date != ''
AND STR_TO_DATE(finish_date, '%Y-%m-%d %H:%i:%s') IS NOT NULL;

describe inventario;

alter table inventario drop column finish_date;

alter table inventario change column finish finish_date datetime;

alter table inventario modify column finish_date DATETIME after Start_date;

select * from inventario;



alter table inventario add column Age int;

UPDATE inventario 
set age = timestampdiff(year, birth_date, curdate());


Select concat(substring_index(name,' ',1), '_', substring(last_n,1,2),'.',substring(type,1,1),'@worker.com') AS Email from inventario;

Alter table inventario add column Email varchar (100);

update inventario set Email = concat(substring_index(name,' ',1), '_', substring(last_n,1,2),'.',substring(type,1,1),'@worker.com');


ALTER TABLE INVENTARIO DROP COLUMN promotion_date;


SELECT *
FROM inventario
order by area, name;
