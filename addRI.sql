show user;
select * from global_name;
set timing on;
set serveroutput on;
whenever sqlerror exit failure rollback;
whenever oserror exit failure rollback;
select 'add RI start time: ' || systimestamp from dual;

begin
	etl_helper_main.add_ri('stewards');
end;
/

select 'add RI end time: ' || systimestamp from dual;
