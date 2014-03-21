###  OpenCV-Max-Build-Package-  ###

    -- March 20, 2014: Must investigate the VTK extensions. Keep using Nvidia provided drivers & cuda direct d/l.
        -- the only downside to that is that when your linux kernel is updated, after an eventual reboot, 
        -- when confronted by the dreaded 'X' cursor on a blank, black, low-res GUI you can't escape:
            Ctrl-Alt-f1, enter login, pass
            sudo service lightdm stop
            (find & run the Nvidia driver installer wherever you saved it.  You DID keep it around, right?
            re-install it.)
            sudo service lightdm start
            (breath easy)
    -- Jan 6 2014 note: After a Jan 2nd xorg-edgers update blew up my Dec. install I went through this guide
    --- Everything worked! With the exception that you should avoid the ppa-based nvidia cuda and video 
    --- drivers and simply install the 5.5.22 cuda version d/l from the nvidia website.

This isn't a build script, though it has a lot of cut & paste. There is, I think, much need for user intervention and 
important choices to be made as you find out what works for particular apps and hardware: your "Maximum Build."

    -- The ordering is useful, though probably not perfect.
    -- Helps a new installer avoid some pitfalls, an old installer try some new tricks.
    -- Helps me to not forget small - but crucial - things - (as often).
    
IPP (Intel Integrated Performance Primitives) library is not on the list due to a lack of package-managed install.
You have to get a (free-of-charge) license code from Intel:

    -- http://software.intel.com/en-us/non-commercial-software-development
    
With IPP - I don't see a ton of improvements. Its benefit will depend on what your applications are 
and what other libraries are providing basic functions like resizing a picture or computing the FFT.
IPP is only free-of-charge for non-commercial use.

New Open CL stuff may be as good or better for many things... still need to test that idea.

    -- 12-2-13 I can confirm that several apps are running as well or better now 
    -- with OpenCL sans IPP (master branch)
    
If using IPP, use 7.1 version with static add-ons.
8.0 leaves out certain depreciated parts that OpenCV still needs (as of Nov 17, 2013)

TBB (Intel Threaded Building Blocks) though, is very much a must-have for your Intel CPU - 
(and it is open-source now) - use it!   (package is in the list below) 

The following Build is only tested on Ubuntu 13.10, CUDA 5.5, Intel cpu, with most everything turned on

--- modern Debian-based installs should work very similarly   -----
--- I would do these lines 1 or 2 at a time to witness results ----

sudo apt-get upgrade

sudo apt-get -y install autoconf2.13 autoconf-archive gnu-standards libcoin80-dev libcoin80

sudo apt-get -y install libcoinutils0 build-essential gcc g++ linux-headers-generic linux-source

sudo apt-get -y install libtool graphviz default-mta gfortran libgmp10 libgmp-dev libatlas-base-dev libeigen3-dev

sudo apt-get -y install libblas3 libblas-dev liblapack3 liblapack-dev liblapacke libmpfr4 libmpfr-dev

sudo apt-get -y install python-dev python-pip python-numpy python-gevent

sudo pip install gmpy grequests requests

    -- gmpy is not strictly needed for opencv but I use it for fast popcount in python
    -- gevent and grequests are optional as well, just here for convenience

sudo apt-get -y install git cmake cmake-gui

    -- if building your own numpy, might as well get OpenBlas first:
        - git clone git://github.com/xianyi/OpenBLAS
    -- make, make install (takes a little while)
        - git clone https://github.com/numpy/numpy.git
        - cd numpy
        - python setup.py build --fcompiler=gnu95
        - sudo python setup.py install
    -- Then, test, assuming nose is installed (sudo pip install nose):
        - cd ..
        - python -c 'import numpy; numpy.test()'
    -- With a test-time of about 9.8 seconds, OpenBlas-backed Numpy was
    -- about .5 sec faster than ATLAS-backed Numpy (ver 1.90-dev, on 4-core 3.4 ghz i5 4760)

sudo apt-get -y remove ffmpeg x264 libx264-dev

sudo apt-get -y install checkinstall pkg-config yasm

