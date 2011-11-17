<?xml version="1.0" encoding="UTF-8" ?>
<!--
 DotNetNuke® - http://www.dotnetnuke.com
 Copyright (c) 2002-2007 by DotNetNuke Corp.

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
  <xsl:output method="xml" version="1.0" indent="yes" omit-xml-declaration="yes" />

  <!--
  *******************************
  Global variables and parameters
  *******************************
  -->
  
  <!--(querystring udt_) parameter-->
  <xsl:param name="param_search" />
  <xsl:param name="param_searchpostback" />
  <xsl:param name="param_ispostback" />
  <xsl:param name="param_page" select="1"  />
  <xsl:param name="param_detail" />
  <xsl:param name="param_orderby" select="//udt:Fields[udt:UserDefinedFieldId=//udt:Context/udt:OrderBy]/udt:SortColumn"/>
  <xsl:param name="param_direction" select="//udt:Context/udt:OrderDirection"/>
  <xsl:variable name="paging" select="//udt:Context/udt:Paging" />
  
  <!--
  This prefix is used to generate module specific query strings
  Each querystring or form value that starts with udt_{ModuleId}_param 
  will be added as parameter starting with param
  -->
  <xsl:variable name="prefix_param">udt_<xsl:value-of select="//udt:Context/udt:ModuleId"/>_param</xsl:variable>

  <!--wrong string would break stylesheet, so fallback to ascending if userinput is wrong-->
  <xsl:variable name="orderDirection">
    <xsl:choose>
      <xsl:when test="$param_direction='descending'">
        <xsl:text>descending</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>ascending</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="orderType">
    <xsl:variable name="DataType" select="//udt:Fields[udt:SortColumn=$param_orderby]/udt:FieldType" />
    <xsl:choose>
      <xsl:when test="$DataType='Int32' or $DataType='Decimal' or $DataType='Currency'">number</xsl:when>
      <xsl:otherwise>text</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!--search-->
  <xsl:variable name="search">
    <xsl:choose>
      <xsl:when test="$param_ispostback">
        <xsl:value-of select="$param_searchpostback" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$param_search" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template name="sortingArrow">
    <img src="{//udt:Context/udt:ApplicationPath}/images/sort{$orderDirection}.gif" border="0" />
  </xsl:template>
  
  <xsl:template name="searchForm">
  <!--XSL Search is not needed anymore. If you want it back, remove the comments. -->
  <!--  <input type="text" name="{$prefix_param}_searchpostback" value="{$search}" />
    <input type="submit" name="go" value="{//udt:Context/udt:LocalizedString_Search}" />
    <input type="hidden" name="{$prefix_param}_ispostback" value="true" />-->
  </xsl:template>

  <xsl:template name="detailLink">
    <xsl:param name="id" />
    <a href="?{$prefix_param}_detail={$id}">
      <img border="0" alt="detail" src="{//udt:Context/udt:ApplicationPath}/images/view.gif" />
    </a>
  </xsl:template>

  <xsl:template name="editLink">
    <xsl:if test="udt:Data[udt:UserDefinedRowId=$param_detail]/udt:EditLink">
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="udt:Data[udt:UserDefinedRowId=$param_detail]/udt:EditLink" />
        </xsl:attribute>
        <img border="0" alt="edit">
          <xsl:attribute name="src">
            <xsl:value-of select="//udt:Context/udt:ApplicationPath" />/images/edit.gif
          </xsl:attribute>
        </img>
      </a>
    </xsl:if>
  </xsl:template>

  <xsl:template name="backLink">
    <a href="{//udt:Context/udt:ApplicationPath}/tabid/{//udt:Context/udt:TabId}/Default.aspx">
      <img border="0" alt="Back" src="{//udt:Context/udt:ApplicationPath}/images/lt.gif" />
    </a>
  </xsl:template>

  <xsl:template name="detailView">
    <table class="Normal">
      <tr>
        <td>
          <xsl:call-template name="backLink" />
          <xsl:call-template name="editLink" />
        </td>
      </tr>
      <xsl:for-each select="udt:Fields">
        <xsl:if test="udt:FieldType!='ChangedAt' and udt:FieldType!='ChangedBy' and udt:FieldType!='CreatedAt' and udt:FieldType!='CreatedBy'">
          <xsl:variable name="NameOfValueColumn" select="udt:ValueColumn" />
          <xsl:if test="//udt:Data[udt:UserDefinedRowId=$param_detail]/*[name()=$NameOfValueColumn]!=''">
            <tr>
              <th class="NormalBold UDT_Table_Head" align="left">
                <xsl:value-of select="udt:FieldTitle" />:
              </th>
              <td>
                <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$param_detail]/*[name()=$NameOfValueColumn]" disable-output-escaping="yes" />
              </td>
            </tr>
          </xsl:if>
        </xsl:if>
      </xsl:for-each>
    </table>
    <hr color="orange" />
    <table style="font-size:smaller;width:100%;align:center">
      <tr>
        <th class="NormalBold UDT_Table_Head" style="font-size:smaller;">
          <xsl:value-of select="//udt:Fields[udt:FieldType='ChangedAt']/udt:FieldTitle" />:
        </th>
        <td class="Normal" style="font-size:smaller;">
          <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$param_detail]/*[name()=//udt:Fields[udt:FieldType='ChangedAt']/udt:ValueColumn]" disable-output-escaping="yes" />
        </td>
        <th class="NormalBold UDT_Table_Head" style="font-size:smaller;">
          <xsl:value-of select="//udt:Fields[udt:FieldType='ChangedBy']/udt:FieldTitle" />:
        </th>
        <td class="Normal" style="font-size:smaller;">
          <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$param_detail]/*[name()=//udt:Fields[udt:FieldType='ChangedBy']/udt:ValueColumn]" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <th class="NormalBold UDT_Table_Head" style="font-size:smaller;">
          <xsl:value-of select="//udt:Fields[udt:FieldType='CreatedAt']/udt:FieldTitle" />:
        </th>
        <td class="Normal" style="font-size:smaller;">
          <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$param_detail]/*[name()=//udt:Fields[udt:FieldType='CreatedAt']/udt:ValueColumn]" disable-output-escaping="yes" />
        </td>
        <th class="NormalBold UDT_Table_Head" style="font-size:smaller;">
          <xsl:value-of select="//udt:Fields[udt:FieldType='CreatedBy']/udt:FieldTitle" />:
        </th>
        <td class="Normal" style="font-size:smaller;">
          <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$param_detail]/*[name()=//udt:Fields[udt:FieldType='CreatedBy']/udt:ValueColumn]" disable-output-escaping="yes" />
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="/udt:UserDefinedTable">
    <xsl:choose>
      <xsl:when test="$param_detail">
        <xsl:call-template name="detailView" />
      </xsl:when>
      <xsl:otherwise>
        <!-- Sorting Support-->

        <xsl:variable name="columncount" select="count(udt:Fields[udt:Visible='true']/udt:FieldTitle)+1" />
        <xsl:variable name="searchColumns" select="//udt:Fields[udt:Searchable='true']/udt:ValueColumn" />
        <xsl:variable name="filteredData" select="udt:Data[contains(*[name()=$searchColumns][1],$search) or contains(*[name()=$searchColumns][2],$search) or contains(*[name()=$searchColumns][3],$search) or contains(*[name()=$searchColumns][4],$search) or contains(*[name()=$searchColumns][5],$search)or contains(*[name()=$searchColumns][6],$search)or contains(*[name()=$searchColumns][7],$search)or contains(*[name()=$searchColumns][8],$search)or contains(*[name()=$searchColumns][9],$search)or contains(*[name()=$searchColumns][10],$search)]" />


        <xsl:variable name="from">
          <xsl:choose>
            <xsl:when test="$paging">
              <xsl:value-of select="$paging * number($param_page) - $paging" />
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:variable name="to">
          <xsl:choose>
            <xsl:when test="$paging">
              <xsl:value-of select="$paging * number($param_page) +1" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="count($filteredData)+1" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:if test="udt:Data">
          <table cellspacing="0" cellpadding="4" border="0" style="border-width:0px;border-collapse:collapse;">
            <xsl:if test ="//udt:Fields[udt:Searchable='true']">
              <tr>
                <td colspan="{$columncount}" align="left">
                  <xsl:call-template name="searchForm" />
                </td>
              </tr>
            </xsl:if>
            <tr class="NormalBold UDT_Table_Head">
              <th />
              <xsl:for-each select="udt:Fields">

                <xsl:if test="udt:Visible='true' or udt:Visible='True'">
                  <td class="NormalBold UDT_Table_Head">
                    <xsl:variable name="currentDirection">
                      <xsl:choose>
                        <xsl:when test="$orderDirection='ascending' and $orderDirection='ascending'">
                          <xsl:text>descending</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>ascending</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>
                    <a href="?{$prefix_param}_search={$search}&amp;{$prefix_param}_orderby={udt:ValueColumn}&amp;{$prefix_param}_direction={$currentDirection}">
                      <!--flipped order direction-->
                      <xsl:value-of select ="udt:FieldTitle"/>
                      <xsl:if test="udt:ValueColumn=$param_orderby">
                        <xsl:call-template name="sortingArrow" />
                      </xsl:if>
                    </a>
                  </td>
                </xsl:if>
              </xsl:for-each>
            </tr>

            <xsl:for-each select="$filteredData">
              <!--Sorting-->
              <xsl:sort select="*[name()=$param_orderby]" order="{$orderDirection}" data-type="{$orderType}" />
              <xsl:if test="position() &gt; $from and position() &lt; $to">
                <xsl:variable name="id" select="udt:UserDefinedRowId" />
                <tr>
                  <xsl:attribute name="class">
                    <xsl:choose>
                      <xsl:when test="position() mod 2=1">
                        Normal UDT_Table_AlternateItem
                      </xsl:when>
                      <xsl:otherwise>
                        Normal UDT_Table_Item
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <td>
                    <xsl:call-template name="detailLink">
                      <xsl:with-param name="id" select="udt:UserDefinedRowId" />
                    </xsl:call-template>
                  </td>
                  <xsl:for-each select="//udt:Fields">
                    <xsl:if test="udt:Visible='true' or udt:Visible='True'">
                      <td>
                        <xsl:variable name="NameOfValueColumn" select="udt:ValueColumn" />
                        <xsl:value-of select="//udt:Data[udt:UserDefinedRowId=$id]/*[name()=$NameOfValueColumn]" disable-output-escaping="yes" />
                      </td>
                    </xsl:if>
                  </xsl:for-each>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>
        </xsl:if >
        <xsl:if test="$paging">
          <xsl:call-template name="renderPaging">
            <xsl:with-param name="maxPages" select="ceiling(count($filteredData) div $paging)" />
          </xsl:call-template>
        </xsl:if>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="pagingSinglePages">
    <!--renders paging links-->
    <xsl:param name="pageNumber" select="1" />
    <xsl:param name="maxPages" select="ceiling(count(//udt:Data) div $paging)" />
    <xsl:choose>
      <xsl:when test="number($param_page)=$pageNumber">
        <span class="NormalDisabled">
          [<xsl:value-of select="$pageNumber" />]
        </span>
      </xsl:when>
      <xsl:otherwise>
        <a href="?{$prefix_param}_page={$pageNumber}&amp;{$prefix_param}_search={$search}&amp;{$prefix_param}_orderby={$param_orderby}&amp;{$prefix_param}_orderDirection={$orderDirection}" class="CommandButton">
          <xsl:value-of select="$pageNumber" />
        </a>
      </xsl:otherwise>
    </xsl:choose>&#160;
    <xsl:if test="$pageNumber &lt; $maxPages">
      <xsl:call-template name="pagingSinglePages">
        <xsl:with-param name="pageNumber" select="$pageNumber +1" />
        <xsl:with-param name="maxPages" select="$maxPages"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="renderPaging">
    <xsl:param name="maxPages" select="ceiling(count(//udt:Data) div $paging)" />
    <xsl:variable name="previous" select="number($param_page) - 1" />
    <xsl:variable name="next" select="number($param_page) + 1" />
    <table class="PagingTable" bordercolor="Gray" border="0" style="border-color:Gray;border-width:1px;border-style:Solid;width:100%;">
      <tr>
        <td class="Normal" align="Left">
          <xsl:value-of select ="//udt:Context/udt:LocalizedString_Page"/>&#160;<xsl:value-of select="number($param_page)"/>&#160;<xsl:value-of select ="//udt:Context/udt:LocalizedString_Of"/>&#160;<xsl:value-of select="$maxPages"/>
        </td>
        <td class="Normal" align="Right" >
          <xsl:choose>
            <xsl:when test="number($param_page)&gt;1">
              <a href="?{$prefix_param}_search={$search}&amp;{$prefix_param}_orderby={$param_orderby}&amp;{$prefix_param}_orderDirection={$orderDirection}" class="CommandButton">
                <xsl:value-of select ="//udt:Context/udt:LocalizedString_First"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <span class="NormalDisabled">
                <xsl:value-of select ="//udt:Context/udt:LocalizedString_First"/>
              </span>
            </xsl:otherwise>
          </xsl:choose>&#160;&#160;
          <xsl:choose>
            <xsl:when test="number($param_page)&gt;1">
              <a href="?{$prefix_param}_page={$previous}&amp;{$prefix_param}_search={$search}&amp;{$prefix_param}_orderby={$param_orderby}&amp;{$prefix_param}_orderDirection={$orderDirection}" class="CommandButton">
                <xsl:value-of select ="//udt:Context/udt:LocalizedString_Previous"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <span class="NormalDisabled">
                <xsl:value-of select ="//udt:Context/udt:LocalizedString_Previous"/>
              </span>
            </xsl:otherwise>
          </xsl:choose>&#160;&#160;
          <xsl:variable name ="startpage">
            <xsl:choose>
              <xsl:when test ="number($param_page)&gt;5">
                <xsl:value-of select="number($param_page) -4"/>
              </xsl:when>
              <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name ="endpage">
            <xsl:choose>
              <xsl:when test="$startpage+9&gt;$maxPages">
                <xsl:value-of select ="$maxPages"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select ="$startpage +9"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:call-template name="pagingSinglePages">
            <xsl:with-param name="pageNumber" select="$startpage"/>
            <xsl:with-param name="maxPages" select="$endpage"/>
          </xsl:call-template>
          <xsl:choose>
            <xsl:when test="number($param_page)&lt;$maxPages">
              <a href="?{$prefix_param}_page={$next}&amp;{$prefix_param}_search={$search}&amp;{$prefix_param}_orderby={$param_orderby}&amp;{$prefix_param}_orderDirection={$orderDirection}" class="CommandButton">
                <xsl:value-of select ="//udt:Context/udt:LocalizedString_Next"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <span class="NormalDisabled">
                <xsl:value-of select ="//udt:Context/udt:LocalizedString_Next"/>
              </span>
            </xsl:otherwise>
          </xsl:choose>&#160;&#160;
          <xsl:choose>
            <xsl:when test="number($param_page)&lt;$maxPages">
              <a href="?{$prefix_param}_page={$maxPages}&amp;{$prefix_param}_search={$search}&amp;{$prefix_param}_orderby={$param_orderby}&amp;{$prefix_param}_orderDirection={$orderDirection}" class="CommandButton">
                <xsl:value-of select ="//udt:Context/udt:LocalizedString_Last"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <span class="NormalDisabled">
                <xsl:value-of select ="//udt:Context/udt:LocalizedString_Last"/>
              </span>
            </xsl:otherwise>
          </xsl:choose>&#160;&#160;
        </td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>


