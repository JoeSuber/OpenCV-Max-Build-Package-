###  OpenCV-Max-Build-Package CUDA 6.5 Ubuntu 14.xx-  ###

Your Maximum Build:

    -- The ordering is useful, perhaps not perfect.
    -- Helps a noob avoid some pitfalls.

IPP (Intel Integrated Performance Primitives) has no package-managed install.
You have to get a (free-of-charge) license code from Intel for the full kit:

    -- http://software.intel.com/en-us/non-commercial-software-development
    
A large subset of IPP will now download automatically as part of opencv.
The asynchronous libs are what is missing, but have been troublesome anyway.

TBB (Intel Threaded Building Blocks) though, is very much a must-have for your Intel CPU - 
(and it is open-source now) TBB now downloads without incident via opencv's make - easy!

The following Build is only tested on Ubuntu 14.xx CUDA 6.5, Intel cpu, with most everything turned on

    --- Linux mint 17 sort-of works  -----
    --- I would do these lines 1 or 2 at a time to witness results ----

sudo apt-get upgrade

sudo apt-get -y install autoconf2.13 autoconf-archive gnu-standards

sudo apt-get -y install build-essential gcc g++ linux-headers-generic linux-source

sudo apt-get -y install libcoin80-dev libcoin80 libtool graphviz default-mta gfortran libgmp10 libgmp-dev libatlas-base-dev 

sudo apt-get -y install libeigen3-dev libblas3 libblas-dev liblapack3 liblapack-dev liblapacke libmpfr4 libmpfr-dev

sudo apt-get -y install python-dev python-pip python-numpy python-gevent python-levenshtein

sudo pip install gmpy requests grequests cython ipython

    -- above pip items are not strictly needed for opencv, but damn great

sudo apt-get -y install git cmake cmake-gui checkinstall pkg-config yasm

     	-- ********* ATLAS holds up the world **************
    	-- ATLAS from distro works, but is generic. 
	-- Build your own from recent Source to ensure it is 'tuned' to your CPU.
	-- Takes 10-20 minutes

The sources of the package and its build-dependencies:

sudo apt-get source atlas
sudo apt-get build-dep atlas
sudo apt-get install devscripts

find the atlas-dir and type the following from the atlas source subdir:

sudo fakeroot debian/rules custom

it should produce packages called:

../libatlas3-base_*.deb

Then install the package using: 

dpkg -i  (for each .deb)

    -- if building your own ATLAS, might as well get OpenBlas:
        - git clone git://github.com/xianyi/OpenBLAS
        -- make, sudo make install (takes a little while, look in /opt/openblas)

    -- Numpy sometimes has other good improvements over distro version
	- may need to edit "site.cfg" to point to the proper ATLAS or OpenBLAS location
        - git clone https://github.com/numpy/numpy.git
        - cd numpy
        - python setup.py build --fcompiler=gnu95
        - sudo python setup.py install

    -- Then, test, assuming nose is installed (sudo pip install nose):
        - cd ..
        - python -c 'import numpy; numpy.test()'
    -- With a test-time of about 9.8 seconds, OpenBlas-backed Numpy was
    -- about .5 sec faster than ATLAS-backed Numpy (ver 1.90-dev, on 4-core 3.4 ghz i5 4670)

Here (finally) is the buildable source for "Clp" - Coin-or Linear Problem Solver:

http://www.coin-or.org/download/source/Clp/Clp-1.15.6.tgz

	-- Clp has very standard build from source dir as follows: 
	-- ./configure, make -j4, make check, make test, sudo make install

sudo apt-get -y remove ffmpeg x264 libx264-dev

sudo apt-get -y install libtbb-dev liborc-dev

sudo apt-get -y install libtiff4-dev libjpeg-dev libjasper-dev libjasper-runtime libjasper1

sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev

sudo apt-get -y install doxygen

sudo apt-get install libsqlite0 sqlite sqlite3 python-sphinx libsphinxbase1 libsphinxbase-dev latex2html ant ant-contrib 

sudo apt-get -y install libilmbase-dev openexr exrtools libopenexr-dev

sudo apt-get -y install libbz2-dev

sudo apt-get -y install libgtk2.0-dev libwebp4 libwebp-dev webp

sudo apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev

sudo apt-get -y install x264 libxvidcore-dev libv4l-dev v4l-utils ffmpeg

sudo apt-get -y install freeglut3 freeglut3-dev build-essential \libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx \libglu1-mesa libglu1-mesa-dev gcc g++ gcc-4.4 g++-4.4

sudo apt-get -y install "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev

