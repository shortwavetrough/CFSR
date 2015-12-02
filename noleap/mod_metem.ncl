; Purpose:    Modify met_em files for RASM leap day.
;             .
;
; Programmer: Brandon Fisel
;             Department of Geological and Atmospheric Sciences
;             Iowa State University
;
; Date:       08/13/2012
;
; Use:        ncl < mod_metem.ncl
;             Before running mod_metem.ncl create a copy of February-29 
;             0000Z met_em file. Move the February-29 copy to an outside
;             directory. Run mod_metem.ncl then run real.exe.
;
; Input:      FEBRUARY-29 & MARCH-01 0000Z LEAP-YEAR MET_EM FIELDS
;
; Output:     MARCH-01 -> FEBRUARY-29 0000Z MET_EM Fields
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

;Set IO directory pointers
print("Setting I/O pointers")
dirin = "./" ;wrfbdy file location
dirou = "./" ;wrfbdy file save location
wrfin = addfile(dirin+"met_em.d01."+year+"-03-01_00:00:00.nc", "r")
wrfin2 = addfile(dirin+"met_em.d01."+year+"-02-29_00:00:00.nc", "r")
fileatts = getvaratts(wrfin2)

;Array of met_em fields not including times
print("Creating arrays")
VAR4D = (/"PRES", "SOIL_LAYERS", "SM", "ST", "RH", "GHT", "RH", "VV", \
          "UU", "TT", "GREENFRAC", "ALBEDO12M", "SOILCBOT", "SOILCTOP", \
          "LANDUSEF"/)
VAR3D = (/"SOILHGT", "LANDSEA", "SM100200", "SM040100", "SM010040", \
          "SM000010", "ST100200", "ST040100", "ST010040", "ST000010", \
          "SNOW", "SEAICE", "SKINTEMP", "PMSL", "PSFC", "OL4", "OL3", "OL2", \
          "OL1", "OA4", "OA3", "OA2", "OA1", "VAR", "CON", "SLOPECAT", \
          "SNOALB", "SOILTEMP", "HGT_V", "HGT_U", \
          "SLPY", "SLPX", "HGT_M", "LU_INDEX", "LANDMASK", "COSALPHA", \
          "SINALPHA", "F", "E", "MAPFAC_UY", "MAPFAC_VY", "MAPFAC_MY", \
          "MAPFAC_UX", "MAPFAC_VX", "MAPFAC_MX", "MAPFAC_U", "MAPFAC_V", \
          "MAPFAC_M", "CLONG", "CLAT", "XLONG_U", "XLAT_U", "XLONG_V", \
          "XLAT_V", "XLONG_M", "XLAT_M"/)

;Get met_em time fields
print("Getting met_em time fields")
Times_1 = wrfin2->Times

;Write times to .nc file
wrfou = addfile(dirin+"met_em.d01_noleap."+year+"-02-29_00:00:00.nc", "c")
filedimdef(wrfou,"Time",-1,True)

wrfou->Times = Times_1
delete(Times_1)

;Do VAR4D first
print("Begin VAR4D")
do n=0, dimsizes(VAR4D) - 1
 print("Writing: "+VAR4D(n))
 var1 = wrfin->$VAR4D(n)$ ;read met_em field in

;Write field to .nc file
 wrfou->$VAR4D(n)$ = var1
 delete(var1)
end do

;Do VAR3D
print("Begin VAR3D")
do n=0, dimsizes(VAR3D) - 1
 print("Writing: "+VAR3D(n))
 var1 = wrfin->$VAR3D(n)$ ;read met_em field in

;Write field to .nc file
 wrfou->$VAR3D(n)$ = var1
 delete(var1)
end do

;Do filevaratts
;Copy the file global attributes
print("Writing met_em file global attributes")
if(.not.all(ismissing(fileatts))) then
 do n=0, dimsizes(fileatts) - 1
  print("copy_fileatts: global attributes ->" + fileatts(n))
  wrfou@$fileatts(n)$ = wrfin2@$fileatts(n)$
 end do
end if

;Clean up
;Replace Feb-29 with "new" Feb-29 file
cmd = "mv met_em.d01_noleap."+year+"-02-29_00\:00\:00.nc met_em.d01."+year+"-02-29_00\:00\:00.nc"
cmdi = systemfunc(cmd)
print(cmdi)

print("Finished")
end

