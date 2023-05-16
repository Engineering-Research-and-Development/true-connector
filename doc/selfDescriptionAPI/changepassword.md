### Changing API password <a href="#changepassword" id="changepassword"></a>

If you want to change password for API, this can be done via following endpoint

```
/notification/password/{new_password}
```

Bare in mind that this endpoint is password protected, and you will have to provide existing credentials in order for TRUE Connector to generate new hash that matches with the value passed in URL. Once new hash is returned, you can modify property and set new password.

```
spring.security.user.password=
```
