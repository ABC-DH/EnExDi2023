<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
     exclude-result-prefixes="xs tei" version="2.0">
 
 <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
 
 <xsl:template match="TEI">
     <xsl:copy>
         <xsl:apply-templates/>
     </xsl:copy>
 </xsl:template>
    
 <xsl:template match="teiHeader">
     <xsl:copy-of select="."/>
 </xsl:template>
 
 <xsl:template match="text">
     <xsl:copy>
         <xsl:apply-templates/>
     </xsl:copy>
 </xsl:template>
    
    <xsl:template match="body">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="lg">
        <xsl:choose>
            <xsl:when test="@type='sonnet'">
                <xsl:element name="div">
                    <xsl:attribute name="type">
                        <xsl:value-of select="@type"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='sizain'">
               <xsl:apply-templates select="lg"/>
            </xsl:when>
            <xsl:when test="@type='tercet'">
                <xsl:element name="lg">
                    <xsl:attribute name="type">
                        <xsl:value-of select="@type"/>
                    </xsl:attribute>
                    <xsl:attribute name="n">
                        <xsl:number  format="1" level="single" from="lg[@type='quatrain']"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="lg">
                    <xsl:attribute name="n">
                        <xsl:number count="lg" format="1" level="single"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:value-of select="@type"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>  
    </xsl:template>
    
    <xsl:template match="l">
        <xsl:element name="l">
            <xsl:attribute name="n">
                <xsl:number count="l" format="1" level="any"/>
            </xsl:attribute>
            <xsl:value-of select="text()"/>
        </xsl:element>
    </xsl:template>
    
   
    
</xsl:stylesheet>
