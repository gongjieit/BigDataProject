#!/bin/bash

flume-ng agent --conf /home/gj/apps/apache-flume-1.7.0-bin/conf --conf-file /home/gj/apps/apache-flume-1.7.0-bin/conf/logAnalysis.properties --name logAgent -Dflume.root.logger=DEBUG,console -Dflume.monitoring.type=http -Dflume.monitoring.port=34545