pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp-image"
        CONTAINER_NAME = "myapp-container"
        DOCKERHUB_USER = "kishorecloud7"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Checking out code..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                echo "Logging in to DockerHub..."
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'kishorecloud7',
                        passwordVariable: 'Kishore&kishore123'
                    )
                ]) {
                    sh '''
                        echo "$Kishore&kishore123" | docker login -u "$kishorecloud7" --password-stdin
                    '''
                }
            }
        }

        stage('Tag & Push to DockerHub') {
            steps {
                echo "Tagging & pushing image..."
                sh '''
                    docker tag ${IMAGE_NAME}:latest ${kishorecloud7}/${IMAGE_NAME}:latest
                    docker push ${kishorecloud7}/${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                echo "Deploying Docker container..."
                sh '''
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker pull ${kishorecloud7}/${IMAGE_NAME}:latest
                    docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${kishorecloud7}/${IMAGE_NAME}:latest
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment Successful!"
        }
        failure {
            echo "Pipeline Failed!"
        }
    }
}
