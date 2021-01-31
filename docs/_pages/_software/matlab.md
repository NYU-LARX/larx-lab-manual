# MATLAB

With individual academic licence, MATLAB only specifies a single username to use the software. For example, if a user `abc` installed MATLAB, then another user `xyz` cannot even open the MATALB because MATLAB recognize the username and only allow the user `abc` to use it. Therefore, each regular user has to install MATLAB individually into his/her own home directory.

## MATLAB Installation

Step 1: Go to [Mathworks](https://www.mathworks.com/) and login with your own Mathworks account. If you do not have an account, check [NYU MATLAB](https://www.nyu.edu/life/information-technology/getting-started/software/matlab.html) for more details.



Step 2: Download the lastest version of MATLAB. 



Step 3: Go to `Download` directory to unzip the file by typing 

```bash
tar xf file_name	# the file name is the donwloaded tarball file
```



Step 4: Go to the unzipped directory and double click `install.sh`.



Step 5: Select installation path. We recommend to install matlab into `/home/username/.local/MATLAB`. 

Step 6: Follow the instructions and finish the installation. 



## MATLAB Remote Access

To access MATLAB remotely, we need to use ssh to access the server, check [Remote Access via SSH](_pages/remote_access.md#remote-access-via-ssh), then type 

```bash
matlab -nodesktop
```

to run MATLAB without desktop. It can be difficult to get MATLAB desktop for non-Linux computer via SSH currently. We willl figure out how to use VNC to access MATLAB with desktop for computers with any OS. 

It is recommeded to use MATLAB at the lab directly if needed.