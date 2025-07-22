pipeline {
    agent {
        label 'secure-agent'
    }
    environment {
        MAVEN_OPTS = "-Dmaven.repo.local=.m2"
        KUBECONFIG = '/kube/.kube/config.docker'
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
        stage('Test') {
            steps {
                dir('secureapp') {
                    sh 'mvn test'
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('SAST Scan (SonarQube)') {
            environment {
                SONAR_HOST_URL = 'http://localhost:9000'
                SONAR_LOGIN = credentials('sonarqube-token')
            }
            steps {
                dir('secureapp') {
                    sh '''
                        sonar-scanner \
                        -Dsonar.projectKey=secureapp \
                        -Dsonar.sources=src \
                        -Dsonar.java.binaries=target \
                        -Dsonar.host.url=$SONAR_HOST_URL \
                        -Dsonar.login=$SONAR_LOGIN
                    '''
                }
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
        stage('Deploy to Minikube') {
            steps {
                dir('k8s') {
                    sh '''
                        kubectl apply -f deployment.yaml
                        kubectl rollout restart deployment secureapp
                        kubectl apply -f service.yaml   
                    '''
                }
            }
        }
        stage('DAST Scan (OWASP ZAP)') {
            agent {
                docker {
                    image 'zaproxy/zap-stable:latest'
                    args """
                    --network host \
                    -u root \
                    -v ${env.WORKSPACE}:/zap/wrk:rw \
                    -w /zap/wrk
                    """
                }
            }
            steps {
                sh '''
                    echo "Container CWD: $(pwd)"

                    zap-baseline.py \
                        -t http://192.168.49.2:30081/hello \
                        -r zap-report.html \
                        -J zap-report.json \
                        -I

                    ls -lah
                '''
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'zap-report.*', fingerprint: true
        }
    }
}
