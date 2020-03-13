# Windows-10-Docker
Installation guide of Docker for Windows 10 without enabling Hyper-v

Manual steps :

1- Enable the containers feature in Windows 10
	Start a PowerShell as Administrator
	Run : Enable-WindowsOptionalFeature -FeatureName containers -Online
	Reboot the system
  
2- Download the Docker Engine zip file (Docker 19.03.5 here)
	Start a PowerShell as Administrator
	Run : Invoke-WebRequest -UseBasicParsing -OutFile docker-19.03.5.zip https://download.docker.com/components/engine/windows-server/19.03/docker-19.03.5.zip

3- Extract the archive
	Run : Expand-Archive docker-19.03.5.zip -DestinationPath $Env:ProgramFiles -Force

4- Clean up the zip file
	Run : Remove-Item -Force docker-19.03.5.zip

5- Add the docker install directory ($env:ProgramFiles\docker) to your PATH environment variable

6- Register the Docker service
	Run : dockerd --exec-opt isolation=process --register-service
	Set the Docker Engine service start mode to manual if you don't want to run your containers at anytime
	Ensure that the Docker Engine service is running
   
 7- Test you installation
	Start a PowerShell as Administrator
	Run : docker run hello-world:nanoserver
	Docker should download a container image (can take a bit of time depending of network bandwidth) and display a message
    
 8- Install docker-compose (1.25.4 here)
	Start a PowerShell as Administrator again
	Run : Invoke-WebRequest "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\Docker\docker-compose.exe
    
Now you can enjoy Docker containers in Windows 10 without virtualization overhead. The only constraint is that you have to choose a container system version that is matching your OS version. Run winver command in order to check what Windows 10 version you are running. I tested with 1903 and 1909 and I found that Windows 10 version 1909 can run 1903 based containers as well.
 
  
