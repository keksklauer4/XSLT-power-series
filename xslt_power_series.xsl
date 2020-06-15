<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="power_series">
        <xsl:param name="x_value"/>
        <xsl:param name="numerator"/>
        <xsl:param name="remaining_iterations"/>
        <xsl:param name="demoninator_fak"/>
        <xsl:param name="i"/>


        <xsl:variable name="term">
            <xsl:choose>
                <xsl:when test="$i = 0">1</xsl:when>
                <xsl:otherwise><xsl:value-of select="$numerator div $demoninator_fak"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$remaining_iterations = 1"><xsl:value-of select="$term"/></xsl:when>
            <xsl:otherwise>
                <xsl:variable name="recursive_ret">
                    <xsl:call-template name="power_series">
                        <xsl:with-param name="i" select="$i + 1"/>
                        <xsl:with-param name="x_value" select="$x_value"/>
                        <xsl:with-param name="remaining_iterations" select="$remaining_iterations - 1"/>
                        <xsl:with-param name="demoninator_fak" select="$demoninator_fak * ($i+1)"/>
                        <xsl:with-param name="numerator" select="$numerator * $x_value"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:value-of select="$term + $recursive_ret"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/">
        <xsl:variable name="e_power_pi">
            <xsl:call-template>
                <xsl:with-param name="i" select="0"/>
                <xsl:with-param name="x_value">3.14159265358979323846</xsl:with-param>
                <xsl:with-param name="remaining_iterations" select="40"/>
                <xsl:with-param name="numerator" select="1"/>
                <xsl:with-param name="demoninator_fak" select="1"/>
            </xsl:call-template>
        </xsl:variable>
        <calc><xsl:value-of select="$e_power_pi"/></calc>
    </xsl:template>
</xsl:stylesheet>