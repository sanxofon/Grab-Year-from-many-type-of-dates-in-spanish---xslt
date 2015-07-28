<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />

    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>

    <!-- match the date and invoke capturaYear to format it -->
    <xsl:template match="date">
        <xsl:element name="date">
            <xsl:element name="original">
                <xsl:value-of select="." />
            </xsl:element>
            <xsl:element name="ini">
                <xsl:call-template name="capturaYear">
                    <xsl:with-param name="cadenaFecha" select="." />
                    <xsl:with-param name="yearif" select="'ini'" />
                </xsl:call-template>
            </xsl:element>
            <xsl:element name="fin">
                <xsl:call-template name="capturaYear">
                    <xsl:with-param name="cadenaFecha" select="." />
                    <xsl:with-param name="yearif" select="'fin'" />
                </xsl:call-template>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <!-- parse out the 'year' only ('a.c.' times must be negatives, year '0' doesn't exist so it's '1') -->
    <!--
        input formats:
            1789-12-31
            ca. 1789-12-31
            1789-12-31 a.c.

            1789-12
            ca. 1789-12
            1789-12 a.c.

            1789
            ca. 1789
            1789 a.c.

            siglo XV
            siglo XV a.c.

            178u
            17uu
            1uuu

            u789
            uu89
            uuu9

            1u89
            1uu9

            ca. u8u a.c.
     -->
    <xsl:template name="capturaYear">
        <xsl:param name="cadenaFecha" />
        <xsl:param name="yearif" />
        <!-- Try to get the year only from the string -->
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
        <!--If includes 'a.c.', will add a minus sign '-' -->
        <xsl:variable name="yearsign">
            <xsl:if test="contains($cadenaFecha, 'a.c.')">
                <xsl:value-of select="'-'" />
            </xsl:if>
        </xsl:variable>
        <!--If includes 'a.c.', will strip it -->
        <xsl:variable name="yearb">
            <xsl:choose>
                <xsl:when test="contains($yeara, 'a.c.')">
                    <xsl:value-of select="normalize-space(substring-before($yeara,'a.c.'))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space($yeara)" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="yearc">
            <xsl:choose>
                <xsl:when test="contains($yearb, 'ca.')">
                    <xsl:value-of select="normalize-space(substring-after($yearb,'ca.'))" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space($yearb)" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- If it is a 'siglo' in roman numbers, eg. siglo XVII -->
        <xsl:variable name="yeard">
            <xsl:choose>
                <xsl:when test="contains($yearc, 'siglo')">
                    <xsl:variable name="yearda" select="normalize-space(substring-after($yearc,'siglo'))" />
                    <xsl:choose>
                        <xsl:when test="$yearda='I'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('100/',$yearsign,'1')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1/',$yearsign,'100')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='II'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('200/',$yearsign,'100')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('100/',$yearsign,'200')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='III'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('300/',$yearsign,'200')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('200/',$yearsign,'300')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='IV'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('400/',$yearsign,'300')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('300/',$yearsign,'400')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='V'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('500/',$yearsign,'400')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('400/',$yearsign,'500')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='VI'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('600/',$yearsign,'500')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('500/',$yearsign,'600')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='VII'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('700/',$yearsign,'600')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('600/',$yearsign,'700')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='VIII'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('800/',$yearsign,'700')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('700/',$yearsign,'800')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='IX'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('900/',$yearsign,'800')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('800/',$yearsign,'900')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='X'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1000/',$yearsign,'900')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('900/',$yearsign,'1000')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XI'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1100/',$yearsign,'1000')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1000/',$yearsign,'1100')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XII'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1200/',$yearsign,'1100')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1100/',$yearsign,'1200')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XIII'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1300/',$yearsign,'1200')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1200/',$yearsign,'1300')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XIV'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1400/',$yearsign,'1300')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1300/',$yearsign,'1400')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XV'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1500/',$yearsign,'1400')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1400/',$yearsign,'1500')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XVI'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1600/',$yearsign,'1500')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1500/',$yearsign,'1600')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XVII'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1700/',$yearsign,'1600')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1600/',$yearsign,'1700')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XVIII'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1800/',$yearsign,'1700')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1700/',$yearsign,'1800')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XIX'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('1900/',$yearsign,'1800')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1800/',$yearsign,'1900')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XX'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('2000/',$yearsign,'1900')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('1900/',$yearsign,'2000')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XXI'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('2100/',$yearsign,'2000')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('2000/',$yearsign,'2100')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XXII'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('2200/',$yearsign,'2100')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('2100/',$yearsign,'2200')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$yearda='XXIII'">
                            <xsl:choose>
                                <xsl:when test="$yearsign='-'">
                                    <xsl:value-of select="concat('2300/',$yearsign,'2200')" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="concat('2200/',$yearsign,'2300')" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space($yearc)" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="yeare">
            <xsl:choose>
                <xsl:when test="contains($yeard, 'u')">
                    <xsl:variable name="yearea" select="normalize-space(translate($yeard,'u','0'))" />
                    <xsl:variable name="yeareb" select="normalize-space(translate($yeard,'u','9'))" />
                    <xsl:variable name="yeareaa">
                        <xsl:choose>
                            <xsl:when test="$yearea='0'">
                                <xsl:value-of select="1" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="substring($yearea,1,1)='0'">
                                        <xsl:value-of select="concat($yearsign,'1',substring($yearea,2))" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat($yearsign,normalize-space($yearea))" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="yeareba">
                        <xsl:choose>
                            <xsl:when test="substring($yeareb,1,1)='9' and string-length($yeareb)=4 and $yearsign!='-'">
                                <xsl:value-of select="concat($yearsign,'1',substring($yeareb,2))" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat($yearsign,normalize-space($yeareb))" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$yearsign='-'">
                            <xsl:value-of select="concat(normalize-space($yeareba),'/',normalize-space($yeareaa))" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(normalize-space($yeareaa),'/',normalize-space($yeareba))" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$yeard='0'">
                            <xsl:value-of select="1" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($yearsign,normalize-space($yeard))" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$yearif='fin'">
                <xsl:if test="normalize-space(substring-before($yeare,'/'))!=normalize-space(substring-after($yeare,'/'))">
                    <xsl:value-of select="normalize-space(substring-after($yeare,'/'))" />
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains($yeare,'/')">
                        <xsl:value-of select="normalize-space(substring-before($yeare,'/'))" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($yeare)" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>