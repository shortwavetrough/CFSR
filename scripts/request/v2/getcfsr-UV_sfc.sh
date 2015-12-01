#!/bin/sh
# Modify startdate and enddate for dates of interest

curl -b auth -d "dsid=ds094.0&rtype=S&rinfo=dsnum=094.0;startdate=yr_b-12-31 00:00;enddate=yr_e-12-31 18:00;parameters=3%217-0.2-1:0.2.2,3%217-0.2-1:0.2.3;product=3;grid_definition=68;level=223;ststep=yes" http://rda.ucar.edu/php/dsrqst.php
