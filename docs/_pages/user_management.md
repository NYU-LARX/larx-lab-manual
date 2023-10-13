# User Management 

This page introduces the basic operations for users in the Linux, including adding and deleting a user, changing the password, etc..


### Root User, Admin User, and Regular Users

In Linux, A *root user* has the highest privilege to modify any files in the system. For security reasons, many Linux distributions such as Ubuntu has locked the root user. This means that we cannot login as root directly or use the `su` command to become the root user. Instead, the *admin user* (with `sudo`, also called super user) is used to configure the system.

An *admin user* is responsible for routine system update including updating software packages and editing system-level configuration files. The admin user are allowed to have the privilege to read, write, and execute any executable files in the computer with `sudo` command.

A *regular user* can utilize the resources of the system within his/her account. However, the regular user has limited privilege to read, write, and execute the files specified by the *file permission*. In general, the allowed permission scope are as follows:
- The `/home/username` directory for full read, write, and execute permission;
- Most system level files for executable permission;
- Files created by other users with appropriate permisson.


**Note:** In all lab computers, the admin user is `larx`. Refer to [Basic Information About Lab Resrouces](_pages/basic_lab_info.md) for the admin password.


### Create New User Account

We need the admin user to create a regular user account. 

First log into `larx` account. Open a terminal and type

```bash
$ sudo adduser foo 	# add a new user with username foo
```

Then follow the prompt and complete the registeration and logout `larx` account.


### Reset Password

Regular users can reset their password in their own account. 

For example, we log into the user account `foo`. Then open a terminal and type

```bash
$ passwd foo 	    # reset the password for user foo
```

Then follow the prompt and type the new password.


### Delete User

We need the admin user to create a regular user account. 

We use the command `deluser` to delete a user. This command has many options:

```bash
$ deluser  [options]  [--force] [--remove-home] [--remove-all-files] [--backup] [--backup-to DIR] user
```

In general, the admin will delete the user and remove all of his/her files if a user becomes inactivate.

```bash
$ sudo deluser --remove-all-files foo     # delete user foo and remove all files
```

**Note:** The deletion is not recoverable. Only the admin user should use it and it should be used with caution.


### Change File Permission

All regular users can change the file permission within their accounts. For detailed file permission explanation, please refer to [File Permissions in Linux/Unix: How to Read/Write & Change?](https://www.guru99.com/file-permissions.html)

The file permission can protect the user's file from being read or modified by other users. The command to change the file permission is `chmod`. For example, we can disable the write permission of `test.txt` for other users by typing

```bash
$ chmod 644 test.txt  # change test.txt to permission rw-r--r-- to aviod modifications from other users
```


### Check User Information
We can print the `/etc/passwd` file to check the information of an individual user or *all existing users*.

```bash
$ cat /etc/passwd		    # list all existing users
$ cat /etc/passwd | grep foo 	# list user info of user foo
```

The output may like this:

```
mark:x:1001:1001:mark,,,:/home/mark:/bin/bash
[--] - [--] [--] [-----] [--------] [--------]
|    |   |    |     |         |        |
|    |   |    |     |         |        +-> 7. Login shell
|    |   |    |     |         +----------> 6. Home directory
|    |   |    |     +--------------------> 5. GECOS
|    |   |    +--------------------------> 4. GID
|    |   +-------------------------------> 3. UID
|    +-----------------------------------> 2. Password
+----------------------------------------> 1. Username
```

1. **Username**: The string you type when you log into the system. Each username must be a unique string on the machine. The **maximum length** of the username is restricted to **32** characters.
2. **Password**: In older Linux systems, the user’s encrypted password was stored in the `/etc/passwd` file. On most modern systems, this field is set to `x`, and the [user password](https://linuxize.com/post/how-to-change-user-password-in-linux/) is stored in the `/etc/shadow` file.
3. **UID**: The user identifier is a number assigned to each user. It is used by the operating system to refer to a user.
4. **GID**: The user’s group identifier number, referring to the user’s primary group. When a user creates a file, the file’s group is set to this group. Typically, the name of the group is the same as the name of the user. User’s [secondary groups](https://linuxize.com/post/how-to-add-user-to-group-in-linux/) are listed in the `/etc/groups` file.
5. **GECOS** or **the full name of the user**: This field contains a list of comma-separated values with the following information:
   - User’s full name or the application name.
   - Room number.
   - Work phone number.
   - Home phone number.
   - Other contact information.
6. **Home directory**: The absolute path to the user’s home directory. It contains the user’s files and configurations. By default, the user home directories are named after the name of the user and created under the `/home` directory.
7. **Login shell**: The absolute path to the user’s login shell. This is the shell that is started when the user logs into the system. On most Linux distributions, the default login shell is Bash.


We can also print user ID using `id` command:

```bash
$ id foo 		# print full id information of user foo
$ id -g foo	    # print user id for user foo
$ id -gn foo 	# print user name for user foo, just copy
```