# Package 'sri24-atlas' is not installed, so not removed
# Package 'libatlas-cpp-0.6-0-dev' is not installed, so not removed
# Package 'libatlas.so.3gf' is not installed, so not removed
# Package 'matlab-dev' is not installed, so not removed
# Package 'matlab-spm8' is not installed, so not removed
# Package 'fsl-atlases' is not installed, so not removed
# Package 'libatlas3gf-sse' is not installed, so not removed
#  Package 'libatlas3gf-sse2' is not installed, so not removed
# Package 'libatlas3gf-3dnow' is not installed, so not removed
# Package 'libatlas-sse-dev' is not installed, so not removed
# Package 'libatlas-sse2-dev' is not installed, so not removed
# Package 'libatlas-3dnow-dev' is not installed, so not removed
# Package 'matlab' is not installed, so not removed
# Package 'gtkatlantic' is not installed, so not removed
# Package 'libatlas-cpp-0.6-1' is not installed, so not removed
# Package 'libatlas-cpp-0.6-1-dbg' is not installed, so not removed
# Package 'libatlas-cpp-0.6-dev' 
#
#
# This file provides configuration information about non-Python dependencies for
# numpy.distutils-using packages. Create a file like this called "site.cfg" next
# to your package's setup.py file and fill in the appropriate sections. Not all
# packages will use all sections so you should leave out sections that your
# package does not use.

# To assist automatic installation like easy_install, the user's home directory
# will also be checked for the file ~/.numpy-site.cfg .

# The format of the file is that of the standard library's ConfigParser module.
#
#   http://www.python.org/doc/current/lib/module-ConfigParser.html
#
# Each section defines settings that apply to one particular dependency. Some of
# the settings are general and apply to nearly any section and are defined here.
# Settings specific to a particular section will be defined near their section.
#
#   libraries
#       Comma-separated list of library names to add to compile the extension
#       with. Note that these should be just the names, not the filenames. For
#       example, the file "libfoo.so" would become simply "foo".
#           libraries = lapack,f77blas,cblas,atlas
#
#   library_dirs
#       List of directories to add to the library search path when compiling
#       extensions with this dependency. Use the character given by os.pathsep
#       to separate the items in the list. Note that this character is known to
#       vary on some unix-like systems; if a colon does not work, try a comma.
#       This also applies to include_dirs and src_dirs (see below).
#       On UN*X-type systems (OS X, most BSD and Linux systems):
#           library_dirs = /usr/lib:/usr/local/lib
#       On Windows:
#           library_dirs = c:\mingw\lib,c:\atlas\lib
#       On some BSD and Linux systems:
#           library_dirs = /usr/lib,/usr/local/lib
#
#   include_dirs
#       List of directories to add to the header file earch path.
#           include_dirs = /usr/include:/usr/local/include
#
#   src_dirs 
#       List of directories that contain extracted source code for the
#       dependency. For some dependenciPackage 'sri24-atlas' is not installed, so not removed
Package 'libatlas-cpp-0.6-0-dev' is not installed, so not removed
Package 'libatlas.so.3gf' is not installed, so not removed
Package 'matlab-dev' is not installed, so not removed
Package 'matlab-spm8' is not installed, so not removed
Package 'fsl-atlases' is not installed, so not removed
Package 'libatlas3gf-sse' is not installed, so not removed
Package 'libatlas3gf-sse2' is not installed, so not removed
Package 'libatlas3gf-3dnow' is not installed, so not removed
Package 'libatlas-sse-dev' is not installed, so not removed
Package 'libatlas-sse2-dev' is not installed, so not removed
Package 'libatlas-3dnow-dev' is not installed, so not removed
Package 'matlab' is not installed, so not removed
Package 'gtkatlantic' is not installed, so not removed
Package 'libatlas-cpp-0.6-1' is not installed, so not removed
Package 'libatlas-cpp-0.6-1-dbg' is not installed, so not removed
Package 'libatlas-cpp-0.6-dev' es, numpy.distutils will be able to build
#       them from source if binaries cannot be found. The FORTRAN BLAS and
#       LAPACK libraries are one example. However, most dependencies are more
#       complicated and require actual installation that you need to do
#       yourself.
#           src_dirs = /home/rkern/src/BLAS_SRC:/home/rkern/src/LAPACK_SRC
#
#   search_static_first
#       Boolean (one of (0, false, no, off) for False or (1, true, yes, on) for
#       True) to tell numpy.distutils to prefer static libraries (.a) over
#       shared libraries (.so). It is turned off by default.
#           search_static_first = false

