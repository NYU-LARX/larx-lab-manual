# Software Installation

In Linux, the software can be installed by **binaries** (also called executables) from different repositories or by the **source code**. The source code needs to be compiled into binaries first. The binaries are stored in different directories according to file types (executables and library files). Upon the software execution, related binaries are found by the software to perform various functions.

Software installation is important because all binaries should be installed somewhere so that the software can find it. Besides, normative installation keeps a neat environment for better maintenance.

We refer to [Linux Filesystem Hierarchy Standard](_pages.fhs_linux.md) to better understand the convention of where to install new software in Linux.


### Installation Methods

There are four typical ways to install software in Linux:

- Install via `apt`, performed by the admin user.
- Linux software center, install via `snap`, performed by admin user.
- Download `deb` package and install via `dpkg`, usually performed by an admin user.
- Install from source code. For all users.

Installation via `apt` and `snap` needs root privilege. So, the admin user takes these two approaches. It is possible to redirect the installation path using `dpkg` and source code installation so that no root privilege is required. So, the last two approaches can be used by regular users.


### System-Level Installation
System-level installation is performed by the *admin user* because it requires the root privilege since it changes system-level configuration. It installs the software outside `/home` directory (usually in `/usr/` and `/opt/`) so that *all regular users* can use it.

Software with the following features can be installed globally:
- commonly used;
- well maintained by organizations, usually from Linux repo or software store;
- open source without a personal license.

For example, web browsers, code editors, and infrastructure software like C/C++ compilers and drivers.

**Note:** It is important to know that all software does not need `sudo` privilege to execute. So, you don't need to perform system-level installation to install every software. It is always recommended to install software locally so that users do not affect each other. Once the software is installed globally, the user may always need to log in as the admin user to configure it.



### User-Level Installation
User-level installation is performed by *regular users*. It is only conducted inside the `/home/user` directory and will not affect the system configuration or other regular users. Once installed, the software is only available for the user who installed it. No other user can use it.

Software with the following features should be installed locally:
- not commonly used;
- need a personal license;
- need extra user-specific configurations.

For example, MATLAB, anaconda, and specific optimization solvers like GUROBI. Installing such software in system-wide can increase the admin maintenance complexity.


### Guideline for User-Level Installation
We provide a brief guideline for user-level installation. Detailed user-level installation instructions for common software can be found in [xxx]().

We can create `/home/username/opt/` and `/home/username/.local` in the user home directory as the installation directory for better management.
- `/home/username/opt/` is used for monolithic software like Foxit pdf reader.
- `/home/username/.local` is used for installing external software that requires `make` and `make install` commands. 

**Note:** `/home/username/.local` mimics the `/usr/` directory to store installed files. Inside `.local/`, we have `./local/bin/`, `./local/lib/`, etc. We recommend the user put all the binary files in this directory. The software installed in this directory is generally the user's own compiled project or open-source software that needs to be compiled and installed using `make`, `make install` commands. 

Once the installation is completed, update `PATH` environment variable by adding the executable path, in general `bin\` directory, to ensure the computer can find the executables.

```bash
$ export PATH=$PATH:/home/username/opt/<software_dir>/bin      # for monolithic software
$ export PATH=$PATH:/home/username/.local/bin                  # for open source software
$ source ~/.bashrc                                             # update environment variable
```
