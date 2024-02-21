testing docker based on instructions in this article: https://gursimarsm.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638
needs some adjustment but works.  Currently runs the flutter app in linux but should be able to run in chrome as well.  will need to modify the dockerfile to install chrome and requirements first though. 
Uses xserver on host to function as display. 
tested on my ubuntu laptop and my windows desktop with WSL 
requires: docker-compose and linux or windows with WSL on host

to run: 
edit the Dockerfile and replace <token> on line 12 with an xauth token (run xauth list on host).  
run sudo docker-compose build
run sudo docker-compose up


to do: 
adjust dockerfile/docker-compose yaml to run from root directory instead. 
add chrome install to dockerfile. 
