--
-- Drop user workspace and drop the user
--  (c) Inge Os 2024
--  29.08.24
--
-- Require run of the package lab_config
--
set serveroutput on
declare
   base_username varchar2(100):=lab_config.base_username;
   username varchar2(100);
   drop_stmt varchar2(100);
   antall integer:=lab_config.user_count;
   l_workspace_id integer;
begin
  dbms_output.enable(65000);
  for i in 1..antall loop
    begin
        username:=base_username||trim(to_char(i,'09'));       
        l_workspace_id := apex_util.find_security_group_id (p_workspace => username);
        apex_util.set_security_group_id (p_security_group_id => l_workspace_id); 
        APEX_UTIL.REMOVE_USER(p_user_name => username);
        APEX_INSTANCE_ADMIN.REMOVE_WORKSPACE( username,'Y','N');  -- Drops schema 'Y' 
        dbms_output.put_line('User workspace: '||username||' removed');
    exception
        when others then
        dbms_output.put_line('Sqlerror: ');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
    end;
  end loop;
end;
/
