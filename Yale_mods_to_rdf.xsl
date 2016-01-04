<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:dc="http://purl.org/dc/elements/1.1/" version="2.0" xmlns="http://www.loc.gov/mods/v3">
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <xsl:template match="/mods:mods">

        <!-- This stylesheet is based on the work done by the North Carolina Digital Heritage Center (NCDHC) and  Empire State Digital Network (ESDN). -->
        <!-- We are using Repox as the harvesting tool to capture MODS harvested data from Yale. -->
        <!-- To create a single stream with CTDA's harvested data, this will transform MODS to rdf. -->
        <!-- The persistent identifier is in the mods:url object in content and the thumbnail url in mods:url preview. -->
        <!-- RelatedItem and language are not mapped. For futher specifications, see mapping document. -->
        
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rda-syntax-ns#"
            xmlns:dc="http://purl.org/dc/elements/1.1/">
            <rdf:Description>
                <xsl:apply-templates select="mods:titleInfo/mods:title"/>
                <xsl:apply-templates select="mods:name/mods:namePart"/>
                
                <dc:contributor>
                    <xsl:text>Beinecke Rare Book and Manuscript Library</xsl:text>
                </dc:contributor>
                
                <xsl:apply-templates select="mods:originInfo/mods:dateCreated"/>
                <xsl:apply-templates select="mods:note"/>
                <xsl:apply-templates select="mods:subject/mods:name"/>
                <xsl:apply-templates select="mods:accessCondition"/>
                <xsl:apply-templates select="mods:typeOfResource"/>
                <xsl:apply-templates select="mods:genre"/>
                <xsl:apply-templates select="mods:physicalDescription/mods:extent"/>
                <xsl:apply-templates select="mods:phyiscalDescription/mods:internetMediaType"/>
                
                <dc:identifier>
                    <xsl:value-of select="mods:location/mods:url[@access='object in context']"/>
                </dc:identifier>
                
                <dc:source>
                    <xsl:value-of select="mods:location/mods:url[@access='preview']"/>
                </dc:source>
                
            </rdf:Description>
        </rdf:RDF>
        
    </xsl:template>
    
    <xsl:template match="mods:titleInfo/mods:title">
        <xsl:for-each select=".">
            <xsl:if test="normalize-space(.)!=''">
                <dc:title>
                    <xsl:value-of select="normalize-space(.)"/>
                </dc:title>
                <!-- title -->
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="mods:name/mods:namePart">
        <xsl:for-each select=".">
        <xsl:if test="normalize-space(.)!=''">
            <dc:creator>
                <xsl:value-of select="normalize-space(.)"/>
                <!-- creator -->
            </dc:creator>
        </xsl:if>
        </xsl:for-each>
    </xsl:template>
      
    <xsl:template match="mods:originInfo/mods:dateCreated">
        <xsl:variable name="datevalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:date>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:date>
            <!-- date -->
        </xsl:if>
    </xsl:template>  
    
    <xsl:template match="mods:note">
        <xsl:if test="normalize-space(.)!=''">
            <dc:description>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:description>
            <!-- description -->
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mods:physicalDescription/mods:extent">
        <xsl:variable name="formatvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:format>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:format>
            <!-- format -->
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mods:physicalDescription/mods:internetMediaType">
        <xsl:variable name="formatvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:format>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:format>
            <!-- format -->
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mods:accessCondition">
        <xsl:variable name="rightsvalue" select="normalize-space(.)"/> 
        <xsl:if test="normalize-space(.)!=''">
            <dc:rights>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:rights>
            <!-- rights -->
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mods:classification">
        <xsl:variable name="subjectvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:subject>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:subject>
            <!-- subject -->
        </xsl:if>
    </xsl:template>   
    
    <xsl:template match="mods:subject/mods:name">
        <xsl:variable name="subjectvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:subject>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:subject>
            <!-- subject -->
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mods:typeOfResource">
        <xsl:variable name="typevalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:type>
                <xsl:value-of select="lower-case(normalize-space(.))"/>
            </dc:type>
            <!-- type -->
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mods:genre">
        <xsl:variable name="typevalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:type>
                <xsl:value-of select="lower-case(normalize-space(.))"/>
            </dc:type>
            <!-- type -->
        </xsl:if>
    </xsl:template>
      
</xsl:stylesheet>
