




README_R_netCDF.txt  
--------------------
The information below provides documentation and usage information for PO.DAAC's generalized NetCDF reader function (ReadNcdf) and example 
calling routine (CallFunc_ReadNcdf) for the R-programming language (http://www.r-project.org/).
This documentation is also available withing the code of the R netCDF reader script files themselves.


------------------------------------------------------------------------



#SCRIPT: CallFunc_ReadNcdf.r
#
#  DESCRIPTION
#   - Illustrates how the ReadNcdf function is called from within a simple R script to generically read all elements
#      (metadata attributes and data) of any arbitrary NetCDF classic (v3+) data file.
#   - All file metadata and data elements are read into memory arrays for access.
#   - Illustrations of how to access the range of data structures are provided.
#
#  DEPENDENCIES  
#  - Invokes the function ReadNcdf()      source file: funcReadNcdf.r
#  - This function uses the "RNetCDF" package, v1.6 1-2 , based on NetCDF 3+ library#
#
#  USAGE
#     The script automatically invokes the ReadNcdf function to capture and expose attributes and data of the user-selected
#     .nc file.  How to use:
#     1) Install the  "RNetCDF" package from the CRAN R-Project  (http://cran.r-project.org/web/packages/RNetCDF/index.html)
#     2) Open the "CallFunc_ReadNcdf.r script, and edit any parameters in the USER INPUTS section (eg. filename, path).
#     3) run the script.
#
#  INPUTS   (in "USER INPUTS" code block section below)
#     fpath: specifies the working directory where the source NetCDF file is located (eg. "C:/Users/vtsontos/Documents/R" )
#     fname: file name of source NetCDF data file  (eg. "capsss20120105.nc" )
#     printFlag: if set to TRUE, list NetCDF file summary information on screen (Default setting = FALSE )
#     nOutputElements: number of data array (VarData) elements to output per data variable (eg. 10)
#     nOutputRows: number of data rows output to screen before pause and user prompt (eg. 20)
#
#  OUTPUTS
#     - all NetCDF file elements read into R data structures in memory for usage
#     - dimAtts, gAtts, carAtts: structure arrays with respective dimensional, global and variable attributes with associated values  
#     - varData: structure array containing the data values for all variables by variable element
#     - optional (if printFlag = TRUE)
#           * print listing of all global file and variable attributes to screen with associated values
#           * print sample data for each data variable (number elements output per variable = nOutputElements)


-------------------------------------------------------------------------


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
   #      This read software was created using R version 2.14.2 (2012-02-29)