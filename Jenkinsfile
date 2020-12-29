pipeline {

    agent any
    
    environment {
        PASS = credentials('dockerhub-cred') 
        Image ='java-maven-demo'
    }

    stages {

        stage('Build') {
            steps {
                sh '''
                   cd java-app/ && mvn -B -DskipTests clean package
                   cd ../ && docker build -t $Image:$BUILD_ID . 
                '''
            }

        }

        stage('Test') {
            steps {
                sh 'cd java-app/ && mvn test'
            }

        }

        stage('Push') {
            steps {
                sh '''
	          docker login -u jenkinsmeetup -p $PASS
                  docker tag  $Image:$BUILD_ID jenkinsmeetup/$Image:$BUILD_ID
                  docker push jenkinsmeetup/$Image:$BUILD_ID
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh 'echo "Deploy"'
            }
        }
    }
}
