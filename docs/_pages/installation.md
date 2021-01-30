# Software Installation

This pages introduces the Linux directory and software installation limitations for regular users. 

In Linux, a software can be directly installed with binaries from different repositories, or it can be installed from the source code. The source code has to be compiled to binaries first. The binaries are stored in different directories according to file types (executable binaries and library files). Upon the software execution, related binaries are found by the software to perform various functions. 

Software installation is important because all binaries should be installed to somewhere so that the software can find it. Besides, normative installation keeps a neat environment for better mantainance. 



## Installation Methods

There are four typical ways to install a software in Linux:

- Install via `apt`, usually performed by admin user.
- Linux software center, install via `snap`, usually performed by admin user.
- Download `deb` package and install via `dpkg`. 
- Install from source code.

Installation via `apt` and `snap` usually need root privilege. So the admin user normally take these two approaches. It is usually possible to redirect the installation path using  `dpkg` and source code installation. So these two approaches can be used by regular users.



## Installation Location and Filesystem Hierarchy Standard

For an admin user, installation via `apt` is recommended as this command uses package manager to manage all software. For most cases, `apt` is enough to find and install necessary software. However, in some cases, the software has to be downloaded and installed manually or from the source code. For these cases, the admin user has to designate the installation path, and make sure the installed software can be properly found. So there are two questions to address:

- Where to install?
- How to find installed software?

To answer the first question, we need some background in Linux Filesystem Hierarchy Standard (FHS). The second question is related to the environment  variable `PATH`.

### Introduction to FHS

FHS specifies the structure to store all types of Linux files. The entire structure orginates from the root directory `/` and grow in a tree structure. The following figure shows the FHS.

![fhs](https://www.tecmint.com/wp-content/uploads/2013/09/Linux-Directory-Structure.jpeg)

These subdirectories can be roughly divided into four categories by the sharability and variability as follows. A more detailed explanation for FHS is given by [Linux Directory Configuration](http://cn.linux.vbird.org/linux_basic/0210filepermission.php) section.

|              | sharable                      | unsharable                            |
| ------------ | ----------------------------- | ------------------------------------- |
| **static**   | `/usr` (software)             | `/etc` (configuration files)          |
|              | `/opt` (unbundled software)   | `/boot` (core files and boot files)   |
| **variable** | `/var/main` (user email)      | `/var/run` (related to applications)  |
|              | `/var/spool/news` (user news) | `/var/lock` (related to applications) |

There is also a related webpage worth reading: [How to understand the Ubuntu file system layout?](https://askubuntu.com/questions/138547/how-to-understand-the-ubuntu-file-system-layout) One of the answer gives the following easy-to-understand figure.

<img src="https://i.stack.imgur.com/BlpRb.png" alt="image" style="zoom:50%;" />



### Installation Directory

All software goes to one of the following directories:`/usr`, `/usr/local`, and `/opt`.

- Precompiled software installed via `apt` usually goes to `/usr`. The package manager will take care of the installlatioin.
- Software that needs to compile from the source code usually goes to `/usr/local`. The compliation occurs on the server and necessary commands (eg. `./configure; make; make install`)  are invovled.
- The large and unbundled software should go to `/opt`. These software are usually self-contained and provides their own subdirectories and file hierarchy. Software such as *google chrome* and *ROS* should be installed in `/opt`.

The following websites are recommended for further reading:

- [What is the difference between /opt and /usr/local?](https://unix.stackexchange.com/questions/11544/what-is-the-difference-between-opt-and-usr-local)
- [Into which directory should I install programs in Linux?](https://unix.stackexchange.com/questions/127076/into-which-directory-should-i-install-programs-in-linux)





### `PATH` Environment Variable

In Linux, the software are binary files. To execute these binaries, the software has to be aware of the installation location. The `PATH` variable controls all search directories of installed binaries. The default `PATH` variable looks like this.

```bash
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

The colon is the separator. We observe that the default `PATH` does not contain `/opt` directory. This means that if we install software to `/opt`, the software canot be found by the computer. Therefore, to update the path, we use export cpmmand. For example, we installed *ROS* to `/opt` and we want to add it to the serch path so that we can use *ROS*, we type

```bash
export PATH="${PATH}:/opt/ros/melodic/bin"
```



## System-Level vs User-Level Software Installation

System-level and user-level software installations relfect whether the software installation will change system configuration. A system-level installation install the software (libraries and binaries) outside the `/home` directory (usually in `/usr` and `/opt`), while user-level installation only takes place inside `/home/user` directory. Therefore, user-level installation will not affect the system configuration.



### System-Level Software Installation

For system-level installation, related system configurations will be modified. So only the admin user has such privilege. After the installation, the installed software is available and executable for all regular users. We have discussed that regular users are only capable of modifying files within `/home` directories. Therefore, regular users do not have permission to perform system-level software installation. 

The system-Level installation automatically manage the installation locations so that installed binaries can be found by the software.

The administrator will guarantee all the necessary software such as *sublime*, *vscode*, *anaconda*, *panda*, *ROS*, pycharm, etc, are all installed and function normally. It is also better for maintenance.  



### User-Level Software Installation

Regular users may install their own software locally based on personal needs. The installations are performed within `/home/user` directory. Therefore, the user-level installation manually put all binaries in `/home/user` directory and make sure the software can find them. In this way, a specific user's software will not affect system configuration as well as other regular users. 

We will discuss how to conduct user-level installation for MATLAB in [xxxxxxxxx](), as MATLAB only recognizes a single username. The system-level installation cannot share MATLAB to every regular users.

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


