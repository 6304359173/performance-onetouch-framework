#!/bin/sh

echo "Cleaning old reports..."

rm -rf /tests/reports/*
rm -f /tests/results/results.jtl

echo "Running JMeter..."

jmeter -n \
  -t /tests/jmeter/testplans/RestfulBooker.jmx \
  -q /tests/config/DEV.properties \
  -l /tests/results/results.jtl \
  -e \
  -o /tests/reports

echo "JMeter execution completed."