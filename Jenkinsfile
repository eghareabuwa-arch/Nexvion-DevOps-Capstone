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

    }
}