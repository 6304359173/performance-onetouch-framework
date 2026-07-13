FROM eclipse-temurin:11-jre

ENV JMETER_VERSION=5.6.3
ENV JMETER_HOME=/opt/jmeter
ENV PATH="${JMETER_HOME}/bin:${PATH}"

RUN apt-get update && \
    apt-get install -y wget unzip dos2unix && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.zip && \
    unzip apache-jmeter-${JMETER_VERSION}.zip && \
    mv apache-jmeter-${JMETER_VERSION} ${JMETER_HOME} && \
    rm apache-jmeter-${JMETER_VERSION}.zip

WORKDIR /tests

COPY run-jmeter.sh /usr/local/bin/run-jmeter.sh

RUN dos2unix /usr/local/bin/run-jmeter.sh && \
    chmod +x /usr/local/bin/run-jmeter.sh

ENTRYPOINT ["sh", "/usr/local/bin/run-jmeter.sh"]