sudo apt-get install gstreamer* 

sudo apt-get install libgstreamer*

sudo apt-get -y install libxine2-dev 

----- the above libxcb dev stuff is suggested by qt5 build. ----------

#####  WARNING  ########  VIDEO DRIVER ZONE ###################

    --- If playing with video drivers, be ready to loose everything on the partition ---
    --- Some concepts for recovery: while booting, hold down <Shift> to GRUB boot, select recovery mode
    --- for moving partitions, re-installs, understand: fstab - sudo nano - ctrl-alt-f1 / ctrl-alt-f7
    ---  consider using 'rsync' based ideas like 'duplicity' & 'deja-dup'
	--- At least have another way to get on-line and look stuff up ---

	Download recent drivers & cuda. chmod +x them.
    Use ctrl-alt-f1 
    enter login & password at text prompts
    - sudo service lightdm stop
    Now run your Downloaded 'binary' 'proprietary' Nvidia installer:
    - sudo chmod +x ~/Downloads/NVIDIA-Linux-x86_64-337.12.run
    - sudo ~/Downloads/NVIDIA-Linux-x86_64-337.12.run
    ok,ok,ok,ok,yes,accept,blah.
    - sudo service lightdm start 
    I'd stick with Nvidia-provided for the forseeable future as it 
    seems easier to recover when this 'proprietary' kind of install goes wrong
    Nvidia is seemingly doing a good job of Linux support now, in 2014.
    
    I would NOT install the PPA right now
    
    	FOR NOW, DO NOT USE:
    	sudo add-apt-repository ppa:xorg-edgers/ppa 
    	sudo apt-get update
    	sudo apt-get install <package name>
 
 	FOR NOW, DO NOT USE:  
	add a .deb install ppa from the official CUDA page:
	https://developer.nvidia.com/cuda-downloads
	then use package-manager, like synaptic (sudo apt-get install synaptic) or aptitude, to run the update.

REMEMBER: When using Synaptic et. al. select Meta-Packages, not individual components.
TROUBLE w/ PACKAGES:  Make sure the ppa is added & you have hit update since ppa was added & that the new address was contacted by the update

    export PATH=/usr/local/cuda-6.5/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-6.5/lib64:$LD_LIBRARY_PATH

#### LEAVING VIDEO DRIVER ZONE #####

sudo ln -s /usr/lib/x86_64-linux-gnu/libglut.so.3 /usr/lib/libglut.so

(below are some extra packages I add-on outside the scope of opencv)

sudo apt-get install gtk-3.0 sox libsox-fmt-mp3

####  QT5 Section  ####
	(QT4 or 5 takes a while to build. consider distro packages)
    ---if in need of latest QT5 git clone git://gitorious.org/qt/qt5.git qt5

cd qt5

git checkout stable

perl init-repository --no-webkit

    -- now check on previous installs of QT. Be rid of environment variables like QMAKEPATH or QMAKEFEATURES
    -- $HOME/.config/Trolltech/QMake.conf should be empty

./configure -developer-build -opensource -nomake examples -nomake tests -no-gtkstyle -confirm-license

make -j4

    -- QT5 notes:
    -- '-j4' means 'use 4 cpu cores'  Adjust yours accordingly.
    -- no 'make install' required as we used developer-build options
    -- also note lack of sudo or non-home activity
    -- want updates?  - may have to run ./configure again
    -- need a _deep_ cleaning before rebuild? 
    git submodule foreach --recursive "git clean -dfx"
    -- for updates / rebuilds / changing branches)
    git pull
    git submodule sync
    git submodule update --recursive

#### how about some java 7-8? in a ppa! ####

sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install oracle-java7-installer

sudo apt-get install oracle-java8-installer

sudo update-java-alternatives -s java-8-oracle

sudo apt-get install oracle-java8-set-default

    --BTW this site is useful for many things distro related:
    http://www.webupd8.org/

#### java ppa ###

(if you were using gcc 4.4 or 4.7 to compile an old CUDA switch back to 4.8 now)

-sudo update-alternatives --config gcc

........ clone into OpenCV repo (default branch is master) .........
cd ~

git clone https://github.com/Itseez/opencv.git

git clone https://github.com/Itseez/opencv_extra.git

-- The above are NOT the 'extra modules'  Quite an unfortunate name. Intended 'extra modules' are:

git clone https://github.com/Itseez/opencv_contrib

-- point to the optional 'extras' option in cmake-gui under OPENCV_EXTRA_MODULES_PATH --> ~/opencv_contrib/modules

cd opencv

recommended option: git checkout 2.4
developer's shining new untested toys: git checkout master
some other options: git branch -h
(then checkout the branch)

