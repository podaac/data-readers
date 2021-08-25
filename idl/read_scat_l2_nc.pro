;  Copyright 2021, by the California Institute of Technology.  ALL RIGHTS
;  RESERVED. United States Government Sponsorship acknowledged. Any commercial
;  use must be negotiated with the Office of Technology Transfer at the
;  California Institute of Technology.

; $Id: $
; read_scat_l2_nc.pro  d. moroni    Caltech/JPL/NASA

;---------------------------------------------------------------
; Author: David Moroni
; Credits: Ed Armstrong (contributing author to main program and sole author
; 	of subroutines get_netcdf_vars.pro and get_netcdf_global_atts.pro.)
; Note: This reader is specifically optimized for Level 2 netCDF scatterometer
; datasets, such as QuikSCAT, RapidScat and ASCAT.
; Questions? Please contact podaac@podaac.jpl.nasa.gov
;---------------------------------------------------------------

PRO read_scat_l2_nc,  ncdf_file 		

;---------------------------------------------------------------
; SYNOPSIS: 
; Reads all the variables and their attributes of a netCDF
; file into two structures: global attributes and variables.
;
; REQUIRES:
; get_netcdf_vars.pro, get_netcdf_global_atts.pro
;
; USAGE:
; IDL> .r read_scat_l2_nc.pro
; % Compiled module: READ_SCAT_L2_NC.
;
; IDL> read_scat_l2_nc, 'nc_file.nc'
;---------------------------------------------------------------

;---------------------------------------------------------------
; Open the file and read the data arrays and global attributes 
; into structures. 
;---------------------------------------------------------------
print, ''
nid = ncdf_open( ncdf_file, /nowrite )

; read the variables and their attributes into a structure
nc_struct = get_netcdf_vars( nid )

; read the netCDF global attributes  into another structure
global_atts = get_netcdf_global_atts( nid )
ncdf_close, nid

print,  '  --> done reading netCDF file <-- '

; some examples of output:
print, ''
print, 'Global Attributes: '

; obtain number of structure tags
ngtags = n_tags(global_atts)

; obtain structure tag names
gtags = tag_names(global_atts)

; loop by number of global attribute structure tags
for i=0, ngtags-1 do begin 
 gtag_name = gtags[i]
 print,'  ',gtag_name,' = ',string(global_atts.(i) )
endfor 

print, ''
print, '  All the variables in structure: nc_struct: '

; obtain number of structure tags
nvtags = n_tags(nc_struct)

; obtain structure tag names
vtags = tag_names(nc_struct)

; loop by number of variable structure tags
for i=0, nvtags-1 do begin 
; obtain number of structure subtags
 ntags = n_tags(nc_struct.(i))
 print,'---------------------------------------'
; filter structure tags which contain no subtags 
 if ntags LE 1 then begin 
  vtag_name = vtags[i]
  print,'  ',vtag_name,' = ',string(nc_struct.(i) )
  
 endif else begin
; resume the for loop if structure subtags exist 
; obtain structure subtag names 
  itags = tag_names(nc_struct.(i))
  
; loop by number of variable structure subtags
  for j=0, ntags-1 do begin
   itag_name = itags[j]
   if j eq 0 then begin 
; retrieve the variable array from the structure 
    var_arr = nc_struct.(i).(j)
; retrieve the dimensions of the variable array
    dims = size(var_arr,/DIMENSIONS)
    n_dims = size(var_arr,/N_DIMENSIONS)
; retrieve the data type of the variable array    
    type = typename(var_arr)
    if n_dims LT 1 then begin
     print,'  ',type,'  ',itag_name,'():'
    endif else if n_dims EQ 1 then begin
     dim=string(dims,FORMAT='(I0)')
     print,'  ',type,'  ',itag_name,'(',dim,'):'
     print,'     ',itag_name,'(0:10):'
     print,var_arr[0:10]
    endif else begin
     dim1=string(dims[0])
     dim2=string(dims[1])
     dim1=strtrim(dim1,2)
     dim2=strtrim(dim2,2)
     print,'  ',type,'  ',itag_name,'(',dim1,',',dim2,'):'
     print,'     ',itag_name,'(0:10):'
; print sample variable array data
     print,var_arr[0:10]        
    endelse
; print remaining contents of variable description    
   endif else begin
    struct_el = nc_struct.(i).(j)
    n_elems = size(struct_el, /N_ELEMENTS)
    n_type = size(struct_el, /TYPE)
    if n_elems EQ 1 then begin
     if n_type EQ 1 AND struct_el LE 32 then begin
       print,'     ',itag_name,' = ',string(struct_el,FORMAT='(I0)')
     endif else print,'     ',itag_name,' = ',string(struct_el)
    endif else print,'     ',itag_name,' = ',string(struct_el)
   endelse
  endfor
 endelse
endfor 

END
