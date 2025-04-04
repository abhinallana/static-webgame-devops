pipeline{
    agent any
    
    environment{
        IMAGE_NAME = 'webapp'
        TAG ='v1'
        KUBECONFIG = '/root/.minikube/config/config'
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
                echo "Docker Version"
                sh 'docker --version'
                withCredentials([usernamePassword(credentialsId: 'DockerCreds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
                }
            }
        stage ("Docker Build"){
            steps{
                sh "docker build -t abhinallana/${IMAGE_NAME}:${TAG} ."
            }
        }
        
        stage ("Push to Docker Hub"){
            steps{
                echo "Pushing Docker Image"
                sh "docker push abhinallana/${IMAGE_NAME}:${TAG}"
                
            }
        }

        //Deploy to Kubernetes Minikube Cluster

        stage ("Deploy to Kubernetes"){
            steps{
                echo "Deploying to Kubernetes"
                sh "kubectl apply -f k8s/pod-exec-rbac.yml"
                sh "kubectl apply -f k8s/nginx-configmap.yml"
                sh "kubectl apply -f k8s/deployment.yml"
                sh "kubectl apply -f k8s/service.yml"
            }
        }
}
}
