### CORS configuration <a href="#extendedjwt" id="extendedjwt"></a>

In order to communicate with UI, CORS (Cross-Origin Resource Sharing) settings should be configured in `application-docer.properties` files in next folders: `be-dataapp_resources_consumer`, `be-dataapp_resources_provider`, `ecc_resources_consumer` and `ecc_resources_provider`. This allows you to specify which origins, methods, and headers are permitted when making cross-origin requests to your application.

```
application.cors.allowed.origins=
application.cors.allowed.methods=
application.cors.allowed.headers=
```

 - `application.cors.allowed.origins`: Specifies the allowed origins. If empty, all origins (*) are allowed.
 - `application.cors.allowed.methods`: Specifies the allowed HTTP methods. If empty, all methods (*) are allowed.
 - `application.cors.allowed.header`s: Specifies the allowed headers. If empty, all headers (*) are allowed.
 
 Example configuration:
 
 ```
 # Allow specific origins
application.cors.allowed.origins=https://example.com,https://another-example.com

# Allow specific HTTP methods
application.cors.allowed.methods=GET,POST,PUT,DELETE

# Allow specific headers
application.cors.allowed.headers=