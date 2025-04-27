pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub') // Replace with your Jenkins credentials ID
        DOCKER_IMAGE = 'ahmed416/newtest' // Replace with your Docker Hub username and image name
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh '''
                    echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin
                    docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh '''
                    docker stop my-container || true
                    docker rm my-container || true
                    docker run -d -p 4000:80 --name newtest $DOCKER_IMAGE
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}