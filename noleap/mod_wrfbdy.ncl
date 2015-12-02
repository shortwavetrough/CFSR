; Purpose:    Modify wrfbdy files for RASM WRF leap-day
;             .
;
; Programmer: Brandon Fisel
;             Department of Geological and Atmospheric Sciences
;             Iowa State University
;
; Date:       08/13/2012
;
; Use:        ncl < mod_wrfbdy.ncl
;
; Input:      WRF BOUNDARY FIELDS
;
; Output:     WRF Boundary Fields
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

;wrfbdy_d01 file must end with '.nc' otherwise ncl can not read the file!
cmd = "mv wrfbdy_d01_"+year+"0201 wrfbdy_d01_"+year+"0201.nc"
cmdi = systemfunc(cmd)
print(cmdi)
delete(cmd)
delete(cmdi)

;Set IO directory pointers
print("Setting I/O pointers")
dirin = "./" ;wrfbdy file location
dirou = "./" ;wrfbdy file save location
wrfin = addfile(dirin+"wrfbdy_d01_"+year+"0201.nc", "r")
fileatts = getvaratts(wrfin)

;Array of wrfbdy fields not including times
print("Creating arrays")
VAR4D = (/"U_BXS", "U_BXE", "U_BYS", "U_BYE", "U_BTXS", "U_BTXE", "U_BTYS", \
          "U_BTYE", "V_BXS", "V_BXE", "V_BYS", "V_BYE", "V_BTXS", "V_BTXE", \
          "V_BTYS", "V_BTYE", "W_BXS", "W_BXE", "W_BYS", "W_BYE", "W_BTXS", \
          "W_BTXE", "W_BTYS", "W_BTYE", "PH_BXS", "PH_BXE", "PH_BYS", \
          "PH_BYE", "PH_BTXS", "PH_BTXE", "PH_BTYS", "PH_BTYE", "T_BXS", \
          "T_BXE", "T_BYS", "T_BYE", "T_BTXS", "T_BTXE", "T_BTYS", "T_BTYE", \
          "QVAPOR_BXS", "QVAPOR_BXE", "QVAPOR_BYS", "QVAPOR_BYE", "QCLOUD_BXS", \
          "QCLOUD_BXE", "QCLOUD_BYS", "QCLOUD_BYE", "QRAIN_BXS", "QRAIN_BXE", \
          "QRAIN_BYS", "QRAIN_BYE", "QICE_BXS", "QICE_BXE", "QICE_BYS", \
          "QICE_BYE", "QSNOW_BXS", "QSNOW_BXE", "QSNOW_BYS", "QSNOW_BYE", \
          "QGRAUP_BXS", "QGRAUP_BXE", "QGRAUP_BYS", "QGRAUP_BYE", \
          "QVAPOR_BTXS", "QVAPOR_BTXE", "QVAPOR_BTYS", "QVAPOR_BTYE", \
          "QCLOUD_BTXS", "QCLOUD_BTXE", "QCLOUD_BTYS", "QCLOUD_BTYE", \
          "QRAIN_BTXS", "QRAIN_BTXE", "QRAIN_BTYS", "QRAIN_BTYE", "QICE_BTXS", \
          "QICE_BTXE", "QICE_BTYS", "QICE_BTYE", "QSNOW_BTXS", "QSNOW_BTXE", \
          "QSNOW_BTYS", "QSNOW_BTYE", "QGRAUP_BTXS", "QGRAUP_BTXE", \
          "QGRAUP_BTYS", "QGRAUP_BTYE"/)
VAR3D = (/"MU_BXS", "MU_BXE", "MU_BYS", "MU_BYE", "MU_BTXS", "MU_BTXE", \
          "MU_BTYS", "MU_BTYE", "HT_SHAD_BXS", "HT_SHAD_BXE", "HT_SHAD_BYS", \
          "HT_SHAD_BYE", "HT_SHAD_BTXS", "HT_SHAD_BTXE", "HT_SHAD_BTYS", \
          "HT_SHAD_BTYE"/)

;Get wrfbdy time fields
print("Getting wrfbdy time fields")
Times_1 = wrfin->Times
md___thisbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_1 = wrfin->md___thisbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_
md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_1 = wrfin->md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_

;Modify wrfbdy time fields
;Only need time steps 0-111 (Feb-01-00Z - Feb-28-18Z)
print("Modifying wrfbdy time fields")
Times_2 = Times_1(0:111,:)
delete(Times_1)

md___thisbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_2 = md___thisbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_1(0:111,:)
delete(md___thisbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_1)

;We want Feb-01-06Z - Feb-28-18Z then add on Mar-01-00Z here
md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_2 = md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_1(0:110,:)
md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_3 = new((/1,19/),typeof(md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_1)) ;define array 1x19 - need this to append time!
md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_3 = md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_1(115,:) ;Mar-01-00Z
md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_4 = array_append_record(md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_2, md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_3, 0)
delete(md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_4@_FillValue) ;remove _FillValue

delete(md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_1)
delete(md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_2)
delete(md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_3)

;Write times to .nc file
wrfou = addfile(dirin+"wrfbdy_noleap_d01_"+year+"0201.nc", "c")
filedimdef(wrfou,"Time",-1,True) ;make Time dim unlimited

wrfou->Times = Times_2
wrfou->md___thisbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_ = md___thisbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_2
wrfou->md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_ = md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_4

delete(Times_2)
delete(md___thisbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_2)
delete(md___nextbdytimee_x_t_d_o_m_a_i_n_m_e_t_a_data_4)

;Modify remaining wrfbdy fields
;Remove Feb-29
;Do VAR4D first
print("Begin VAR4D")
do n=0, dimsizes(VAR4D) - 1
 print("Modifying: "+VAR4D(n))
 var1 = wrfin->$VAR4D(n)$ ;read wrfbdy field in
 var2 = var1(0:111,:,:,:) ;create new var with times dim size 0-111

;Write field to .nc file
 wrfou->$VAR4D(n)$ = var2
 delete(var1)
 delete(var2)
end do

;Do VAR3D
print("Begin VAR3D")
do n=0, dimsizes(VAR3D) - 1
 print("Modifying: "+VAR3D(n))
 var1 = wrfin->$VAR3D(n)$ ;read wrfbdy field in
 var2 = var1(0:111,:,:) ;create new var with times dim size 0-111

;Write field to .nc file
 wrfou->$VAR3D(n)$ = var2
 delete(var1)
 delete(var2)
end do

;Do filevaratts
print("Writing wrfbdy file global attributes")
if(.not.all(ismissing(fileatts))) then
 do n=0, dimsizes(fileatts) - 1
  print("copy_fileatts: global attributes ->" + fileatts(n))
  wrfou@$fileatts(n)$ = wrfin@$fileatts(n)$
 end do
end if

;Clean up
;Remove the .nc suffix so that file may be read back into WRF
cmd = "mv wrfbdy_noleap_d01_"+year+"0201.nc wrfbdy_noleap_d01_"+year+"0201"
cmdi = systemfunc(cmd)
print(cmdi)

rmcmd = "/bin/rm wrfbdy_d01_"+year+"0201.nc"
rmcmdi = systemfunc(rmcmd)
print(rmcmd)

print("Finished")
end

