### Changing API password <a href="#changepassword" id="changepassword"></a>

If you want to change password for connector users, this can be done via following endpoint

```
/api/password/{new_password}
```
Using this endpoint, it is guaranteed that the password strength rules configured in the `application.properties` file will be enforced.

Bare in mind that this endpoint is password protected, and you will have to provide existing credentials in order for TRUE Connector to generate new hash that matches with the value, which later you can edit in `user.properties` file.
