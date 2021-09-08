![example workflow](https://github.com/dalmatialab/zookeeper/actions/workflows/main.yml/badge.svg)

# Supported tags and respective Dockerfile links

 - 3.6.3-rc-1
 - 3.6.3-rc-2

# What is Zookeeper ? 

[ZooKeeper](https://zookeeper.apache.org/) is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications. Each time they are implemented there is a lot of work that goes into fixing the bugs and race conditions that are inevitable. Because of the difficulty of implementing these kinds of services, applications initially usually skimp on them, which make them brittle in the presence of change and difficult to manage. Even when done correctly, different implementations of these services lead to management complexity when the applications are deployed.

<img src="https://github.com/dalmatialab/zookeeper/blob/0ed4fa437c993300657ae34a5896674b75ba6ac2/logo.png?raw=true" width="250" height="150">

# How to use this image

## Start Zookeeper instance

    $ docker run -d --name some-zookeeper-name --hostname some-zookeeper-hostname-N image:tag

Where:

 - `some-zookeeper-name` is name you want to assign to your container
 - `some-zookeeper-hostname-N` is container hostname. N stands for instance number (0,1,...,N).  
   **It is important to follow name format or container wont start.** (e.g zookeeper-0, zookeeper-1, ... , zookeeper-N)
 - `image` is Docker image name
 - `tag` is Docker image version

## Environment variables

**TZ**

This is *optional* variable. It specifes timezone. Default value is `Europe/Zagreb`.

## Ports

This image includes EXPOSE 2181 2888 3888 8080 (the Zookeeper client port, follower port, election port, AdminServer port)

## Volumes

To save Zookeeper data mount container path `/var/lib/zookeeper` to host path.

    $ -v some-host-path:/var/lib/zookeeper

# License

