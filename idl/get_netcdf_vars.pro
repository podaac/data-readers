;  Copyright 2012, by the California Institute of Technology.  ALL RIGHTS
;  RESERVED. United States Government Sponsorship acknowledged. Any commercial
;  use must be negotiated with the Office of Technology Transfer at the
;  California Institute of Technology.

; $Id: $
; get_netcdf_vars.pro  e. armstrong    Caltech/JPL/NASA

FUNCTION get_netcdf_vars, ncdf_id

;--------------------------------------------------------------
; SYNOPSIS: 
; Reads all netCDF variables and their attributes into a set 
; of anonymous  structures. Anonymous structures are required 
; for reading multiple netCDF files that have different 
; variables and attributes.
;
; INPUTS: 
; ncdf_id: the file ID returned by the ncdf_open IDL command that
; opens a netCDF file for reading (remember to close it)
; 
; RETURNS:
; an anonymous structure containing all variables 
; and their attributes (as additional anonymous structures)
;
; USAGE:
; IDL> ncdf_id = ncdf_open( 'myNetCDF.nc', /nowrite )
; IDL> ncdf_struct = get_netcdf_vars( ncdf_id )
; IDL> ncdf_close, ncdf_id 
; IDL> help, ncdf_struct
;--------------------------------------------------------------

; inquire about this file; returns structure
file_info = ncdf_inquire( ncdf_id )

; ------------------------------------------------------------
; 'nc_struct' is structure for all variable and attribute data 
; that is returned by this function
; ------------------------------------------------------------
nc_struct = create_struct( 'num_nc_vars', file_info.nvars )

; -----------------------------------------------------------
; loop through each variable and read into variable structure
; 'var_struct'
; -----------------------------------------------------------
for var_id=0, file_info.nvars-1 do begin

    ; return variable info structure 
    var_info = ncdf_varinq( ncdf_id, var_id ) 

    print, '  reading variable . . . ',  var_info.name

    ; get variable array values
    ncdf_varget, ncdf_id, var_id, var_value  

    ; create variable structure, holds variable array values
    var_struct = create_struct(  var_info.name, var_value ) 

    ; -----------------------------------------------------------
    ; loop through variable attributes; retrive each attribute
    ; name and value and store in attribute structure 'att_struct'
    ; -----------------------------------------------------------
    for att_num=0, var_info.natts-1 do begin
        att_name = ncdf_attname( ncdf_id, var_id , att_num )
	;att_info = ncdf_attinq( ncdf_id, var_id, att_name ) 
        ncdf_attget, ncdf_id, var_id, att_name, att_value
        tmp_struct = create_struct( att_name, att_value )
        if( att_num eq 0 ) then begin
            att_struct = create_struct( tmp_struct )
        endif else begin
            att_struct = create_struct( att_struct, tmp_struct )
	endelse    
    endfor
    
    ; ------------------------------------------------------
    ; catenate variable and attribute structures (anonymous)  
    ; ------------------------------------------------------
    var_atts_struct = create_struct(  var_struct, att_struct )

    ; -----------------------------------------
    ; append variable structures to 'nc_struct' 
    ; -----------------------------------------
    tag = var_info.name
    nc_struct = create_struct( nc_struct, tag, var_atts_struct )
endfor

return, nc_struct

END
