ReadNcdf <- function (fpath, fname, printFlag = FALSE) {
   
   #  FUNCTION: ReadNcdf()
   #
   #  DESCRIPTION
   #   This function reads any generic, user defined NetCDF "Classic" file and returns a series of data structures 
   #   that capture in memory and potentially expose all attributes, variables, and data values from the input .nc file.
   #
   #  USAGE
   #   Call the "ReadNcdf() " function from either the R command
   #   line or from within a script using suitable arguement values
   #
   #  INPUT ARGUEMENTS
   #       fpath: specifies the working directory where the source NetCDF file is located (eg. "C:/Users/vtsontos/Documents/R" )
   #       fname: file name of source NetCDF data file  (eg. "capsss20120105.nc" )
   #       printFlag: if set to TRUE, list NetCDF file summary information on screen (Default setting = FALSE )
   #
   #  OUTPUTS
   #       nDims, nGatts,nVars: number of Dimensions, Global Attributes, Variables respectively
   #	     Dims, gAtts, VarAtts: structure arrays with respective dimensional, global and variable attributes with associated values  
   #       Var.Data: structure array containing the data values for all variables by variable element
   #       optional - print listing of key file information to screean (if printFlag = TRUE)
   #
   #
   #  DEPENDENCIES  
   #	Uses the "rnetcdf" package, v1.6 1-2 (http://cran.r-project.org/web/packages/RNetCDF/index.html) based on NetCDF 3+ library
   #
   #  NOTES
   #      1. This read software was created using R version 2.14.2 (2012-02-29)
   #      2. Please email all comments and questions concerning these routines
   #           to podaac@podaac.jpl.nasa.gov.
   #
   #  CREATED:
   #       10/09/2012: Vardis Tsontos, PO.DAAC, NASA-JPL CalTech
   #
   #======================================================================
   # Copyright (c) 2012, California Institute of Technology
   #======================================================================
   
   # Call the NetCDF library, set the local file path, and open the user selected .nc file
   library("RNetCDF")
   setwd(fpath)
   nc <- open.nc(fname)
  
   # Print File summary listing as required
   if (printFlag == TRUE){print.nc(nc)}
  
   # Get Info and Dimensional Extents of NetCDF file data structures
   ncInfo <- file.inq.nc(nc)
   nDims <<- ncInfo$ndims
   nGatts <<- ncInfo$ngatts
   nVars <<- ncInfo$nvars
   
   # Get all GLOBAL Attributes & Values
   if (nGatts >0) {
      globalAtts <<- array(list(NULL), c(nGatts,1))
      for (cnt in 0:(nGatts-1)){
         Temp <- att.inq.nc(nc, "NC_GLOBAL", cnt)
         Temp1 <- unlist(Temp[2])
         Temp2 <- att.get.nc(nc, "NC_GLOBAL", cnt)
         globalAtts[[cnt+1]] <<- list(name=Temp1,value=Temp2) }}
   
   # Get all DIMENSION Attributes & Values
   if (nDims >0) {   
      dimAtts <<- array(list(NULL), c(nDims,1))
      for (cnt in 0:(nDims-1)){
         dimAtts[[cnt+1]] <<- dim.inq.nc(nc, cnt) }}
   
   # Get all VARIABLE Attributes & Data Values
   if (nVars >0) {
      varAtts <<- array(list(NULL), c(nVars,1))
      for (cnt in 0:(nVars-1)){
         varAtts[[cnt+1]] <<- var.inq.nc(nc, cnt) }
      varData <<- read.nc(nc) }
   
   # Cleanup - close file and remove temporary variables
   close.nc(nc)
   rm(cnt, Temp, Temp1, Temp2, ncInfo, nc)
}