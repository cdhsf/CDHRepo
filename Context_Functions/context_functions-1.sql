-- Lets see these functions in action and see what result they bring.
show functions like 'CURRENT%';

-- since they are functions like sum() or avg(), they have to be used within select statement
select  
    current_region(),  
    current_version(), 
    current_user(),    
    current_role(),    
    current_database(), 
    current_schema(),
    current_schemas(),
    current_warehouse();
    
	
	
	
 -- Now set them and see how to change it via SQL without using the UI features
    use role sysadmin; 
    use database my_db;
    use schema my_schema;
    use warehouse sap_load_wh;
    

-- they can also be used to set a variable value
-- you don't need to have select keyword in this case.
    
    set my_wh = current_warehouse();

-- Now you can print them using variable name like this
    select $my_wh;

-- if you have to set them for multiple variables together, you can also follow this
    set (my_db, my_schema, my_wh) = (current_database(), current_schema(), current_warehouse());
    
    select $my_db, $my_schema, $my_wh;
    
-- what about current_schemas and how to slipt it
    set my_search_path = current_schemas();
    
    select $my_search_path;
    select * from table(strtok_split_to_table($my_search_path,',')) f;
    -- we have a better way to do it
	
	/*   SETTING VARIABLES  **/
	
	-- they can also be used to set a variable value
-- you don't need to have select keyword in this case.
    
    set my_wh = current_warehouse();

-- Now you can print them using variable name like this
    select $my_wh;

-- if you have to set them for multiple variables together, you can also follow this
    set (my_db, my_schema, my_wh) = (current_database(), current_schema(), current_warehouse());
    
    select $my_db, $my_schema, $my_wh;
    
-- what about current_schemas and how to slipt it
    set my_search_path = current_schemas();
    
    select $my_search_path;
    select * from table(strtok_split_to_table($my_search_path,',')) f;
    -- we have a better way to do it