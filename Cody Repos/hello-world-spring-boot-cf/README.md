# Hello World - Spring Boot

This is a simple Hello World application using Spring Boot.

## How to Build
./mvnw clean package

## How to Run
./mvnw spring-boot:run

## How to Test

- `http://localhost:8080/actuator/health` Actuator health check
- `http://localhost:8080/hello` Displays a hello message
- `http://localhost:8080/hello?name=John` Displays a personalized message 
- `http://localhost:8080/sid` Displays a unique `id` for each instance deployed 

## Spring Boot Actuator

Spring Boot Actuator provides production-ready features to help monitor and manage your application. It includes endpoints for health checks, metrics, and more. These endpoints can be accessed to gain insights into the application’s state and ensure it’s running correctly. By default, the health endpoint is available at:  
    [http://localhost:8080/actuator/health](http://localhost:8080/actuator/health)
