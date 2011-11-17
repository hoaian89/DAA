<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
  <div>
	<div class="news_item_c1">
		<a>
			<xsl:attribute name="href">
			<xsl:value-of select="News/MainNews/Link"></xsl:value-of>
			</xsl:attribute>
			<img border="0" width="100" height="100">
			<xsl:attribute name="src">
			  <xsl:value-of select="News/MainNews/ImageUrl"></xsl:value-of>
			</xsl:attribute>
			</img>	
		</a>		
	</div>    		          
	<div class="news_item_c2">
		<a>
			<xsl:attribute name="href">
			<xsl:value-of select="News/MainNews/Link"></xsl:value-of>
			</xsl:attribute>
			<b>
				<xsl:value-of select="News/MainNews/HeadLine"></xsl:value-of>
			</b>
		</a>
		<br/>
		<xsl:value-of select="News/MainNews/Description"/>
		</div>
	</div>
	<div class="clearb">
		<xsl:for-each select="News/Others/AnotherNews">		
			<a>
				<xsl:attribute name="href">
				<xsl:value-of select="Link"></xsl:value-of>
				</xsl:attribute>
				<b>
				<xsl:value-of select="HeadLine"></xsl:value-of>
				</b>		
			</a>
			<br/>			
		</xsl:for-each>
	</div>	  
  </xsl:template>
</xsl:stylesheet>
