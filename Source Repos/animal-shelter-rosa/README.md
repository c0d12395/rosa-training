# Animal Shelter - Java/Spring

## Database Load Script
- [PostgreSQL Load Script (1000 records)](./animals-pg-load-script.sql)

## API Documentation
- [Simple Autos API Documentation (Swagger)](./api-docs-openapi.yaml)

## Local Setup Instructions

1. **Prerequisites**
   - Ensure Java JDK 17 is installed on your system.

2. **Build the Application**
   - Run the following command to clean and package the project:
     ```bash
     ./mvnw clean package
     ```

3. **Run the Application with an H2 In-Memory Database**
   - Use this command to run the application with a test profile:
     ```bash
     ./mvnw spring-boot:run -Dspring-boot.run.profiles=test
     ```

4. **Run the Application with a PostgreSQL Database**
   - Export the following environment variables to configure the PostgreSQL database connection:
     ```bash
     export DB_HOST=postgres.galvanizelabs.net
     export DB_PORT=5432 
     export DB_NAME=animals 
     export DB_USER=animals 
     export DB_PWD=animals123
     ```
   - Then start the application:
     ```bash
     ./mvnw spring-boot:run
     ```

5. **Spring Boot Actuator**
   - Spring Boot Actuator provides production-ready features to help monitor and manage your application. It includes endpoints for health checks, metrics, and more. These endpoints can be accessed to gain insights into the application’s state and ensure it’s running correctly. By default, the health endpoint is available at:  
     [http://localhost:8080/actuator/health](http://localhost:8080/actuator/health)

6. Test the application at this path: `http://localhost:8080/animals`. This may change depending on where the application is run/deployed.
    - Endpoint can be found in `src/main/java/com/galvanize/controller/AnimalController.java`
