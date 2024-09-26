--  Alter the password for the workshops
--
--  (c) Inge Os 2024
--  201.09.24
--
-- Require run of the package lab_config
set serveroutput on
declare 
   --
   -- Changes the password for an amount of users
   --
   --  Get the user name from lab_config package
   --
   -- Runs from user_offset and changes the password for user_count users
   --
   base_username varchar2(100):=lab_config.base_username;
   user_offset integer :=1;
   user_count integer := 10;
   workshop_password varchar2(100):='';
   username varchar2(100);
   stmt varchar2(100);
   i integer;
begin
    dbms_output.enable(65000);

    for i in user_offset..user_count loop
        begin
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