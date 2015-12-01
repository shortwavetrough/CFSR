#!/bin/sh

export RDAPSWD=foo

echo "Initializing..."
dir=$WORKDIR/WRF_data/CFSR
year=2015
# Only 10 requests at 1 time
# Set to true for first 10 requests, then set to false for last 6 requests
FIRSTPASS=false

if [ ! -d "$dir/$year" ]; then
  echo "Directory does not exist..."
  echo "Exiting"
  exit
fi

if [ "$FIRSTPASS" = true ]; then
  echo "Downloading..."
  cd $dir/$year/HGT_p/
  perl get_file.pl
  cd $dir/$year/ICE/
  perl get_file.pl
  cd $dir/$year/LANDSEA/
  perl get_file.pl
  cd $dir/$year/PMSL/
  perl get_file.pl
  cd $dir/$year/P_sfc/
  perl get_file.pl
  cd $dir/$year/RH_p/
  perl get_file.pl
  cd $dir/$year/RH_sfc/
  perl get_file.pl
  cd $dir/$year/SKINTEMP/
  perl get_file.pl
  cd $dir/$year/SM/
  perl get_file.pl
  cd $dir/$year/SNOW/
  perl get_file.pl
else
  echo "Downloading..."
  cd $dir/$year/SOILHGT/
  perl get_file.pl
  cd $dir/$year/ST/
  perl get_file.pl
  cd $dir/$year/TT_p/
  perl get_file.pl
  cd $dir/$year/TT_sfc/
  perl get_file.pl
  cd $dir/$year/UV_p/
  perl get_file.pl
  cd $dir/$year/UV_sfc/
  perl get_file.pl
fi

echo "Job complete..."
