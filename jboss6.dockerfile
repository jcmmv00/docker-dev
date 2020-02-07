FROM jboss/base-jdk:8

#Cambio de usuario a root para realizar instalaciones y configuraciones del contenedor
USER root

# Instalacion de maven
RUN yum -y update && \
yum -y install sudo maven && \
yum clean all

#Copia de la carpeta que tiene el jboss
COPY  jboss-6.1.0.Final /opt/jboss

# Creación de variables de sistema en el contenedor
ENV LAUNCH_JBOSS_IN_BACKGROUND true
ENV JBOSS_HOME /opt/jboss

# Habilitar que los archivos sean ejecutables
RUN cd $HOME \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

#Cambio de usuario a jboss
USER jboss

ENV JAVA_OPTS="-Xmx2048m -Xms1024m"

# Puertos expuestos del contenedor
EXPOSE 8080 8787

WORKDIR /opt/jboss

CMD ["/opt/jboss/bin/run.sh", "-c", "default", "-b", "0.0.0.0"]
