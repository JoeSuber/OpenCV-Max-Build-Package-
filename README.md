###  OpenCV-Max-Build-Package-  ###

    -- Benefit from having this in one place.  Also the ordering is useful, if not perfect.
    -- Helps a new installer avoid some pitfalls or at least know where the tarpits are located.
    
IPP (Intel Integrated Performance Primitives) library is not on here due to a lack of package-managed install. You have to get a (free-of-charge) license code from Intel. link:

    -- http://software.intel.com/en-us/non-commercial-software-development
    
TBB (Intel Threaded Building Blocks) is very much a must-have - (and it is open-source now) - use it!  
But with IPP - I don't see a ton of improvements. Its benefit will depend on what your applications are and what other libraries are providing basic functions like resizing a picture or computing the FFT.

New Open CL stuff may be as good... still need to test that idea. If using IPP, use 7.1 version with static add-ons.
8.0 leaves out certain depreciated parts that OpenCV still needs (as of Nov 17, 2013)

    todo: try to understand all the pros & cons of cmake-gui options
    todo: test with openNI - I don't have a device
    todo: Gige-whatever-cam, Ximea, Plantuml

The Following Build is only tested on Ubuntu 13.10, CUDA 5.5, Intel cpu, with most everything turned on

--- I would do these 1 or 2 at a time to witness results ----

sudo apt-get -y install autoconf2.13 autoconf-archive gnu-standards libclp-dev libcoinutils0 libcgl0 libvol0

sudo apt-get -y install libtool graphviz default-mta gfortran libgmp10 libatlas-base-dev libeigen3-dev

sudo apt-get -y install libblas3 libblas-dev liblapack3 liblapack-dev liblapacke libmpfr4 libmpfr-dev

sudo apt-get -y install python-dev python-pip python-numpy

sudo pip install gmpy

sudo apt-get -y install git cmake cmake-gui

    -- as of this note, gfortran is used to build atlas, hence, numpy so if building your own numpy:
    -- git clone https://github.com/numpy/numpy.git
    -- cd numpy
    -- python setup.py build --fcompiler=gnu95
    -- sudo python setup.py install
        -- Then, test, assuming nose is installed (sudo pip install nose):
    -- python -c 'import numpy; numpy.test()'

sudo apt-get upgrade

sudo apt-get -y remove ffmpeg x264 libx264-dev

sudo apt-get -y install build-essential checkinstall pkg-config yasm

sudo apt-get -y install libtiff4-dev libjpeg-dev libjasper-dev 

sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev

sudo apt-get -y install doxygen

sudo apt-get -y install libjasper-runtime libjasper1 libilmbase-dev libopenexr6 libopenexr6-dev exrtools

sudo apt-get -y install libbz2-dev libcoin80

sudo apt-get -y install libtbb-dev liborc-dev

sudo apt-get -y install libgtk2.0-dev libwebp4 libwebp-dev webp

sudo apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev

sudo apt-get -y install x264 libxvidcore-dev libv4l-dev v4l-utils ffmpeg

sudo apt-get -y install freeglut3 freeglut3-dev build-essential \
    libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx \
    libglu1-mesa libglu1-mesa-dev gcc g++ gcc-4.4 g++-4.4 \
    linux-headers-generic linux-source

sudo apt-get -y install "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev

sudo apt-get -y install libgstreamer*

sudo apt-get -y install libxine-dev

sudo apt-get -y install libxine2-dev 

----- the above libxcb stuff  somehow is not fully covered by anything else. ----------

    --- If playing with video drivers, be ready to loose everything on the partition ---
    --- Some Concepts: GRUB - fstab - sudo nano - ctrl-alt-f1 / ctrl-alt-f7 - service lightdm stop
    -- it is nice to have a way to 'put it back like it was.' consider this:
    http://www.fsarchiver.org/QuickStart

#####  WARNING  ########  VIDEO DRIVER ZONE ###################
sudo apt-get -y install libopencv-dev

    .... Above is older version. Changes video driver. Probably should reboot here .....

--- At least have another way to get on-line and look stuff up ---

That being said, the following seems to be working well now circa Nov 17, 2013...

Very condensed NVIDIA driver / CUDA-5.5 install instructions:

    Drivers. How about some fresh crack?
    nvidia-331_331.20-0ubuntu1~xedgers~saucy1_amd64.deb
    
add a .deb install ppa from the official CUDA page:

    https://developer.nvidia.com/cuda-downloads
    select this -> cuda-repo-ubuntu1210   or  the 1204 version... CUDA 6 is coming

then use package-manager, like synaptic (sudo apt-get install synaptic) or aptitude, to run the update.

    --when using Synaptic et. al. select Meta-Packages, not individual components
    --trouble? make sure the ppa is added & you have hit update since ppa was added & that the new 
    address was contacted by the update
###### OR ######
If looking for an education, a Bachelor of Arts in video driver installation:

    sudo apt-get install cuda-5.5 nvidia-current nvidia-current-dev \
                  nvidia-modprobe nvidia-settings

after that madness:

    export PATH=/usr/local/cuda-5.5/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-5.5/lib64:$LD_LIBRARY_PATH
    
####  NVIDIA STUFF + Silly Salamander = DANGEROUS  ########
(leaving danger zone)

