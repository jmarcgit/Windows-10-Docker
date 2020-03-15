# escape=`

#ARG SERVERCORE_VERSION=ltsc2019
ARG SERVERCORE_VERSION=1903
FROM mcr.microsoft.com/windows/servercore:$SERVERCORE_VERSION

ENV KAPOW_HOME=c:\kapow
RUN mkdir %KAPOW_HOME%
RUN mkdir %KAPOW_HOME%\gitkeys

ADD bin ${KAPOW_HOME}/bin
ADD jre ${KAPOW_HOME}/jre
ENV JAVA_HOME=${KAPOW_HOME}\jre
ENV JRE_HOME=${KAPOW_HOME}\jre

ADD nativelib/wrapper-windows-x86-64.dll ${KAPOW_HOME}/nativelib/
ADD lib/thirdparty ${KAPOW_HOME}/lib/
ADD lib/tomcat/tomcat-embed-core-* ${KAPOW_HOME}/lib/
ADD lib/synchronizer.jar ${KAPOW_HOME}/lib/synchronizer.jar

COPY docker-win/synchronizer/synchronizer.ps1 ${KAPOW_HOME}/bin/

WORKDIR ${KAPOW_HOME}

CMD ["powershell", "-File", "c:/kapow/bin/synchronizer.ps1"]
