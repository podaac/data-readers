function [finfo outstrct]=read_nc_file_struct(fnam)
%FILENAME:  read_nc_file_struct
%
%DESCRIPTION:
%This file contains one Matlab program that is a high level NetCDF reader.  It will read any NetCDF file
%inputted.  If the file is properly formatted, CF or another standard format, it will apply offsets and scaling
%automatically and will replace the fill values with NaNs.  Otherwise you will need to do this manually.  
%This program will output all of the variables in the file into a
%structure.
%
%USAGE:  To run this program, use the following command:
%   >> [finfo outstrct] = read_nc_file('filename');
%
%INPUTS:
%fnam = The filename of the file you would like to read, with the full path,
%as a string
%
%OUTPUTS:
%1. finfo = File information, as a structure, with the Global and Variable Attributes
%
%2. outstrct is a structure containing all of the variables within the
%   specified file.  The first field in the structure is the filename
%
%3. This function will output Variable and Global Attributes to the screen.  If you do
%   not want this feature comment line 38.
%
%NOTES:
%This code was written with Matlab Version 7.13.0.564 (R2011b)
%
%19 April 2012
%======================================================================
% Copyright (c) 2012, California Institute of Technology
%======================================================================


ncdisp(fnam)        %outputs Variable and Global Attributes to the screen

finfo=ncinfo(fnam); %gets Variable and Global Attribute information from the file

minargs=1;      %make sure that the right number of fields are inputted and outputted
maxargs=2;
outstrct=struct('filename',fnam);      %first field in the structure is the filename
nargoutchk(minargs,maxargs)     %check if more than just finfo is declared but make sure that the number of variables declared is not more than what is in the file

for i=1:length(finfo.Variables)         %loop over the number of variables in the file
    eval(['a=ncread(fnam,''' finfo.Variables(i).Name ''');'])    %reads in variable data
    outstrct=setfield(outstrct,finfo.Variables(i).Name,a);
    clear a
end

end     %ends function
