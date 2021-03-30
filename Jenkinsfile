pipeline {
    agent any
    environment {
        PROJECT_ID = 'master-coder-297316'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'us-central1-a'
        CREDENTIALS_ID = 'master-coder-297316'
        DOCKER_TAG='latest'
        dockerImage=''
        registry='rrj66520/demo'
    }
    stages {
        stage("Checkout code") {
            steps {
                checkout scm
            }
        }
        stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
           docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
        }
      }
    }
        
        // stage("Push image") {
        //     steps {
        //         script {
        //             docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
        //                     myapp.push("latest")
        //                     myapp.push("${env.BUILD_ID}")
        //             }
        //         }
        //     }
        // }        
        stage('Deploy to GKE') {
            steps{
                sh "sed -i 's/hello:latest/demo:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
    }    
}