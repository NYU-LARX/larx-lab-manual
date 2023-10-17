# Group Management 

This page introduces the basic operations for groups in Linux, including creating a group, adding and deleting a member in the group, etc..


### Concept of Groups

Groups are mainly used to *share resources* in Linux systems. Group permissions allow multiple users to share a common set of permissions for an object. For example, two users, `A` and `B`, are in the same group, `AandB`. Then, they can access and modify files that belong to that group. Suppose we have another `C` who does not belong to the group `AandB`. Then, `C` has no permission to access or modify the files in that group.



### Add and Delete a Group 

We need the admin user to create or delete a group.

To create a new group, we use the command `addgroup`. Log into `larx` account. Open a terminal and type

```bash
$ sudo addgroup foobar    # add a new group `foobar`
```

The system will prompt necessary information.

To delete a group, we use the command `delgroup`. Log into `larx` account. Open a terminal and type

```bash
$ sudo delgroup foobar    # delete an existing group `foobar`
```


### Add (Delete) a User to (from) a Group

We need the admin user to add or delete a user from or to a group. 

To add an existing user to an existing group, we use the command `usermod`. Log into `larx` account. Open a terminal and type

```bash
$ sudo usermod -a -G group123 foo     # add a user `foo` to a group `foobar`
```

To delete an existing user in a group, we use the command `deluser`. Log into `larx` account. Open a terminal and type

```bash
$ sudo deluser foo foobar         #  delete a user `foo` from a group `foobar`
```


### Check Group Information
We can print the `/etc/group` file to check the information of an individual group or *all existing groups*.

```bash
$ cat /etc/group	# list all existing groups
$ cat /etc/group | grep foobar 	# list group info of group foobar
```

The output may be like this:

![image](https://www.cyberciti.biz/media/new/faq/2006/02/etc_group_file.jpg)

1. **group_name**: It is the name of the group. If you run `ls -l` command, you will see this name printed in the group field.
2. **Password**: Generally, the password is not used. Hence, it is empty/blank. It can store encrypted passwords. This is useful for implementing privileged groups.
3. **Group ID (GID)**: Each user must be assigned a group ID. You can see this number in your `/etc/passwd` file.
4. **Group List**: It is a list of user names of users who are members of the group. Commas must separate the user names.



Some quick commands.

``` bash
$ groups foo 	# print all groups names that user foo is in
```

We can also print group ID of a particular user using `id` command:

```bash
$ id -G foo 	# print group id that user foo is in
$ id -Gn foo 	# print group names that user foo is in
```

