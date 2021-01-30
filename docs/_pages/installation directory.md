# Software Installation

This pages introduces the Linux directory and software installation limitations for regular users. 

In Linux, a software can be installed with binaries from repositories, or it can be installed from the source code. The source code has to be compiled to binaries to execute. The binaries are stored in different directories according to file types (executable binaries and library files). Upon the software execution, related binaries are found by the software to perform various functions. 

Software installation is important because it has to be installed to somewhere so that the software can find it. Besides, normative installation keeps a neat environment for better mantainance. 



## Installation Methods

There are four typical ways to install a software in Linux:

- Install via `apt`, usually performed by admin user.
- Linux software center, install via `snap`, usually performed by admin user.
- Download `deb` package and install via `dpkg`. 
- Install from source code.

Installation via `apt` and `snap` usually need root privilege. So the admin user normally take these two approaches. It is usually possible to redirect the installation path using  `dpkg` and source code installation. So these two approaches can be used by regular users.



## Installation Location and Filesystem Hierarchy Standard

For admin user, the first





## System-Level vs User-Level Software Installation

System-level and user-level software installations relfect whether the software installation will change system configuration. A system-level installation install the software (libraries and binaries) outside the `/home` directory (usually in `/usr` and `/opt`), while user-level installation only takes place inside `/home/user` directory. Therefore, user-level installation will not affect the system configuration.



### System-Level Software Installation

For system-level installation, related system configurations will be modified. So only the admin user has such privilege. After the installation, the installed software is available and executable for all regular users. We have discussed that regular users are only capable of modifying files within `/home` directories. Therefore, regular users do not have permission to perform system-level software installation. 

The system-Level installation automatically manage the installation locations so that installed binaries can be found by the software.

The administrator will guarantee all the necessary software such as *sublime*, *vscode*, *anaconda*, *panda*, *ROS*, pycharm, etc[^1], are all installed and function normally. It is also better for maintenance.  



### User-Level Software Installation

Regular users may install their own software locally based on personal needs. The installations are performed within `/home/user` directory. Therefore, the user-level installation manually put all binaries in `/home/user` directory and make sure the software can find them. In this way, a specific user's software will not affect system configuration as well as other regular users. 

We will discuss how to conduct user-level installation for MATLAB in [xxxxxxxxx](). 



## Where to install the software in Linux?

Usually when installing software in Linux, we have the following ways:

- install via `apt`
- download `deb` package and install via `dpkg`
- Linux software center, usually install via `snap`

There are two questions for installations:

- If I install the downloaded software manually, where should I install?
- Whether I should install software locally or globally? How to install software locally?

We answer the question one by one.



### Where should I install?

We first ignore the question of local and global installation. 

When we install the user defined software, there are usually two directories: `/opt` and `/usr/local/`. What are the difference? The following discussion answers the question: [What is the difference between /opt and /usr/local?](https://unix.stackexchange.com/questions/11544/what-is-the-difference-between-opt-and-usr-local)

There is also a related question worth reading: [How to understand the Ubuntu file system layout?](https://askubuntu.com/questions/138547/how-to-understand-the-ubuntu-file-system-layout) One of the answer gives an easy-to-understand figure. Not quite correct but essential for understanding the file system layout.

![image](https://i.stack.imgur.com/BlpRb.png)

Summary from the highest vote answer.  The large and unbundled software/packages should go into `/opt`, for example, `ros`, `google-chrome`, etc. The **unbundled packages** means the packages are not part of the Operating System distribution, but provided by an independent source. Usually, each one has its own subdirectories and file hierarchy, including `/bin`, `/lib`, `/inlcude`.  For example, `someapp` would be installed in `/opt/someapp`. The important feature of such package is that they are **NOT** offered by the Linux distributions, provided by an independent source code, **being able to work independently** and **large**. 

`/usr/local/` is a place to install files built by the administrator, typically by using the `make` command (e.g., `./configure; make; make install`). The **idea** is to avoid clashes with files that are part of the operating system, which would either be overwritten or overwrite the local ones otherwise (e.g., `/usr/bin/foo` is part of the OS while `/usr/local/bin/foo` is a local alternative). `/usr/local/` follows the [Linux file system hierarchy](https://linux.die.net/man/7/hier). Therefore, they have the similar structure as `/usr`.  The files installed in `/usr/local/` should be static and sharable. 

It is worth noting that if use `apt` or other native package manager to install the software, the installed software usually directly goes to `/usr`, with executable going to `/usr/bin` and library going to `/usr/lib`, etc.

To summarize, when installing a software:

- It is recommended to use `apt` to manage package installation first. The installed files will go to `/usr` because we use `sodu` command.

- When installing a large but relatively OS independent software, such as google-chrome, ros, MATLAB, it is recommended to install to `/opt` directory. Usually this type software will provide their own subdirectories and file hierarchy to function well. The installation should also give instructions to set the installation directory.

- When installing a external library for your own project use or a small source code software that **needs to compile and install using `make`, `make install` commands**. It is recommended to install them to `/usr/local/`. Such packages often have `./configure` fies to specify the installation path. Usually, we can use 

  ```bash
  ./configure --help less 	# for checking options
  ./configure --prefix=/usr/local 	# set install path
  ```

  For example, when learning MIT 8.828, there are many external libraries needed to be installed. Many of them are small packages, providing useful APIs. But they are not the software such as vscode or google-chrome which can work independently and finish some tasks. They are just a part of your project.  

 

### Install globally or locally?

Linux has many groups and users. The notion of groups is less useful for us, while the notion of users is very common. Normally, each user have his own account, he can use the installed software on the computer, which is observable for any users in the computer. He can also install his own software and keep private. Other users will not be able to access his own software. This is what we mean install globally and locally. 

First, any software installed via `sudo apt` can be seen by any users. Second, if we are the group administrator (the user in the `sudo` group, there is no root user in the Ubuntu), we can install the software to `/usr/local/`. Although it is the user program not the system program, all the users in the computer can still see the software. But of course the administrator can modify the file privilege to limit the usage of the software. But this is wired because everyone can already see the software but cannot use it. Why don't we make it invisible directly?

Therefore, if we really want to install some local software without using the root privilege, we can install all the software in our own `home` directory. Since many software follows the routine of FHS, we can make a directory similar as the root user, ie, we create our local `/usr/` and `/opt/`. So we can always download the software and install locally with proper configurations.



### FHS detailed explanation

This website gives a detailed explanation for Filesystem Hierarchy Standard (FHS). Check [Linux目录配置](http://cn.linux.vbird.org/linux_basic/0210filepermission.php) section.



[Into which directory should I install programs in Linux?](https://unix.stackexchange.com/questions/127076/into-which-directory-should-i-install-programs-in-linux)

If you will be compiling your own software then you ultimately control the installation location. By convention, software compiled and installed manually (not through a package manager, e.g apt, yum, pacman) is installed in `/usr/local`. Some packages (programs) will create a sub-directory within `/usr/local` to store all of their relevant files in, such as `/usr/local/openssl`. Other packages will install their necessary files into existing directories such as `/usr/local/sbin` and `/usr/local/etc`. 