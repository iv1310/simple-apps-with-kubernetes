#!/bin/bash

function build_and_push_image (){
	REGISTRY_URL=$1
	SERVICE_NAME=$2
	TAG_NAME=$3
	DOCKERFILE=$4
	cache_image="true"
	docker pull $REGISTRY_URL/$SERVICE_NAME:$TAG_NAME || cache_image="false"
	if [ "${cache_image}" == "true" ]; then
		echo "Image is exist, use as cache image...."
	fi
	docker build -t $REGISTRY_URL/$SERVICE_NAME:$TAG_NAME -f $DOCKERFILE .
	docker push $REGISTRY_URL/$SERVICE_NAME:$TAG_NAME
	docker rmi $REGISTRY_URL/$SERVICE_NAME:$TAG_NAME
}

if [[ "${_MODULE}" == "autoapp" ]]; then
	cd ${_MODULE}
	build_and_push_image $1 goapp $2 Dockerfile
elif [[ "${_MODULE}" == "simple-node-app" ]]; then
	cd ${_MODULE}
	build_and_push_image $1 nodeapp $2 Dockerfile
fi
