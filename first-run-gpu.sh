#! /bin/bash
if [ $# -ge 2 ]
then    
	CONTAINER_VERSION="$2"
	CONTAINER_NAME="--name $1";
	echo "Creating container $1";
	if [ -z "$3" ]
	then
		CONTAINER_PORT=8888
	else
		CONTAINER_PORT=$3
	fi
else    
	echo "Usage: build.sh <name> <tf-version> [<port>=8888]. The tf-version matches the tag of the built image, you can find it using \"docker images\"."
fi
echo "Binding Nootebook Port 8888 to host $3.  TensorBoard port is 6006."
nvidia-docker run -p $CONTAINER_PORT:8888 -p 6006:6006 -v $PWD/../:/tf/ $CONTAINER_NAME -it edoardogiacomello/projectenv:$CONTAINER_VERSION

