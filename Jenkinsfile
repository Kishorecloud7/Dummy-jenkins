pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                echo '🔧 Building the Docker image...'
                sh 'docker build -t my-node-app .'
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running tests (placeholder)...'
                sh 'echo "Tests passed!"'
            }
        }

        stage('Deploy Docker Container') {
            steps {
                echo '🚀 Deploying the Docker container...'
                sh '''
                docker stop my-node-app || true
                docker rm my-node-app || true
                docker run -d -p 3000:3000 --name my-node-app my-node-app
                '''
            }
        }
    }
}