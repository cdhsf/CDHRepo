

--    Snowflake Date Time Context Functions  *****
-- ============================================================ --



select 
    current_date(),
    current_time(),
    current_timestamp(),
    sysdate();
	
	
	SHOW PARAMETERS LIKE 'TIMEZONE%';
	
	-- ============================================================ --	
	
-- Default Snowflake System Timezone is configured to use Pacific Time Zone
-- The session parameter timezone can be configurable to UTC or other timezone
-- please follow the link https://docs.snowflake.com/en/sql-reference/parameters#parameter-hierarchy-and-types
-- ALTER SESSION SET TIMEZONE = 'US/Eastern'    -- FOR THIS SESSION time zone can be altered.
-- these functions do need a running warehouse
-- they get it from metadata services
-- look at the date and time format
-- default fraction of second is with ff(3)
-- lets try these context functions without parenthesis (except sysdate all works)


-- ============================================================ --
select 
    current_date,
    current_time,
    current_timestamp,
    sysdate();

select sysdate;   -- parantheses not required

-- ============================================================ --

-- 01. LETS TRY WITH VARIALBE VALUES WITH AND WIHOUT SECOND FRACTION 

-- ============================================================ --

set (my_time, my_ts) = (current_time, current_timestamp);

select $my_time, $my_ts;

-- So if don't defint the second fraction parameters, it continue to display the FF(3)

-- WHAT IF WE SPECIFY FF(9), WILL IT CHANGE THE RESULT


set (my_time, my_ts) = (current_time(9), current_timestamp(9));
select $my_time, $my_ts;

/*
    NO CHANGE. SO WHY IT IS NOT CHANGING...???
    YOU HAVE TO USE THE SESSION LEVEL PARAMETERS
	set the session level parameters as below
*/

alter session set timestamp_output_format = 'YYYY-MM-DD HH24:MI:SS.FF';

alter session set time_output_format = 'HH24:MI:SS.FF';

select current_time(9), current_timestamp(9);

set (my_time, my_ts,my_sysdate) = (current_time, current_timestamp,sysdate());

select $my_time, $my_ts, $my_sysdate;    


-- ============================================================ --
-- 02.  SQL Script - How to use them to set column default value
-- ============================================================ --

create table demo01 (
  row_id integer autoincrement not null,
  dt_value date default current_date(),
  time_value time default current_time(),
  ts_value timestamp default current_timestamp(),
  sysdt_value timestamp default sysdate(),
  msg string
);

desc table demo01; 
-- interesting thing to notice about sysdt_value 
-- CAST(CONVERT_TIMEZONE('UTC', CAST(CURRENT_TIMESTAMP() AS TIMESTAMP_TZ(9))) AS TIMESTAMP_NTZ(9))

-- lets insert one row and see the result
insert into demo01 (msg) values ('1st row') ;
select * from demo01;

--since in this session, we have not set the date and time format, we can still see FF(3)
--now change the date and time format with FF
alter session set timestamp_output_format = 'YYYY-MM-DD HH24:MI:SS.FF';
alter session set time_output_format = 'HH24:MI:SS.FF';

select * from demo01;

-- why only FF(3)
-- let me insert 10 rows at one go..
insert into demo01 (msg) values 
    ('2nd row'),('3rd row'),('4th row'),('5th row'),('6th row'),('7th row'),('8th row'),('9th row'),('10th row') ;
select * from demo01;
-- all values are same, means that meta data layer get the value and then insert happens.

insert into demo01 (msg) values ('11th row');
insert into demo01 (msg) values ('12th row');
insert into demo01 (msg) values ('13th row');
insert into demo01 (msg) values ('14th row');
insert into demo01 (msg) values ('15th row');

select * from demo01;

-- ============================================================ --
--  03. SQL Script - Timezone and Date/Time context functions
-- ============================================================ --
-- By default your current session is in your local timezone

select current_date,current_timestamp,sysdate();

-- you can change the session level parameters 
alter session set timezone = 'Japan';
alter session set timestamp_output_format = 'YYYY-MM-DD HH24:MI:SS.FF';
alter session set time_output_format = 'HH24:MI:SS.FF';

-- after setting my time zone as Japan, lets see the result
select current_date,current_timestamp, sysdate();

-- you noticed that sysdate is not changed with session value, it still shows the sysdate with UTC.

-- lets insert some record to our table

-- setting my context
use role sysadmin;
use database sales;
use schema sandbox;
select current_database() || '.' ||current_schema() || '(' || current_role() || ')' as context; -- lets check the context

insert into demo01 (msg) values ('21st row - Japan');
insert into demo01 (msg) values ('22nd row - Japan');
insert into demo01 (msg) values ('23rd row - Japan');
insert into demo01 (msg) values ('24th row - Japan');
insert into demo01 (msg) values ('25th row - Japan');

select * from demo01 where msg like '%Japan%';
