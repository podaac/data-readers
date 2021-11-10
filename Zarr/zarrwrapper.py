#! /usr/bin/env python
# file: zarrwrapper.py
# $id: $

"""
SYNOPSIS:
Receives input from readzarr.py and allows user to visualize customized input.
REQUIRES:
readzarr.py subroutine
Python xarray module. See:
http://xarray.pydata.org/en/stable/
USAGE:
% zarrwrapper.py -f <filename>
****************************************************************
Note: some systems may require the following usage variations:
% python ./zarrwrapper.py -f <filename>
... or ...
% ./zarrwrapper.py -f <filename>
****************************************************************
"""

#import
from optparse import OptionParser
import numpy as np
import xarray as xr

from readzarr import readGlobalAttrs
from readzarr import readVars

# authorship
__author__     = "Yibo Jiang"
__copyright__  = "Copyright 2020, California Institute of Technology"
__credits__    = ["Yibo Jiang, David Moroni"]
__license__    = "Apache 2.0"
__version__    = "1.1"
__maintainer__ = "Yibo Jiang"
__email__      = "ybj at jpl dot nasa dot gov"
__status__     = "Release Candidate"

# Read command line using optparse module
print (" ---- Print Variable and Global Attributes of a zarr file ---- \n")
parser = OptionParser( )
parser.add_option( "-f", "--file", dest="filename",
                  help="filename to validate metadata and structure", metavar="FILE",
		  type = 'string' )
(options, args) = parser.parse_args()

if not options.filename :
    parser.error("Please specify a zarr file name!")
else:
    zarrfile = options.filename

# -----------------------------
# Open zarr file for reading
# -----------------------------
ds = xr.open_zarr(zarrfile)

#Global Attributes
global_sttrs = readGlobalAttrs(ds)
print("Global Attributes")
print(global_sttrs)

#Variable Info
var_list, var_attr_list =  readVars ( ds )
print("Variable Info")
print(var_list)
print(var_attr_list)


