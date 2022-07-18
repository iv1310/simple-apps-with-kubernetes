#!groovy

pipeline {
	agent any
	options {
		timestamps()
		buildDiscarder(logRotator(numToKeepStr: '5'))
	}

	stages {
		stage("Build") {
			steps {
				sh """
					docker-compose -f autoapp/docker-compose.yaml run --rm builder
					docker-compose -f simple-node-app/docker-compose.yaml run --rm builder
				"""
			}
		}
		stage("Build docker images") {
			steps {
				withCredentials([string(credentialsId: 'b38c2444-c9e2-4893-afb6-593e3b46ec37', variable: 'CR_PAT')]) {
					sh """
						_MODULE=autoapp ./build-push-image.sh ghcr.io/iv1310 ${BUILD_NUMBER}
						_MODULE=simple-node-app ./build-push-image.sh ghcr.io/iv1310 ${BUILD_NUMBER}
					"""
				}
			}
		}
	}
}
