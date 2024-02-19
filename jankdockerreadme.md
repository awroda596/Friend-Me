testing docker based on instructions in this article: https://gursimarsm.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638
kinda jank, fairly new to docker
working on my ubuntu laptop and my windows desktop with WSL 
requires: docker-compose and linux on host

to run: 
in friend-me:
sudo docker-compose build
#start container
sudo docker-compose up --d 
xauth list  
#copy a token from the above to clipboard
#run shell in container
docker exec -ti <container> /bin/bash
#add token
xauth add <token>
flutter run

#after exiting stop container
sudo docker-compose kill
