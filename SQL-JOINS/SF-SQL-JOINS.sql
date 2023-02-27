
--   18. SF -  SQL - 4 - Joins in SF.ppt

-- inner join in Snowflake

/*  Inner join, joins two table according to ON condition. 
	If inner join is used without ON clause or using comma without WHERE clause then the result will be cross join.
	Inner join will joins the common data which should present in both the tables.*/
	
	CREATE OR REPLACE TABLE Customer (id number, name varchar(30));
	
	INSERT INTO customer(id, name) values(1,	'JOHN'),
																		  (2,	'STEVEN'),
																		   (3,	'DISHA'),
																		   (4,	'JEEVAN');
																		   
	CREATE OR REPLACE TABLE profession (id number, profession_desc varchar(50));
	
	INSERT INTO customer(id, profession_desc ) values (1,	'PRIVATE EMPLOYEE'), 
																							(2,	'ARTIST'),
																							(5,	'GOVERNMENT EMPLOYEE');
	--Statement : 
SELECT  T1.ID,T1.name,T2.profession_desc FROM customer T1 INNER JOIN profession T2 ON T1.ID=T2.ID

--    left join in snowflake

SELECT  T1.ID,T1.NAME,T2.profession_desc FROM customer T1 LEFT JOIN profession T2 ON T1.ID=T2.ID;

--  Right Outer Join in Snowflake

--Statement : 
SELECT  T1.ID,T1.NAME,T2.profession_desc FROM CUSTOMER T1 RIGHT JOIN profession T2 ON T1.ID=T2.ID;

-- Full Outer Join in Snowflake

--SQL Statement : 
SELECT  T1.ID,T1.NAME,T2.profession_desc FROM Customer T1 FULL OUTER JOIN Profession T2 ON T1.ID=T2.ID;

--  Cross Join in Snowflake

--SQL Statement : 
SELECT  T1.ID,T1.NAME,T2.profession_desc FROM Customer T1 CROSS JOIN  Profession T2;

--  Natural Join in snowflake

--Statement : 
SELECT  T1.ID,T1.NAME,T2.profession_desc FROM T1 NATURAL JOIN T2;

--  Lateral Join in Snowflake

CREATE TABLE departments (department_id INTEGER, name VARCHAR);
CREATE TABLE employees (employee_ID INTEGER, last_name VARCHAR, 
                        department_ID INTEGER, project_names ARRAY);
						
INSERT INTO departments (department_ID, name) VALUES      (1, 'Engineering'),     (2, 'Support');
INSERT INTO employees (employee_ID, last_name, department_ID) VALUES     (101, 'Richards', 1),    (102, 'Paulson',  1),    (103, 'Johnson',  2); 

--Statement : 
SELECT * 
    FROM departments AS d, LATERAL (SELECT * FROM employees AS e WHERE e.department_ID = d.department_ID) AS iv2
    ORDER BY employee_ID;
	
	--   using LATERAL with FLATTEN()
	-- This example shows how a lateral join can use the inline view returned by FLATTEN:
	--   SELECT * FROM table1, LATERAL FLATTEN(...);
	
	-- First, update the employee table to include ARRAY data that FLATTEN can operate on:
	UPDATE employees SET project_names = ARRAY_CONSTRUCT('Materialized Views', 'UDFs') 
    WHERE employee_ID = 101;
UPDATE employees SET project_names = ARRAY_CONSTRUCT('Materialized Views', 'Lateral Joins')
    WHERE employee_ID = 102;
	
	--   Second, execute a query that uses FLATTEN and contains a reference to a column(s) in a table that precedes it:
	
	SELECT emp.employee_ID, emp.last_name, index, value AS project_name
    FROM employees AS emp, LATERAL FLATTEN(INPUT => emp.project_names) AS proj_names
    ORDER BY employee_ID;
	
	/*  The following SQL statements are equivalent and produce the same output (the output is shown only once below). 
	The first SQL statement below uses a comma before the keyword LATERAL while the second SQL statement uses the keywords INNER JOIN.    */
	
	-- 1
	SELECT * 
    FROM departments AS d, LATERAL (SELECT * FROM employees AS e WHERE e.department_ID = d.department_ID) AS iv2
    ORDER BY employee_ID;
	--  2
	SELECT * 
    FROM departments AS d INNER JOIN LATERAL (SELECT * FROM employees AS e WHERE e.department_ID = d.department_ID) AS iv2
    ORDER BY employee_ID;



