#! /usr/bin/env python
# file: readzarr.py
# $id: $

"""
SYNOPSIS:
Contains two functions which read and return
zarr variables, variable attributes, and global
attributes to main program.
REQUIRES:
Python xarray module. See:
http://xarray.pydata.org/en/stable/
USAGE:
Requires usage of main program as follows:
% readzarr.py -f <filename>
"""

#import
from optparse import OptionParser
import numpy as np
import xarray as xr

# authorship
__author__     = "Yibo Jiang"
__copyright__  = "Copyright 2012, California Institute of Technology"
__credits__    = ["David Moroni and Yibo Jiang"]
__license__    = "Apache 2.0"
__version__    = "1.0"
__maintainer__ = "Yibo Jiang"
__email__      = "ybj at jpl dot nasa dot gov"
__status__     = "Release Candidate"

# ---------------------------
# read and return global_atts
# ---------------------------
def readGlobalAttrs( zarr_file ):
  return zarr_file.attrs 

# --------------------------------------------------
# read and return variables and their attributes 
# --------------------------------------------------
var_list = []
var_attr_list = []
def readVars ( zarr_file ):
  for var_name, da in zarr_file.data_vars.items():
      var_list.append( var_name )
      var_attr_list.append( da.attrs )

  return var_list, var_attr_list



