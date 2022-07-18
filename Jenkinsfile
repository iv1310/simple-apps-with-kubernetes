#!groovy

pipeline {
	//agent { node { label 'slave' } }
	options {
		timestamps()
		ansiColor('xterm')
		buildDiscarder(logRotator(numToKeepStr: '5'))
	}

	stages {
		stage("Checkout") {
			steps {
				cleanWs()
				checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'ddb12ac2-9b29-4bbf-a47a-bf6356139a46', url: 'git@github.com:iv1310/simple-kubernetes-github-action.git']]])
			}
		}
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