sudo apt-get -y install libtiff4-dev libjpeg-dev libjasper-dev 

sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev

sudo apt-get -y install doxygen

sudo apt-get install libsqlite0 sqlite sqlite3 python-sphinx libsphinxbase1 libsphinxbase-dev latex2html ant ant-contrib 

sudo apt-get -y install libjasper-runtime libjasper1 libilmbase-dev openexr exrtools libopenexr-dev

sudo apt-get -y install libbz2-dev

sudo apt-get -y install libtbb-dev liborc-dev

sudo apt-get -y install libgtk2.0-dev libwebp4 libwebp-dev webp

sudo apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev

sudo apt-get -y install x264 libxvidcore-dev libv4l-dev v4l-utils ffmpeg

sudo apt-get -y install freeglut3 freeglut3-dev build-essential \libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx \libglu1-mesa libglu1-mesa-dev gcc g++ gcc-4.4 g++-4.4

sudo apt-get -y install "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev

sudo apt-get -y install libgstreamer* 

sudo apt-get -y install gstreamer*

sudo apt-get -y install libxine-dev

sudo apt-get -y install libxine2-dev 

----- the above libxcb stuff  somehow is not fully covered by anything else. ----------

    --- If playing with video drivers, be ready to loose everything on the partition ---
    --- Some Concepts: GRUB - fstab - sudo nano - ctrl-alt-f1 / ctrl-alt-f7 - service lightdm stop
    -- it is nice to have a way to 'put it back like it was.' consider this:
    http://www.fsarchiver.org/QuickStart
    or better yet (your own script / plan) to use 'rsync'


#####  WARNING  ########  VIDEO DRIVER ZONE ###################

--- At least have another way to get on-line and look stuff up ---

    Very condensed NVIDIA driver / CUDA-5.5 install instructions:
    1-6-14 UPDATE - recent PPA version seems to be made for ubuntu 14.0x or I don't
    understand what... It breaks X windows, I loose some GL stuff...
    I think it is made for kernel 3.13.xx but salamander is on 3.11.  
    Nvidia d/l drivers seem to be the only way to fix.  
    Use ctrl-alt-f1 
    - sudo service lightdm stop
    run the downloaded Nvidia installer, NOT package managed version, ok ok ok 
    - sudo service lightdm start 
    - back in business.  Ignore Below until this trouble clears up.
    
    I would NOT install the PPA right now
    
    Drivers. How about some fresh crack?
    sudo add-apt-repository ppa:xorg-edgers/ppa 
    sudo apt-get update
    sudo apt-get install <package name>
    -- Nov 18 2013 that meant:  nvidia-331_331.20-0ubuntu1~xedgers~saucy1_amd64.deb
    
add a .deb install ppa from the official CUDA page:

    https://developer.nvidia.com/cuda-downloads
    select this -> cuda-repo-ubuntu1210   or  the 1204 version... CUDA 6 is coming

then use package-manager, like synaptic (sudo apt-get install synaptic) or aptitude, to run the update.

    --when using Synaptic et. al. select Meta-Packages, not individual components
    --trouble? make sure the ppa is added & you have hit update since ppa was added & that the new 
    address was contacted by the update

    export PATH=/usr/local/cuda-5.5/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-5.5/lib64:$LD_LIBRARY_PATH

####  NVIDIA STUFF + Silly Salamander or Reckless Racoon = DANGEROUS  ########
(leaving danger zone)
        
    -- gcc 4.4 WAS needed for Ubuntu 13.04
    -- gcc 4.8 has worked for 13.10 (and quite well) obsoleting the gcc-related items below:
            other recommendations for compilation of cuda 5.5 on various OS are on:
        http://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#linux-5-5
            (though this is getting a little long-in-the-tooth)
    
sudo update-alternatives --remove-all gcc

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 20

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 50

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60

sudo update-alternatives --config gcc       #choose 4.7.x or 4.8 for now

    -- below link-up may be outdated... but maybe not

sudo ln -s /usr/lib/x86_64-linux-gnu/libglut.so.3 /usr/lib/libglut.so

####  QT5 Section  ####

    ---if in need of latest QT5 
