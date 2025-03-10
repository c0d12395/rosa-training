# Use Amazon Corretto JDK 17 as the base image
FROM amazoncorretto:17-alpine

# Set the working directory
WORKDIR /app

# Copy the application JAR file into the container (adjust if your JAR file name is different)
COPY target/animal-shelter-java-0.0.1-SNAPSHOT.jar app.jar

# Set default environment variable for database type
ENV SPRING_PROFILES_ACTIVE=test

# Expose the application port
EXPOSE 8080

# Define the entry point for the application
ENTRYPOINT ["java", "-jar", "app.jar"]