# Defaults
# ========
# The settings given here will apply to all other sections if not overridden.
# This is a good place to add general library and include directories like
# /usr/local/{lib,include}
#

[DEFAULT]
library_dirs = /usr/local/atlas/lib
include_dirs = /usr/local/atlas/include



[atlas]
search_static_first = true
libraries = lapack,ptf77blas,ptcblas,atlas,satlas,tatlas,atlas,cblas,f77blas,lapack,ptf77blas,ptcblas
library_dirs = /usr/local/atlas/lib
include_dirs = /usr/local/atlas/include

# OpenBLAS
# --------
# OpenBLAS is another open source optimized implementation of BLAS and Lapack
# and can be seen as an alternative to Atlas. To build numpy against OpenBLAS
# instead of Atlas, use this section instead of the above, adjusting as needed
# for your configuration (in the following example we installed OpenBLAS with
# ``make install PREFIX=/opt/OpenBLAS``.
#
# **Warning**: OpenBLAS, by default, is built in multithreaded mode. Due to the
# way Python's multiprocessing is implemented, a multithreaded OpenBLAS can
# cause programs using both to hang as soon as a worker process is forked on
# POSIX systems (Linux, Mac).
# This is fixed in Openblas 0.2.9 for the pthread build, the OpenMP build using
# GNU openmp is as of gcc-4.9 not fixed yet.
# Python 3.4 will introduce a new feature in multiprocessing, called the
# "forkserver", which solves this problem. For older versions, make sure
# OpenBLAS is built using pthreads or use Python threads instead of
# multiprocessing.
# (This problem does not exist with multithreaded ATLAS.)
#
# http://docs.python.org/3.4/library/multiprocessing.html#contexts-and-start-methods
# https://github.com/xianyi/OpenBLAS/issues/294
#
#[openblas]
#search_static_first = false
#libraries = openblas
#library_dirs = /opt/openblas/lib
#include_dirs = /opt/openblas/include
#
# MKL
#----
# MKL is Intel's very optimized yet proprietary implementation of BLAS and
# Lapack.
# For recent (9.0.21, for example) mkl, you need to change the names of the
# lapack library. Assuming you installed the mkl in /opt, for a 32 bits cpu:
# [mkl]
# library_dirs = /opt/intel/mkl/9.1.023/lib/32/
# lapack_libs = mkl_lapack
#
# For 10.*, on 32 bits machines:
#[mkl]
#library_dirs = /opt/intel/mkl/lib/intel64
#include_dirs = /opt/intel/mkl/include   
#lapack_libs = mkl_lapack
#blas_libs = mkl_blas95, mkl_blas
#mkl_libs = mkl

# UMFPACK
# -------
# The UMFPACK library is used in scikits.umfpack to factor large sparse matrices. 
# It, in turn, depends on the AMD library for reordering the matrices for
# better performance.  Note that the AMD library has nothing to do with AMD
# (Advanced Micro Devices), the CPU company.
#
# UMFPACK is not used by numpy.
#
#   http://www.cise.ufl.edu/research/sparse/umfpack/
#   http://www.cise.ufl.edu/research/sparse/amd/
#   http://scikits.appspot.com/umfpack
#
#[amd]
#amd_libs = amd
#
#[umfpack]
#umfpack_libs = umfpack

# FFT libraries
# -------------
# There are two FFT libraries that we can configure here: FFTW (2 and 3) and djbfft.
# Note that these libraries are not used by for numpy or scipy.
#
#   http://fftw.org/
#   http://cr.yp.to/djbfft.html
#
# Given only this section, numpy.distutils will try to figure out which version
# of FFTW you are using.
#[fftw]
#libraries = fftw3
#
# For djbfft, numpy.distutils will look for either djbfft.a or libdjbfft.a . 
#[djbfft]
#include_dirs = /usr/local/djbfft/include
#library_dirs = /usr/local/djbfft/lib
