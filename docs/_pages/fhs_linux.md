# Filesystem Hierarchy Standard

This page introduces the Filesystem Hierarchy Standard (FHS) in the Linux to better understand the file organization.


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

