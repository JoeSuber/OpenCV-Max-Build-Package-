OpenCV-Max-Build-Package-
=========================

    -- when coming from a fresh install, packages for setting up a fat full-featured build
    
IPP is not on here due to a lack of package-managed install and new Open CL stuff may 
be as good... still need to test that idea. If using IPP, use 7.1 version with static add-on.
8.0 leaves out certain depreciated parts that OpenCV still needs.

todo: describe the pros & cons of cmake-gui options

todo: test with openNI - I don't have a device

CUDA-5.5 was just added to the regular synaptic stuff

only tested on Ubuntu 13.10, CUDA 5.5, with most everything turned on

--- I would do these 1 or 2 at a time to witness results ----

sudo apt-get -y install autoconf2.13 autoconf-archive gnu-standards

sudo apt-get -y install libtool graphviz default-mta gfortran libgmp10

sudo apt-get -y install libblas3 libblas-dev liblapack3 liblapack-dev liblapacke libmpfr4 libmpfr-dev

sudo apt-get -y install python-dev

sudo apt-get -y install git cmake-gui

.........................  CAREFUL    .................................................

... maybe not just yet ........  sudo apt-get remove nvidia*

............................ NVIDIA STUFF  - DANGEROUS .................................

sudo apt-get upgrade

sudo apt-get -y remove ffmpeg x264 libx264-dev

sudo apt-get -y install libopencv-dev

........ Above is older version. Changes nvidia driver. .probably reboot here ...........

sudo apt-get -y install build-essential checkinstall cmake pkg-config yasm

sudo apt-get -y install libtiff4-dev libjpeg-dev libjasper-dev

sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev

sudo apt-get -y install python-pip doxygen

sudo apt-get -y install python-gmpy libeigen3-dev

sudo apt-get -y install libjasper-runtime libjasper1 libilmbase-dev libopenexr6 libopenexr6-dev exrtools

sudo apt-get -y install python-dev python-numpy libbz2-dev libcoin80

sudo apt-get -y install libtbb-dev liborc-dev

sudo apt-get -y install libgtk2.0-dev libwebp4 libwebp-dev webp

sudo apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev

sudo apt-get -y install libxine2-dev libxvidcore-dev libv4l-dev

sudo apt-get -y install x264 v4l-utils ffmpeg

sudo apt-get -y install libgstreamer*

sudo apt-get -y install python-symeig

sudo apt-get install freeglut3 freeglut3-dev build-essential \
    libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx \
    libglu1-mesa libglu1-mesa-dev gcc g++ gcc-4.4 g++-4.4 \
    linux-headers-generic linux-source

sudo apt-get install "^libxcb.*" libx11-xcb-dev libglu1-mesa-dev libxrender-dev

----- the above libxcb stuff  somehow is not fully covered by anything else. ----------

sudo apt-get install libicu-dev

sudo apt-get install libsqlite0 sqlite sqlite3 python-sphinx libsphinxbase1 libsphinxbase-dev latex2html ant ant-contrib 

    -- For setting up CUDA-needed gcc versions 

sudo update-alternatives --remove-all gcc

sudo update-alternatives --config gcc

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 20

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 50

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 10

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 40

sudo update-alternatives --config gcc      #choose 4.7.x or 4.8 for now

    -- below link may be outdated... but maybe not

sudo ln -s /usr/lib/x86_64-linux-gnu/libglut.so.3 /usr/lib/libglut.so

    ---if in need of latest QT5 - yeah, it takes a while, but provides best gui -----

git clone git://gitorious.org/qt/qt5.git qt5

cd qt5

git checkout stable

perl init-repository --no-webkit

    -- now check on previous installs of QT - no environment variables like QMAKEPATH or QMAKEFEATURES
    -- $HOME/.config/Trolltech/QMake.conf should be empty
    -- openCV (cmake-gui) will want  --> $HOME/qt5/qtbase/lib/cmake/Qt5...

./configure -developer-build -opensource -nomake examples -nomake tests -no-gtkstyle -confirm-license

make -j4

    -- no 'make install' required as we used developer-build options
    -- also note lack of sudo or non-home activity
    -- want updates?  - may have to run ./configure again
    -- need a cleaning before rebuild? - git submodule foreach --recursive "git clean -dfx"
    (for updates)
    git pull
    git submodule sync
    git submodule update --recursive


----------  how about some java 7?  -------------------------------------------------

sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install oracle-java7-installer

sudo update-java-alternatives -s java-7-oracle

sudo apt-get install oracle-java7-set-default

................. must switch to gcc-4.4 for compile of cuda-stuff ..................

sudo update-alternatives --config gcc

................  clone into repo (default branch is master) git checkout 2.4 .........

git https://github.com/Itseez/opencv.git

cd opencv

mkdir build

cd build

cmake-gui .

---- point to a bunch of stuff, select a bunch of options, configure, configure, configure, generate, exit---

sudo make -j4

sudo make install

sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

sudo ldconfig

---- assume that all worked  ----

python

>>> import cv2

>>> b = cv2.getBuildInformation().split('\n')

>>> for l in b:

>>>     print l

--- (here you will get a whole bunch of info to verify the build.  ctrl-D to exit) ---
