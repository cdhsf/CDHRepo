
Is Role In Session Context Function
--=============================

 -- Syntax  ---
select is_role_in_session();  -- end up with error (it needs a paramter)
select is_role_in_session;    -- since it needs a parameter, we have to use the (), else it ends with error
    
-- role hierarchy 
-- accountadmin >> securityadmin/sysadmin >> useradmin >> public
    
use role securityadmin;
select is_role_in_session('securityadmin'); -- this is equal to current_role()
    
-- with lower role in hiearchy
select is_role_in_session('securityadmin'),is_role_in_session('useradmin'),is_role_in_session('public'); 
        
-- upper case and lower case 
-- how does it work
select is_role_in_session('SECURITYADMIN'), is_role_in_session('securityadmin');
    


-- what if role does not exist or incorrect role name
-- in both case, you would get false value
-- so be careful
    
select is_role_in_session('accountadmin'), is_role_in_session('acountadmin');
    
-- Since this data comes from cloud service layer, you don't need any running compute
select current_warehouse();
select is_role_in_session('SECURITYADMIN');-- the warehouse is still suspended.
    
 -- What kind of function is_role_in_session() scalar/tabular?
show functions like 'is_role_in%'; 
    
-- it is built-in function, is_ansi = true, and scalar function.
--any user profile can run the above show function. 

-- assigned to a variable
set useradmin_role_exist = is_role_in_session('useradmin');
select $useradmin_role_exist;
    
set (role_useradmin_exist,role_accountadmin_exist) = (is_role_in_session('useradmin'),is_role_in_session('accountadmin')); 
select $role_useradmin_exist,$role_accountadmin_exist;
    
-- CAUTION - make sure the open and close bracket at both side of equal operator matches, else compilation error
    
-- Lets undestand the snowflake default role hierarchy 
-- https://docs.snowflake.com/en/user-guide/security-access-control-overview.html#role-hierarchy-and-privilege-inheritance
    
-- select role public
use role sysadmin;
select  is_role_in_session('public'),
        is_role_in_session('useradmin'),
        is_role_in_session('securityadmin'),
        is_role_in_session('sysadmin'),
        is_role_in_session('accountadmin');
          
-- 2nd example of customer role 
    
use role accountadmin;
select  is_role_in_session('business_analyst'),
            is_role_in_session('dev_ops_admin'),
            is_role_in_session('elt_developer'),
            is_role_in_session('project_admin'),
            is_role_in_session('sysadmin'),
            is_role_in_session('accountadmin');