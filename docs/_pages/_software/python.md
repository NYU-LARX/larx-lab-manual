# Python 

There are multiple versions of python in the server: *Python2.7*, *Python3.6*, and the lasted version *Python3.9*. We recommend all regular users to use *Python3.9*.

Since mutliple versions coexist, we recommend the user to run `python3.9` command to specify the version 3.9. Otherwise, the system may take the default version, which is either  *Python2.7* or *Python3.6*.

## Install python packages 

Users can install python packages via `pip` command. For example, to install `numpy` package, we type

```bash
python3.9 -m pip install numpy
```

To install virtual environment package, we type

```bash 
python3.9 -m install --user virtualenv
```

With virtual environment package, we can create virtual python environment by typing 

```bash
python3.9 -m venv /path/to/new/virtual/environment
```

To activate the virtual environment, we need to source the activation file by typing

```bash
source /path/to/new/virtual/environment/bin/activate
```

To deactivate the virtual environment, we simply type

```bash
deactivate
```





