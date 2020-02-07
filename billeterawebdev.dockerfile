FROM alpine:3.8

RUN apk add --no-cache tar bash 
RUN apk add docker nodejs-current npm

#JAVA

RUN mkdir -p /usr/java/
COPY jdk-8u221-linux-x64.tar.gz /usr/java/

RUN mkdir -p /opt/java-jdk/ && \
 tar -zxf /usr/java/jdk-8u221-linux-x64.tar.gz --directory /opt/java-jdk/ && \
 rm /usr/java/jdk-8u221-linux-x64.tar.gz && \
 mv /opt/java-jdk/jdk1.8.0_221/* /opt/java-jdk/

ENV JAVA_VERSION=8
ENV JAVA_HOME="/opt/java-jdk/"
ENV GLIBC_VERSION=2.27-r0

RUN apk add --no-cache --virtual=build-dependencies libstdc++ curl ca-certificates unzip && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \ 
	ln -s "$JAVA_HOME/bin/"* "/usr/bin/" 

#MAVEN

RUN mkdir -p /usr/maven/
COPY apache-maven-3.6.3-bin.tar.gz /usr/maven/

RUN mkdir -p /opt/maven/ && \
 tar -zxf /usr/maven/apache-maven-3.6.3-bin.tar.gz --directory /opt/maven/ && \
 rm /usr/maven/apache-maven-3.6.3-bin.tar.gz && \
 mv /opt/maven/apache-maven-3.6.3/* /opt/maven/ && \
 ln -s /opt/maven/bin/mvn /usr/bin/mvn && \
 mkdir /root/.m2/

ENV MAVEN_HOME /usr/maven
ENV MAVEN_CONFIG "/root/.m2"
ENV MAVEN_OPTS="-Xmx4096m -Xms2048m"

WORKDIR /usr/mysources/

#BILLETERA_WEB_DESA
#Pegar settings maven
#Copia archivo init billetera web
RUN mkdir -p /usr/target
COPY settings.xml "/root/.m2"



CMD [""]

#container run -d -t --name javadev --mount type=bind,source=/c/Dev/Test1/mysources/,target=/usr/mysources/ java bash
#docker container run -d -t --name javadev --mount type=volume,dst=/root/.m2/,volume-driver=local,volume-opt=type=none,volume-opt=o=bind,volume-opt=device=/c/Dev/Test1/maven.m2/ --mount type=volume,dst=/opt/maven/,volume-driver=local,volume-opt=type=none,volume-opt=o=bind,volume-opt=device=/c/Dev/Test1/maven --mount type=volume,dst=/usr/mysources/,volume-driver=local,volume-opt=type=none,volume-opt=o=bind,volume-opt=device=/c/Dev/Test1/mysources/ billetera_web_dev:latest bash
