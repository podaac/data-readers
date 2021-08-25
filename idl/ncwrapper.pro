;  Copyright 2012, by the California Institute of Technology.  ALL RIGHTS
;  RESERVED. United States Government Sponsorship acknowledged. Any commercial
;  use must be negotiated with the Office of Technology Transfer at the
;  California Institute of Technology.

; ncwrapper.pro  e. armstrong    Caltech/JPL/NASA

PRO ncwrapper,  ncdf_file 		

;---------------------------------------------------------------
; SYNOPSIS: 
; Reads all the variables and their attributes of a netCDF PCMDI 
; file into two structre.
;
; REQUIRES:
; get_netcdf_vars.pro, get_netcdf_global_atts.pro
;
; USAGE:
; IDL> ncwrapper, 'netCDF_file.nc'
;---------------------------------------------------------------

;-------------------------------------------------------------
; Open the file and read the data arrays and global attributes 
; into structures. 
;-------------------------------------------------------------
print, ''
nid = ncdf_open( ncdf_file, /nowrite )

; read the variables and their attributes into a structure
nc_struct = get_netcdf_vars( nid )

; read the netCDF global attributes  into another structure
global_atts = get_netcdf_global_atts( nid )
ncdf_close, nid

print,  '  --> done reading netCDF file <-- '

; some examples of output (if it contains CF metadata):
print, ''
print, 'Example output: '
print, '  the title of the data set is: ', string(global_atts.title )
print, '  processing history: ', 	   string(global_atts.history )
print, '  the data begin on: ',            string(nc_struct.time.units )
print, ''
print, '  All the variables in structure: nc_struct: '
help,  nc_struct

END
