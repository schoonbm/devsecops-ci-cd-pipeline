# DevSecOps CI/CD Pipeline

An enhanced, end-to-end DevSecOps demonstration project integrating secure automation best practices into every stage of the Software Development Lifecycle (SDLC). Utilizing tools such as Jenkins, Docker, Trivy, SonarQube, OWASP ZAP, and Minikube (Kubernetes), this pipeline locally builds, tests, scans, and securely deploys a Java Spring Boot application.

---

## 🛠️ Technologies Used

- **Jenkins** - Automation server to orchastrate CI/CD
- **Custom Jenkins Docker Agent** - Pre-configured with Java 21, Maven, Docker CLI, Trivy, and Kubectl
- **Docker** - For building, scanning, and running containers
- **Trivy** - Container and dependency vulnerability scanning (SCA)
- **JUnit** - Unit testing with results archived in Jenkins
- **Minikube** Local Kubernetes cluster for containerized app deployment
- **SonarQube** - Static Application Security Testing (SAST) and code quality analysis
- **OWASP ZAP** - Dynamic Application Security Testing (DAST)
- **Docker Hub** - Container image registry
- **Gmail SMTP** - Jenkins email notifications

---

## 🚦 Pipeline Stages

1. Build Spring Boot app with Maven
2. Run unit tests and archive JUnit results
3. Scan dependencies and image using Trivy
4. Build Docker image and push to Docker Hub
5. Deploy to Minikube via `kubectl apply`
6. Run DAST scan with OWASP ZAP container
7. Archive ZAP report and publish in Jenkins
8. Send email notifications with build status

---

## 📖 About This Project

This project provides a hands-on simulation of a real-world DevSecOps pipeline, showcasing best practices in secure CI/CD automation. It demonstrates the integration of continuous security scanning throughout each stage of software delivery, fully automated using Jenkins and open-source security tools.

Designed for educational purposes, this project highlights practical skills in DevOps, security automation, and secure software development.

---

## 📸 Screenshots

### ✅ Jenkins Pipeline Execution
<img width="1705" height="818" alt="image" src="https://github.com/user-attachments/assets/d789ed7a-fae9-48c7-9cc7-18b3c9239134" />

<img width="1706" height="1075" alt="image" src="https://github.com/user-attachments/assets/dc23f106-885d-4644-9e90-dbfe294e95ec" />

<img width="1357" height="888" alt="image" src="https://github.com/user-attachments/assets/4f52c0f2-4429-47fe-8a74-cf547821b470" />

### 🔍 Trivy Scan Results in Jenkins

<img width="1637" height="863" alt="image" src="https://github.com/user-attachments/assets/da2d50dc-fcda-47ea-8b77-d5e2c225f07c" />

<img width="1600" height="1121" alt="image" src="https://github.com/user-attachments/assets/ae990024-e38a-4890-a1ad-094033ae07a1" />

<img width="1601" height="429" alt="image" src="https://github.com/user-attachments/assets/68200cc8-98e2-40f9-816e-3c4509eadf94" />

### 🧪 Unit Test Results Archive

<img width="1632" height="1012" alt="image" src="https://github.com/user-attachments/assets/34ce3c2f-4f47-455b-ad41-f9d41f668406" />

<img width="1707" height="813" alt="image" src="https://github.com/user-attachments/assets/d52e40bf-33dd-4c33-a50d-57a6d441499f" />

### 🐳 Docker Image Successfully Pushed

<img width="1307" height="410" alt="image" src="https://github.com/user-attachments/assets/a9c20c26-bdf7-45e9-8765-4ecb8ab7ee7a" />

<img width="1898" height="591" alt="image" src="https://github.com/user-attachments/assets/106cd46a-427c-4d59-aef0-427c4744ea0a" />

### 🚀 App Deployed on Minikube

<img width="1633" height="248" alt="image" src="https://github.com/user-attachments/assets/71f3581f-ba1f-4d51-a6fc-1739171050fe" />

<img width="405" height="142" alt="image" src="https://github.com/user-attachments/assets/1ac24379-a7ed-4cc0-9b6f-a94f4bd257cb" />

### 🛡️ OWASP ZAP Report

<img width="1701" height="927" alt="image" src="https://github.com/user-attachments/assets/a95c9a8b-8aed-4884-8cf0-0f97ab87151c" />

### 🎯 SonarQube Static Code Analysis

<img width="1704" height="991" alt="image" src="https://github.com/user-attachments/assets/b5dd43a3-d884-4410-a203-f19d896d0780" />

---

## 📬 Contact

If you'd like to discuss the project, feel free to connect!

> Mirela Schoonbeck | [LinkedIn](https://www.linkedin.com/in/mirela-schoonbeck/)
