'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2007 by DotNetNuke Inc.
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

Namespace DotNetNuke.Modules.XML
    Public Module Definition
        Public Const PathOfModule As String = "/DesktopModules/XML/"
        Public Const XmlParameter As String = "URL"
        Public Const XslParameter As String = "XSL"

        ''' <summary>
        ''' Converts a string representation of a <see cref="IndexRun"/> to its object value.
        ''' </summary>
        ''' <param name="value">Value to convert.</param>
        Public Function ParseIndexRun(ByVal value As String) As IndexRun
            Dim objType As IndexRun
            Try
                objType = CType([Enum].Parse(objType.GetType(), value), IndexRun)
            Catch ex As Exception
                objType = IndexRun.never
            End Try
            Return objType
        End Function


        ''' <summary>
        ''' Converts the <see cref="IndexRun"/> to a string value.
        ''' </summary>
        Public Function ConvertIndexRunToString(ByVal value As IndexRun) As String
            Return [Enum].GetName(value.GetType(), value)
        End Function
    End Module

    Public Class Setting
        Public Const SourceUrl As String = "XML_XmlSourceUrl"
        Public Const SourceAccount As String = "XML_XmlSourceAccount"
        Public Const SourcePassWord As String = "XML_XmlSourcePassword"
        Public Const TransUrl As String = "XML_XslTrans"
        Public Const ContentType As String = "XML_ContentType"
        Public Const RenderTo As String = "XML_RenderTo"
        Public Const IndexRun As String = "XML_IndexRun"
        Public Const LastIndexRun As String = "XML_LastIndexRun"
        Public Const EnableParam As String = "XML_EnableParam"
        Public Const EnableValue As String = "XML_EnableValue"
        Public Const UrlEncoding As String = "XML_UrlEncoding"
    End Class

    Public Class Portable
        Public Const ModuleElement As String = "xmlModule"
        Public Const SettingsElement As String = "settings"
        Public Const SettingElement As String = "setting"
        Public Const ParamElement As String = "param"
        Public Const NameAttribute As String = "name"
        Public Const TypeAttribute As String = "type"
        Public Const ArgAttribute As String = "arg"
        Public Const ValueAttribute As String = "value"
        Public Const ValueRequiredAttribute As String = "required"
    End Class

    Public Enum IndexRun
        Never
        NextRun
        Always
        OncePerHour
        OncePerDay
    End Enum

    Public Enum ShowMode
        Inline
        Link
        Response
        Disabled
    End Enum
End Namespace


