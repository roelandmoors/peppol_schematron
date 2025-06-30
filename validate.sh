#!/bin/bash
set -e

XML="invoice.xml"
OUTPUT="result.xml"

if [ "$UBL_BE" == "true" ]; then
    # Using Belgian-specific schematron: GLOBALUBL.BE.sch
    SCHEMATRON="GLOBALUBL.BE.sch"
    java -jar saxon.jar -s:$SCHEMATRON -xsl:schxslt2/transpile.xsl -o:compiled_be.xsl
    java -jar saxon.jar -s:$XML -xsl:compiled_be.xsl -o:$OUTPUT
else
    # Running CEN-EN16931-UBL.sch...
    SCHEMATRON="CEN-EN16931-UBL.sch"
    java -jar saxon.jar -s:$SCHEMATRON -xsl:schxslt2/transpile.xsl -o:compiled_cen.xsl
    java -jar saxon.jar -s:$XML -xsl:compiled_cen.xsl -o:result_cen.xml

    # Check if CEN validation passed (no failed assertions)
    if ! grep -q "<svrl:failed-assert" result_cen.xml; then
        # CEN validation passed. Running PEPPOL-EN16931-UBL.sch...
        SCHEMATRON="PEPPOL-EN16931-UBL.sch"
        java -jar saxon.jar -s:$SCHEMATRON -xsl:schxslt2/transpile.xsl -o:compiled_peppol.xsl
        java -jar saxon.jar -s:$XML -xsl:compiled_peppol.xsl -o:$OUTPUT
    else
        # CEN validation failed. Skipping PEPPOL validation.
        cp result_cen.xml $OUTPUT
    fi
fi

# Optional plain text output
if [ "$PLAIN_TEXT" == "true" ]; then
    java -jar saxon.jar -s:$OUTPUT -xsl:to_text_output.xsl -o:result.txt
    cat result.txt
else
    xmllint --format $OUTPUT
fi
