# Eigen3

*Eigen3* is a C++ template library for linear algebra which contains algorithms for matrices, vectors, numerical solvers, etc.. It is widely used in C++ applications, especially in robotics and computer vision. 

Eigen3 can be installed system-wide by 
```bash
$ sudo apt install libeigen3-dev
``` 
However, we recommend install Eigen3 manually to use a stable version because Eigen3 is a low-level library and different versions may have API changes. 

The installation process is similar with other packages that needs to install from the source. Basically, the installation process contains three parts:
- Download the source code.
- Compile and build the sorce code.
- Install the built binaries, libraries and inclusion files to specific directory.

We install Eigen3 in `\home\username\.local` directory.


### Download Eigen3 Package  

There are two ways to download the source code:
- Go to the official website [Eigen](http://eigen.tuxfamily.org/index.php?title=Main_Page) and download the zip file directory. Recommended if certain version is needed.
- Download the source code via `git`:
  ```bash
  $ git https://gitlab.com/libeigen/eigen.git
  ```

### Compile and Build

The necessary tools to build Eigen3 are `cmake` and `gcc`, which have been installed in all workstations. `cmake` takes care of preconfigurations to build Eigen3 and `gcc` builds the project according to the configurations frome `cmake`.

Unzip tarball and make build directory.
```bash
$ tar xf eigen3.x.x 	      # unzip the downloaded tarball, ignore if installation via git
$ cd eigen3			            # enter the eigen3 directory
$ mkdire build && cd build 	# make the build directory and enter the build directory
```

Specify the installation path and build. Then install the executables.

```bash
$ cmake -D CMAKE_INSTALL_PREFIX=/home/username/.local	    # specify the installation path
$ make -j 16 		# build with 16 cores
$ make install  # copy executables to the installed directory
```

**Note:**  Users can specify custom installation directory under `/home/username` for installation, e.g., `/home/username/eigen3`. However, we recommend install the package to the directory `/home/username/.local` for better management. 


### Update `PATH`
After the installation, we update `PATH` environment variable to ensure the computer can find the installed package:

```bash
$ export PATH="${PATH}:/home/username/.local/bin" 	  # add installed path to the PATH variable
```