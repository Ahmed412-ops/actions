pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ahmed416/newtest' // Replace with your Docker Hub username and image name
        IMAGE_TAG = 'v1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$IMAGE_TAG .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                    sh '''
                    echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
                    docker push $DOCKER_IMAGE:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                docker stop newtest || true
                docker rm newtest || true
                docker run -d -p 4000:80 --name newtest $DOCKER_IMAGE:$IMAGE_TAG
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
