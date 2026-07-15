FROM justb4/jmeter:latest

WORKDIR /tests

COPY jmeter /tests/jmeter
COPY config /tests/config
COPY docker/run-jmeter.sh /run-jmeter.sh

RUN sed -i 's/\r$//' /run-jmeter.sh && chmod +x /run-jmeter.sh

ENTRYPOINT ["/bin/sh", "/run-jmeter.sh"]