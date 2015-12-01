#!/bin/sh
# Modify startdate and enddate for dates of interest

curl -b auth -d "dsid=ds093.0&rtype=S&rinfo=dsnum=093.0;startdate=yr_b-12-31 00:00;enddate=yr_e-12-31 18:00;parameters=3%217-0.2-1:0.3.1;product=1;grid_definition=57;level=219;ststep=yes" http://rda.ucar.edu/php/dsrqst.php