sudo apt-get install libsqlite0 sqlite sqlite3 python-sphinx libsphinxbase1 libsphinxbase-dev latex2html ant ant-contrib 

    -- For setting up CUDA-compiler-needed gcc versions
    -- you may only need one or two of the following
    -- 4.4 is needed for Ubuntu 13.10- other recommendations for cuda 5.5 are on:
    http://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#linux-5-5
    
sudo update-alternatives --remove-all gcc

sudo update-alternatives --config gcc

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 20

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 50

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 10

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 40

sudo update-alternatives --config gcc       #choose 4.7.x or 4.8 for now

    -- below link-up may be outdated... but maybe not

sudo ln -s /usr/lib/x86_64-linux-gnu/libglut.so.3 /usr/lib/libglut.so

####  QT5 Section  ####

    ---if in need of latest QT5 - yeah, it takes a while, but provides best GUI for OpenCV-----

git clone git://gitorious.org/qt/qt5.git qt5

cd qt5

git checkout stable

perl init-repository --no-webkit

    -- now check on previous installs of QT. Be rid of environment variables like QMAKEPATH or QMAKEFEATURES
    -- $HOME/.config/Trolltech/QMake.conf should be empty

./configure -developer-build -opensource -nomake examples -nomake tests -no-gtkstyle -confirm-license

make -j4

    -- QT5 notes:
    -- no 'make install' required as we used developer-build options
    -- also note lack of sudo or non-home activity
    -- want updates?  - may have to run ./configure again
    -- need a _deep_ cleaning before rebuild? 
    git submodule foreach --recursive "git clean -dfx"
    -- for updates / rebuilds / changing branches)
    git pull
    git submodule sync
    git submodule update --recursive


----------  how about some java 7? in a ppa! -----------------------------------------

sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install oracle-java7-installer

sudo update-java-alternatives -s java-7-oracle

sudo apt-get install oracle-java7-set-default

    --BTW this site is useful for many things distro related:
    http://www.webupd8.org/

................. must switch to gcc-4.4 for compile of cuda-stuff (Ubuntu 13.10) .....

sudo update-alternatives --config gcc

........  clone into OpenCV repo (default branch is master) .........

git clone https://github.com/Itseez/opencv.git

git clone https://github.com/Itseez/opencv_extra.git

    -- include the optional 'extras' in cmake-gui under OPENCV --> ~/opencv_extra

cd opencv

##### recommended option ##### =  git checkout 2.4 

mkdir build

cd build

cmake-gui .

    -- some cmake-gui hints:
    -- don't go all OCD trying to fill in everything before you hit 'configure' at least once.
    -- initially, check the two boxes in top area to 'group entries' and 'show advanced'
    -- MAKE: don't use fast-math for GCC or CUDA unless you probably don't need this guide & know better. eg:
    -- http://stackoverflow.com/questions/11507440/does-use-fast-math-option-translate-sp-multiplications-to-intrinsics
    -- don't check 'download tbb' up top if you already have it, but make sure the path is true after a 'config'
    -- uncheck CLAMBLAS and CLAMDFFT if yours is an Intel cpu
    -- MAKE: do check mark all of the SSE instruction sets (and AVX) if you have a modern non-ARM CPU
    -- after checking options you can press configure as many times as needed.  Sometimes the script finds things.
    -- just because the red highlight goes away doesn't mean it is fixed - look at the paths
    -- If Intel, you still can use Open CL - but you benefit from an active TBB & IPP more than AMD
    -- QT can be tricky. If using QT5 don't worry about that massive bunch of QT4 stuff that seems incomplete
    -- you can select nvidia options like nvcuuvd (video) and nvfft (fast Fourier transform) without selecting CUDA.
    -- /usr/local/cuda or /usr/local/cuda-5-5 is your friend. also /usr/lib/nvidia-updates
    -- CUDA: there is a blank after Generation. click there and choose 'Kepler'if you have a modern nvidia card
    -- CUDA: UNcheck attach to target
    -- the qmake executable = ~/qt5/qtbase/bin/qmake
    -- for QT-DIR options you want--> ~/qt5/qtbase/lib/cmake/Qt5... where ... are things like Concurrent, Core etc
    -- after a 'configure' or 3, under MAKE, select Debug or Release build type before you hit 'generate'
    -- OPENGL_xmesa_INCLUDE = /usr/lib/x86_64-linux-gnu/mesa
    -- the many cuda addresses may not show up right away. if you get the script started sometimes it finds the rest:
        CUDA_CUDART_LIBRARY --> /usr/local/cuda-5.5/lib64/libcudart.so
        CUDA_NVCC_EXECUTABLE --> /usr/local/cuda-5.5/bin/nvcc
        CUDA_nvcuvid_LIBRARY --> /usr/lib/nvidia-331/libnvcuvid.so
        CUDA_cupti_LIBRARY --> /usr/local/cuda-5.5/extras/CUPTI/lib64/libcupti.so
        CUDA_CUDA_LIBRARY --> /usr/lib/nvidia-331/libcuda.so

---- point to a bunch of stuff, select a bunch of options, configure, configure, configure, generate, exit---

sudo make -j4

sudo make install

sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

sudo ldconfig

---- to verify that all worked, enter the python interpreter ----

python

>>> import cv2

>>> b = cv2.getBuildInformation().split('\n')

>>> for p in b:

>>>     print p

--- (here you will get a whole bunch of info to verify the build.  ctrl-D to exit) ---
