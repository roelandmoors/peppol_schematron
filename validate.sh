#!/bin/bash
set -e

XML="invoice.xml"
OUTPUT="result.xml"

# Determine which schematron to use
if [ "$UBL_BE" == "true" ]; then
    echo "Using Belgian-specific schematron: GLOBALUBL.BE.sch"
    SCHEMATRON="GLOBALUBL.BE.sch"
    java -jar saxon.jar -s:$SCHEMATRON -xsl:schxslt2/transpile.xsl -o:compiled.xsl
    java -jar saxon.jar -s:$XML -xsl:compiled.xsl -o:$OUTPUT
else
    echo "Trying CEN-EN16931-UBL.sch..."
    SCHEMATRON="CEN-EN16931-UBL.sch"
    java -jar saxon.jar -s:$SCHEMATRON -xsl:schxslt2/transpile.xsl -o:compiled_cen.xsl
    if java -jar saxon.jar -s:$XML -xsl:compiled_cen.xsl -o:$OUTPUT; then
        echo "CEN validation passed or completed."
    else
        echo "CEN validation failed. Trying PEPPOL-EN16931-UBL.sch..."
        SCHEMATRON="PEPPOL-EN16931-UBL.sch"
        java -jar saxon.jar -s:$SCHEMATRON -xsl:schxslt2/transpile.xsl -o:compiled_peppol.xsl
        java -jar saxon.jar -s:$XML -xsl:compiled_peppol.xsl -o:$OUTPUT
    fi
fi

# Optional plain text output
if [ "$PLAIN_TEXT" == "true" ]; then
    java -jar saxon.jar -s:$OUTPUT -xsl:to_text_output.xsl -o:result.txt
    cat result.txt
else
    xmllint --format $OUTPUT
fi

