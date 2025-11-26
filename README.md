<h1>🚀 Node.js App with Jenkins CI/CD Pipeline</h1>
This project demonstrates a complete **Continuous** Integration and Continuous  __Deployment__  (CI/CD) pipeline using Jenkins and Docker for a simple Node.js application.

**Continuous**

**This text will be bold**
__This text will also be bold__


<h2>🎯 Objective</h2>
To automate the process of building, testing, and deploying a Node.js application using Jenkins.

<h2>🧰 Tools Used</h2>

* Node.js
* Jenkins
* Docker
* GitHub

<h2>📁 Folder Structure</h2>

```
node-app-jenkins-cicd/
├── app.js          # Node.js app entry point
├── Dockerfile      # Docker image configuration
├── Jenkinsfile     # Jenkins pipeline script
└── README.md       # Documentation
```

<h2>🔧 Prerequisites</h2>
Ensure the following are installed:

* Jenkins
* Docker
* Git
* Node.js (on your local machine for development)
* GitHub account

<h2>🛠️ Step-by-Step Workflow</h2>
<h3>1️⃣ Clone the Project</h3>

```
git clone https://github.com/<your-username>/node-app-jenkins-cicd.git
cd node-app-jenkins-cicd
```

<h3>2️⃣ Review the Application Code</h3>

app.js

```
const http = require("http");
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.end("Hello from Jenkins CI/CD Pipeline!");
});

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});
```

<h3>3️⃣ Create the Dockerfile</h3>
<h3>Dockerfile</h3>

```
FROM node:14
WORKDIR /app
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
```

<h3>4️⃣ Create the Jenkins Pipeline Script</h3>
<h3>Jenkinsfile</h3>

```
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
```

<h3>5️⃣ Configure Jenkins</h3>

1. Go to Jenkins Dashboard → New Item
2. Enter item name → Select Pipeline
3. In the Pipeline configuration:
    * Choose Pipeline script from SCM
    * SCM: Git
    * Enter your GitHub repo URL
    * Script Path: Jenkinsfile

<h3>6️⃣ Optional: Configure GitHub Webhook</h3>
To trigger builds automatically on push:

* Go to GitHub Repo → Settings → Webhooks
* Payload URL: http://<your-jenkins-ip>:8080/github-webhook/
* Content type: application/json
* Select: Just the push event

<h3>7️⃣ Trigger the Pipeline</h3>
Make a change and push to GitHub:

```
echo "// trigger build" >> app.js
git add .
git commit -m "Trigger Jenkins pipeline"
git push
```

Check Jenkins dashboard for job execution.

<h3>8️⃣ Access the Running App</h3>
Open in your browser:

```
http://<your-jenkins-ip>:3000
```

Expected output:

```
Hello from Jenkins CI/CD Pipeline!
```

<h2>✅ Conclusion</h2>
You’ve successfully set up a Jenkins CI/CD pipeline for a Node.js app using Docker. This setup automatically builds, tests, and deploys your app on every code push.

