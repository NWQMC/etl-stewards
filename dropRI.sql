show user;
select * from global_name;
set timing on;
set serveroutput on;
whenever sqlerror exit failure rollback;
whenever oserror exit failure rollback;
select 'drop RI start time: ' || systimestamp from dual;

begin
   etl_helper.drop_ri('stewards');
end;
/

select 'drop RI end time: ' || systimestamp from dual;
