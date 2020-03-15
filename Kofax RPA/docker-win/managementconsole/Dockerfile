# escape=`

#ARG SERVERCORE_VERSION=ltsc2019
ARG SERVERCORE_VERSION=1903
FROM mcr.microsoft.com/windows/servercore:$SERVERCORE_VERSION

ENV KAPOW_HOME=c:\kapow

RUN mkdir %KAPOW_HOME%

ADD jre ${KAPOW_HOME}/jre

ADD https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.47/bin/apache-tomcat-8.5.47-windows-x64.zip ${KAPOW_HOME}/.

RUN mkdir %KAPOW_HOME%\tomcat

RUN powershell -Command "expand-archive -Path 'c:\kapow\apache-tomcat-8.5.47-windows-x64.zip' -DestinationPath 'c:\kapow\tomcat'"

ENV JAVA_HOME=${KAPOW_HOME}\jre

ENV JRE_HOME=${KAPOW_HOME}\jre

ENV CATALINA_HOME=${KAPOW_HOME}\tomcat\apache-tomcat-8.5.47

COPY docker-win/managementconsole/catalina.properties.extra ${KAPOW_HOME}/.

RUN type %KAPOW_HOME%\catalina.properties.extra >> %CATALINA_HOME%\conf\catalina.properties

ADD https://clojars.org/repo/com/microsoft/sqlserver/sqljdbc4/4.0/sqljdbc4-4.0.jar ${CATALINA_HOME}/lib/jdbc/

COPY WebApps/Configurator.jar ${KAPOW_HOME}/managementConsoleConfigurator.jar

COPY WebApps/ManagementConsole.war ${CATALINA_HOME}/webapps/ROOT.war

RUN rmdir %CATALINA_HOME%\webapps\ROOT /s /q

COPY docker-win/managementconsole/managementconsole.ps1 ${KAPOW_HOME}

# Install git client
# ADD https://github.com/git-for-windows/git/releases/download/v2.24.0.windows.2/Git-2.24.0.2-64-bit.exe /
# RUN Git-2.24.0.2-64-bit.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /SP- /LOG=C:\git_install.log
# RUN Git-2.24.0.2-64-bit.exe  /SUPPRESSMSGBOXES /NORESTART /NOCANCEL
# RUN del Git-2.24.0.2-64-bit.exe /f

CMD ["powershell", "-File", "c:/kapow/managementconsole.ps1"]
