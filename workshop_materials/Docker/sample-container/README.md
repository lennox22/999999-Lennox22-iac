Download example files from git (https://git.rockfin.com/training-iac/training-starter-kit)​
git
​

Navigate to the  git “training-starter-kit/workshop_materials/Docker/sample-container”​

### build

docker build -t [YOURNAME-CONTAINER] -f Dockerfile . 

Lets break this down. ​Build indicates that we're looking to start the creation of a new container. `-t` indicates the tag. Tags are arbitrary, but the standard nomenclature is `namespace/name:version`. In this case we're only developing locally, so we only indicate the name. `-f` indicates the file containing the build instructions for the container 


### run

docker run -d –p 5000:80 [YOURNAME-CONTAINER]

This is going to bind host port 5000 to container port 80. It's going to run in detached mode, which means in the background. 

### modify

Now we want to explore making a change and rebuilding the container:
goto : workshop_materials/Docker/sample-container/aspnetapp/Views/Home/Index.cshtml - Update with your name. 

We're going to build like we did before, but this time we're going to tag our new version

Docker build -t [YOURNAME-CONTAINER]:2.0 -f Dockerfile .  


Docker run –p 5001:80 [YOURNAME-CONTAINER]:2.0 

Notice we've incremented the port number here and are specifically running version 2.0 of the container. 

Browse to localhost:5001​ and localhost:5000 to compare websites

​



​

​

​

​

​

​

​
