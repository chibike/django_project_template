# demonstration_ws

### Docker Useful Commands

use to kill a docker
```
docker kill 03030fa83f6d
```

use to rm stop docker
```
docker rm $(docker ps -a -q)
```

use to delete docker image
```
docker rmi {image_name}
```

use to build a new one
```
docker build -t test_docker .
```

use to rm stop docker containers and build new one
```
docker rm $(docker ps -a -q) && docker build -t test_docker .
```

use to run build
```
docker run -p 8000:8000 --name test test_docker:latest
```

step to build and push to gitlab
```
docker login dev-gitlab.cryptoquantique.com
docker build -t dev-gitlab.cryptoquantique.com/crypto-team/demos/demonstration_ws .
docker push dev-gitlab.cryptoquantique.com/crypto-team/demos/demonstration_ws
```

others
```
docker image
docker ps
```

### Tips to Use Docker

For Ubuntu:

1. Add the following to `/etc/docker/daemon.json`
```
{
    "insecure-registries" : [ "http://dev-gitlab.cryptoquantique.com:5555" ]
}
```

2. Do the following
```
# remove the previous login credentials
rm $HOME/.docker/

# restart docker
sudo service docker restart

# log in
docker login dev-gitlab.cryptoquantique.com:5555

# build your image
docker build -t dev-gitlab.cryptoquantique.com:5555/crypto-team/demos/demonstration_ws .

# push your image
docker push dev-gitlab.cryptoquantique.com:5555/crypto-team/demos/demonstration_ws

# pull your image
docker pull dev-gitlab.cryptoquantique.com:5555/crypto-team/demos/demonstration_ws

# run your image
docker run -p 8000:8000 dev-gitlab.cryptoquantique.com:5555/crypto-team/demos/demonstration_ws:latest
```

For WSL with Docker Desktop for Windows

1. Open the Docker Desktop Settings
2. Goto Daemon and add `http://dev-gitlab.cryptoquantique.com:5555` to `Insecure registries`
3. Apply, goto `reset` and *left-click* `Restart Docker Desktop`
4. Open WSL and follow the steps for Ubuntu


For Windows Command Line and Docker Toolbox

`docker machine ref: ` [https://docs.docker.com/machine/reference/](https://docs.docker.com/machine/reference/)

1. Open the command prompt as an Adminstrator
2. Run the following commands

```
# list docker machines currently on the system
docker-machine ls

# start the target docker machine [replace default]
docker-machine start default

# ssh into the target machine [replace default]
docker-machine ssh default
```

3. Add the following to `/etc/docker/daemon.json`
```
{
    "insecure-registries" : [ "http://dev-gitlab.cryptoquantique.com:5555" ]
}
```

4. Logout and restart the docker
```
# logout
logout

# restart the target machine [replace default]
docker-machine restart default

# make a note of the target docker machine's ip [replace default]
docker-machine ip default
```

5. Run the APP: see sections above
6. Open your browser and goto `{docker_machine_ip}:{service_port}/` e.g `192.168.99.100:8000/`

### SSL setup Ubuntu

```
# copy your certificate file to the ca-certificates directory could be different for each user
# use 'updatedb && locate ca-certificates' to see where your certificates have been stored
sudo mv {certificate_file.crt} /usr/local/share/ca-certificates

# update your certificates
sudo update-ca-certificates

# restart the docker service
sudo service docker restart

# ----- END ------------

# depending on your setup you might need to
#   1. restart the docker service on Windows, if using WSL and docker desktop on Windows
#   2. 'sudo dpkg-reconfigure ca-certificates'
```

### SSL setup on Windows
###### How to Manage Trusted Root Certificates on Windows

This instructions are based off [https://www.thewindowsclub.com/manage-trusted-root-certificates-windows](https://www.thewindowsclub.com/manage-trusted-root-certificates-windows)

The complete steps in pictures can be found in: [res/setup_ssl_for_windows_steps](https://dev-gitlab.cryptoquantique.com/crypto-team/Demos/demonstration_ws/tree/master/res/setup_ssl_for_windows_steps)

The steps are as follows:

1. launch the RUN app
2. type `mmc` and hit Enter

N.B. This is `MMC`

3. Goto `File > Add/Remove Snap in...`
4. Select `Certificates` then ADD
5. from the certificates snap-in dialog Select `Computer account` and hit Next
6. Select `Local computer (...... running on)` and hit Finish and Ok
7. from the first column in MMC, `double-click` on `Certificates (Loca... ..)` then `right-click` on `Trusted Root Certification Authorities Store`
8. Goto to `All Tasks > Import`
9. The Certificate Import Wizard will open
10. Follow the instructions in the wizard to complete the process
11. If asked choose to `Place all certificates in the following store` -> `Trusted Root Certification Authorites`

Next configure the trusted root certificates for your local computer

1. Open `mmc` and Goto `File > Add/Remove Snap in...`
2. Under `Available snap-ins`, `left-click` *Group Policy Object Editor* and then ADD
3. Leave the default selection `Local Computer` and then hit `Finish`
4. from the MMC console tree, Goto `Local Computer Policy > Computer Configuration > Windows Settings > Security Settings > Public Key Policies`
5. *Double-Click* `Certificate Path Validation Settings`, and then select the Stores tab
6. Leave the defaults -> `Click Ok`


### Install Chocolatey Windows

```
# Copy into an ADMIN Command Prompt
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

### Install Docker Toolbox (Windows HOME only)

There is a better tool for Windows 10 Pro/Enterprise

```
choco install docker-toolbox -ia /COMPONENTS="kitematic,virtualbox,dockercompose" --ignore-checksums
```

Next, launch Windows Start Menu > Docker Quick Start 
