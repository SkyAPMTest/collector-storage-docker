# build artifact
FROM maven:3.5.3-jdk-8-alpine as builder

COPY src /h2/src
COPY pom.xml /h2/pom.xml

WORKDIR /h2

RUN mvn package

# build docker image
FROM openjdk:8u151-jdk-alpine3.7

# TZ default Asia/Shanghai,if you want modify TZ,
# use `docker build --build-arg TZ=xxx/xxx` to change it
ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV MODULE h2

RUN apk upgrade --update \
    && apk add bash curl ca-certificates \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=builder /${MODULE}/target/${MODULE}*jar /${MODULE}.jar

CMD ["bash","-c","java -jar /${MODULE}.jar"]
