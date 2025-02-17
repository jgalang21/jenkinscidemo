pipeline {
 agent any
 stages {
    stage('Clone Repository'){
        steps{
            git branch: 'main', url: 'https://github.com/jgalang21/jenkinscidemo.git'
        }
    }
    stage('Build Docker Image') {
        steps {
            script{
                docker.build("datajeremy/jenkinssci-demo:${env.BUILD_ID}")
            }
        }
    }
 }

 post{
    always{
        cleanWs()
    }
 }

}