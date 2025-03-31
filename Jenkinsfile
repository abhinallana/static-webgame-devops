pipeline{
    agent any
    
    environment{
        IMAGE_NAME = 'webgame'
        TAG ='v1'
    }
    
    stages{
        stage("Checkout from Github"){
            steps{
                git 'https://github.com/abhinallana/static-webgame-devops.git'
            }
        }
        stage ("Login to Docker"){
            steps{
                echo "Logging in to Docker"
                withCredentials([usernamePassword(credentialsId: 'DockerCreds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
                }
            }
        stage ("Docker Build"){
            steps{
                sh "docker build -t abhinallana/webgame:v1 ."
            }
        }
        
        stage ("Push to Docker Hub"){
            steps{
                echo "Pushing Docker Image"
                sh "docker push abhinallana/${IMAGE_NAME}:${TAG}"
                
            }
        }
}
}
