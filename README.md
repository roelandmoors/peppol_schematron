## Peppol Schematron

A Docker image to make it easy to do a [schematron](https://schematron.com/) validation for Peppol.


## Variables

- PLAIN_TEXT: The default output is SVRL (Schematron Validation Report Language). You can get a plain text output of you set this to true.
- UBL_BE: You can also validate for [UBL.BE](https://www.ubl.be/schematron/) if you set this to true.


## Using the registry

You can run it directly from ghcr like this:

```
docker run --rm -e PLAIN_TEXT=true -v ./your-invoice.xml:/app/invoice.xml:ro ghcr.io/mooroe/peppol_schematron:latest
```

## Without using the image from the registry

If you want to do your own build:
```
docker build -t peppol_schematron .
```

And run it like this for Peppol validation:
```
docker run --rm -e PLAIN_TEXT="true" -v ./your-invoice.xml:/app/invoice.xml:ro peppol_schematron
```
