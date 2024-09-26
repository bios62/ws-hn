-- 
-- Scripts that creates a larger number of APEX workspaces
--  (c) Inge Os 2024
--  29.08.24
--
-- Require run of the package lab_config
--
set serveroutput on
declare
   base_username varchar2(100):=lab_config.base_username;
   user_count integer := lab_config.user_count;
   password varchar2(100):=lab_config.lab_password;
   username varchar2(100);
   stmt varchar2(100);

   i integer;
   l_workspace_id number;
begin
    for i in 1..user_count loop
        begin
            username:=base_username||trim(to_char(i,'09'));
            APEX_INSTANCE_ADMIN.ADD_WORKSPACE(
                p_workspace=>username,
                p_primary_schema=>username );
            l_workspace_id := apex_util.find_security_group_id (p_workspace => username);
            apex_util.set_security_group_id (p_security_group_id => l_workspace_id); 
            APEX_UTIL.CREATE_USER(
                p_user_name=>username,
                p_web_password=>password,
                p_default_schema=> username,
                p_email_address => 'nobody@somebody.com',
                p_change_password_on_first_use=>'N',
                p_developer_privs=>'CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL' );
            dbms_output.put_line('Workspace and APEX User: '||username||' Successfully created');
        exception
            when others then
            dbms_output.put_line('Sqlerror: ');
                dbms_output.put_line(sqlcode);
                dbms_output.put_line(sqlerrm);
        end;
    end loop;
    commit;
end;
/