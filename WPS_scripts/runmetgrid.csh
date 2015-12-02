#!/bin/csh -f
# Script used to run ungrib to generate intermediate files.

date -u

set st_gdir = $WORKDIR/WPS/WPS
set st_idir = $WORKDIR/WRF_data/CFSR/intmdt
set st_mdir = $WORKDIR/WRF_data/CFSR/metgrid
set st_y = 2013

set q = 2
#while ($q <= 5)
while ($q <= 2)
  rsync -av --progress --exclude 'geog' WPS/ WPS$q/
  cd WPS$q/

  set sim_name = 'r'$st_y

  echo 'Setting pbs for '$sim_name
  sed -e 's/yr_b/'$st_y'/g' \
      -e 's;m_dir;'$st_mdir';g' \
      < metgrid.pbs > $sim_name'_metgrid.pbs'

  echo 'Setting namelist for '$sim_name
  sed -e 's/yr_b/'$st_y'/g' \
      -e 's;g_dir;'$st_gdir';g' \
      -e 's;i_dir;'$st_idir';g' \
      -e 's;m_dir;'$st_mdir';g' \
      < namelist.wps.STD > $sim_name'_namelist.wps'
  mv $sim_name'_namelist.wps' namelist.wps

  qsub {$sim_name}_metgrid.pbs

  cd ../
@ q ++
@ st_y ++
date -u
end
