-- check current context --

select current_schema();
select current_warehouse();
select current_database();

--- Creating database orders ---

CREATE OR REPLACE DATABASE TEST_DB;
CREATE OR REPLACE SCHEMA TEST_SCH;

-- current context  ---

use TEST_DB;
USE TEST_SCH;

SELECT CURRENT_SCHEMA();

-- create SALESMAN Table --

CREATE OR REPLACE TABLE SALESMAN(salesman_id number, name Varchar(15),city Varchar(10),commission float(7));

-- Check columns--
desc table SALESMAN;

-- delete all rows from SALESMAN TABLE  ---

truncate table salesman;

-- insert data into salesman ---
INSERT INTO SALESMAN (salesman_id,name,city,commission) VALUES (5001,'James Hoog', 'New York', 0.15);
INSERT INTO SALESMAN (salesman_id,name,city,commission) VALUES (5002,'Nail Knite', 'Paris', 0.13);
INSERT INTO SALESMAN (salesman_id,name,city,commission) VALUES (5005,'Pit Alex', 'London', 0.11);
INSERT INTO SALESMAN (salesman_id,name,city,commission) VALUES (5006,'Mc Lyon', 'Paris', 0.14);
INSERT INTO SALESMAN (salesman_id,name,city,commission) VALUES (5003,'Lauson Hen', '', 0.12);
INSERT INTO SALESMAN (salesman_id,name,city,commission) VALUES (5007,'Paul Adam', 'Rome', 0.13);


-- View the data in SALESMAN  --

select * from TEST_DB.TEST_SCH.salesman;

--SELECT * FROM SALESMAN;

-- Create Customer tables  ---

CREATE OR REPLACE TABLE CUSTOMER(customer_id Number,customer_name varchar(15),city varchar(10),grade number, salesman_id number);

-- show customer table columns  --

DESC table CUSTOMER;

-- Insert data into Customer---

INSERT INTO CUSTOMER (customer_id,customer_name,city,grade, salesman_id)  VALUES (3002,'Nick Rimando', 'New York',100, 5001);
INSERT INTO CUSTOMER (customer_id,customer_name,city,grade, salesman_id)  VALUES (3005,'Graham Zusi', 'California',200, 5002);
INSERT INTO CUSTOMER (customer_id,customer_name,city) VALUES (3001,'Brad Guzan', 'London');
INSERT INTO CUSTOMER (customer_id,customer_name,city,grade, salesman_id) VALUES (3004,'Fabian Johns', 'Paris',300, 5006);
INSERT INTO CUSTOMER (customer_id,customer_name,city,grade, salesman_id) VALUES (3007,'Brad Davis', 'New York',200, 5001);
INSERT INTO CUSTOMER (customer_id,customer_name,city,grade) VALUES (3009,'Geoff Camero', 'Berlin',100);
INSERT INTO CUSTOMER (customer_id,customer_name,city,grade, salesman_id) VALUES (3008,'Julian Green', 'London',300, 5002);
INSERT INTO CUSTOMER (customer_id,customer_name,city,grade, salesman_id) VALUES (3003,'Jozy Altidor', 'Moncow',200, 5007);

select * from customer;

-- Create Order Table  ---

CREATE OR REPLACE TABLE ORDERS(order_no Number,purch_amt numeric,order_date datetime,customer_id number, salesman_id number);

-- SHOW table ORDERS COLUMNS --

DESC table ORDERS;

truncate table orders;

-- INSERT values into ORDERS Table ---

INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id, salesman_id)  VALUES (70001,150.5, '2016-10-05',3005, 5002);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id)  VALUES (70009,270.65, '2016-09-10',3001);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id, salesman_id) VALUES (70002,65.26, '2016-10-05',3002, 5001);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id) VALUES (70004,110.5, '2016-08-17',3009);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id, salesman_id) VALUES (70007,948.5, '2016-09-10',3005, 5002);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id, salesman_id) VALUES (70005,2400.6, '2016-07-27',3007, 5001);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id, salesman_id) VALUES (70008,5760, '2016-09-10',3002, 5001);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id, salesman_id) VALUES (70010,1983.43, '2016-10-10',3004, 5006);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id) VALUES (70003,2480.4, '2016-10-10',3009);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id, salesman_id) VALUES (70012,250.45, '2016-06-27',3008, 5002);
INSERT INTO ORDERS (order_no,purch_amt,order_date,customer_id, salesman_id) VALUES (70012,75.29, '2016-08-17',3003, 5007);

