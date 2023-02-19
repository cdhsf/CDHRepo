--  CURRENT_CLIENT  ---------

--  ********************

-- 	1. current_client();		-> General Context
-- 	2. All_user_names(); 		-> Session Context
-- 	3. Current_account(); 		-> Session Context
-- 	4. Current_available roles(); 		-> Session Context
-- 	5. Current_session(); 		-> Session Context
-- 	6. Current_statement(); 		-> Session Context

--  ********************
current_client();
current_client;   -- Not an ANSI standard

-- try with Snowsql and JDBC Driver and see what results it produces

-- Query History does not capture current client.
-- and if you have stored procedures which is being called by any and you want to audit it you need this FUNCTION

user role AccountAdmin;

select * from "SNOWFLAKE"."ACCOUNT_USAGE"."QUERY_HISTORY" LIMIT 20;

CURRENT_STATEMENT();
CURRENT_STATEMENT;   -- PRODUCES ERROR

select current_client(), current_account, current_statement();

-- You can set the values for variables using these context functions using set operator

-- check the behavior of current_statement comparing the previous output and current output.

set (x,y,z) = (current_client(), current_account(), current_statement());

select $z;

set pi = 2.27;

select $pi, current_statement(); -- this won't display the value of the variable. current_statement displays the query (variable name not the value).

select current_role(), current_user(), all_user_names();

select index, cast(values as string) as user_names, 
		"sf does not support" as login_name,
		from table (flatten(input => parse_json(all_user_names())));
		
		
-- current_available_roles


select current_user(), current_role(), current_available_roles();

-- if you are working with complex environment and you have to switch role between the existing roles this will really help you.
select index,value,this from table(flatten(input => json_parse(current_available_roles())));

-- for a read-only profile how it looks just check using below statements
-- This gives you the PUBLIC role as the only role.

select current_user(), current_role(), current_available_roles();
select index,value,this from table(flatten(input => json_parse(current_available_roles())));

-- TRANSACTIONS ---

-- current_transaction();
--  last_transaction();

--  check the current context for this workshee (session.)
select current_session(),current_role(),current_database(),current_schema(),current_warehouse();

-- Initiate a Transaction --
begin transaction name my_transaction;
-- begin work name level1  --  alternatively you can use work instead of Transaction.

-- Create a table --
drop table if exists tx1;
create or replace table tx1(
id integer autoincrement not null,
msg string
);

rollback;  -- rollback only rolls back the DML statement not the DDL statement. so it creates the table and does not drop the table.

desc table tx1;
select * from table tx1;


// ******* INSERT A RECORD WITHIN A transaction

begin transaction name insert_transaction;
	insert into tx1(msg) values ("insert operation");
	select * from tx1;
	
	-- set this data from different worksheet
	select current_transaction();
	rollback;
	select * from tx1;
	
	-- Last Transaction
	
   select last_transaction();
   
   
   --   Multi level TRANSACTIONS
   -- Lets start multi level transaction 
   
begin transaction name level_1;
	insert into tx1(msg) values ("multi tx level_1");
	select * from tx1;
	select current_transaction();
	
	   -- 1676822393004000000  - transaction id

      
begin transaction name level_2;
	insert into tx1(msg) values ('multi tx level_2');
	select * from tx1;
	select current_transaction();
    -- 1676822393004000000  - transaction id same as the one recorded before 
    -- snowflake doesnot support multi level transactions.
    -- if you start one transaction and if you start another transaction if one transaction is already running 
    -- snowflake treats it as the same transaction as the current running transaction.

    -- verify with show transactions command.
    show transactions;

-- IF YOU ARE USING THESE WITH STORED PROCEDURES THEN THE BEHAVIOR OF TRANSACTIONS IS VERY DIFFERENT and will see in next classes  -----






		


