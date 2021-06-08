
# Generic Data Readers
 ----

![N|Solid](https://podaac.jpl.nasa.gov/sites/default/files/image/custom_thumbs/podaac_logo.png)

The data readers within this repository are intended to generically read all data variables and metadata from a formatted data file (e.g., netCDF).
Readers are available in Python (version 3.x), R, IDL, and MATLAB. 

## Dependencies

Each reader has its own dependencies depending on the native programming language, but the core dependency for each reader are the libraries and packages required to read formatted data. At this time, the only formatted data that these readers are designed for is netCDF (v3, v4, and v4-classic). NetCDF libraries and packages are available for various programming languages as follows:

1. Python - https://github.com/Unidata/netcdf4-python
2. R - https://github.com/mjwoods/RNetCDF
3. MATLAB (built-in netCDF package) - https://www.mathworks.com/help/matlab/network-common-data-form.html
4. IDL (built-in netCDF package) - https://www.l3harrisgeospatial.com/docs/routines-101.html

## Note: 
The code contained within this repository is intended for generic use across many different datasets. As such, this code is not guarunteed to work for all datasets, even when sharing a common data format. As the code continues to be tested for a wider variety of datasets, this repository will be periodically updated to ensure wider compatibility across common data formats. 

### In need of Help?
The PO.DAAC User Services Office is the primary point of contact for answering your questions concerning data and information held by the PO.DAAC. User Services staff members are knowledgeable about both the data ordering system and the data products themselves. We answer questions about data, route requests to other DAACs, and direct questions we cannot answer to the appropriate information source.

Please contact us via email at podaac@podaac.jpl.nasa.gov