cd ~/opencv

mkdir build

cd build

(here is where we select the options to be built in to our OPENCV MAXIMUM-BUILD!!!)

cmake-gui .

(put in the paths in the gui forms at the top)

    -- Some cmake-gui opencv build hints:
    -- master vs 2.4 - notice different options
    -- Don't go all OCD trying to fill in everything before you hit 'configure' at least once.
    -- upon opening cmake-gui, check the two boxes in top area to:
    	'group entries' and 'show advanced'  That wil organize the hundreds of options into sane categories.
    -- MAKE: don't use fast-math for GCC or CUDA unless you probably don't need this guide & know better.
    -- Don't check 'DOWNLOAD TBB' up top if you already have it, but make sure the path is true after a 'config'
    -- uncheck CLAMBLAS and CLAMDFFT if yours is an Intel cpu
    -- JASPER: cmake never auto-fills the debug lib-path. Just copy the release path to DEBUG slot.
    -- MAKE: do check mark all of the SSE instruction sets (and AVX) if you have a modern non-ARM CPU
    -- After checking options you can press configure as many times as needed.  Sometimes the script finds things.
    -- CMAKE-gui: Just because the red highlight goes away doesn't mean 'solved.' Look to see if the paths are filled.
    -- If Intel-CPU / Nvidia GPU, you still use some OpenCL - you benefit MORE from an active TBB & IPP than AMD users.
    -- QT info can be tricky. If using QT5 don't worry about that massive bunch of QT4 stuff that seems incomplete
    -- X11 options will always have a few missing, but you can ignore that to no ill effect. Trying to hunt down
        those 'X' items will probably mess up a chain of dependencies specific to your functional setup.
    -- OPENEXR: As long as you see a version number (currently 1.71 from packages) for it under MEDIA I/O you are good.
    -- WITH: You may select nvidia options like nvcuuvd (video) and nvfft (fast Fourier transform) without selecting CUDA.
    -- CUDA: When looking for 'missing' libraries, dirs under: /usr/local/cuda are your friend. 
    -- when using xorg/ppa look in /usr/lib/nvidia-updates for those pesky missing *.so libs
    -- CUDA: there is a blank after Generation. 'Fermi' is older than 'Kepler.' 
    	Yes, Even though Enrico Fermi is a quantum physics guy and Johans Kepler was wearing a poofy shirt most of his life,
    	the more modern Nvidia GPU is of the 'Kepler' generation.
    -- QT5:the qmake executable = ~/qt5/qtbase/bin/qmake
    -- QT-DIR options you want--> ~/qt5/qtbase/lib/cmake/Qt5... where ... are things like Concurrent, Core etc
    -- CMAKE after a 'configure' or 3, under MAKE, select Debug or Release build type before you hit that final 'generate'
    -- OPENGL_xmesa_INCLUDE = /usr/lib/x86_64-linux-gnu/mesa  For some reason it has trouble finding that one.
    -- CUDA: the many cuda addresses may not show up right away. if you get the script started with nvcc, 
        then 'configure' sometimes it finds the rest.
    -- Clp - libcoin - I've never been sure this is active. There are conflicting messages. Machine Learning indeed.
    -- Here are a few typical CUDA paths in case they aren't auto-populated. However, recent installs have not needed these hints:
        CUDA_CUDART_LIBRARY --> /usr/local/cuda-5.5/lib64/libcudart.so
        CUDA_NVCC_EXECUTABLE --> /usr/local/cuda-5.5/bin/nvcc
        CUDA_nvcuvid_LIBRARY --> /usr/lib/nvidia-331/libnvcuvid.so
        CUDA_cupti_LIBRARY --> /usr/local/cuda-5.5/extras/CUPTI/lib64/libcupti.so
        CUDA_CUDA_LIBRARY --> /usr/lib/nvidia-331/libcuda.so
    -- Of course, you can't just cut n' paste the above - drivers & versions will change

---- you have pointed to a bunch of stuff, selected a bunch of options, configure, configure, configure, generate, exit---

(now back at the prompt)
(drum roll..)

make -j4

sudo make install

sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

sudo ldconfig

---- to verify that all worked, enter the ipython interpreter ----

ipython

[1] import numpy as np

[2] import cv2

[3] b = cv2.getBuildInformation().split('\n')

[4] for p in b:
    print p

... (shows you the options of the build, what should be active) ...

[5] dir(cv2)
... 
[6] dir(np)
...
(you can use ipython to look at all the (python) available method & function doc-strings, try them out)

Let me know what needs to change!

