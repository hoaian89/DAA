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
Imports System.IO
Imports System.XML
Imports System.Xml.Serialization
Imports System.Net
Imports DotNetNuke.Common


Namespace DotNetNuke.Modules.XML
    Public Module Utils

        ''' <summary>
        ''' GetXMLContent loads the xml content from a web resource into an XmlReader. 
        ''' </summary>
        ''' <param name="ContentUrl"></param>
        ''' <param name="username"></param>
        ''' <param name="password"></param>
        ''' <returns>A Xml Reader</returns>
        Public Function GetXMLContent(ByVal ContentUrl As String, ByVal username As String, ByVal password As String) As XmlReader

            Dim req As WebRequest
            If username & password = String.Empty Then
                req = GetExternalRequest(ContentUrl)   'WebRequest.Create(ContentUrl)
            Else
                req = GetExternalRequest(ContentUrl, New NetworkCredential(username, password))
            End If

            Dim result As WebResponse = req.GetResponse()
            Dim ReceiveStream As Stream = result.GetResponseStream()

            Return XmlReader.Create(result.GetResponseStream(), XmlReaderSettingsWithoutValidation)
        End Function

        Public Function XmlReaderSettingsWithoutValidation() As XmlReaderSettings
            Dim settings As New XmlReaderSettings()
            settings.ProhibitDtd = False
            settings.ValidationType = ValidationType.None
            Return settings
        End Function

        ''' <summary>
        ''' GetXSLContent loads the xsl content into an Xsl.XslCompiledTransform
        ''' </summary>
        ''' <param name="ContentUrl">The url to the xsl text</param>
        ''' <returns>A XslCompiledTransform</returns>
        Public Function GetXSLContent(ByVal ContentURL As String) As Xsl.XslCompiledTransform

            GetXSLContent = New Xsl.XslCompiledTransform
            Dim req As WebRequest = GetExternalRequest(ContentURL)
            Dim result As WebResponse = req.GetResponse()
            Dim ReceiveStream As Stream = result.GetResponseStream()
            Dim objXSLTransform As XmlReader = New XmlTextReader(result.GetResponseStream)
            GetXSLContent.Load(objXSLTransform, Nothing, Nothing)

        End Function

        ''' <summary>
        ''' Returns the value as string if the object isn't null or empty. Otherwise it is replaced by the default string
        ''' </summary>
        ''' <param name="value"></param>
        ''' <param name="default"></param>
        ''' <returns></returns>
        ''' <remarks>Thanks to Markus Hamburger, UDT</remarks>
        Public Function CStrN(ByVal value As Object, Optional ByVal [default] As String = "") As String
            If value Is Nothing Then Return [default]
            If value Is DBNull.Value Then Return [default]
            If CStr(value) = "" Then Return [default]
            Return CStr(value)
        End Function

        ''' <summary>
        ''' determines whether the current Security grants the need permissions to connect to the url 
        ''' </summary>
        ''' <param name="url"></param>
        ''' <returns></returns>
        ''' <remarks>Helpful in Medium Trust environment.</remarks>
        Public Function CheckWebPermission(ByVal url As String) As Boolean
            Return System.Security.SecurityManager.IsGranted(New WebPermission(NetworkAccess.Connect, url))
        End Function
    End Module
End Namespace

