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
                sh '''
                     ls -l
                     export IMAGE=$Image && export BUILD_TAG=$BUILD_ID && mkdir tmp
                     docker-compose config > tmp/docker-compose.yml
                     rsync -a tmp/docker-compose.yml --rsync-path="sudo rsync" 192.168.56.102:/opt/docker-compose.yml
                     ssh 192.168.56.102 "docker login -u jenkinsmeetup -p $PASS && cd /opt && sudo docker-compose up -d"  
		'''
            }
        }
    }
}
