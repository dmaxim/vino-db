#!/bin/bash

appPasswordArg=$1

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./initialize.sql -o output.txt

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./create-database.sql -o create-output.txt

echo :setvar appPassword $appPasswordArg > initialize-users.sql

cat intialize-users-template.sql >> initialize-users.sql

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./initialize-users.sql -o user-output.txt 

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./initialize-data.sql -o data-output.txt


