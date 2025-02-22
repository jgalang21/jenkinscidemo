pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image and Run Tests') {
            steps {
                script {
                    // Build the Docker image up to the 'build' stage
                    sh 'docker build --target build -t datajeremy/jenkinsci-demo-build .'

                    // Ensure directories exist and copy artifacts
                    sh '''
                        # Clean up any existing container
                        docker rm -f build-container || true
                        docker create --name build-container datajeremy/jenkinsci-demo-build
                        mkdir -p /var/jenkins_home/workspace/DockerBuilder/test-coverage
                        mkdir -p /var/jenkins_home/workspace/DockerBuilder/test-reports
                        docker cp build-container:/my-react-app/test-coverage /var/jenkins_home/workspace/DockerBuilder/test-coverage
                        docker cp build-container:/my-react-app/test-reports/junit.xml /var/jenkins_home/workspace/DockerBuilder/test-reports/junit.xml
                        docker rm build-container
                    '''
                }
            }
        }
        stage('Build Final Production Image') {
            steps {
                script {
                    // Build the final Nginx production image
                    sh 'docker build -t datajeremy/jenkinsci-demo .'
                }
            }
        }
        stage('Publish Test Results') {
            steps {
                // Publish the JUnit test results
                junit 'test-reports/junit.xml'
            }
        }
    }
    post {
        always {
            cleanWs() // Clean workspace after build
        }
    }
}