-- QUERIES---

-- 1.  Display name and commission of all the salesmen
select name, commission from SALESMAN;

-- 2. Retrieve salesman id of all salesmen from orders table without any repeats.

select distinct salesman_id from ORDERS;


-- 3. Display names and city of salesman, who belongs to the city of Paris.

select name, city from salesman where city = 'Paris';

-- Query 4
-- Display all the information for those customers with a grade of 200.

select *from customer where grade = 200;

-- Query 5
-- Display the order number, order date and the purchase amount for order(s) which will be delivered by
--  the salesman with ID 5001.

select order_no, order_date,purch_amt from orders where salesman_id= 5001;

-- Create table noble_winner  ---

create or replace table noblewinner(year number,subject varchar(15),winner varchar(15),country VARCHAR(10),category varchar(10));  

-- show colums in noblewinner ---

desc table noblewinner;

alter table noblewinner modify winner varchar(25);

-- insert values into table noble winner

insert into noblewinner(year, subject,winner,country,category) values (1970, 'physics', 'Louis Neel','France', 'Scientist');
insert into noblewinner(year, subject,winner,country,category) values (1970, 'physics', 'Hannes Alfven','Sweden', 'Scientist');
insert into noblewinner(year, subject,winner,country,category) values (1970, 'Economics', 'Simon Kuznets','Russia', 'Scientist');
insert into noblewinner(year,subject,winner,country,category) values (1970, 'Chemistry','Luis Federico Leloir', 'France', 'Scientist');
insert into noblewinner(year, subject,winner,country,category) values (1970, 'Literature', 'Aleksandr Solzhenitsyn', 'Russia', 'Linguist');
insert into noblewinner(year, subject,winner,country,category) values (1994, 'Literature', 'Kenzaburo Oe', 'Japan','Linguist');
insert into noblewinner(year, subject,winner,country,category) values (1994, 'Economics', 'Reinhard Selten', 'Germany', 'Economist');
insert into noblewinner(year, subject,winner,country,category) values (1987, 'Chemistry', 'Donald J. Cram', 'USA', 'Scientist');
insert into noblewinner(year, subject,winner,country,category) values (1987, 'Chemistry', 'Jean-Marie Lehn', 'France', 'Scientist');
insert into noblewinner(year, subject,winner,country,category) values (1987, 'Literature', 'Joseph Brodsky', 'Russia', 'Linguist');
insert into noblewinner(year, subject,winner,country,category) values (1987, 'Economics', 'Robert Solow', 'USA', 'Economist');
insert into noblewinner(year, subject,winner,country,category) values (1971, 'Chemistry', 'Gerhard Herzberg', 'Germany', 'Scientist');
insert into noblewinner(year, subject,winner,country,category) values (1971, 'Literature', 'Pablo Neruda', 'Chile','Linguist');
insert into noblewinner(year, subject,winner,country,category) values (1971, 'Economics', 'Simon Kuznets', 'Russia', 'Economist');
insert into noblewinner(year, subject,winner,country,category) values (1970, 'Literature', 'Aleksandr Solzhenitsyn', 'Russia', 'Linguist');
insert into noblewinner(year, subject,winner,country,category) values (1970, 'Chemistry Luis','Federico Leloir', 'France', 'Scientist');
insert into noblewinner(year, subject,winner,country,category) values (1970, 'Economics Paul','Samuelson', 'USA', 'Economist');




-- 6. • Show the winner of the 1971 prize for Literature.--


select winner from noblewinner where year = 1971 and subject = 'Literature';


-- 7. • Show all the details of the winners with first name Louis.--

