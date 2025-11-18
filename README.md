<h1>✅ Jenkinsfile (Basic CI/CD Pipeline with Docker)</h1>

Copy & paste this into a file named Jenkinsfile in your repository:

```
pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp-image"
        CONTAINER_NAME = "myapp-container"
        DOCKERHUB_USER = "your-dockerhub-username"
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
                script {
                    sh """
                        docker build -t ${IMAGE_NAME}:latest .
                    """
                }
            }
        }

        stage('Tag & Push to DockerHub') {
            steps {
                echo "Tagging and pushing Docker image..."
                script {
                    sh """
                        docker tag ${IMAGE_NAME}:latest ${DOCKERHUB_USER}/${IMAGE_NAME}:latest
                        docker login -u ${DOCKERHUB_USER} -p \$DOCKERHUB_PASSWORD
                        docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Deploy Container') {
            steps {
                echo "Deploying Docker container..."
                script {
                    sh """
                        docker stop ${CONTAINER_NAME} || true
                        docker rm ${CONTAINER_NAME} || true
                        docker pull ${DOCKERHUB_USER}/${IMAGE_NAME}:latest
                        docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${DOCKERHUB_USER}/${IMAGE_NAME}:latest
                    """
                }
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

```

<h2>📝 What You Need to Configure</h2>
<h3>✔️ 1. Add DockerHub credentials in Jenkins</h3>

Go to: Jenkins → Manage Credentials

Add:

ID: dockerhub

Username: your-dockerhub-user

Password: your-access-token

<h3>✔️ 2. Add environment variable in Jenkins</h3>

Go to your job → Configure → Build Environment → Use secret text(s)

Secret variable: DOCKERHUB_PASSWORD

Select your DockerHub credential

<h2>🧩 Folder Structure Example</h2>
```
your-app/
 ├── Dockerfile
 ├── app.js / index.html / main.py (your code)
 └── Jenkinsfile

```

<h2>🚀 What This Pipeline Does</h2>
<h3> Stage	                             Description          </h3>
Checkout Code	                Pulls code from your repo
Build Docker Image	            Builds your app into a Docker image
Tag & Push to DockerHub     	Pushes image → DockerHub registry
Deploy Container	            Pulls latest image & runs the container