# Create  New Regular Users

This pages introduces how to create a regular user account for any lab member who wants to operate workstations.



## Use Administrator to Create New Account

The administrator `larx` is responsible for creating a new regular user. After logging into the administrator's account (the `larx` account), we type

```bash
sudo adduser jack 	# add a new user with username jack
```

Then we simply follow the prompt and finish the registeration. 

**Important:** The password is required for creating a new account. But this password can be modified by users. We recommend that the administrator `larx` uses the default password `123456` for every new user. 

After creating the new user, we simply logout `larx` account.



## Changing User's Password

Regular users can change their password in their own account. 

For example, after creating the new account `jack`, we log into the account `jack` with password `123456`. Then we type

```bash
passwd jack 	# change the password for user jack
```

The system requires to input the current password first. Then we simply follow the prompt and type the new password. The new password is not visable for any user including the administrator `larx`. 

Next time when we log into our own account, we use the new password.