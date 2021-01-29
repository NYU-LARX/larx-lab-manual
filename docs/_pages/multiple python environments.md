## Manage multiple Python environments 

Linux distributions are equipped with obsoleted python. If we want to install new version of python and switch among different versions, there are three ways to achieve this. 

First it is recommended to install the new version of the python to `/opt/` or `/usr/local/`, not directly to `/usr/` or via `apt`. This may cause confusion to the link files. 

### System python files

There are two components that are related to system python: python executable file, and pip. The executable files are all in `/usr/bin/`. Before the installation, we can list the relative files and understand what we will change next.

```bash
lrwxrwxrwx 1 root root       9 Apr 16  2018 /usr/bin/python -> python2.7
lrwxrwxrwx 1 root root       9 Apr 16  2018 /usr/bin/python2 -> python2.7
-rwxr-xr-x 1 root root 3628976 Sep 30 09:38 /usr/bin/python2.7
lrwxrwxrwx 1 root root      33 Sep 30 09:38 /usr/bin/python2.7-config -> x86_64-linux-gnu-python2.7-config
lrwxrwxrwx 1 root root      16 Apr 16  2018 /usr/bin/python2-config -> python2.7-config
lrwxrwxrwx 1 root root       9 Oct 25  2018 /usr/bin/python3 -> python3.6
-rwxr-xr-x 2 root root 4526456 Oct  8 08:12 /usr/bin/python3.6
lrwxrwxrwx 1 root root      33 Oct  8 08:12 /usr/bin/python3.6-config -> x86_64-linux-gnu-python3.6-config
-rwxr-xr-x 2 root root 4526456 Oct  8 08:12 /usr/bin/python3.6m
lrwxrwxrwx 1 root root      34 Oct  8 08:12 /usr/bin/python3.6m-config -> x86_64-linux-gnu-python3.6m-config
lrwxrwxrwx 1 root root      16 Oct 25  2018 /usr/bin/python3-config -> python3.6-config
lrwxrwxrwx 1 root root      10 Oct 25  2018 /usr/bin/python3m -> python3.6m
lrwxrwxrwx 1 root root      17 Oct 25  2018 /usr/bin/python3m-config -> python3.6m-config
lrwxrwxrwx 1 root root      16 Apr 16  2018 /usr/bin/python-config -> python2.7-config
```

and 

```bash
-rwxr-xr-x 1 root root 292 Oct 22 10:40 pip
-rwxr-xr-x 1 root root 292 Oct 22 10:40 pip2
-rwxr-xr-x 1 root root 293 Oct 22 10:40 pip3
```

Basically, for **executable** files related to python, we have three components:

- `pyhtonx`
- `pythonx.xm`
- `pythonx-config`

But for executable files, we almost only care `pythonx`. Therefore, it is the link file that we are going to change.

Follow the [website](https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/) to install necessary libraries, we download and install python3.9 to `/opt/` directory. This is convenient for future modifications.

```bash
./configure --prefix=/opt/Python-3.9.0 --enable-optimizations
make -j 12
sudo make install
```

**Remark**: `install` command is just a command of copying files and setting attributes. First `make` command compiles all python files in the current file, for example `/Downloads/`. Next, `sudo make install` will copy all complied files to the destination location `/opt/Python-3.9.0/`. Using `--prefix` command, no files will go to `/usr/local/` directory.



### Using `update-alternatives`

First we export `PATH` variable: 

```bash
export PATH="${PATH}:/opt/Python-3.9.0/bin"
```

Then we install and update alternatives.

```bash
update-alternatives --install /usr/bin/python python /opt/Python-3.9.0/bin/python 1
update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 3
```

**Remark**: We of course do not need to add the alternatives if we use python 3.9 by calling `python3.9`. This name is distinguishable. But there will be some issues when using `pip3`. There is no executable files called `pip3.9`. 



### Manually change the link file in `/usr/bin/`

This is the brute force way. We can use 

```bash
sudo ln -s /opt/Python-3.9.0/bin/python3.9 /usr/bin/python3 # ln source destination
```



## The same principle

The same principle applies to other software, such as `gcc`, `g++`. 



### Some practical points

When installing python manually, the python package automatically has the lastest `pip`. This `pip` has several features:

- It is installed in the same directory as python.
- It has an additional name `pip3.x` as `python3.x` does.
- If we use `pip3.x install xxx`, the package will automatically be installed locally, ie, the default install directory is `$HOME/.local`. 

The second feature means that we do not need to create additional soft link such as `pip-py3.x` to call the corresponding `pip`.

The third feature means that each user can actually call `pip3.x` to directly intall the needed packages. These packages will **not** be installed to the system directories and hence will not cause interference among different users. We can of course change the default directory by using `pip config`, but it is not good because this will subtarge the original non-interference properties. 