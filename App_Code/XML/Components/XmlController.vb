'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2007 by DotNetNuke Inc.
'
'
' Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
' documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
' the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
' to permit persons to whom the Software is furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all copies or substantial portions 
' of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
' DEALINGS IN THE SOFTWARE.
'
Imports DotNetNuke
Imports DotNetNuke.Common
Imports DotNetNuke.Services.Search
Imports System
Imports System.IO
Imports system.Xml
Imports system.Xml.Xsl
Imports System.Xml.XPath


Namespace DotNetNuke.Modules.XML
    Public Class XmlController
        Inherits ControllerBase
        Implements Entities.Modules.IPortable
        Implements Entities.Modules.ISearchable

#Region "| Constructors |"
        Public Sub New(ByVal ModuleInfo As Entities.Modules.ModuleInfo)
            Initialise(ModuleInfo)
        End Sub


        Public Sub New(ByVal parent As Entities.Modules.PortalModuleBase)
            Initialise(parent)
        End Sub

        Public Sub New()
            ' needed for ISearchale and IPortable
        End Sub
#End Region

#Region "| Properties |"


        ''' <summary>
        ''' Accesses the Xml Source as XmlReader
        ''' </summary>
        ''' <remarks>
        ''' The xml source is retrieved from a file or an extern resource.
        ''' If it fails, a default &lt;noData&gt; is returned.
        ''' </remarks>
        Protected ReadOnly Property XmlSource() As XmlReader
            Get
                Dim xmlsrc As String = CStrN(Settings(Setting.SourceUrl))
                If xmlsrc <> "" Then
                    Try
                        If GetURLType(xmlsrc) = Entities.Tabs.TabType.Url Then
                            Dim ParamList As ParameterList = New ParameterController(XmlParameter).GetParameters(ModuleID)
                            ParamList.Encoding = GetQueryStringEncoding()
                            If ParamList.IsValid Then
                                xmlsrc += IIf(xmlsrc.IndexOf("?") = -1, "?", "&").ToString() + ParamList.ToString
                                Return Utils.GetXMLContent(xmlsrc, CStrN(Settings(Setting.SourceAccount)), CStrN(Settings(Setting.SourcePassWord)))
                            Else
                                Dim x As New XmlDocument
                                x.LoadXml("<noData cause=""Parameters""/>")
                                Return New XmlNodeReader(x.ParentNode)
                            End If
                        Else
                            'Dim doc As New XPathDocument(Request.MapPath(PortalSettings.HomeDirectory & xmlsrc))
                            Return XmlReader.Create(GetMappedPath(xmlsrc), XmlReaderSettingsWithoutValidation)
                        End If
                    Catch ex As System.Security.SecurityException
                        Throw
                    Catch ex As Exception
                        Dim x As New XmlDocument
                        x.LoadXml("<noData cause=""Exception"" message=""" & ex.Message & """/>")
                        Return New XmlNodeReader(x)
                    End Try
                End If
                Return Nothing
            End Get
        End Property

        ''' <summary>
        ''' Loads the stylesheet into the transform engine
        ''' </summary>
        Protected Function GetXslTransform() As XslCompiledTransform
            Dim xslsrc As String = CStrN(Settings(Setting.TransUrl))
            If xslsrc <> "" Then
                If GetURLType(xslsrc) = Entities.Tabs.TabType.Url Then
                    Return Utils.GetXSLContent(xslsrc)
                Else
                    Dim trans As New XslCompiledTransform

                    trans.Load(GetMappedPath(xslsrc))
                    Return trans
                End If
            End If
            Return Nothing
        End Function

        ''' <summary>
        ''' returns the defined Xsl parameter
        ''' </summary>
        Protected ReadOnly Property TransformArgumentList() As XsltArgumentList
            Get
                Return New ParameterController(XslParameter).GetParameters(ModuleID).ToXsltArgumentList
            End Get
        End Property

        ''' <summary>
        ''' Returns the Content Type for the responseheader out of the settings 
        ''' </summary>
        Public ReadOnly Property ContentType() As String
            Get
                Return CStrN(Settings(Setting.ContentType), "xml|text/xml").Split("|".ToCharArray)(1)
            End Get
        End Property

        ''' <summary>
        ''' Returns a default filename for a separate download
        ''' </summary>
        Public ReadOnly Property FileName() As String
            Get
                Return "Result." & CStrN(Settings(Setting.ContentType), "xml|text/xml").Split("|".ToCharArray)(0)
            End Get
        End Property
#End Region

#Region "| Rendering |"
        ''' 
        ''' Returns the result of the XSL Transformation into a TextWriter. 
        ''' 
        Public Sub Render(ByVal output As TextWriter)
            Dim Xslt As XslCompiledTransform = GetXslTransform()
            Using Xml As XmlReader = XmlSource
                If Not Xslt Is Nothing And Not Xml Is Nothing Then
                    Xslt.Transform(Xml, TransformArgumentList, output)
                End If
            End Using
        End Sub

        ''' 
        ''' Returns the result of the XSL transformation into a Stream
        ''' 
        Public Sub Render(ByVal stream As System.IO.Stream)
            Dim Xslt As XslCompiledTransform = GetXslTransform()
            Using Xml As XmlReader = XmlSource
                If Not Xslt Is Nothing And Not Xml Is Nothing Then
                    Xslt.Transform(XmlSource, TransformArgumentList, stream)
                End If
            End Using
        End Sub
#End Region

#Region "| Other Methods |"

        ''' <summary>
        ''' Clears the indexed content of the DotNetNuke search for this module
        ''' </summary>
        Public Sub ClearSearchIndex()
            DotNetNuke.Data.DataProvider.Instance.DeleteSearchItems(ModuleID)
        End Sub


        ''' <summary>
        ''' Returns the way how the module is rendered (<see cref="ShowMode"></see>).
        ''' </summary>
        Public Function checkShowMode(ByVal Mode As String) As ShowMode

            Dim EnableParam As String = CStrN(Settings(Setting.EnableParam))
            Dim EnableValue As String = CStrN(Settings(Setting.EnableValue))
            If EnableParam.Length > 0 AndAlso EnableValue.Length > 0 _
                AndAlso CStrN(HttpContext.Current.Request.QueryString(EnableParam)) <> EnableValue Then Return ShowMode.Disabled
            If EnableParam.Length > 0 AndAlso EnableValue.Length = 0 _
                AndAlso CStrN(HttpContext.Current.Request.QueryString(EnableParam)).Length > 0 Then Return ShowMode.Disabled

            Mode = CStrN(Mode, CStrN(Settings(Setting.RenderTo), [Enum].GetName(GetType(ShowMode), ShowMode.Inline)))
            Try
                Return CType([Enum].Parse(GetType(ShowMode), Mode), ShowMode)
            Catch ex As Exception
                Return ShowMode.Inline
            End Try
        End Function

        ''' <summary>
        ''' Returns the needed <see cref="Encoding"/> for the query string parameter out of settings.
        ''' </summary>
        Private Function GetQueryStringEncoding() As Text.Encoding

            Select Case CStrN(Settings(Setting.UrlEncoding))
                Case "ASCII"
                    Return Text.Encoding.ASCII
                Case "Default"
                    Return Text.Encoding.Default
                Case Else
                    Return Text.Encoding.UTF8
            End Select
        End Function

