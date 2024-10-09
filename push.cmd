@echo off
git add .
git add files\*
git add labs\*
git add images\*
if [%1] == [] goto nocommit
git commit -m "%1%"
echo ********************
echo security check
echo ********************
find ":=" files\config_workshop.sql
find "RESOURCE_URI=" files\lab3.dsnb
set /P secok="OK to proceed: (Y/N) "
if secok == 'N' goto nopush
echo pushing to git
git push -u origin
goto exit
:nocommit
echo "commit label missing"
goto exit
:nopush
echo please correct securty 
:exit
