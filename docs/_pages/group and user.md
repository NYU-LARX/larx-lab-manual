## Group and user in Linux

We introduce some knowledge about the group and user in Linux.

There are group administrators. We omit for the moments.



#### About root user in Ubuntu

By default, the root account password is **locked** in Ubuntu. This means that **you cannot login as root directly** or **use the `su` command to become the root user**. However, since the root account physically exists it is still possible to run programs with root-level privileges. This is where `sudo` comes in – it allows authorized users to run certain programs as root without having to know the root password. This means that in the terminal you should use `sudo` for commands that require root privileges; simply prepend `sudo` to all the commands you need to run as root.



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

where,

1. **group_name**: It is the name of group. If you run `ls -l` command, you will see this name printed in the group field.
2. **Password**: Generally password is not used, hence it is empty/blank. It can store encrypted password. This is useful to implement privileged groups.
3. **Group ID (GID)**: Each user must be assigned a group ID. You can see this number in your `/etc/passwd` file.
4. **Group List**: It is a list of user names of users who are members of the group. The user names, must be separated by commas.



### Some useful command

#### Find out the groups a user is in 

``` bash
groups xxx 	# print groups names that user xxx is in
```

where `xxx` is the user name. For example, `groups james`. The command will output all the group names that the user `james` is in. 

#### Print user ID and the corresponding group ID

```bash
id xxx 		# print full id information of user xxx
id -g xxx	# print user id for user xxx
id -gn xxx 	# print user name for user xxx, just copy
id -G xxx 	# print group id that user xxx is in
id -Gn xxx 	# print group names that user xxx is in
```

