pipeline {

    agent any
   
    triggers{
      pollSCM('* * * * *')
    }
    
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
            post {
		success {
                  archiveArtifacts artifacts: 'java-app/target/*.jar', fingerprint: true
                }
            }

        }

        stage('Test') {
            steps {
                sh 'cd java-app/ && mvn test'
            }

            post {
                 always {
                        junit 'java-app/target/surefire-reports/*.xml'
                 }
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
                sh '''
                     ls -l
                     export IMAGE=$Image && export BUILD_TAG=$BUILD_ID
                     docker-compose config > docker-compose_new.yml
                     rsync -a docker-compose_new.yml --rsync-path="sudo rsync" 192.168.56.102:/opt/docker-compose.yml
                     ssh 192.168.56.102 "docker login -u jenkinsmeetup -p $PASS && cd /opt && sudo docker-compose up -d"  
		'''
            }
        }
    }
}
