#!/bin/csh -f
# Script used to run ungrib to generate intermediate files.

date -u

set din = $WORKDIR/WRF_data/CFSR
set st_gdir = $WORKDIR/WPS/WPS
set st_idir = $WORKDIR/WRF_data/CFSR/intmdt
set st_y = 2014
set en_y = 2015

set q = 1
#while ($q <= 5)
while ($q <= 1)
  set st_wdir = $WORKDIR/WPS/WPS_ungrib_sfc$q
  rsync -av --progress WPS/ WPS_ungrib_sfc$q/
  cd WPS_ungrib_sfc$q/

  set sim_name = 'r'$st_y

  echo 'Linking data'
  ./link_grib.csh $din/$st_y/GRIB/sfc/*.grib

  echo 'Setting pbs for '$sim_name

  sed -e 's/yr_b/'$st_y'/g' \
      -e 's;i_dir;'$st_idir';g' \
      < ungrib.pbs > $sim_name'_ungrib.pbs'

  echo 'Setting namelist for '$sim_name
  sed -e 's/yr_b/'$st_y'/g' \
      -e 's/yr_e/'$en_y'/g' \
      -e 's;g_dir;'$st_gdir';g' \
      -e 's;w_dir;'$st_wdir';g' \
      < namelist.wps.SFC > $sim_name'_namelist.wps'
  mv $sim_name'_namelist.wps' namelist.wps

  qsub {$sim_name}_ungrib.pbs

  cd ../

  set st_wdir = $WORKDIR/WPS/WPS_ungrib_pl$q
  rsync -av --progress WPS/ WPS_ungrib_pl$q/
  cd WPS_ungrib_pl$q/

  set sim_name = 'r'$st_y

  echo 'Linking data'
  ./link_grib.csh $din/$st_y/GRIB/pres/*.grib

  echo 'Setting pbs for '$sim_name

  sed -e 's/yr_b/'$st_y'/g' \
      -e 's;i_dir;'$st_idir';g' \
      < ungrib.pbs > $sim_name'_ungrib.pbs'

  echo 'Setting namelist for '$sim_name
  sed -e 's/yr_b/'$st_y'/g' \
      -e 's/yr_e/'$en_y'/g' \
      -e 's;g_dir;'$st_gdir';g' \
      -e 's;w_dir;'$st_wdir';g' \
      < namelist.wps.PL > $sim_name'_namelist.wps'
  mv $sim_name'_namelist.wps' namelist.wps

  qsub {$sim_name}_ungrib.pbs

  cd ../

@ q ++
@ st_y ++
@ en_y ++
date -u
end
