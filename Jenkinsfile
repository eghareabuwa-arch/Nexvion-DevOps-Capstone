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