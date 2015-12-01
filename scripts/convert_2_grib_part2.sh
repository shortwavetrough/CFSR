#!/bin/sh

echo "Initializing..."
dir=$WORKDIR/WRF_data/CFSR
year=2015

if [ ! -d "$dir/$year" ]; then
  echo "Directory does not exist..."
  echo "Exiting"
  exit
fi

echo "Converting SM..."
cd $dir/$year/SM/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.SM.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting SNOW..."
cd $dir/$year/SNOW/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.SNOW.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting SOILHGT..."
cd $dir/$year/SOILHGT/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.SOILHGT.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting ST..."
cd $dir/$year/ST/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.ST.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting TT_p..."
cd $dir/$year/TT_p/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.TT_P.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting TT_sfc..."
cd $dir/$year/TT_sfc/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.TT_sfc.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting UV_p..."
cd $dir/$year/UV_p/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.UV_p.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting UV_sfc..."
cd $dir/$year/UV_sfc/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.UV_sfc.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Job complete..."
