#!/bin/csh -f
# Script used to run real over and over to create RACM boundary conditions.
# Note: this script creates lateral, lower, initial condition, and nudging files.
# Matt Higgins - 19 May 2010
# BJF - 03 February 2012

date -u

set yr1 = 2010

set x = 1
while ($x <= 5)

    @ yr2 = $yr1 + 1
    @ yr0 = $yr1 - 1  # previous year

    set stmon   = ('01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12')
    set enmon   = ('02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12' '01')

    set dy_b = '01'
    set dy_e = '01'

    set q = 1
    #set q = 9
    while ($q <= 12)

        mkdir -p 'CFSR/'$yr1'/'$stmon[$q]'/'
        cp -r WRFV3_single/ CFSR/$yr1/$stmon[$q]/

        set mo_b = $stmon[$q]
        set mo_e = $enmon[$q]
   
        if ($q <= 11) then
            set yr_b = $yr1
            set yr_e = $yr1
        else
            set yr_b = $yr1
            set yr_e = $yr2
        endif

#    @ v = $q - 1
#    set mo_pre = $stmon[$v]
  
        set sim_name = 'r'$yr_b'-'$mo_b
        echo 'Setting pbs for '$sim_name

        sed -e 's/sim_name/'$sim_name'/g' \
            -e 's/st_m/'$mo_b'/g' \
            -e 's/en_m/'$mo_e'/g'\
            -e 's/st_y/'$yr_b'/g'\
            < real.CFSR.pbs > $sim_name'_real.CFSR.pbs'
        mv $sim_name'_real.CFSR.pbs' 'CFSR/'$yr1'/'$stmon[$q]'/WRFV3_single/run/'

        echo 'Setting namelist for '$sim_name
        sed -e 's/st_y/'${yr_b}'/g'  \
            -e 's/st_m/'${mo_b}'/g'  \
            -e 's/st_d/'${dy_b}'/g'  \
            -e 's/en_y/'${yr_e}'/g'  \
            -e 's/en_m/'${mo_e}'/g'  \
            -e 's/en_d/'${dy_e}'/g'  \
            < namelist.input.racm_input > $sim_name'_namelist.input'

        mv $sim_name'_namelist.input' 'CFSR/'$yr1'/'$stmon[$q]'/WRFV3_single/'

        cd 'CFSR/'$yr1'/'$stmon[$q]'/WRFV3_single/run/'
        ls ./

        qsub {$sim_name}_real.CFSR.pbs

        cd ../../../../../
        ls ./

    @ q ++
    date -u
    end
@ x ++
@ yr1 ++
date -u
end
