<?xml version="1.0" encoding="UTF-8" ?>
<!--
 DotNetNuke® - http://www.dotnetnuke.com
 Copyright (c) 2002-2006 by DotNetNuke Corp.

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
 documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
 the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
 to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions 
 of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
 TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
 THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
 CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
 DEALINGS IN THE SOFTWARE.
-->
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:udt="DotNetNuke/UserDefinedTable" exclude-result-prefixes ="udt">
  <xsl:output method="xml" version="1.0"  indent="yes" omit-xml-declaration="yes"/>
  <xsl:template match="/udt:UserDefinedTable">
    <xsl:if test="udt:Data">
      <table cellspacing="0" cellpadding="4" border="0"  style="border-width:0px;border-collapse:collapse;">
        <tr class="NormalBold UDT_Table_Head">
          <th/>
          <xsl:for-each select="udt:Fields">
            <xsl:if test="udt:Visible='true' or udt:Visible='True'">
              <th>
                <xsl:value-of select ="udt:FieldTitle"/>
              </th>
            </xsl:if>
          </xsl:for-each>
        </tr>
        <xsl:for-each select="udt:Data">
          <xsl:variable name="id" select="udt:UserDefinedRowId"/>
          <tr >
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="position() mod 2 = 1">
                  Normal UDT_Table_AlternateItem
                </xsl:when>
                <xsl:otherwise>
                  Normal UDT_Table_Item
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <td>
              <xsl:if test="udt:EditLink">
                <a>
                  <xsl:attribute name="href">
                    <xsl:value-of select="udt:EditLink" />
                  </xsl:attribute>
                  <img border="0" alt="edit">
                    <xsl:attribute name="src">
                      <xsl:value-of select="//udt:Context/udt:ApplicationPath"/>/images/edit.gif
                    </xsl:attribute>
                  </img>
                </a>
              </xsl:if>
            </td>
            <xsl:for-each select="//udt:Fields">
              <xsl:if test="udt:Visible='true' or udt:Visible='True'">
                <td>
                  <xsl:variable name="NameOfValueColumn" select="udt:ValueColumn"/>
                  <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$id]/*[name()=$NameOfValueColumn]" disable-output-escaping="yes"/>
                </td>
              </xsl:if>
            </xsl:for-each>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:if >
  </xsl:template>

</xsl:stylesheet>


