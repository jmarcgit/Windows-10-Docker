# escape=`

#FROM microsoft/mssql-server-windows-express:latest
FROM octopusdeploy/mssql-server-windows-express:1903

COPY docker-win/sqlserver/script.sql /

COPY docker-win/sqlserver/start.ps1 /

CMD ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';", ".\\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \\\"$env:attach_dbs\\\" -Verbose"]
