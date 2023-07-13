## Self Description API <a href="#selfdescription" id="selfdescription"></a>

To manage your Self Description Document please check following [link](https://github.com/Engineering-Research-and-Development/true-connector-execution\_core\_container/blob/1.14.0/doc/SELF\_DESCRIPTION.md)

You can copy existing valid self-description.json document to following location **/ecc\_resources\_consumer** or **/ecc\_resources\_provider** folders, for consumer or provider.


There is also possibility to change location of self\_description.json document, which can be done by changing following property:

```
application.selfdescription.filelocation=

```

Be careful when changing this property, since it needs to be reflected inside docker container.

When connector is starting up, it will look for file named _self\_description.json_ file, and if such file exists, it will load Self Description document from file, otherwise it will create default Self Description document, from properties:

```
application.selfdescription.description=
application.selfdescription.title=
application.selfdescription.curator=
application.selfdescription.maintainer=
```

With single offered resource, artifact and contract offer.