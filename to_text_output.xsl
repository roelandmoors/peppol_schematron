<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svrl="http://purl.oclc.org/dsdl/svrl">
    
    <xsl:output method="text" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="svrl:schematron-output">
        <xsl:text>SCHEMATRON VALIDATION REPORT</xsl:text>
        <xsl:text>&#10;================================&#10;&#10;</xsl:text>
        
        <!-- Summary Section -->
        <xsl:text>VALIDATION SUMMARY:&#10;</xsl:text>
        <xsl:text>Total Fatal Errors: </xsl:text>
        <xsl:value-of select="count(svrl:failed-assert[@flag='fatal'])"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Total Warnings: </xsl:text>
        <xsl:value-of select="count(svrl:failed-assert[@flag='warning'])"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Total Rules Fired: </xsl:text>
        <xsl:value-of select="count(svrl:fired-rule)"/>
        <xsl:text>&#10;&#10;</xsl:text>
        
        <!-- Document Information -->
        <xsl:if test="svrl:active-pattern/@documents">
            <xsl:text>DOCUMENT VALIDATED: </xsl:text>
            <xsl:value-of select="svrl:active-pattern/@documents[1]"/>
            <xsl:text>&#10;&#10;</xsl:text>
        </xsl:if>
        
        <!-- Fatal Errors Section -->
        <xsl:if test="svrl:failed-assert[@flag='fatal']">
            <xsl:text>FATAL ERRORS:&#10;</xsl:text>
            <xsl:text>-------------&#10;</xsl:text>
            <xsl:for-each select="svrl:failed-assert[@flag='fatal']">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="@id"/>
                <xsl:text>] </xsl:text>
                <xsl:value-of select="svrl:text"/>
                <xsl:text>&#10;</xsl:text>
                <xsl:if test="@location">
                    <xsl:text>   Location: </xsl:text>
                    <xsl:value-of select="@location"/>
                    <xsl:text>&#10;</xsl:text>
                </xsl:if>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        </xsl:if>
        
        <!-- Warnings Section -->
        <xsl:if test="svrl:failed-assert[@flag='warning']">
            <xsl:text>WARNINGS:&#10;</xsl:text>
            <xsl:text>---------&#10;</xsl:text>
            <xsl:for-each select="svrl:failed-assert[@flag='warning']">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="@id"/>
                <xsl:text>] </xsl:text>
                <xsl:value-of select="svrl:text"/>
                <xsl:text>&#10;</xsl:text>
                <xsl:if test="@location">
                    <xsl:text>   Location: </xsl:text>
                    <xsl:value-of select="@location"/>
                    <xsl:text>&#10;</xsl:text>
                </xsl:if>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        </xsl:if>
        
        <!-- Validation Result -->
        <xsl:text>VALIDATION RESULT: </xsl:text>
        <xsl:choose>
            <xsl:when test="svrl:failed-assert[@flag='fatal']">
                <xsl:text>FAILED (Contains Fatal Errors)</xsl:text>
            </xsl:when>
            <xsl:when test="svrl:failed-assert[@flag='warning']">
                <xsl:text>PASSED WITH WARNINGS</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>PASSED</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
