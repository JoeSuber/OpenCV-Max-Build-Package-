###  OpenCV-Max-Build-Package-  ###

    -- March 29, 2014: Keep using Nvidia provided drivers & cuda direct d/l.
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

This isn't a build script, but it has a lot of cut & paste. There is, I think, much need for user intervention and 
important choices to be made as you adjust for particular apps and hardware: your "Maximum Build."

    -- The ordering is useful, though probably not perfect.
    -- Helps a new installer avoid some pitfalls, an old installer try some new tricks.
    -- Helps me to not forget small - but crucial - things - (as often).
    
IPP (Intel Integrated Performance Primitives) library is not on the list due to a lack of package-managed install.
You have to get a (free-of-charge) license code from Intel:

    -- http://software.intel.com/en-us/non-commercial-software-development
    
IPP used to be more crucial, but OpenCL is now picking up some of the parallelization chores.
Its benefit will depend on what your applications are and what other libraries are providing 
basic functions like resizing a picture or computing the FFT.
IPP is only free-of-charge for non-commercial use.
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

sudo apt-get -y install python-dev python-pip python-numpy python-gevent python-levenshtein

sudo pip install gmpy grequests requests

    -- gmpy is not strictly needed for opencv but I use it for fast popcount in python
    -- gevent and grequests are optional as well, just here for convenience

sudo apt-get -y install git cmake cmake-gui
sudo apt-get -y install checkinstall pkg-config yasm

     **************************************************
    -- ATLAS from distro works, but is generic. Build your own from recent Source to 
    ensure it is 'tuned' to your CPU.  First git clone or dl LAPACK, then
        - http://sourceforge.net/projects/math-atlas/files/
    A sample ATLAS configure line (run from 'ATLAS/build/'): 
        ../configure -D c -DPentiumCPS=3401 -Si archdef 0 --shared \
	        --prefix=/home/suber/lib/atlas \
	        --with-netlib-lapack-tarfile=/home/suber/Downloads/lapack-3.5.0.tgz
        
    make              ! tune and compile library (can take 30+ minutes)
    make check        ! perform sanity tests
    make ptcheck      ! checks of threaded code for multiprocessor systems
    make time         ! provide performance summary as % of clock rate
    (sudo) make install      ! Copy library and include files to other directories
    **************************************************
    
    -- if building your own ATLAS, might as well get OpenBlas:
        - git clone git://github.com/xianyi/OpenBLAS
        -- make, make install (takes a little while)
    -- Numpy -newest sometimes has good improvements over distro version
        - git clone https://github.com/numpy/numpy.git
        - cd numpy
        - python setup.py build --fcompiler=gnu95
        - sudo python setup.py install
    -- Then, test, assuming nose is installed (sudo pip install nose):
        - cd ..
        - python -c 'import numpy; numpy.test()'
    -- With a test-time of about 9.8 seconds, OpenBlas-backed Numpy was
    -- about .5 sec faster than ATLAS-backed Numpy (ver 1.90-dev, on 4-core 3.4 ghz i5 4670)

sudo apt-get -y remove ffmpeg x264 libx264-dev

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
    
    FOR NOW, DO NOT USE:
    sudo add-apt-repository ppa:xorg-edgers/ppa 
    sudo apt-get update
    sudo apt-get install <package name>
    -- Nov 18 2013 that meant:  nvidia-331_331.20-0ubuntu1~xedgers~saucy1_amd64.deb
 
 FOR NOW, DO NOT USE:  
add a .deb install ppa from the official CUDA page:

    https://developer.nvidia.com/cuda-downloads
    select this -> cuda-repo-ubuntu1210   or  the 1204 version... CUDA 6 is coming

 FOR NOW, DO NOT USE:
then use package-manager, like synaptic (sudo apt-get install synaptic) or aptitude, to run the update.

    --when using Synaptic et. al. select Meta-Packages, not individual components
    --trouble? make sure the ppa is added & you have hit update since ppa was added & that the new 
    address was contacted by the update

    export PATH=/usr/local/cuda-5.5/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda-5.5/lib64:$LD_LIBRARY_PATH

####  NVIDIA STUFF + Silly Salamander or Reckless Racoon = DANGEROUS  ########
(leaving danger zone)
        
    -- gcc 4.4 WAS needed for Ubuntu 13.04
    -- gcc 4.7.x has worked for 13.10:
            other recommendations for compilation of cuda 5.5 on various OS are on:
        http://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#linux-5-5
            (though this is getting a little long-in-the-tooth)
    
sudo update-alternatives --remove-all gcc

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 20

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 50

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60

sudo update-alternatives --config gcc   # choose 4.4, 4.7.x or 4.8 for CUDA 5.5 compilation

    -- below link-up may be outdated... but maybe not

sudo ln -s /usr/lib/x86_64-linux-gnu/libglut.so.3 /usr/lib/libglut.so

(some packages added on later)

sudo apt-get install gtk-3.0 sox libsox-fmt-mp3

####  QT5 Section  ####

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

---------- how about some java 7? in a ppa! -----------------------------------------

sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install oracle-java7-installer

sudo update-java-alternatives -s java-7-oracle

sudo apt-get install oracle-java7-set-default

    --BTW this site is useful for many things distro related:
    http://www.webupd8.org/

(if you were using 4.4 to compile CUDA switch back to 4.8 now)

