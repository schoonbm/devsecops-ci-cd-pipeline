pipeline {
    agent {
        docker {
            image 'jenkins-agent-secure:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /home/mirela/.kube:/root/.kube -v /home/mirela/.minikube:/root/.minikube -e KUBECONFIG=/root/.kube/config'
        }
    }
    environment {
        MAVEN_OPTS = "-Dmaven.repo.local=.m2"
        KUBECONFIG = '/root/.kube/config'
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
                    credentialsId: 'github-token',
                    url: 'https://github.com/schoonbm/devsecops-ci-cd-pipeline'

            }
        }
        stage('Build') {
            steps {
                dir('secureapp') {
                    sh 'mvn clean package'
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }
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
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag secureapp:latest schoonbm/secureapp:latest
                        docker push schoonbm/secureapp:latest
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                dir('secureapp') {
                    sh 'mvn test'
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Deploy to Minikube') {
            steps {
                dir('k8s') {
                    sh '''
                        echo "KUBECONFIG=$KUBECONFIG"
                        kubectl config get-contexts
                        kubectl config current-context
                        kubectl apply -f deployment.yaml --record
                        kubectl apply -f service.yaml   
                    '''
                }
            }
        }
    }
}
