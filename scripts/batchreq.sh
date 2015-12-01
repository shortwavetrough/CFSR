#!/bin/sh

# Add pass to env var ($pswd)
echo "Authenticating..."
curl -c auth -d "email=user@foo.com&passwd=$pswd&action=login" https://rda.ucar.edu/cgi-bin/login

echo "Initializing..."
dir=$WORKDIR/WRF_data/CFSR
# yearb=previous year; yeare=current year
yearb=2013
yeare=2014
# CFSR version
# version=1 -> 1979-2010; version=2 -> 2011+
version=2
# Only 10 requests at 1 time
# Set to true for first 10 requests, then set to false for last 6 requests
FIRSTPASS=false

if [ ! -d "$dir/$yeare" ]; then
  echo "Directory does not exist..."
  echo "Exiting"
  exit
else
   cd $dir/$yeare/
fi

if [ ! -d "HGT_p" ]; then
  mkdir HGT_p/
fi
if [ ! -d "ICE" ]; then
  mkdir ICE/
fi
if [ ! -d "LANDSEA" ]; then
  mkdir LANDSEA/
fi
if [ ! -d "PMSL" ]; then
  mkdir PMSL/
fi
if [ ! -d "P_sfc" ]; then
  mkdir P_sfc/
fi
if [ ! -d "RH_p" ]; then
  mkdir RH_p/
fi
if [ ! -d "RH_sfc" ]; then
  mkdir RH_sfc/
fi
if [ ! -d "SKINTEMP" ]; then
  mkdir SKINTEMP/
fi
if [ ! -d "SM" ]; then
  mkdir SM/
fi
if [ ! -d "SNOW" ]; then
  mkdir SNOW/
fi
if [ ! -d "SOILHGT" ]; then
  mkdir SOILHGT/
fi
if [ ! -d "ST" ]; then
  mkdir ST/
fi
if [ ! -d "TT_p" ]; then
  mkdir TT_p/
fi
if [ ! -d "TT_sfc" ]; then
  mkdir TT_sfc/
fi
if [ ! -d "UV_p" ]; then
  mkdir UV_p/
fi
if [ ! -d "UV_sfc" ]; then
  mkdir UV_sfc/
fi

if [ "$FIRSTPASS" = true ]; then
  cp $dir/scripts/auth HGT_p/.
  cp $dir/scripts/auth ICE/.
  cp $dir/scripts/auth LANDSEA/.
  cp $dir/scripts/auth PMSL/.
  cp $dir/scripts/auth P_sfc/.
  cp $dir/scripts/auth RH_p/.
  cp $dir/scripts/auth RH_sfc/.
  cp $dir/scripts/auth SKINTEMP/.
  cp $dir/scripts/auth SM/.
  cp $dir/scripts/auth SNOW/.

  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-HGT_p.sh > $dir/$yeare/HGT_p/getcfsr-HGT_p.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-ICE.sh > $dir/$yeare/ICE/getcfsr-ICE.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-LANDSEA.sh > $dir/$yeare/LANDSEA/getcfsr-LANDSEA.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-PMSL.sh > $dir/$yeare/PMSL/getcfsr-PMSL.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-P_sfc.sh > $dir/$yeare/P_sfc/getcfsr-P_sfc.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-RH_p.sh > $dir/$yeare/RH_p/getcfsr-RH_p.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-RH_sfc.sh > $dir/$yeare/RH_sfc/getcfsr-RH_sfc.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-SKINTEMP.sh > $dir/$yeare/SKINTEMP/getcfsr-SKINTEMP.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-SM.sh > $dir/$yeare/SM/getcfsr-SM.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-SNOW.sh > $dir/$yeare/SNOW/getcfsr-SNOW.sh

  echo "Requesting..."
  cd $dir/$yeare/HGT_p/
  sh ./getcfsr-HGT_p.sh
  cd $dir/$yeare/ICE/
  sh ./getcfsr-ICE.sh
  cd $dir/$yeare/LANDSEA/
  sh ./getcfsr-LANDSEA.sh
  cd $dir/$yeare/PMSL/
  sh ./getcfsr-PMSL.sh
  cd $dir/$yeare/P_sfc/
  sh ./getcfsr-P_sfc.sh
  cd $dir/$yeare/RH_p/
  sh ./getcfsr-RH_p.sh
  cd $dir/$yeare/RH_sfc/
  sh ./getcfsr-RH_sfc.sh
  cd $dir/$yeare/SKINTEMP/
  sh ./getcfsr-SKINTEMP.sh
  cd $dir/$yeare/SM/
  sh ./getcfsr-SM.sh
  cd $dir/$yeare/SNOW/
  sh ./getcfsr-SNOW.sh
else
  cp $dir/scripts/auth SOILHGT/.
  cp $dir/scripts/auth ST/.
  cp $dir/scripts/auth TT_p/.
  cp $dir/scripts/auth TT_sfc/.
  cp $dir/scripts/auth UV_p/.
  cp $dir/scripts/auth UV_sfc/.

  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-SOILHGT.sh > $dir/$yeare/SOILHGT/getcfsr-SOILHGT.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-ST.sh > $dir/$yeare/ST/getcfsr-ST.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-TT_p.sh > $dir/$yeare/TT_p/getcfsr-TT_p.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-TT_sfc.sh > $dir/$yeare/TT_sfc/getcfsr-TT_sfc.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-UV_p.sh > $dir/$yeare/UV_p/getcfsr-UV_p.sh
  sed -e 's/yr_b/'${yearb}'/g' \
      -e 's/yr_e/'${yeare}'/g' \
      < $dir/scripts/request/v$version/getcfsr-UV_sfc.sh > $dir/$yeare/UV_sfc/getcfsr-UV_sfc.sh

  echo "Requesting..."
  cd $dir/$yeare/SOILHGT/
  sh ./getcfsr-SOILHGT.sh
  cd $dir/$yeare/ST/
  sh ./getcfsr-ST.sh
  cd $dir/$yeare/TT_p/
  sh ./getcfsr-TT_p.sh
  cd $dir/$yeare/TT_sfc/
  sh ./getcfsr-TT_sfc.sh
  cd $dir/$yeare/UV_p/
  sh ./getcfsr-UV_p.sh
  cd $dir/$yeare/UV_sfc/
  sh ./getcfsr-UV_sfc.sh
fi

echo "Job complete..."