#End Region

#Region "| Optional Interfaces |"
        ''' <summary>
        '''DotNetNuke Search support 
        ''' </summary>
        Public Function GetSearchItems(ByVal ModInfo As Entities.Modules.ModuleInfo) As Services.Search.SearchItemInfoCollection Implements Entities.Modules.ISearchable.GetSearchItems
            Me.Initialise(ModInfo)

            Dim SearchItemCollection As New SearchItemInfoCollection
            If MustAddContentToSearch() Then
                Dim sw As New System.IO.StringWriter
                Render(sw)
                sw.Flush()
                Dim Content As String = sw.ToString
                Dim now As DateTime = DateTime.Now
                SearchItemCollection.Add(New SearchItemInfo(ModInfo.ModuleTitle, Content, Me.AdministratorId, now, ModInfo.ModuleID, "", Content))
                Dim mc As New DotNetNuke.Entities.Modules.ModuleController
                mc.UpdateModuleSetting(ModuleID, Setting.LastIndexRun, DateTime.Now.ToString("s"))
            End If
            Return SearchItemCollection
        End Function

        ''' <summary>
        ''' Determines whether the module should be indexed or not. 
        ''' </summary>
        Private Function MustAddContentToSearch() As Boolean
            Dim LastRun As DateTime = DateTime.Parse(CStrN(Settings(Setting.LastIndexRun), DateTime.MinValue.ToString("s")))
            Select Case ParseIndexRun(CStrN(Settings(Setting.IndexRun), "Never"))
                Case IndexRun.Always
                    Return True
                Case IndexRun.Never
                    Return False
                Case IndexRun.NextRun
                    Dim mc As New DotNetNuke.Entities.Modules.ModuleController
                    mc.UpdateModuleSetting(ModuleID, Setting.IndexRun, ConvertIndexRunToString(IndexRun.Never))
                    Return True
                Case IndexRun.OncePerDay
                    Return LastRun.AddDays(1) < DateTime.Now
                Case IndexRun.OncePerHour
                    Return LastRun.AddHours(1) < DateTime.Now
            End Select
        End Function

        ''' <summary>
        ''' IPortable: Export
        ''' </summary>
        Public Function ExportModule(ByVal ModuleID As Integer) As String Implements DotNetNuke.Entities.Modules.IPortable.ExportModule
            'initialise Controller
            Me.ModuleID = ModuleID
            'start export
            Dim strXML As New StringWriter
            Dim Writer As XmlWriter = New XmlTextWriter(strXML)
            Writer.WriteStartElement(Portable.ModuleElement)
            Writer.WriteStartElement(Portable.SettingsElement)
            For Each item As DictionaryEntry In Settings
                Writer.WriteStartElement(Portable.SettingElement)
                Writer.WriteAttributeString(Portable.NameAttribute, CStr(item.Key))
                Writer.WriteAttributeString(Portable.ValueAttribute, CStr(item.Value))
                Writer.WriteEndElement()
            Next
            Writer.WriteEndElement()
            Dim paramDomains As String() = {XmlParameter, XslParameter}
            For Each paramDomain As String In paramDomains
                Writer.WriteStartElement(paramDomain)
                For Each param As ParameterInfo In New ParameterController(paramDomain).GetParameters(ModuleID)
                    Writer.WriteStartElement(Portable.ParamElement)
                    Writer.WriteAttributeString(Portable.NameAttribute, param.Name)
                    Writer.WriteAttributeString(Portable.TypeAttribute, param.Type)
                    If param.IsArgumentRequired Then Writer.WriteAttributeString(Portable.ArgAttribute, param.TypeArgument)
                    If param.IsValueRequired Then Writer.WriteAttributeString(Portable.ValueRequiredAttribute, "true")
                    Writer.WriteEndElement()
                Next
                Writer.WriteEndElement()
            Next
            Writer.WriteEndElement()
            Writer.Close()

            Return strXML.ToString
        End Function

        ''' <summary>
        ''' IPortable:Import
        ''' </summary>
        Public Sub ImportModule(ByVal ModuleID As Integer, ByVal Content As String, ByVal Version As String, ByVal UserID As Integer) Implements DotNetNuke.Entities.Modules.IPortable.ImportModule
            Dim node As XmlNode
            Dim nodes As XmlNode = GetContent(Content, Portable.ModuleElement)
            Dim objModules As New DotNetNuke.Entities.Modules.ModuleController
            For Each node In nodes.SelectSingleNode(Portable.SettingsElement)
                objModules.UpdateModuleSetting(ModuleID, node.Attributes(Portable.NameAttribute).Value, _
                                                         node.Attributes(Portable.ValueAttribute).Value)
            Next
            Dim paramDomains As String() = {XmlParameter, XslParameter}
            For Each paramDomain As String In paramDomains
                Dim pc As New ParameterController(paramDomain)
                For Each p As ParameterInfo In pc.GetParameters(ModuleID)
                    pc.DeleteParameter(p.Key)
                Next
                For Each node In nodes.SelectSingleNode(paramDomain)
                    Dim p As New ParameterInfo
                    p.ModuleID = ModuleID
                    p.Name = node.Attributes("name").Value
                    p.Type = node.Attributes(Portable.TypeAttribute).Value
                    If p.IsArgumentRequired Then p.TypeArgument = node.Attributes(Portable.ArgAttribute).Value
                    p.IsValueRequired = Not (node.Attributes(Portable.ValueRequiredAttribute) Is Nothing)
                    pc.AddParameter(p)
                Next
            Next
        End Sub
#End Region

    End Class
End Namespace


