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



		


