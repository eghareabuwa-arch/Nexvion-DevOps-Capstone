pipeline {
    agent any

    stages {

        stage('Validate') {
            steps {
                sh '''
                    echo "Validating Nexvion application..."
                    test -f index.html
                    test -f style.css
                    test -f script.js
                    test -f Dockerfile
                    echo "Application validation successful."
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    echo "Building Nexvion Docker image..."
                    docker build -t nexvion:${BUILD_NUMBER} .
                '''
            }
        }

stage('Security Scan') {
    steps {
        sh '''
            echo "Scanning Nexvion Docker image for vulnerabilities..."

            docker run --rm \
              -v /var/run/docker.sock:/var/run/docker.sock \
              aquasec/trivy:latest image \
              --timeout 60m \
              --severity HIGH,CRITICAL \
              --exit-code 0 \
              nexvion:${BUILD_NUMBER}

            echo "Trivy security scan completed."
        '''
    }
}

stage('Push to Docker Hub') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-credentials',
            usernameVariable: 'DOCKERHUB_USER',
            passwordVariable: 'DOCKERHUB_TOKEN'
        )]) {
            sh '''
                echo "Tagging Nexvion image for Docker Hub..."
                docker tag nexvion:${BUILD_NUMBER} ${DOCKERHUB_USER}/nexvion:${BUILD_NUMBER}

                echo "Logging in to Docker Hub..."
                echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin

                echo "Pushing Nexvion image to Docker Hub..."
                docker push ${DOCKERHUB_USER}/nexvion:${BUILD_NUMBER}

                docker logout
            '''
        }
    }
}
        stage('Deploy') {
    steps {
        sh '''
            echo "Deploying Nexvion to Kubernetes..."

            kubectl --kubeconfig=/tmp/jenkins-kubeconfig \
              set image deployment/nexvion-deployment \
              nexvion=abuwa4real/nexvion:${BUILD_NUMBER}

            echo "Waiting for Kubernetes rollout..."
            kubectl --kubeconfig=/tmp/jenkins-kubeconfig \
              rollout status deployment/nexvion-deployment \
              --timeout=120s

            echo "Nexvion Kubernetes deployment completed."
        '''
    }
}

        stage('Health Check') {
    steps {
        sh '''
            echo "Checking Nexvion Kubernetes deployment..."

            kubectl --kubeconfig=/tmp/jenkins-kubeconfig \
              get pods -l app=nexvion

            kubectl --kubeconfig=/tmp/jenkins-kubeconfig \
              wait --for=condition=ready pod \
              -l app=nexvion \
              --timeout=120s

            echo "All Nexvion Kubernetes pods are healthy and ready."
        '''
    }
}

    post {
        success {
            echo 'Nexvion CI/CD pipeline completed successfully.'
        }

        failure {
            echo 'Nexvion CI/CD pipeline failed. Check the console output.'
        }
    }
}