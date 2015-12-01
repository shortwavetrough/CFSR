#!/bin/sh

echo "Initializing..."
dir=$WORKDIR/WRF_data/CFSR
year=2015

if [ ! -d "$dir/$year" ]; then
  echo "Directory does not exist..."
  echo "Exiting"
  exit
fi

echo "Converting HGT_p..."
cd $dir/$year/HGT_p/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.HGT_p.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting ICE..."
cd $dir/$year/ICE/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.ICE.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting LANDSEA..."
cd $dir/$year/LANDSEA/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.LANDSEA.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting PMSL..."
cd $dir/$year/PMSL/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.PMSL.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting P_sfc..."
cd $dir/$year/P_sfc/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.P_sfc.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting RH_p..."
cd $dir/$year/RH_p/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.RH_p.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting RH_sfc..."
cd $dir/$year/RH_sfc/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.RH_sfc.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Converting SKINTEMP..."
cd $dir/$year/SKINTEMP/
mkdir GRIB/
FILE=*.grb2
for f in $FILE; do
  prefix=$(echo "${f%%.*}")
  fname=$prefix.SKINTEMP.grib
  cnvgrib -g21 $f GRIB/$fname
done

echo "Job complete..."
