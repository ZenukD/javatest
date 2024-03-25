# Використовуйте офіційний образ Maven для компіляції додатку
FROM maven:3.8.4-openjdk-17-slim AS build

# Встановлюємо робочу директорію в контейнері
WORKDIR /app

# Копіюємо файли вашого Java-додатку у контейнер
COPY pom.xml .
COPY src ./src

# Виконуємо збірку додатку з використанням Maven
RUN mvn clean package

# Використовуємо офіційний образ Java 17 для запуску додатку
FROM openjdk:17-jdk

# Встановлюємо робочу директорію в контейнері
WORKDIR /app

# Копіюємо JAR-файл додатку з контейнера build до контейнера run
COPY --from=build /app/target/simplecrud-0.0.1-SNAPSHOT.jar /app/simplecrud-0.0.1-SNAPSHOT.jar

# Запускаємо ваше Java-додаток
CMD ["java", "-jar", "simplecrud-0.0.1-SNAPSHOT.jar"]
