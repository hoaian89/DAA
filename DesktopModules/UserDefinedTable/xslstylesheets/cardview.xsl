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
  <xsl:output method="xml" version="1.0"  indent="yes" omit-xml-declaration="yes" />
  <xsl:template match="/udt:UserDefinedTable">
    <xsl:variable name ="imgColumn" select="//udt:Fields[udt:FieldType='Image'][1]/udt:ValueColumn"/>
    <xsl:variable name ="titleColumn" select="//udt:Fields[udt:FieldType='String'][1]/udt:ValueColumn"/>
    <xsl:variable name ="htmlColumn" select="//udt:Fields[udt:FieldType='TextHtml'][1]/udt:ValueColumn"/>

    <!-- Sorting Support-->
    <xsl:variable name="OrderBy">
      <xsl:choose>
        <xsl:when test ="//udt:Fields[udt:UserDefinedFieldId=//udt:Context/udt:OrderBy]/udt:SortColumn">
          <xsl:value-of select ="//udt:Fields[udt:UserDefinedFieldId=//udt:Context/udt:OrderBy]/udt:SortColumn"/>
        </xsl:when>
        <xsl:otherwise>UserDefinedRowId</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="OrderDirection">
      <xsl:choose>
        <xsl:when test ="//udt:Context/udt:OrderDirection">
          <xsl:value-of select ="//udt:Context/udt:OrderDirection"/>
        </xsl:when>
        <xsl:otherwise>ascending</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="OrderType">
      <xsl:variable name ="DataType" select ="//udt:Fields[udt:UserDefinedFieldId=//udt:Context/udt:OrderBy]/udt:FieldType"/>
      <xsl:choose>
        <xsl:when test="$DataType='Int32' or $DataType='Decimal' or $DataType='Currency'">number</xsl:when>
        <xsl:otherwise>text</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="udt:Data">
      <table cellspacing="0" cellpadding="4"  border="0"  style="border-width:0px;border-collapse:collapse;">
        <xsl:for-each select="udt:Data">
          <!--Sorting-->
          <xsl:sort select="*[name()=$OrderBy]" order="{$OrderDirection}" data-type= "{$OrderType}"/>

          <xsl:variable name="id" select="udt:UserDefinedRowId"/>
          <tr class="Normal">
            <td valign="top" style="border-bottom: silver 1px solid;">
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
            <td valign="top" style="border-bottom: silver 1px solid;;">
              <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$id]/*[name()=$imgColumn]" disable-output-escaping="yes"/>
            </td>
            <td style="border-bottom: silver 1px solid;">
              <h2>
                <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$id]/*[name()=$titleColumn]" disable-output-escaping="yes"/>
              </h2>
              <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$id]/*[name()=$htmlColumn]" disable-output-escaping="yes"/>
              <table cellspacing="0" cellpadding="0" border="0">
                <xsl:for-each select="//udt:Fields">
                  <xsl:variable name="NameOfValueColumn" select="udt:ValueColumn"/>
                  <xsl:variable name="CurrentValue" select="//udt:Data[udt:UserDefinedRowId=$id]/*[name()=$NameOfValueColumn]"/>
                  <xsl:if test ="$CurrentValue and $CurrentValue!='' and ($NameOfValueColumn!=$imgColumn or not($imgColumn)) and ($NameOfValueColumn!=$titleColumn  or not($titleColumn)) and ($NameOfValueColumn!=$htmlColumn  or not($htmlColumn))and (udt:Visible='true' or udt:Visible='True')" >
                    <tr class="Normal">
                      <td>
                        <xsl:value-of select ="udt:FieldTitle"/>:
                      </td>
                      <td>&#160;</td>
                      <td>
                        <xsl:value-of select="$CurrentValue" disable-output-escaping="yes"/>
                      </td>
                    </tr>
                  </xsl:if>
                </xsl:for-each>
                <tr>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              </table>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>


