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
Imports DotNetNuke.Entities.Portals
Imports System.Web
Imports System.Threading
Imports System.IO


Namespace DotNetNuke.Modules.XML
    Public MustInherit Class ControllerBase
        Private _moduleSettings As Hashtable
        Private _moduleId As Integer
        Private _portalId As Integer
        Private _portalInfo As DotNetNuke.Entities.Portals.PortalInfo

        Public ReadOnly Property Settings() As Hashtable
            Get
                If Not _moduleSettings Is Nothing Then
                    Return _moduleSettings
                Else
                    Return PortalSettings.GetModuleSettings(ModuleID)
                End If

            End Get
        End Property


        Private ReadOnly Property PortalSettings() As Entities.Portals.PortalSettings
            Get
                Return PortalController.GetCurrentPortalSettings()
            End Get
        End Property

        Public ReadOnly Property PortalInfo() As DotNetNuke.Entities.Portals.PortalInfo
            Get
                If _portalInfo Is Nothing Then
                    _portalInfo = New PortalController().GetPortal(PortalId)
                End If
                Return _portalInfo
            End Get

        End Property

        Protected Property ModuleID() As Integer
            Get
                Return _moduleId
            End Get
            Set(ByVal Value As Integer)
                _moduleId = Value
            End Set
        End Property


        Protected Property PortalId() As Integer
            Get
                Return _portalId
            End Get
            Set(ByVal value As Integer)
                _portalId = value
            End Set
        End Property

        Protected Function GetMappedPath(ByVal localPath As String) As String
            If Not (HttpContext.Current Is Nothing) Then
                Return PortalSettings.HomeDirectoryMapPath + localPath
            Else
                Return System.Threading.Thread.GetDomain.GetData(".appPath") _
                                 + PortalInfo.HomeDirectory + "\" + localPath
            End If

        End Function

        Protected ReadOnly Property AdministratorId() As String
            Get
                If Not (HttpContext.Current Is Nothing) Then
                    Return PortalSettings.AdministratorId
                Else
                    Return PortalInfo.AdministratorId
                End If
            End Get
        End Property


        Public Sub Initialise(ByVal parent As DotNetNuke.Entities.Modules.PortalModuleBase)
            _moduleSettings = parent.Settings
            ModuleID = parent.ModuleId
            PortalId = parent.PortalId
        End Sub

        Public Sub Initialise(ByVal ModuleInfo As DotNetNuke.Entities.Modules.ModuleInfo)
            ModuleID = ModuleInfo.ModuleID
            PortalId = ModuleInfo.PortalID
        End Sub


       

    End Class
End Namespace

