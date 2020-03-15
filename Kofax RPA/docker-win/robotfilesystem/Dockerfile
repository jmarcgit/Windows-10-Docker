# escape=`

#ARG SERVERCORE_VERSION=ltsc2019
ARG SERVERCORE_VERSION=1903
FROM mcr.microsoft.com/windows/servercore:$SERVERCORE_VERSION

ENV KAPOW_HOME=c:\kapow
RUN mkdir %KAPOW_HOME%
RUN mkdir %KAPOW_HOME%\tomcat
RUN mkdir %KAPOW_HOME%\lib
RUN mkdir %KAPOW_HOME%\bin

ADD jre ${KAPOW_HOME}/jre
ENV JAVA_HOME=${KAPOW_HOME}\jre
ENV JRE_HOME=${KAPOW_HOME}\jre

ADD https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.47/bin/apache-tomcat-8.5.47-windows-x64.zip ${KAPOW_HOME}/.
RUN powershell -Command "expand-archive -Path "$env:KAPOW_HOME\apache-tomcat-8.5.47-windows-x64.zip" -DestinationPath "$env:KAPOW_HOME\tomcat"
RUN del "%KAPOW_HOME%\apache-tomcat-8.5.47-windows-x64.zip"
ENV CATALINA_HOME=${KAPOW_HOME}\tomcat\apache-tomcat-8.5.47

COPY WebApps/Configurator.jar ${KAPOW_HOME}/lib/robotFileSystemConfigurator.jar
COPY WebApps/rfs.war ${CATALINA_HOME}/webapps/rfs.war
RUN rmdir %CATALINA_HOME%\webapps\ROOT /s /q

COPY docker-win/robotfilesystem/robotfilesystem.ps1 ${KAPOW_HOME}/bin

WORKDIR ${CATALINA_HOME}

CMD ["powershell", "-File", "c:/kapow/bin/robotfilesystem.ps1"]
