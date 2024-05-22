FROM registry.access.redhat.com/ubi8-minimal

ENV KEYCLOAK_VERSION 14.0.0
ENV JDBC_POSTGRES_VERSION 42.3.1
ENV JDBC_MYSQL_VERSION 8.0.28
ENV JDBC_MARIADB_VERSION 2.7.4
ENV JDBC_MSSQL_VERSION 9.4.1.jre11

ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING false
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8

ARG GIT_REPO
ARG GIT_BRANCH
ARG KEYCLOAK_DIST=https://github.com/keycloak/keycloak/releases/download/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz

USER root

RUN microdnf update -y && microdnf install -y glibc-langpack-en gzip hostname java-11-openjdk-headless openssl tar which && microdnf clean all

ADD tools /opt/jboss/tools
RUN chmod +x /opt/jboss/tools/build-keycloak.sh
RUN /opt/jboss/tools/build-keycloak.sh

USER 1000

EXPOSE 8080
EXPOSE 8443

RUN chmod +x /opt/jboss/tools/*.*

ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]