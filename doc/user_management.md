# User management

TRUE Connector implements simple user management. Both in ECC and DataApp in resources you can find the user.properties file, where all user credentials are stored. 

None of user credentials are persisted anywhere beside properties files, and their passwords are encoded using BcryptPasswordEncoder.

Those users are strictly related to the connector on appliation level, if there is a need to create new users for SSH access, please refer to [Manage OS users](./advancedConfiguration/manage-os-users.md).

## Default configuration

By default, there are 4 users divided in two groups for quick start:

idsUser and bob - initiates communication with connector (sends IDS messages, performs contract negotiation process, downloads artifacts)
apiUser and alice - makes modification for Self Description document

DataApp user.properties

```
# List of users
users.list=idsUser,bob

# Credentials for each user
# encoded - passwordIdsUser
idsUser.password=$2a$12$54Rw0Bp/9yt5Zcj4gVkvnuVT9aeN36m4dzVMMLrPC0v78lAOQo9te
# encoded - passwordBob
bob.password=$2a$12$8ngZQYUF9pATTwNRmLiYeu6XGlLd79eb4FIgr5ezzuAA6tGLxuAyy

```

ECC users.properties

```
# List of users
users.list=apiUser,alice

# Credentials for each user
# encoded - passwordApiUser
apiUser.password=$2a$12$cxXwcV989VwOUznb10oBcuvHSTVDAl6MWL2GG257RfI3Gg.J8Qvnu
# encoded - passwordAlice
alice.password=$2a$12$xeiemEk5ycerfxq7440ieeTUmZ3EK65hwXwM.NQu.1Y29xbpOMVyq
```
The `user.list` property is a list containing usernames of all users, with each username separated by a comma (,) but without any spaces. It is essential to individually assign each user a specific password which must be encoded using BCrypt.


## Manage users credentials

 
***IMPORTANT: *** By default, only admin(root) OS user can change credentials for TC users. If there is a specific need for a new OS user to access and modify the configurations, more information can be found [here](./advancedConfiguration/manage-os-users.md).

ECC `users.properties` can be found in next folders: [***ecc_resources_provider (ECC Provider)***](../ecc_resources_provider/users.properties)  and  [***ecc_resources_consumer (ECC consumer)***](../ecc_resources_consumer/users.properties).

[here](../ecc_resources_consumer/users.properties)

DataApp `users.properties` can be found in next folder: [***be-dataapp_resouces***](../be-dataapp_resources/users.properties)


### Usernames naming convention

If your company doesn't have established naming convention, you can follow these basic guidelines:

* Uniqueness: Ensure each username is unique.
* Character Set: Stick to letters and numbers.
* Length: Keep it short, around 3-20 characters.
* No Personal Info: Avoid using personal data like full names or birthdays.
* Case Insensitivity: Make usernames case-insensitive for user convenience.
* Reserved Keywords: Don't allow reserved or restricted words.


### Add new user

As mentioned earlier `user.list` property is a list containing usernames, with each username separated by a comma (,) but without any spaces. It is essential to individually assign each user a specific password, as demonstrated in the example. These passwords must be encoded using BCrypt. Getting passwords can be done via following endpoint:

```
/api/password/{new_password}
```

Using this endpoint, it is guaranteed that the password strength rules configured in the `application.properties` file will be enforced.

Bare in mind that this endpoint is password protected, and you will have to provide existing credentials in order for TRUE Connector to generate new hash that matches with the value passed in URL, so the general advice is to keep `apiUser` as a kind of administrator account. Once new hash is returned, you can modify properties file and set new password for specific user.

Example:

```
# List of users
users.list=exisitingUser,newUser

# Credentials for each user
# encoded - passwordExistingUser123
exisitingUser.password=$2a$12$pnOQFwnr4abSkXs3DaKt8O0MRE2r234WHFLPKUmUgwXZkA245BDa.
# encoded - passwordNewUser123
newUser.password=$2a$12$v7/AKsx5KTNJpwOg9yRRe.h6jP80gc03umqqN6aMAQtvVEWmpIqna
```

After the files are modified, it is necessary to restart container in order to apply changes.


### Modify existing user

Same rules applies to user credentials modification, what it needs to be updated is username in the `user-list`, and if password need to be updated, the same endpoint mentioned above should be used. 


Example for changing username and password:

```
# List of users
users.list=exisitingUser,newUserModify

# Credentials for each user
# encoded - passwordExistingUser123
exisitingUser.password=$2a$12$pnOQFwnr4abSkXs3DaKt8O0MRE2r234WHFLPKUmUgwXZkA245BDa.
# encoded - passwordNewUser123Modify
newUserModify.password=$2a$12$O8BZtPck4AtFpMl.WvflFOy4MniRcc0S94X43I32Eym1ZuOr5M1/.

```

Also here, after the files are modified, it is necessary to restart container in order to apply changes.

### Delete existing user

If user needs to be deleted, it can be done by deleting desired username in the in the `user-list`, alongside with assigned password.

Also here, after the files are modified, it is necessary to restart container in order to apply changes.


## User request for changing password

If user wants to change password previously assigned by admin, it should directly contact the admin, providing new desired password, after which admin will apply changes.

