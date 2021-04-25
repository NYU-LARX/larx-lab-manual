# User and Group Management 

This page introduces the basic operations for users and group in Linux. Specifically, the procedure of adding and deleting a user will be given. 



## User Operations

###  Root User, Admin User, and Regular Users

In Linux, A root user has the highest privilege to modify any files in the system. For security reasons, many Linux distributions such as Ubuntu has locked the root user. This means that we cannot login as root directly or use the `su` command to become the root user. Instead, the admin user (with `sudo`) is used to configure the system.

A admin user is responsible for managing packages, editing config files, installing a program from source. Since many of these operations need system level configurations, the admin user are allowed to have the privilege to read, write, and execute any files in the computer with `sudo` command.

A regular user can utilize the resources of the system. However, he/she only has limited privilege to read, write, and execute the files specified by the *file permission*. Usually, the allowed permission scope are as follows:

- The `home` directory for full read, write, and execute permission;
- Most system level files for executable permission;
- Files created by other users with appropriate permisson.



### Add and Delete a User

We need the admin user to create or delete a user. 

To create a new user, we use the command `adduser`. For example, we want to add a new user `jack`. We type

```bash
sudo adduser jack
```

The system will prompt necessary information to enter to finish the registration.

To delete a user, we use the command `deluser`. This command has many options:

```bash
deluser  [options]  [--force] [--remove-home] [--remove-all-files] [--backup] [--backup-to DIR] user
```

 Usually, if we want to delete a user `jack` and remove all of files, we type

```bash
sudo deluser --remove-all-files jack
```



### Reset Password

To reset the password, we use the command `passwd`. For example, we want to reset the password for user `jack`, we type

```bash
passwd jack
```

The system will prompt information to reset the password.

**Note:** for regular users, the admin user first create the regular user account with default password. Then reguar users can log in and use the above command to reset their own password.



### Change File Permission

For detailed file permission explanation, please refer to [File Permissions in Linux/Unix: How to Read/Write & Change?](https://www.guru99.com/file-permissions.html)

A user can change the file permission to protect his/her files from being modified by other users. We use the command `chmod` to change the file permission of a specifc file. For example, we want to change file `test.txt` from permission `rw-rw-rw-` to `rw-r--r--`, we type

```bash
chmod 644 test.txt
```



### Important Initialization for Regular Users

Since the admin user has to install some software from source code, to use these software, all regular users should execute the following commands.

```bash
# step 1: open terminal: Ctrl+Alt+T and type
gedit ~/.bashrc
# step 2: scroll down to the bottom and add the following
export PATH="${PATH}:/opt/Python3.9.1/bin"
export PATH="${PATH}:/home/xxx/.local/bin" 	# xxx is your username
# step 3: save and close editor, they type
source ~/.bashrc
```





## Group Operations

### Concept of Groups

Groups are mainly used to share resources in Linux system. Groups permissions allow multiple users to share a common set of permissions for an object. For example, two users `A` and `B` are in the same group `AandB`. Then they can access and modify files which belongs to that group. Suppose we have another `C` who does not belong to the group `AandB`, then `C` has no permission to access or modify the files in that group.



### Add and Delete a Group 

We need the admin user to create or delete a group. 

To create a new group, we use the command `addgroup`. For example, we want to add a new group `group123`. We type

```bash
sudo addgroup group123
```

The system will prompt necessary information.

To delete a group, we use the command `delgroup`. For example, we want to delete an existing group `group123`. We type

```bash
sudo delgroup group123
```



### Add(Delete) a User to(from) a Group

We need the admin user to add or delete a user from or to a group. 

To add an existing user to an existing group, we use command `usermod`. For example, we want to add a user `jack` to a group `group123`. We type

```bash
sudo usermod -a -G group123 jack
```

 To delete an existing user in a group, we use command `deluser`. For example, we want to delete a user `jack` from a group `group123`. We type

```bash
sudo deluser jack group123
```



## Additional Info About User and Group

In this section, we introduce some additional knowledge about the group and user in Linux.

There are group administrators. We omit for the moments.

#### Understanding the `/etc/passwd` file

To check **all existing users**, we can use

```bash
cat /etc/passwd		# list all existing users
cat /etc/passwd | grep xxx 	# list user info of user xxx
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



#### Understanding the `/etc/group` file

To check **all existing groups**, we can use 

```bash
cat /etc/group	# list all existing groups
cat /etc/group | grep xxx 	# list group info of group xxx
```

The output may like this:

![image](https://www.cyberciti.biz/media/new/faq/2006/02/etc_group_file.jpg)

1. **group_name**: It is the name of group. If you run `ls -l` command, you will see this name printed in the group field.
2. **Password**: Generally password is not used, hence it is empty/blank. It can store encrypted password. This is useful to implement privileged groups.
3. **Group ID (GID)**: Each user must be assigned a group ID. You can see this number in your `/etc/passwd` file.
4. **Group List**: It is a list of user names of users who are members of the group. The user names, must be separated by commas.



### Some useful command

#### Find out the groups a user is in 

``` bash
groups xxx 	# print groups names that user xxx is in
```

where `xxx` is the user name. For example, `groups AandB`. The command will output all the group names that the user `AandB` is in. 

#### Print user ID and the corresponding group ID

```bash
id xxx 		# print full id information of user xxx
id -g xxx	# print user id for user xxx
id -gn xxx 	# print user name for user xxx, just copy
id -G xxx 	# print group id that user xxx is in
id -Gn xxx 	# print group names that user xxx is in
```

