
---   Query ID Context Function


// =================================

    -- Syntax
    select last_query_id();
    
    -- ANSI not supported and without bracket, it lands on error
    select last_query_id();
    
// =================================

    -- does not need any warehousse, it is executed at cloud service layer
    select current_warehouse();
    
    --warehoue is assigned but not running and this context function does not resume it
    select last_query_id();
    
// =================================

    -- even a failed query gets a query id as this is the 1st step in query life cycle in snowflake.
    -- the bracket is missing, so below SQL statement will fail.
    select last_transaction(), last_query_id;
    
// =================================

    -- it is not a numeric value, so following SQL statement fails
    select last_query_id()+last_query_id();

// =================================

    -- What kind of function last_query_id() scalar/tabular?
    show functions like 'last_q%'; -- the query id
    
    show functions;

// =================================

    -- assigned to a variable
    set lst_query_id = last_query_id();
    select $lst_query_id;
    
    
// =================================
    
    -- usage with argument and default argument
    select last_query_id(-1), last_query_id();
    
    select current_session();
    -- positive integer
    -- 1 means 1st query in the session
    -- 2 means 2nd query in the session
    -- -1 is default and means last executed query
    -- -2 second last query.
    
    -- so lets open a up a new windows and run some queries and validate it.
    select last_query_id(-1), last_query_id(1);
    
use role sysadmin;          -- 1st Query
use database demo_db;       -- 2nd Query
use schema public;          -- 3rd Query
use warehouse compute_wh;  -- 4th Query

select current_user(), current_role(), current_database(), current_schema(), current_warehouse(),current_session(); -- 5th Query

select current_user(), current_role; -- 6th Query, a failed query

select last_query_id(), last_query_id(-1); -- now this becomes 7th query

select last_query_id(1); -- this gives the 1st query id -- use role sysadmin;
select last_query_id(2); -- this gives the 2nd query id -- use database demo_db; 


-- switch role and run query
use role accountadmin;
select query_id, split(query_id,'-'),session_id from "SNOWFLAKE"."ACCOUNT_USAGE"."QUERY_HISTORY" 
