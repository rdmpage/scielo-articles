<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:output method='html' version='1.0' encoding='ISO-8859-1' indent='no'/>

<xsl:template match="/">

<xsl:apply-templates select="//ref-list"/>

</xsl:template>

	<!-- references -->
    <xsl:template match="ref-list">
        <ol>
            <xsl:apply-templates select="ref"/>
        </ol>
    </xsl:template>

    <!-- Reference list -->
    <xsl:template match="ref">
        <li>
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@id" />
                </xsl:attribute>
            </a>
            <xsl:apply-templates select="nlm-citation"/>
        </li>
    </xsl:template>

    <!-- authors -->
    <xsl:template match="//person-group">
        <xsl:apply-templates select="name"/>
    </xsl:template>
    
    <xsl:template match="name">
        <xsl:if test="position() != 1"><xsl:text>, </xsl:text></xsl:if>
        <xsl:value-of select="surname" />
        <xsl:text>, </xsl:text>
        <xsl:value-of select="given-names" />
    </xsl:template>

    <!-- a citation -->
    <xsl:template match="nlm-citation">
        <xsl:apply-templates select="person-group"/>
        <xsl:text> (</xsl:text><xsl:value-of select="year" /><xsl:text>) </xsl:text>

		<xsl:choose>
			<xsl:when test="article-title and source and volume">
				<xsl:value-of select="article-title" />
				<xsl:text>. </xsl:text>							<i><xsl:value-of select="source" /></i>
				<xsl:text> </xsl:text>
				<xsl:value-of select="volume" />
				<xsl:text>:</xsl:text>

				<xsl:value-of select="page-range" />

				<!--
				<xsl:value-of select="fpage" />
				<xsl:text>-</xsl:text>
				<xsl:value-of select="lpage" />
				-->

			</xsl:when>

			<xsl:otherwise>
				<xsl:value-of select="source" />			</xsl:otherwise>
		</xsl:choose>

				<!-- identifiers -->
				<xsl:for-each select="ext-link">
					<xsl:choose>
						<xsl:when test="@ext-link-type='uri'">
							<xsl:value-of select="." />
						</xsl:when>
						<xsl:otherwise>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
</xsl:template>



</xsl:stylesheet>