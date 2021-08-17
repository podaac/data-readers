#  SCRIPT: CallFunc_ReadNcdf.r
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
#
#  NOTES
#      1. This read software was created using R version 2.14.2 (2012-02-29)
#      2. Please email all comments and questions concerning these routines
#           to podaac@podaac.jpl.nasa.gov.
#
#  CREATED:
#       10/11/2012: Vardis Tsontos, PO.DAAC, NASA-JPL CalTech
#
#======================================================================
# Copyright (c) 2012, California Institute of Technology
#======================================================================



# ****** User Inputs Section ***********              # User inputs entered here

path = "C:/Users/vtsontos/Documents/R"                # Enter the data directory path
name = "os2_l2b2013001_17342_17343.nc"                # Enter the filename of the source NetCDF data file
printFlag = TRUE                                      # Set to TRUE or FALSE if file content listing info is desired
nOutputElements = 10                                  # number of VarData array elements to output per data variable
nOutputRows = 20                                      # number of data rows output to screen before pause and user prompt

# ************** MAIN ********************** 

source('~/R/funcReadNcdf.r')                          # compiles the function from its source code .r file
ReadNcdf(path, name, printFlag)                       # calls the function and passes user defined arguements


# print example Data outputs for all variables illustrating how data elements are accessed at the command line
if (printFlag == TRUE) {
   for (cnt in 1:nVars){
      cat(varAtts[[cnt]]$name,": ",varData[[cnt]][1:nOutputElements], "\n");
      if (cnt > nOutputRows){
         readline(prompt = "Paused. Press <Enter> to continue...")}   
   }
}


# *************  END ***********************