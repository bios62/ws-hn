--  Creates database users for the workshops
--
--  (c) Inge Os 2024
--  20.08.24
--
-- Require run of the package lab_config
set serveroutput on
declare 
-- create or replace procedure create_workshop_users(p_base_username in varchar2,p_workshop_password in varchar2,p_user_count in integer)
   --
   -- Change base_username password and antall prior to run, change in package 
   -- user_count reflects number of users
   --
   -- Minor tweak, the user schema got a initial password, tha is changed later
   -- A bug in 23ai require a password change after creation
   --
   base_username varchar2(100):=lab_config.base_username;
   user_count integer :=lab_config.user_count;
   workshop_password varchar2(100):=lab_config.lab_password;
   username varchar2(100);
   stmt varchar2(100);
   i integer;
   additional_roles varchar2(100):='CONSOLE_DEVELOPER,DWROLE,OML_DEVELOPER,DB_DEVELOPER_ROLE';
begin
    dbms_output.enable(65000);

    for i in 1..user_count loop
        begin
            if user_count >1 then
                username:=base_username||trim(to_char(i,'09'));
            else
                username:=base_username;
            end if;
            -- USER SQL
            stmt:='CREATE USER '||username||' IDENTIFIED BY '||lab_config.initial_password;
            execute immediate stmt;
            -- ADD ROLES
            stmt:='GRANT CONNECT,RESOURCE,'||additional_roles ||' TO '||username;
            execute immediate stmt;
            stmt:='ALTER USER '||username||' DEFAULT ROLE '||additional_roles;
            execute immediate stmt;
            -- QUOTA
            stmt:='ALTER USER '||username||' QUOTA 100M ON DATA';
            execute immediate stmt;
            -- Grants required for select AI demo
            stmt:='GRANT execute on dbms_cloud TO '||username;
            execute immediate stmt;
            stmt:='GRANT execute on dbms_cloud_ai TO '||username;
            execute immediate stmt;
            stmt:='GRANT select any mining model TO '||username;
            execute immediate stmt;
            -- REST ENABLE
            ORDS_METADATA.ORDS_ADMIN.ENABLE_SCHEMA(
                p_enabled => TRUE,
                p_schema => username,
                p_url_mapping_type => 'BASE_PATH',
                p_url_mapping_pattern => username,
                p_auto_rest_auth=> TRUE
            );
            -- ENABLE DATA SHARING
            C##ADP$SERVICE.DBMS_SHARE.ENABLE_SCHEMA(
                    SCHEMA_NAME => username,
                    ENABLED => TRUE
            );
            commit;
            -- Password
            stmt:='ALTER USER '||username||' identified by '||workshop_password;
            execute immediate stmt;
            dbms_output.put_line('User: '||username||' Successfully created');
            if user_count = 1 then
               exit;
            end if;
        exception
            when others then
            dbms_output.put_line('Sqlerror: ');
                dbms_output.put_line(sqlcode);
                dbms_output.put_line(sqlerrm);
    end;
    end loop;
end;
/