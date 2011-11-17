<?xml version="1.0" encoding="UTF-8" ?>
<!--
************************************************************************************
YOU SHOULD ENABLE  E D I T  O N L Y  O W N  I T E M S !!
The rows from other users don't get displayed but someone might guess their edit URL
************************************************************************************
-->
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

    <xsl:variable name ="NameOfCurrentUser"        select ="udt:Context/udt:UserName"/>
    <xsl:variable name ="IsAdministrator"          select ="udt:Context/udt:IsAdministratorRole='true'"/>
    <xsl:variable name ="NameOfCreatedByColumn"    select="concat(udt:Fields[udt:FieldType='CreatedBy']/udt:ValueColumn, '_UDT_Original')"/>

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
    <xsl:if test ="udt:Data[*[name()=$NameOfCreatedByColumn]=$NameOfCurrentUser or $IsAdministrator]">
      <table cellspacing="0" cellpadding="4"  border="0"  style="border-width:0px;border-collapse:collapse;">
        <tr class="NormalBold UDT_Table_Head">
          <th/>
          <xsl:for-each select="//udt:Fields[(udt:FieldType!='CreatedBy' and udt:Visible='true') 
                                      or (udt:FieldType='CreatedBy' and $IsAdministrator)]">
            <th>
              <xsl:value-of select ="udt:FieldTitle"/>
            </th>
          </xsl:for-each>
        </tr>
        <xsl:for-each select="udt:Data[*[name()=$NameOfCreatedByColumn]=$NameOfCurrentUser or $IsAdministrator]">
          <!--Sorting-->
          <xsl:sort select="*[name()=$OrderBy]" order="{$OrderDirection}" data-type= "{$OrderType}"/>

          <xsl:variable name="id" select="udt:UserDefinedRowId"/>
          <tr >
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="position() mod 2 = 1">
                  <xsl:text>Normal UDT_Table_AlternateItem</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>Normal UDT_Table_Item</xsl:text>
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
            <xsl:for-each select="//udt:Fields[(udt:FieldType!='CreatedBy' and udt:Visible='true') 
                                      or (udt:FieldType='CreatedBy' and $IsAdministrator)]">
              <td>
                <xsl:variable name="NameOfValueColumn" select="udt:ValueColumn"/>
                <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$id]/*[name()=$NameOfValueColumn]" disable-output-escaping="yes"/>
              </td>
            </xsl:for-each>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>