-sudo update-alternatives --config gcc

........ clone into OpenCV repo (default branch is master) .........

git clone https://github.com/Itseez/opencv.git

    -- Git Noob? Do this from your 'home-dir'. '/home/your_user_name' = '~' = what I call 'home-dir'
    -- Git makes /opencv and puts all the stuff there.  Now back out (type 'cd ..') and:

git clone https://github.com/Itseez/opencv_extra.git

-- The above are NOT the 'extra modules'  Quite an unfortunate name. Intended 'extras' are next:

git clone https://github.com/Itseez/opencv_contrib

-- include the optional 'extras' in cmake-gui under OPENCV_EXTRA_MODULES_PATH --> ~/opencv_contrib/modules

cd opencv

recommended option = git checkout 2.4

mkdir build

cd build

cmake-gui .

    -- Some cmake-gui opencv build hints:
    -- master vs 2.4 - some of the following only apply to 'master' builds (~/opencv$ git checkout master)
    -- Don't go all OCD trying to fill in everything before you hit 'configure' at least once.
    -- Initially, check the two boxes in top area to 'group entries' and 'show advanced'  That wil organize them a bit.
    -- MAKE: don't use fast-math for GCC or CUDA unless you probably don't need this guide & know better. eg:
    -- http://stackoverflow.com/questions/11507440/does-use-fast-math-option-translate-sp-multiplications-to-intrinsics
    -- Don't check 'download tbb' up top if you already have it, but make sure the path is true after a 'config'
    -- uncheck CLAMBLAS and CLAMDFFT if yours is an Intel cpu
    -- JASPER: cmake never auto-fills the debug lib-path. Just copy the release path to DEBUG slot.
    -- MAKE: do check mark all of the SSE instruction sets (and AVX) if you have a modern non-ARM CPU
    -- After checking options you can press configure as many times as needed.  Sometimes the script finds things.
    -- CMAKE-gui: Just because the red highlight goes away doesn't mean 'solved.' Look to see if the paths are filled.
    -- If Intel, you still can use Open CL - but you benefit MORE from an active TBB & IPP than AMD users.
    -- QT info can be tricky. If using QT5 don't worry about that massive bunch of QT4 stuff that seems incomplete
    -- X11 options will always have a few missing, but you can ignore that to no ill effect. Trying to hunt down
        those 'X' items will probably mess up a chain of dependencies specific to your setup.
    -- OPENEXR - As long as you see a version number (currently 1.71 from packages) for it under MEDIA I/O you are good.
    -- You may select nvidia options like nvcuuvd (video) and nvfft (fast Fourier transform) without selecting CUDA.
    -- CUDA: When looking for 'missing' libraries, dirs under: /usr/local/cuda or /usr/local/cuda-5-5 are your friend. 
    -- also look in /usr/lib/nvidia-updates for those pesky missing *.so libs
    -- CUDA: there is a blank after Generation. click there and choose 'Kepler'if you have a modern nvidia card.
    -- CUDA: UNcheck attach to target
    -- QT5:the qmake executable = ~/qt5/qtbase/bin/qmake
    -- QT-DIR options you want--> ~/qt5/qtbase/lib/cmake/Qt5... where ... are things like Concurrent, Core etc
    -- CMAKE after a 'configure' or 3, under MAKE, select Debug or Release build type before you hit that final 'generate'
    -- OPENGL_xmesa_INCLUDE = /usr/lib/x86_64-linux-gnu/mesa  For some reason it has trouble finding that one.
    -- CUDA the many cuda addresses may not show up right away. if you get the script started with nvcc, 
        then 'configure' sometimes it finds the rest.
    -- Clp - libcoin - I've never been sure this is active. There are conflicting messages. Its a minor thing.
    -- Here are a few typical CUDA paths to get YOU started. I think all the others are along these paths:
        CUDA_CUDART_LIBRARY --> /usr/local/cuda-5.5/lib64/libcudart.so
        CUDA_NVCC_EXECUTABLE --> /usr/local/cuda-5.5/bin/nvcc
        CUDA_nvcuvid_LIBRARY --> /usr/lib/nvidia-331/libnvcuvid.so
        CUDA_cupti_LIBRARY --> /usr/local/cuda-5.5/extras/CUPTI/lib64/libcupti.so
        CUDA_CUDA_LIBRARY --> /usr/lib/nvidia-331/libcuda.so
    -- Of course, you can't just cut n' paste the above - drivers & versions will change

---- point to a bunch of stuff, select a bunch of options, configure, configure, configure, generate, exit---

make -j4

sudo make install

sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

sudo ldconfig

---- to verify that all worked, enter the python interpreter ----

    python
    
                import cv2
    
                b = cv2.getBuildInformation().split('\n')
    
                for p in b:
    
                print p
    
    --- (here you will get a whole bunch of info to verify the build. ctrl-D to exit) ---

When I started using OpenCV & Python I looked all over & never found this info in one spot. I was a Windows user. I had no idea how the linux world worked. I still have so much to learn. I went from driving a mini-van while wearing a motorcycle helmet - backwards - to that black, 4-on-the-floor 6.6 litre 1978 Trans-Am complete with golden chicken & Gidget.
Think of this as some gasoline. Or a road atlas. For your openCV adventure... Trial, error - my wrong turns can be your paths-not-taken.

If you spot any smokies, pick up the horn & give me a shout!
    
