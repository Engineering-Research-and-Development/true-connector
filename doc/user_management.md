# User management

TRUE Connector implements simple user management. Both in ECC and DataApp in resources you can find the user.properties file, where all user credentials are stored. 

None of user credentials are not persisted anywhere beside properties files, and their passwords are encoded using BcryptPasswordEncoder.

By default, there are 4 users:

idsUser and bob - interacts with Basic DataApp, initiates communication with connector
apiUser and alice - interacts with Execution Core Container, makes modification for Self Description document

DataApp user.properties

```
# List of users
users.list=idsUser,bob

# Credentials for each user
# encoded - password
idsUser.password=$2a$10$MQ5grDaIqDpBjMlG78PFduv.AMRe9cs0CNm/V4cgUubrqdGTFCH3m
# encoded - passwordBob
bob.password=$2a$12$8ngZQYUF9pATTwNRmLiYeu6XGlLd79eb4FIgr5ezzuAA6tGLxuAyy

```

ECC users.properties

```
# List of users
users.list=apiUser,alice

# Credentials for each user
# encoded - password
apiUser.password=$2a$10$MQ5grDaIqDpBjMlG78PFduv.AMRe9cs0CNm/V4cgUubrqdGTFCH3m
# encoded - passwordAlice
alice.password=$2a$12$xeiemEk5ycerfxq7440ieeTUmZ3EK65hwXwM.NQu.1Y29xbpOMVyq
```


## Modifying users credentials

In the examples provided earlier, the `user.list` property is a list containing usernames, with each username separated by a comma (,) but without any spaces. It is essential to individually assign each user a specific password, as demonstrated in the example. These passwords must be encoded using BCrypt. Getting passwords can be done via following endpoint:

```
/notification/password/{new_password}
```


Using this endpoint, it is guaranteed that the password strength rules configured in the `application.properties` file will be enforced.

Bare in mind that this endpoint is password protected, and you will have to provide existing credentials in order for TRUE Connector to generate new hash that matches with the value passed in URL, so the general advice is to keep `apiUser` as a kind of administrator account. Once new hash is returned, you can modify properties file and set new password for specific user.


