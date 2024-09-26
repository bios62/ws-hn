# Workshop preperation for administators

The workshop can be installed in your envrionment.  

The following files makes up the workshop configuration:
- [config_workshop.sql](files/config_workshop.sql)  a PL/SQL package that defines all variables the other create script uses. Modify this script to your need  
Do not save and push your version of the script to public git, as it will expose usernames/passwords
- [create_user.sql](files/create_user.sql)  Script to create database users and set the password. The script uses the config from `config_workshop.sql`
- [create_workspace.sql](files/create_workspace.sql)  Script to create APEX workspaces and users and set the password. The username and workspace name will be the same as the database username created in the prior script.  
  
The script uses the config from config_workshop.sql
  
For cleaning up run the following script in this order:
- [drop_workspaces.sql](files/drop_workspaces.sql), cleans out all workspaces and users. Usernames are generated from config_workshop.sql
- [drop_users.sql](files/drop_users.sql), cleans out all database users. Usernames are generated from config_workshop.sql
  
All scripts are run as administator. The initial script, that sets the config parameters, config_workshop.sql sets the following parameters:
  
- base_username, The username is generated out of base_username added with a number stating with 01 and upto usercount.
- lab_password, The password user will use for both database logon, Notebook logon and APEX workspace logon
- initial_password, Due to a bug, a initial dummy password is needed, the password is used for `create user`, and is immediately changed to `lab_password`
- user_count, The number of users you will create 

Make sure the passwords are inline with the password complexity rules of your database.
Example config:  

```
create or replace package lab_config as
--
--  Package that configures the PL/SQL creating the workshop
--  Run prior to user creation or workspace creation, set defaults
--  (c) Inge Os 2024
--  29.08.24
--
--
    base_username varchar2(15):='labuser';
    lab_password varchar2(20):='SomePassword2024####';
    initial_password varchar2(20):='NeverUsed2024####';
    user_count number:=10;  --  1= no number added,create just the base 
end lab_config;
```

When running the create user script yo will have `labuser01, labuser02 ... labuser10`

All scripts are run as `admin` 

The sequence of creating the labusers are:
- Create a Autonomous database, for transaction processing
- Modify `create_workspace.sql` to you usercount, userbase name and passwords
- Run the modified `create_workspace.sql`
- Run [create_user.sql](files/create_user.sql)
- Run [create_workspace.sql](files/create_workspace.sql)

When the workshop is completed and you want to clean up run the following as `admin`, assuming the `lab_config` package still exsists:
- Run [drop_workspace.sql](files/drop_workspace.sql)
- Run [drop_users.sql](files/drop_users.sql)

## Additional variables that may be changed

Lab1 refers to object storage that is held in a public bucket. The bucket contains kjoredataV2.csv and positions.csv.  
If you want to deploy the files tovyour own objectstorage bucket, the configuration of the S3 parameters are done  
in the `Set lab values` paragraph in the lab1 notebook. These are standard S3 API parameters that will be used though the rest of the notebook
this is not a mandatory step, but it is recommended to verify availability of the preconfigured object storage prior to the workshop.