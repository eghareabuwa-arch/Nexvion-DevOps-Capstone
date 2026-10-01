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
              --timeout 10m \
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
                    echo "Deploying Nexvion..."

                    docker rm -f nexvion-cicd || true

                    docker run -d \
                      --name nexvion-cicd \
                      -p 8085:80 \
                      nexvion:${BUILD_NUMBER}
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    echo "Waiting for Nexvion to start..."
                    sleep 3

                    echo "Checking application..."
                    curl -f http://host.docker.internal:8085/

                    echo "Nexvion deployment is healthy."
                '''
            }
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