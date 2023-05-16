### Validate protocol <a href="#validateprotocol" id="validateprotocol"></a>

Forward-To protocol validation can be enabled by setting the property **application.enableProtocolValidation** to true. If you have this enabled please refer to the following step.

Forward-To protocol validation can be changed by editing _application-docker.properties_ and modify **application.validateProtocol**. Default value is _false_ and Forward-To URL will not be validated. Forward-To URL can be set like http(https,wss)://example.com or just example.com and the protocol chosen (from application-docker.properties) will be automatically set (it will be overwritten!)\
Example: http://example.com will be wss://example if you chose wss in the properties).

If validateProtocol is true, then Forward-To header must contain full URL, including protocol.\
Forward-To=localhost:8890/data - this one will fail, since it lack of information is it http or https\
Forward-To=https://localhost:8890/data - this one will work, since it has protocol information in URL.
