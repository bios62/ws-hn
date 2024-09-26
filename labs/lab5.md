# Lab 5 instructions

## Purpose of lab

The purpose of this lab is to import and run the Oracle APEX application for viewing the trip- and log-data.

## Prerequsite

Completed lab 4  

## APEX logon and URL  

The URL to the APEX Workspace is:  

`https://<your ATP instance>.adb.eu-frankfurt-1.oraclecloudapps.com/ords/r/apex/workspace-sign-in/oracle-apex-sign-in`  

** APEX username is in UPPERCASE **  
  

![APEX logon](../images/apex_logon.jpg)  
  

![APEX workspace](../images/apex_workspace.jpg)

After first logon you will be asked to chnag eyour profile  
First Name  
Last Name  
Change the password. Minimum 12 Charaters with One Uppercase, digits and special Character  

![APEX profile](../images/apex_profile.jpg)  
  
## Build the Oracle APEX application

Go to the "App Builder" and choose the "Import" action.  
![APEX App Builder](../images/apex_home.png)
  
Drag and drop, or select the ![APEX app](../files/apex_app.sql) file.    
  
![APEX App Import](../images/apex_import.png)

Install the application  
![APEX App Install](../images/apex_install.png)

Install script logdata_t.sql to enable push notification  

You need to run the script [logdata_t.sql](..files/logdata_t.sql) from SQL Developer WEB or APEX SQL Commands  

The script needs to be updated with the application ID from the import.
![Screenshot of APEX SQL Commands](sqlcommands.sql)

Run the application  
![APEX Run App](../images/apex_run.png)