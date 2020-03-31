# escape=`

#ARG SERVERCORE_VERSION=ltsc2019
ARG SERVERCORE_VERSION=1903
FROM mcr.microsoft.com/windows/servercore:$SERVERCORE_VERSION

ENV KAPOW_HOME=c:\kapow

ADD jre ${KAPOW_HOME}/jre

ADD nativelib ${KAPOW_HOME}/nativelib

ADD Resources ${KAPOW_HOME}/Resources

ADD bin ${KAPOW_HOME}/bin

ADD lib ${KAPOW_HOME}/lib

COPY docker-win/roboserver/roboserver.ps1 /kapow/bin/.

COPY docker-win/roboserver/roboServerConfigurator.jar /kapow/bin

RUN echo wrapper.java.additional.22=-Dkapow.applicationDataFolder=%KAPOW_HOME%/data >> %KAPOW_HOME%/bin/common.conf

COPY docker-win/roboserver/vc_redist*x86.exe /

RUN powershell -Command "Start-Process -FilePath 'C:\vc_redist.100.x86.exe' -ArgumentList '/Q' -Passthru -Wait"

RUN powershell -Command "Start-Process -FilePath 'C:\vc_redist.120.x86.exe' -ArgumentList '/Q' -Passthru -Wait"

RUN powershell -Command "Start-Process -FilePath 'C:\vc_redist.141.x86.exe' -ArgumentList '/Q' -Passthru -Wait"

RUN del C:\vc_redist*x86.exe /f

# Find dxva2.dll (can be found at C:\Windows\SysWOW64 of your host OS) and copy it inside OS directory of docker container.
# Comment out or remove line below if you use ltsc2016 since dxva2.dll is already included into that docker image.
COPY docker-win/roboserver/dxva2.dll /windows/SysWOW64

WORKDIR ${KAPOW_HOME}

CMD ["powershell", "-File", "c:/kapow/bin/roboserver.ps1"]
