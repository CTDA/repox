<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" version="2.0" xmlns="http://www.loc.gov/mods/v3">
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <xsl:template match="/oai_dc:dc">

        <!-- This stylesheet is based on the work done by the North Carolina Digital Heritage Center (NCDHC) and  Empire State Digital Network (ESDN). -->
        <!-- We are using Repox as the harvesting tool to capture OAI Dublin Core harvested data from CTDA. -->
        <!-- To avoid Repox ignoring the stylesheet, we are going from oai_dc to rdf as well as constructing the handle and thumbnail url. -->

        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rda-syntax-ns#"
            xmlns:dc="http://purl.org/dc/elements/1.1/">
            <rdf:Description>
                <xsl:apply-templates select="dc:title"/>
                <xsl:apply-templates select="dc:creator"/>
                <xsl:apply-templates select="dc:contributor"/>
                
                <dc:contributor>
                    <xsl:choose>
                        <xsl:when test="contains(dc:publisher, 'Ownership')">
                            <xsl:value-of select="normalize-space(substring-after(dc:publisher, 'Ownership Statement: '))"/>
                        </xsl:when>
                    </xsl:choose>
                </dc:contributor>
                
                <xsl:apply-templates select="dc:date"/>
                <xsl:apply-templates select="dc:description"/>
                <xsl:apply-templates select="dc:subject"/>
                <xsl:apply-templates select="dc:coverage"/>
                <xsl:apply-templates select="dc:publisher"/>
                <xsl:apply-templates select="dc:rights"/>
                <xsl:apply-templates select="dc:type"/>
                <xsl:apply-templates select="dc:format"/>
                <xsl:apply-templates select="dc:language"/>

                <!-- CTDA's handle or persistent ID goes into the identifier element and the thumbnail url goes into the source element -->
                <xsl:variable name="pid"
                    select="(dc:identifier/tokenize(., '/')[matches(., '^\d{5,10}[:]\d*$')])[1]"/>
                <dc:identifier>
                    <xsl:value-of select="concat('http://hdl.handle.net/11134/', $pid)"/>
                </dc:identifier>
                <dc:source>
                    <xsl:value-of
                        select="concat('http://collections.ctdigitalarchive.org/islandora/object/', $pid, '/datastream/TN')"
                    />
                </dc:source>

            </rdf:Description>
        </rdf:RDF>

    </xsl:template>

    <xsl:template match="dc:title">
        <xsl:for-each select=".">
            <xsl:if test="normalize-space(.)!=''">
                <dc:title>
                    <xsl:value-of select="normalize-space(.)"/>
                </dc:title>
                <!-- title -->
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="dc:contributor">
        <xsl:variable name="contributorvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:contributor>
                <xsl:value-of select="normalize-space(.)"/>
                <!-- contributor -->
            </dc:contributor>
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:coverage">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:choose>
                <!-- check to see if there are any numbers in this coverage value -->
                <xsl:when test='matches(.,"\d+")'>
                    <xsl:choose>
                        <!-- if numbers follow a coordinate pattern, it's probably geo data -->
                        <xsl:when test='matches(.,"\d+\.\d+")'>
                            <dc:subject>
                                <xsl:value-of select="normalize-space(.)"/>
                            </dc:subject>
                            <!--coverage-->
                        </xsl:when>
                        <!-- if there's no coordinate pattern, it's probably temporal data; put it in <subject><topic> -->
                        <xsl:otherwise>
                            <dc:subject>
                                <xsl:value-of select="normalize-space(.)"/>
                            </dc:subject>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <!-- if there are no numbers, it's probably geo data -->
                <xsl:otherwise>
                    <dc:coverage>
                        <xsl:value-of select="normalize-space(.)"/>
                    </dc:coverage>
                    <!--coverage-->
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:creator">
        <xsl:variable name="creatorvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:creator>
                <xsl:value-of select="normalize-space(.)"/>
                <!-- creator -->
            </dc:creator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:date">
        <xsl:variable name="datevalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:date>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:date>
            <!-- date -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:publisher">
        <xsl:variable name="publishervalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <xsl:choose>
                <xsl:when test="not(contains($publishervalue, 'Ownership'))">
                    <dc:publisher>
                        <xsl:value-of select="normalize-space(.)"/>
                    </dc:publisher>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            <!--publisher-->
        </xsl:if>
    </xsl:template>


    <xsl:template match="dc:description">
        <xsl:if test="normalize-space(.)!=''">
            <dc:description>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:description>
            <!-- description -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:format">
        <xsl:variable name="formatvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:format>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:format>
            <!-- format -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:language">
        <xsl:variable name="languagevalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:language>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:language>
            <!-- language -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:rights">
        <xsl:variable name="rightsvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:rights>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:rights>
            <!-- rights -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:subject">
        <xsl:variable name="subjectvalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:subject>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:subject>
            <!-- subject -->
        </xsl:if>
    </xsl:template>

    <xsl:template match="dc:type">
        <xsl:variable name="typevalue" select="normalize-space(.)"/>
        <xsl:if test="normalize-space(.)!=''">
            <dc:type>
                <xsl:value-of select="normalize-space(.)"/>
            </dc:type>
            <!-- type -->
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
