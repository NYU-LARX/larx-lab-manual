# Python 

Each Ubuntu distribution has its own version of Python. For example, Ubuntu 18.04 is with Python 3.6. In many cases we may want to use the lasted Python without distrupting the default one. Then we can install the lastest Python locally.

#Since mutliple versions coexist, we recommend the user to run `python3.9` command to specify the version 3.9. Otherwise, the system may take the default version, which is either  *Python2.7* or *Python3.6*.


The installation process is similar with other packages that needs to install from the source. Basically, the installation process contains three parts:
- Download the source code.
- Compile and build the sorce code.
- Install the built binaries, libraries and inclusion files to specific directory.

We use Python 3.11 as an example and install it `\home\username\opt` directory.


### Installation Procedure
First, download the tarball from [Python Official Website](https://www.python.org/). Select the version and the platform.

Then unzip the tarball and configure the installation.
```bash
$ tar xf Python-3.x.x 	        # unzip the downloaded tarball
$ cd Python-3.xx			    # enter the eigen3 directory
$ ./configure --prefix=/home/username/opt/Python-xxx --enable-optimizations		# use Python-xxx for naming convention
```

**Note:** Python is configured by `bash` script rather than `cmake`. We use the `configure` script for configurations.

**Note:** There are many configuration options available. Use `./configure --help less` to check detailed options. `--enable-optimizations` is commonly used.

Next, use `make` to build Python and install the binary after the building: 

```bash 
$ make -j12 		# use 12 cup to build
$ make install      # copy executables to the install direction
```

Finally, update `PATH` environment variable:

```bash
$ export PATH=$PATH:/home/username/opt/Python-xxx
$ source ~/.bashrc
```


### Install Python Packages with New Python 

After installing new Python, we can use command `python3.11` to use it. Using `python` or `python3` may select the system-level version.

Users can use `pip` command to install python packages. All the packages are installed locally since Python is installed locally. For example,
```bash
$ python3.11 -m pip install numpy    # install numpy package
```

It is recommended to create a virtual environment for different packages to aviod package confusions. Python has a built-in module `venv`, which contains partial features of the python package `virtualenv`. We can create a virtual environment by typing 
```bash
$ python3.11 -m venv /path/to/new/virtual/environment
```

To activate the virtual environment, we need to source the activation file by typing

```bash
$ source /path/to/new/virtual/environment/bin/activate
```

To deactivate the virtual environment, we simply type

```bash
$ deactivate
```





