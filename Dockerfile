FROM openjdk:17-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y bash libxml2-utils && \
    apt-get clean

COPY . .

RUN apt-get update && apt-get install -y bash && chmod +x /app/validate.sh

ENTRYPOINT ["bash", "/app/validate.sh"]
