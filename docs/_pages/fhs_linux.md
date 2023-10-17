# Filesystem Hierarchy Standard

This page introduces Linux's Filesystem Hierarchy Standard (FHS) to better understand file organization.

The admin user can install system-wide software via the `apt` command. Regular users can install software locally. Either way, the installed software should be properly placed and easily found by the computer. Therefore, it is natural to ask the following two questions:
- Where to install the software in Linux?
- How to find the installed software in the Linux?

The first question requires some Linux Filesystem Hierarchy Standard (FHS) background. The second question is related to the environment variable `PATH`.


### Introduction to FHS

FHS specifies the structure to store all types of Linux files. The entire structure originates from the root directory `/` and grows in a tree structure. The following figure shows the FHS.

![fhs](https://www.tecmint.com/wp-content/uploads/2013/09/Linux-Directory-Structure.jpeg)

These subdirectories can be divided into four categories by sharability and variability. A more detailed explanation for FHS is given in [Linux Directory Configuration](http://cn.linux.vbird.org/linux_basic/0210filepermission.php) section.

|              | sharable                      | unsharable                            |
| ------------ | ----------------------------- | ------------------------------------- |
| **static**   | `/usr` (software)             | `/etc` (configuration files)          |
|              | `/opt` (unbundled software)   | `/boot` (core files and boot files)   |
| **variable** | `/var/main` (user email)      | `/var/run` (related to applications)  |
|              | `/var/spool/news` (user news) | `/var/lock` (related to applications) |

There is also a related webpage worth reading: [How to understand the Ubuntu file system layout?](https://askubuntu.com/questions/138547/how-to-understand-the-ubuntu-file-system-layout) One of the answers gives the following easy-to-understand figure.

<img src="https://i.stack.imgur.com/BlpRb.png" alt="image" style="zoom:50%;" />



### Installation Directory

The system-level installed software goes to one of the following directories:`/usr`, `/usr/local`, and `/opt`.
- Precompiled software installed via `apt` usually goes to `/usr`. The package manager will take care of the installation.
- Software that needs to compile from the source code usually goes to `/usr/local`. The compilation occurs on the server and necessary commands (eg. `./configure; make; make install`)  are involved.
- The large and unbundled software should go to `/opt`. These software are usually self-contained and provide their own subdirectories and file hierarchy. Software such as *chrome* and *ROS* should be installed in `/opt`.

In short, large and monolithic software goes to `/opt`. Other software (precompiled or needs compilation) goes to `/usr`.

The following websites are recommended for further reading:
- [What is the difference between /opt and /usr/local?](https://unix.stackexchange.com/questions/11544/what-is-the-difference-between-opt-and-usr-local)
- [Into which directory should I install programs in Linux?](https://unix.stackexchange.com/questions/127076/into-which-directory-should-i-install-programs-in-linux)




### `PATH` Environment Variable

In Linux, the software is binary files. To execute these binaries, the OS needs to know the installation location. The `PATH` variable controls all search directories of installed binaries. The default `PATH` variable looks like this.

```
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

The colon `:` is the separator. Note that the default `PATH` does not contain `/opt` directory. Therefore, if we install software in `/opt`, we need to update `PATH` environment variable to ensure the OS finds the software. We use `export` command to update `PATH`. For example,

Therefore, to update the path, we use `export` command. For example, we installed ROS melodic to `/opt` and type
```bash
$ export PATH="${PATH}:/opt/ros/melodic/bin"
```

