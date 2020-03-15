# escape=`

#ARG SERVERCORE_VERSION=ltsc2019
ARG SERVERCORE_VERSION=1903
FROM mcr.microsoft.com/windows/servercore:$SERVERCORE_VERSION

# preparing base environment
ENV KAPOW_HOME=c:\kapow
ENV CATALINA_HOME=${KAPOW_HOME}\tomcat\apache-tomcat-8.5.47

RUN mkdir %KAPOW_HOME% `
    & mkdir %KAPOW_HOME%\tomcat `
	& mkdir %KAPOW_HOME%\tomcat\conf `
    & mkdir %KAPOW_HOME%\tomcat\conf\Catalina\localhost `
    & mkdir %KAPOW_HOME%\tomcat\lib\jdbc `
    & mkdir %KAPOW_HOME%\backup `
    & mkdir %KAPOW_HOME%\logs
	
	
ADD jre ${KAPOW_HOME}/jre

ENV JAVA_HOME=${KAPOW_HOME}\jre

ENV JRE_HOME=${KAPOW_HOME}\jre

ADD https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.47/bin/apache-tomcat-8.5.47-windows-x64.zip ${KAPOW_HOME}/.

RUN powershell -Command "expand-archive -Path 'c:\kapow\apache-tomcat-8.5.47-windows-x64.zip' -DestinationPath 'c:\kapow\tomcat'"

ADD https://download.jetbrains.com/idea/jdbc-drivers/MSSQL/7.2/mssql-jdbc-7.4.1.jre8.jar ${CATALINA_HOME}/lib/jdbc/

COPY docker-win/kapplets/catalina.properties.extra ${KAPOW_HOME}/.

RUN type %KAPOW_HOME%\catalina.properties.extra >> %CATALINA_HOME%\conf\catalina.properties

COPY docker-win/kapplets/kapplets.ps1 ${KAPOW_HOME}\tomcat\bin\

COPY WebApps/kapplets.war ${CATALINA_HOME}\webapps\ROOT.war

RUN rmdir %CATALINA_HOME%\webapps\ROOT /s /q

CMD ["powershell", "-File", "c:/kapow/tomcat/bin/kapplets.ps1"]
