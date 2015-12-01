#!/bin/sh
# Modify startdate and enddate for dates of interest

curl -b auth -d "dsid=ds093.0&rtype=S&rinfo=dsnum=093.0;startdate=yr_b-12-31 00:00;enddate=yr_e-12-31 18:00;parameters=3%217-0.2-1:0.2.2,3%217-0.2-1:0.2.3;product=1;grid_definition=57;level=76,77,78,79,80,562,81,563,82,557,83,84,85,86,87,88,89,90,91,92,93,574,94,577,95,581,96,97,98,99,100,101;ststep=yes" http://rda.ucar.edu/php/dsrqst.php
