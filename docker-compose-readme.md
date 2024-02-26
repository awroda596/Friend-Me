Partially working docker based on instructions in this article: https://gursimarsm.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638
Currently builds and runs the app in linux, will need to fix for chrome.  
tested on my ubuntu laptop and my windows desktop with WSL 
requires: docker-compose and linux or windows with WSL on host

to run: 
edit the Dockerfile and replace <token> on line 19 with an xauth token (run xauth list on host).  
if using WSL, can just remove the line instead. 
run sudo docker-compose build
run sudo docker-compose run app


to do: 
adjust dockerfile/docker-compose yaml to run from root directory instead. 
add chrome install to dockerfile. 
