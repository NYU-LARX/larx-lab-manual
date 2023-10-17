# Python 

Each Ubuntu distribution has its version of Python. For example, Ubuntu 18.04 is with Python 3.6. We may often use the latest Python without disrupting the default one. Then, we can install the latest Python locally.

The installation process is similar to other packages that need to be installed from the source. The installation process contains three parts:
- Download the source code.
- Compile and build the source code.
- Install the built binaries, libraries, and inclusion files to a specific directory.

We use Python 3.11 as an example and install it in the `\home\username\opt` directory.


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
$ make -j12 		  # use 12 cups to build
$ make install    # copy executables to the install direction
```

Finally, update the `PATH` environment variable:

```bash
$ export PATH=$PATH:/home/username/opt/Python-xxx
$ source ~/.bashrc
```


### Install Python Packages with the New Python 

After installing the new Python, we can use the command `python3.11`. Using `python` or `python3` may select the system-level version.

Users can use the `pip` command to install Python packages. All the packages are installed locally since Python is installed locally. For example,
```bash
$ python3.11 -m pip install numpy    # install numpy package
```

Creating a virtual environment for different packages is recommended to avoid package confusion. Python has a built-in module, `venv`, which contains partial features of the Python package `virtualenv`. We can create a virtual environment by typing 
```bash
$ python3.11 -m venv /path/to/new/virtual/environment
```

To activate the virtual environment, we need to source the activation file by typing

```bash
$ source /path/to/new/virtual/environment/bin/activate
```

To deactivate the virtual environment, we type

```bash
$ deactivate
```





