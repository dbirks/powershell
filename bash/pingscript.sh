#!/bin/bash

# Ping Google's DNS server approximately every 10 seconds and write the current
# date, time, and ping times to ping.log.

# Example output:
# 02/15/2016 11:26:54 AM - rtt min/avg/max/mdev = 50.755/50.755/50.755/0.000 ms

while [ 1 ]
do date +"%x %X - `ping -c1 8.8.8.8|grep rtt`" >> ping.log
sleep 10
done
