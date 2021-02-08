# Eigen3

*Eigen3* is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms. It is widely used in many applications and software, especially in robotics and computer vision. 

Although *Eigen3* can be obtained via `sudo apt install libeigen3-dev` command, it can also be installed from the source. We use *Eigen3* as an example to show how to install packages from source code. The installation process is similar for any other packages which are needed to install from the source. Regular users can follow the process to install their own software under their `home` directory.

Basically, the installation process contains three parts:

- Download the source code.
- Compile and build the sorce code.
- Install the built binaries, libraries and inclusion files to specific directory.



## Download Eigen3 Package  

There are two typical way to download the source code:

- Go to the official website [Eigen](http://eigen.tuxfamily.org/index.php?title=Main_Page) and download the zip file directory. Recommended if certain version is needed.

- Download the source code via `git`:

  ```bash
  git https://gitlab.com/libeigen/eigen.git 	# usually the lasted version
  ```



## Compile and Build

The necessary tools to build *Eigen3* are `cmake` and `gcc`, which have been install in all workstations. `cmake` takes care of preconfigurations to build *Eigen3* and `gcc` is responsible to build the project according to the configurations frome `cmake`.

We type 

```bash
tar xf eigen3.x.x 	# unzip the downloaded tarball, ignore if installation via git
cd eigen3			# enter the eigen3 directory
mkdire build && cd build 	# make the build directory and enter the build directory
```

We also need to specify the installation path in this step. The installation path is specified in `cmake command`. We type

```bash
cmake -D CMAKE_INSTALL_PREFIX=/path/to/install/dir ..	# specify the installation path
make -j 16 		# build with 16 cores	
```

**Note:**  We recommend to install the package to the directory `/home/username/.local` for better management (`username` is replaced by the true username). But users can also specify the installation directory under `/home/username`. For example, the user can create new directory `/home/username/eigen3` and use it as the installation path.



## Install Built Files and Add PATH

After successfully building the project, we install the built files to the designated directory via

```bash
make install 	# install built files to the designated director
```

After the installation, we also need to make sure the system can find the installed package. This is done by modifying `PATH` environment variable:

```bash
export PATH="${PATH}:/path/to/install/dir" 	# add installed path to the PATH variable
```

The `/path/to/install/dir` is specified by users. 