select * from noblewinner where winner like 'Louis%';

-- 8.Show all the winners in Physics for 1970 together with the winner of Economics for 1971

select * from noblewinner where (subject ='physics' and year = 1970)
UNION
(select * from noblewinner where (subject = 'Economics' and year = 1971));


-- Show all the winners of Nobel prize in the year 1970 except the subject Physics and Economics

select * from noblewinner where year =1970 
AND subject not in ('physics','economics');

-- 10. Find all the details of the Nobel winners for the subject not started with the letter 'P' and arranged
--the list as the most recent comes first, then by name in order.
-- year subject winner country category

select * from noblewinner where subject not like 'p%' order by year desc, winner;

-- Create ITEM MASTER Table  ---

CREATE OR REPLACE TABLE ITEM_MAST(pro_no number,pro_name varchar(15),pro_price float);

-- insert values in item_mast    --
--

insert into item_mast(pro_no,pro_name,pro_price) values(1,'Zip Drive',250);
insert into item_mast(pro_no,pro_name,pro_price) values(2,'Mouse',250);
insert into item_mast(pro_no,pro_name,pro_price) values(3,'USB Mouse',150);
insert into item_mast(pro_no,pro_name,pro_price) values(4,'Head Phones',1250);



-- SUBQUERY 
--Query 11 (table: item_mast)
-- Find the name and price of the cheapest item(s).

SELECT MIN(pro_price) FROM item_mast;

SELECT pro_name, pro_price FROM item_mast WHERE pro_price = (SELECT MIN(pro_price) FROM item_mast);

-- Query 12 (table: customer)
-- Display all the customers, who are either belongs to the city New York or not had a grade above 100.

select * from CUSTOMER where city = 'New York' or  NOT grade >100;

--Query 13 (table: salesman)
--• Find those salesmen with all information who gets the commission within a range of 0.12 and 0.14.

select name from salesman where commission BETWEEN 0.12  AND 0.14;

-- Query 14 (table: customer)
--• Find all those customers with all information whose names are ending with the letter 'n'.

select * from customer where customer_name like '%n';

--Query 15 (table: salesmen)
--• Find those salesmen with all information whose name containing the 1st character is 'N' and the 4th
--  character is 'l' and rests may be any character.

select * from salesman where name like 'N__l%';

--Query 16 (table: customer)
-- Find that customer with all information who does not get any grade except NULL.
-- IS NOT NULL also used for not null values;

select * from customer where grade IS NULL;

--Query 17 (table: orders)
--• Find the total purchase amount of all orders.

select sum(purch_amt)  as TotalAmt from orders;


-- Query 18 (table: orders)
--• Find the number of salesman currently listing for all of their customers.

--select count(salesman_id) from orders;


SELECT COUNT (DISTINCT salesman_id) FROM orders;

--Query 19 (table: customer)
--• Find the highest grade for each of the cities of the customers.

select city, Max(grade) as "Highest Grade" from customer group by city;

-- Query 20 (table: orders)  
-- Find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.

select customer_id, max(purch_amt) from orders group by customer_id;

--Query 21 (table: orders)
--• Find the highest purchase amount ordered by the each customer on a particular date with their ID, order date
--  and highest purchase amount.

select customer_id, max(purch_amt) as max from orders group by order_date,customer_id;

-- Query 22 (table: orders)
--• Find the highest purchase amount on a date '2012-08-17' for each salesman with their ID.

select salesman_id, max(purch_amt) from orders where order_date = '2016-08-17' group by salesman_id;


-- Query 23 (table: orders)
-- • Find the highest purchase amount with their customer ID and order date, for only those customers who have -- the highest purchase amount in a day is more than 2000.  ---
-- GROUP BY  .... HAVING




select customer_id,order_date, max(purch_amt) from orders group by order_date, customer_id having max(purch_amt)>2000;


-- Query 24 (table: orders)
--• Write a SQL statement that counts all orders for a date August 17th, 2016.

select count(*) from orders where order_date = '2016-08-17';

