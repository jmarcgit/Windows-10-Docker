# Windows-10-Docker
Installation guide of Docker for Windows 10 without enabling Hyper-v

## Manual steps :

1. Enable the containers feature in Windows 10
	- Start a PowerShell as Administrator
	- Run : Enable-WindowsOptionalFeature -FeatureName containers -Online
	- Reboot the system
  
2. Download the Docker Engine zip file
	- Start a PowerShell as Administrator
	- Run : Invoke-WebRequest -UseBasicParsing -OutFile docker.zip https://master.dockerproject.org/windows/x86_64/docker.zip

3. Extract the archive
	- Run : Expand-Archive docker.zip -DestinationPath $Env:ProgramFiles -Force

4. Clean up the zip file
	- Run : Remove-Item -Force docker.zip

5. Add the docker install directory ($env:ProgramFiles\docker) to your PATH environment variable
	- Close the PowerShell window
	- Update the PATH environnement variable in Windows system properties
	- Start a new PowerShell as Administrator
	- Check if the docker command is found (should return an error at this stage). If not check you environment variable and try to fix that.

6. Register the Docker service
	- Run : dockerd --exec-opt isolation=process --register-service
	- Set the Docker Engine service start mode to manual if you don't want to run your containers at anytime
	- Ensure that the Docker Engine service is running

 7. Install docker-compose (1.25.4 here) if required
	- Start a PowerShell as Administrator
	- Run : Invoke-WebRequest "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\Docker\docker-compose.exe
 
 8. I recommend to exclude the $Env:ProgramData\docker directory from your antivirus scan path ($Env:ProgramData\docker is where Docker will store layers and volumes)
 
 9. Test your installation
	- Start a PowerShell as Administrator again
	- Run : docker run hello-world:nanoserver
	- Docker should download a container image (can take a bit of time depending of the network bandwidth) and display a message
        
Now you can enjoy Docker containers in Windows 10 without the virtualization overhead. The only constraint is that you have to choose a container system version that is matching your OS version. Run winver command in order to check what Windows 10 version you are running. I tested with 1903 and 1909 and I found that Windows 10 version 1909 can run 1903 based containers as well.

## Few TIPS :

If you don't like the CLI you can now install Portainer :
```
docker pull portainer/portainer
docker run -d --restart always --name portainer -h portainer -p 9000:9000 -v //./pipe/docker_engine://./pipe/docker_engine portainer/portainer
```

In $Env:ProgramData\docker\config you can create a daemon.json file in order to set few parameters. Here is a copy of my configuration :
```
{
"fixed-cidr": "192.168.51.0/24",
"dns": ["8.8.4.4", "8.8.8.8"],
"storage-opts": ["size=30GB"],
"group": "Users"
}
```
- fixed-cidr : change the adress range of the containers nat network. Default range was conflicting with my VPN
- dns : containers don't use any DNS by default. I use Google DNS servers
- storage-opts : the default max storage per image is 20GB
- group : users allowed to run docker cli. Default is Administrators

You have to restart the Docker service in order to apply the changes. A system reboot is recommended if you change the network addresses

About docker-compose networking : compose will create networks that could have conflicting addresses with your VPN software. It's possible to define another network range in the docker-compose yaml. What I suggest to do is to just use the Docker default nat network. Example :
```
networks:
  net:
    external:
      name: "nat"
```
## If you want to uninstall :

1. Stop the Docker Engine service
2. Run : dockerd --unregister-service
3. Remove the $Env:ProgramFiles\docker directory
4. Remove the $Env:ProgramData\docker directory (I recommend using docker-ci-zap https://github.com/moby/docker-ci-zap because some files have special access rights)
5. Remove $env:ProgramFiles\docker from your PATH environment variable
  
## Known issues :
- When removing images or containers sometimes physical layers aren't removed from the disk. This means that disk usage will grow and some cleaning will be needed after a while. (Stop docker service, run docker-ci-zap in order to remove the $Env:ProgramData\docker directory and start docker service again)
- Windows 10 could complain about unregistered Windows copy. The problem was introduced by recent Windows update patches. A system reboot solves the problem for me
