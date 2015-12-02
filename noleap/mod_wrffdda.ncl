; Purpose:    Modify wrffdda files for RASM WRF leap-day
;             .
;
; Programmer: Brandon Fisel
;             Department of Geological and Atmospheric Sciences
;             Iowa State University
;
; Date:       08/13/2012
;
; Use:        ncl < mod_wrffdda.ncl
;
; Input:      WRF SPECTRAL NUDGING FIELDS
;
; Output:     WRF Spectral Nudging Fields
;
; References: NCL reference webpage: http://www.ncl.ucar.edu/

; Load NCL library files
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

;Set year
year = "2012"

;wrffdda_d01 file must end with '.nc' otherwise ncl can not read the file!
cmd = "mv wrffdda_d01_"+year+"0201 wrffdda_d01_"+year+"0201.nc"
cmdi = systemfunc(cmd)
print(cmdi)
delete(cmd)
delete(cmdi)

;Set IO directory pointers
print("Setting I/O pointers")
dirin = "./" ;wrffdda file location
dirou = "./" ;wrffdda file save location
wrfin = addfile(dirin+"wrffdda_d01_"+year+"0201.nc", "r")
fileatts = getvaratts(wrfin)

;Array of wrffdda fields not including times
print("Creating arrays")
VAR4D = (/"U_NDG_OLD", "V_NDG_OLD", "T_NDG_OLD", "Q_NDG_OLD", "PH_NDG_OLD", \
          "U_NDG_NEW", "V_NDG_NEW", "T_NDG_NEW", "Q_NDG_NEW", "PH_NDG_NEW", \
          "MU_NDG_OLD", "MU_NDG_NEW"/)

;Get wrffdda time fields
print("Getting wrffdda time fields")
Times_1 = wrfin->Times

;Modify wrffdda time fields
;Only need time steps 0-111 (Feb-01-00Z - Feb-28-18Z)
print("Modifying wrffdda time fields")
Times_2 = Times_1(0:111,:)
delete(Times_1)

;Write times to .nc file
wrfou = addfile(dirin+"wrffdda_noleap_d01_"+year+"0201.nc", "c")
filedimdef(wrfou,"Time",-1,True) ;make Time dim unlimited

wrfou->Times = Times_2
delete(Times_2)

;Modify remaining wrffdda fields
;Remove Feb-29
;Do VAR4D
print("Begin VAR4D")
do n=0, dimsizes(VAR4D) - 1
 print("Modifying: "+VAR4D(n))
 var1 = wrfin->$VAR4D(n)$ ;read wrffdda field in
 var2 = var1(0:111,:,:,:) ;create new var with times dim size 0-111

;Write field to .nc file
 wrfou->$VAR4D(n)$ = var2
 delete(var1)
 delete(var2)
end do

;Do filevaratts
print("Writing wrffdda file global attributes")
if(.not.all(ismissing(fileatts))) then
 do n=0, dimsizes(fileatts) - 1
  print("copy_fileatts: global attributes ->" + fileatts(n))
  wrfou@$fileatts(n)$ = wrfin@$fileatts(n)$
 end do
end if

;Clean up
;Remove the .nc suffix so that file may be read back into WRF
cmd = "mv wrffdda_noleap_d01_"+year+"0201.nc wrffdda_noleap_d01_"+year+"0201"
cmdi = systemfunc(cmd)
print(cmdi)

rmcmd = "/bin/rm wrffdda_d01_"+year+"0201.nc"
rmcmdi = systemfunc(rmcmd)
print(rmcmd)

print("Finished")
end

