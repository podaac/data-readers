
# IDL NetCDF Data Reader
 ----


## Description 

IDL functions and procedures that will read the entire contents of a netCDF granule into a structures.

get_netcdf_vars.pro 	       : function to read netCDF variables and attributes\
get_netcdf_global_atts.pro  : function to read netCDF global attributes\
ncwrapper.pro		             : generic netCDF wrapper around above functions to read entire file contents\
read_scat_l2_nc.pro         : generalized netCDF wrapper fine-tuned for reading Level 2 scatterometer datasets (e.g., ASCAT, QuikSCAT, RapidSCAT)


## Usage and Output


IDL> .r ncwrapper.pro                                                          
% Compiled module: NCWRAPPER.

IDL> ncwrapper, '20130909235837-NAVO-L2P_GHRSST-SST1m-VIIRS_NPP-v02.0-fv01.0.nc'

% Loaded DLM: NCDF.
% Compiled module: GET_NETCDF_VARS.\
  reading variable . . . lat\
  reading variable . . . lon\
  reading variable . . . time\
  reading variable . . . sea_surface_temperature\
  reading variable . . . sst_dtime\
  reading variable . . . sses_bias\
  reading variable . . . sses_standard_deviation\
  reading variable . . . dt_analysis\
  reading variable . . . wind_speed\
  reading variable . . . aerosol_dynamic_indicator\
  reading variable . . . adi_dtime_from_sst\
  reading variable . . . satellite_zenith_angle\
  reading variable . . . l2p_flags\
  reading variable . . . quality_level\
  reading variable . . . brightness_temperature_4um\
  reading variable . . . brightness_temperature_11um\
  reading variable . . . brightness_temperature_12um\
 % Compiled module: GET_NETCDF_GLOBAL_ATTS.\
  reading global attributes . . .  
     --> done reading netCDF file <-- 


 Example output:\
 the title of the data set is: VIIRS L2P SST\
 processing history: Created with VIIRSseatemp on  2013/09/10 at 01:14:45 UT\
 the data begin on: seconds since 1981-01-01 00:00:00

 All the variables in structure: nc_struct:
 
  ** Structure <188d808>, 18 tags, length=68814744, data length=68814710, refs=1:\
  NUM_NC_VARS     LONG                17\
  LAT             STRUCT    -> <Anonymous> Array[1]\
  LON             STRUCT    -> <Anonymous> Array[1]\
  TIME            STRUCT    -> <Anonymous> Array[1]\
  SEA_SURFACE_TEMPERATURE STRUCT    -> <Anonymous> Array[1]\
  SST_DTIME       STRUCT    -> <Anonymous> Array[1]\
  SSES_BIAS       STRUCT    -> <Anonymous> Array[1]\
  SSES_STANDARD_DEVIATION STRUCT    -> <Anonymous> Array[1]\ 
  DT_ANALYSIS     STRUCT    -> <Anonymous> Array[1]\
  WIND_SPEED      STRUCT    -> <Anonymous> Array[1]\
  AEROSOL_DYNAMIC_INDICATOR STRUCT    -> <Anonymous> Array[1]\
  ADI_DTIME_FROM_SST STRUCT    -> <Anonymous> Array[1]\
  SATELLITE_ZENITH_ANGLE STRUCT    -> <Anonymous> Array[1]\
  L2P_FLAGS       STRUCT    -> <Anonymous> Array[1]\
  QUALITY_LEVEL   STRUCT    -> <Anonymous> Array[1]\
  BRIGHTNESS_TEMPERATURE_4UM STRUCT    -> <Anonymous> Array[1]\
  BRIGHTNESS_TEMPERATURE_11UM STRUCT    -> <Anonymous> Array[1]\
  BRIGHTNESS_TEMPERATURE_12UM STRUCT    -> <Anonymous> Array[1]



### In need of Help?
The PO.DAAC User Services Office is the primary point of contact for answering your questions concerning data and information held by the PO.DAAC. User Services staff members are knowledgeable about both the data ordering system and the data products themselves. We answer questions about data, route requests to other DAACs, and direct questions we cannot answer to the appropriate information source.

Please contact us via email at podaac@podaac.jpl.nasa.gov


