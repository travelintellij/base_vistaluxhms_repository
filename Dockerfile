# Stage 1: Build the application
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY mvnw .
COPY .mvn ./.mvn
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/AshokaCRM-*.war app.war

# Expose the port (Render will override this with its own $PORT)
EXPOSE 8080

# Run the application with the Render-provided PORT (defaults to 8080)
ENTRYPOINT ["java", "-Dserver.port=${PORT:-8080}", "-jar", "app.war"]
