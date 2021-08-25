;  Copyright 2012, by the California Institute of Technology.  ALL RIGHTS
;  RESERVED. United States Government Sponsorship acknowledged. Any commercial
;  use must be negotiated with the Office of Technology Transfer at the
;  California Institute of Technology.

; $Id: $
; get_netcdf_global_atts.pro  e. armstrong    Caltech/JPL/NASA

FUNCTION get_netcdf_global_atts, ncdf_id

;---------------------------------------------------------------
; SYNOPSIS: 
; Reads all netCDF global attributes into an anonymous
; structure. Anonymous structures are required for reading
; multiple netCDF files that have different global attributes.
;
; INPUTS: 
; ncdf_id: the file ID returned by the ncdf_open IDL command that
; opens a netCDF file for reading (remember to close it). 
;
; RETURNS:
; An anonymous structure with all netCDF global attributes. 
; 
; USAGE:
; IDL> ncdf_id = ncdf_open( 'myNetCDF.nc', /nowrite )
; IDL> global_struct = get_netcdf_global_atts( ncdf_id  )
; IDL> ncdf_close, ncdf_id 
; IDL> help, global_struct
;---------------------------------------------------------------

; inquire about this file; returns structure
file_info = ncdf_inquire( ncdf_id )

; -----------------------------------------------------------
; Loop throught the global attributes and read into structure.
; -----------------------------------------------------------
print, '  reading global attributes . . .  '
for gatt_id=0, file_info.ngatts - 1 do begin
     gatt_name = ncdf_attname( ncdf_id, gatt_id, /GLOBAL )
     gatt_info = ncdf_attinq( ncdf_id, gatt_name, /GLOBAL )
     ncdf_attget, ncdf_id, gatt_name, gatt_value, /GLOBAL 

     ; ------------------------------------------------------------
     ; create 'tmp_struct' then add key/value pair to 'gatt_struct' 
     ; ------------------------------------------------------------
     tmp_struct = create_struct( gatt_name, gatt_value )
     if( gatt_id eq 0 ) then begin
        gatt_struct = create_struct( tmp_struct )
     endif else begin
         gatt_struct = create_struct( gatt_struct, tmp_struct )
     endelse
endfor

return, gatt_struct

END
