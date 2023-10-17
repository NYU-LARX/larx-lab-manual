# MATLAB

MATLAB only allows a single user to access the software with a personalized license. Therefore, users must install MATLAB locally in their home directory and use it with their licenses.


### MATLAB Installation

Step 1: Go to [Mathworks](https://www.mathworks.com/) and log in with your Mathworks account. If you do not have an account, check [NYU MATLAB](https://www.nyu.edu/life/information-technology/getting-started/software/matlab.html) for more details.

Step 2: Download the latest version of MATLAB. 

Step 3: Go to the `Download` directory and unzip the tarball： 

```bash
$ tar xf file_name
```

Step 4: Go to the unzipped directory and double click `install.sh`.

Step 5: Select the installation path. We recommend to install MATLAB to `/home/username/opt/MATLAB`.

Step 6: Follow the instructions and complete the installation. 

Step 7: Update `PATH` environment variable:
```bash
$ export PATH="$PATH:/home/username/opt/MATLAB/R2020b/bin"    # take MATLAB R2020 for example.
```



### MATLAB Remote Access

To access MATLAB remotely, we need to use `ssh` to access the workstation. Check [Remote Access via SSH](_pages/remote_access.md#remote-access-via-ssh) for more details.

After logging into the remote host, we can run MATLAB command line by 
```bash
$ matlab -nodesktop
```

We can also enable graphic UI if the user's computer installs an X server. If so, we run
```bash
$ matlab
```
