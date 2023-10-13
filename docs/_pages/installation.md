# Software Installation

In the Linux, a software can be installed by **binaries** (also called executables) from different repositories, or by the **source code**. The source code needs to be compiled to binaries first. The binaries are stored in different directories according to file types (executables and library files). Upon the software execution, related binaries are found by the software to perform various functions.

Software installation is important because all binaries should be installed to somewhere so that the software can find it. Besides, normative installation keeps a neat environment for better mantainance.

We refer to [xxx]() to better understand the convention of where to install new software in the Linux.


### Installation Methods

There are four typical ways to install a software in the Linux:

- Install via `apt`, performed by admin user.
- Linux software center, install via `snap`, performed by admin user.
- Download `deb` package and install via `dpkg`, usually performed by admin user.
- Install from source code. For all users.

Installation via `apt` and `snap` need root privilege. So the admin user take these two approaches. It is possible to redirect the installation path using `dpkg` and source code installation so that no root privilege is required. So the last two approaches can be used by regular users.


### System-Level Installation
System-level installation is performed by the *admin user* because it requires the root privilege since it changes system-level configuration. It install the software outside `/home` directory (usually in `/usr/` and `/opt/`), so that *all regular users* can use it.

Software with the following features can be installed globally:
- commonly used;
- well maintained, usually from Linux repo or software store;
- open source without personal licence.

For example, web browsers, code editors, and infrastructure software like C/C++ compliers.

Large software goes to `/opt/`, monolithic, like google
other software goes to `/usr/`, convention



### User-Level Installation
User-level installation is performed by *regular users*. It is only conducted inside `/home/user` directory and will not affect the system configuration as well as other regular users. Once installed, the software is only available for the user who installed it. No other user can use it.

Software with the following features should be installed locally:
- not commonly used
- need personal licence
- need extra user-specific configurations

For example, MATLAB, anaconda, specific optimization solvers like GUROBI. Installing such software in system-wide can increase the maintainance complexity.

We can create `/home/username/opt/` and `/home/username/.local` as the installation directory for better management.

For user-level source code installation, we recommend the user put all the binary files to the `/home/username/.local` directory for better management. The following commands may be helpful for user-level source code installation.

When installing a external library for your own project use or a small source code software that **needs to compile and install using `make`, `make install` commands**. It is recommended to install them to `/usr/local/`. Such packages often have `./configure` fies to specify the installation path. Usually, we can use 

```bash
# step 1: check if `/home/username/.local` directory exists
mkdir /home/username/.local
# step 2: go to downloaded software package and type the following
./configure --help less 					# for checking options
./configure --prefix=/home/username/.local 	# set install path
# step 3: compile and install the software
make -j8		# use 8 cores to compile
make install	# install the compiled binaries
```

We use [*Eigen3*](_pages/_software/eigen.md) as an example to demonstrate the user-level installation. 

remember to add to path.

Python is commonly used. either installation anaconda, or install new version of python locally, see example.