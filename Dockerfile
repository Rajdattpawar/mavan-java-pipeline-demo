FROM openjdk:8-jre-alpine

RUN mkdir /app

COPY java-app/target/*.jar /app/app.jar

CMD java -jar /app/app.jar
