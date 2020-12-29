pipeline {

    agent any
    
    environment {
        PASS = credentials('registry-pass') 
    }

    stages {

        stage('Build') {
            steps {
                sh '''
                    
                    echo 'build steps'

                '''
            }

        }

        stage('Test') {
            steps {
                sh 'echo "Test"'
            }

        }

        stage('Push') {
            steps {
                sh 'echo "Push Image"'
            }
        }

        stage('Deploy') {
            steps {
                sh 'echo "Deploy"'
            }
        }
    }
}
