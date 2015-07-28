<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />
    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="date">
        <xsl:element name="date">
            <xsl:call-template name="capturaYear">
                <xsl:with-param name="cadenaFecha" select="." />
            </xsl:call-template>
        </xsl:element>
    </xsl:template>
    <xsl:template name="capturaYear">
        <xsl:param name="cadenaFecha" />
        <xsl:variable name="yeara">
            <xsl:choose>
                <xsl:when test="contains($cadenaFecha, '-')">
                    <xsl:value-of select="substring-before($cadenaFecha,'-')" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space($cadenaFecha)" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="normalize-space($yeara)" />
    </xsl:template>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>