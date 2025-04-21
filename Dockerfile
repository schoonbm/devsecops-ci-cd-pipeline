FROM eclipse-temurin:21-jdk
COPY secureapp/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]