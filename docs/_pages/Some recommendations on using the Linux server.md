## Some recommendations on using the Linux server

The followings are some practical recommendations when individual user install his/her own software. The objective of these recommendations is to keep a clear and clean server environments for the administrator and all users for better maintenance. 

1. We encourage everyone to create his/her own account with user-name and password, and operate the machine under his/her own account. This will guarantee the the privacy of the individual user and avoid potential conflict. 
2. The administrator, `larx`, is the only user who has the root privilege to modify the system configuration. The administrator is responsible for routine system and software update.  
3. Every user do not have the root privilege to modify the system configuration, including installing software via `sudo apt install` command. The administrator will guarantee all the necessary software such as sublime, vscode, anaconda, panda, ros, pycharm, etc[^1], are all installed and function normally. It is for better maintenance.  
4. Every user may install his/her own software locally based on the personal need. For more details, please see *local user software installation guide*.



### Using multiple versions of programming language

Currently, the newest version Python, Julia, Java are installed, and they will be constantly updated by the administrator. If any additional programming languages such as R and C# are needed, please contact the administrator. 

Different versions of the interpreters and compliers are named by the convention `name+version`. For example, python 2.7 is called by `python2.7`, while python 3.9 is called by `python3.9`. The abbreviation is pointed to the latest version. For example, calling `python` is actually calling `python3.9`.



### Local user software installation guide

All users can install local software based on their own needs. The local software does not need the root privilege, and is invisible for the rest users and the administrator. 

It is not recommended for users to install software/packages via `sudo apt install` because this modifies the system changes. The software installed via `sudo apt install` is visible and usable for any other users. For better maintenance, user may install the software in their own accounts.

Most software for Linux distributions follows the [Filesystem Hierarchy Standard](https://linux.die.net/man/7/hier) (FHS) and install their executable files and libraries to `/usr/local/bin/` and `/usr/local/lib/` directories. Some large and unbundled software such as google-chrome and ros are installed in `/opt/` directory. Therefore, each user can follow the convention and install the software in the `/$HOME/usr/` and `$HOME/opt/` directories by changing the installation configuration. Normally, the software for Ubuntu distribution is packed in either tarball `.tar`, `.tar.gz`, `.tar.bz2` form or deb package `.deb` form. 

- For tarball form, we first unzip the tarball 

  ```bash
  tar -xvf tarball.tar dir_to_unzip		# .tar file
  tar -zxvf tarball.tar.gz dir_to_unzip	# .tar.gz file
  tar -jxvf tarball.tar.bz2 dir_to_unzip	# .tar.bz2 file
  ```

  Then we enter the unzipped directory and configure the installation specification:

  ```bash
  ./configure --prefix=$Home/usr		# set installation destination
  ```

  The compile and install all files:

  ```bash
  make -j 12		# use 12 cores to compile files
  make install 	# install the compiled files to the target destination 
  ```

- For `.deb` form, 

  ```bash
  dpkg-deb -x extract then follow the same?
  ```

**Remark**: If the target destination is `/$HOME/opt/`, we also need to update the `PATH` variable so that the system can find the executable file:

```bash
echo export PATH="${PATH}:/$HOME/opt/xxx/bin" >> ~/.bashrc 	# xxx is the name of the target directory
```



When creating the account, the administrator has already created to additional folders for local software installation.

  





[1]: MATLAB may not be included as it requires professional license. Each student and faculty can apply for personal license. The group/lab license application needs extra permission. Therefore, we install Octave as a substitute for MATLAB. 