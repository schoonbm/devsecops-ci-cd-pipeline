pipeline {
    agent {
        docker {
            image 'jenkins-agent-secure:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock' // for Docker inside Docker
        }
    }
    environment {
        MAVEN_OPTS = "-Dmaven.repo.local=.m2"
    }
    stages {
        stage('Clean workspace') {
            steps {
                deleteDir()
            }
        }
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/schoonbm/DevSecOps-CI-CD-Pipeline.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        stage('Trivy Scan') {
            steps {
                sh 'trivy fs . --exit-code 0 --severity HIGH,CRITICAL'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t secureapp:latest .'
            }
        }
        stage('Trivy Image Scan') {
            steps {
                sh 'trivy image secureapp:latest --exit-code 0 --severity HIGH,CRITICAL'
            }
        }
    }
}
