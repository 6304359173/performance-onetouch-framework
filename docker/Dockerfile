FROM eclipse-temurin:11-jre

ENV JMETER_VERSION=5.6.3
ENV JMETER_HOME=/opt/jmeter
ENV PATH=$JMETER_HOME/bin:$PATH

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.zip && \
    unzip apache-jmeter-${JMETER_VERSION}.zip && \
    mv apache-jmeter-${JMETER_VERSION} $JMETER_HOME && \
    rm apache-jmeter-${JMETER_VERSION}.zip

WORKDIR /tests

COPY run-jmeter.sh /run-jmeter.sh
RUN chmod +x /run-jmeter.sh

ENTRYPOINT ["/run-jmeter.sh"]