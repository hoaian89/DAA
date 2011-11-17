'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2006 by DotNetNuke Corp.
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
Option Strict On
Option Explicit On

Imports DotNetNuke
Imports DotNetNuke.Security
Imports System.Web
Imports System.Web.UI.WebControls
Imports System.Web.UI


Namespace DotNetNuke.Modules.XML

    Public Class Download
        Implements System.Web.IHttpHandler

        Private Sub RenderToResponseStream(ByVal Response As System.Web.HttpResponse, ByVal controller As XmlController)
            ' save script timeout
            Dim scriptTimeOut As Integer = HttpContext.Current.Server.ScriptTimeout
            ' temporarily set script timeout to large value ( this value is only applicable when application is not running in Debug mode )
            HttpContext.Current.Server.ScriptTimeout = Integer.MaxValue
            Response.ContentType = controller.ContentType
            Response.AppendHeader("content-disposition", "inline; filename=" & controller.FileName)
            controller.Render(Response.OutputStream)
            Response.Flush()
            ' reset script timeout
            HttpContext.Current.Server.ScriptTimeout = scriptTimeOut
        End Sub
#Region " WebHandler "
        Public ReadOnly Property IsReusable() As Boolean Implements System.Web.IHttpHandler.IsReusable
            Get
                Return True
            End Get
        End Property

        Public Sub ProcessRequest(ByVal context As System.Web.HttpContext) Implements System.Web.IHttpHandler.ProcessRequest
            Try
                handleAuthenticateRequest(context)

                Dim portalSettings As Entities.Portals.PortalSettings = Entities.Portals.PortalController.GetCurrentPortalSettings

                If context.Request.QueryString("tabid") Is Nothing OrElse context.Request.QueryString("mid") Is Nothing Then Return
                ' get TabId
                Dim TabId As Integer = -1
                If Not IsNothing(context.Request.QueryString("tabid")) Then
                    TabId = Int32.Parse(context.Request.QueryString("tabid"))
                End If

                ' get ModuleId
                Dim ModuleId As Integer = -1
                If Not IsNothing(context.Request.QueryString("mid")) Then
                    ModuleId = Int32.Parse(context.Request.QueryString("mid"))
                End If

                Dim userInfo As UserInfo
                userInfo = UserController.GetCurrentUserInfo()

                Dim settings As Hashtable = portalSettings.GetModuleSettings(ModuleId)
                Dim moduleInfo As Entities.Modules.ModuleInfo = New Entities.Modules.ModuleController().GetModule(ModuleId, TabId)

                If PortalSecurity.IsInRoles(moduleInfo.AuthorizedViewRoles) OrElse PortalSecurity.IsInRoles(portalSettings.AdministratorRoleName) OrElse (Not (userInfo Is Nothing) AndAlso userInfo.IsSuperUser) Then
                    RenderToResponseStream(context.Response, New XmlController(moduleInfo))
                End If
            Catch ex As Exception
                context.Response.Write("Not defined")
            End Try

        End Sub
#End Region

#Region "| Copy from DNNMemberShip  (Workaraound) |"
        Private Sub handleAuthenticateRequest(ByVal context As System.Web.HttpContext)

            Dim Request As HttpRequest = context.Request
            Dim Response As HttpResponse = context.Response

            'runonly when DnnMemberShip did not run before
            If Not context Is Nothing AndAlso Request.IsAuthenticated AndAlso HttpContext.Current.Items("UserInfo") Is Nothing Then


                ' Obtain PortalSettings from Current Context
                Dim _portalSettings As Entities.Portals.PortalSettings = Entities.Portals.PortalController.GetCurrentPortalSettings

                If Request.IsAuthenticated = True And Not _portalSettings Is Nothing Then
                    Dim arrPortalRoles() As String
                    Dim objRoleController As New DotNetNuke.Security.Roles.RoleController

                    Dim objUser As UserInfo = UserController.GetCachedUser(_portalSettings.PortalId, context.User.Identity.Name)

                    If Not Request.Cookies("portalaliasid") Is Nothing Then
                        Dim PortalCookie As System.Web.Security.FormsAuthenticationTicket = System.Web.Security.FormsAuthentication.Decrypt(context.Request.Cookies("portalaliasid").Value)
                        ' check if user has switched portals
                        If _portalSettings.PortalAlias.PortalAliasID <> Int32.Parse(PortalCookie.UserData) Then
                            ' expire cookies if portal has changed
                            Response.Cookies("portalaliasid").Value = Nothing
                            Response.Cookies("portalaliasid").Path = "/"
                            Response.Cookies("portalaliasid").Expires = DateTime.Now.AddYears(-30)

                            Response.Cookies("portalroles").Value = Nothing
                            Response.Cookies("portalroles").Path = "/"
                            Response.Cookies("portalroles").Expires = DateTime.Now.AddYears(-30)
                        End If
                    End If

                    ' authenticate user and set last login ( this is necessary for users who have a permanent Auth cookie set ) 
                    If objUser Is Nothing OrElse objUser.Membership.LockedOut = True OrElse objUser.Membership.Approved = False Then
                        Dim objPortalSecurity As New PortalSecurity
                        objPortalSecurity.SignOut()
                        ' Redirect browser back to home page
                        Response.Redirect(Request.RawUrl, True)
                        Exit Sub
                    Else    ' valid Auth cookie
                        ' create cookies if they do not exist yet for this session.
                        If Request.Cookies("portalroles") Is Nothing Then
                            ' keep cookies in sync
                            Dim CurrentDateTime As Date = DateTime.Now

                            ' create a cookie authentication ticket ( version, user name, issue time, expires every hour, don't persist cookie, roles )
                            Dim PortalTicket As New System.Web.Security.FormsAuthenticationTicket(1, objUser.Username, CurrentDateTime, CurrentDateTime.AddHours(1), False, _portalSettings.PortalAlias.PortalAliasID.ToString)
                            ' encrypt the ticket
                            Dim strPortalAliasID As String = System.Web.Security.FormsAuthentication.Encrypt(PortalTicket)
                            ' send portal cookie to client
                            Response.Cookies("portalaliasid").Value = strPortalAliasID
                            Response.Cookies("portalaliasid").Path = "/"
                            Response.Cookies("portalaliasid").Expires = CurrentDateTime.AddMinutes(1)

                            ' get roles from UserRoles table
                            arrPortalRoles = objRoleController.GetRolesByUser(objUser.UserID, _portalSettings.PortalId)

                            ' create a string to persist the roles
                            Dim strPortalRoles As String = Join(arrPortalRoles, New Char() {";"c})

                            ' create a cookie authentication ticket ( version, user name, issue time, expires every hour, don't persist cookie, roles )
                            Dim RolesTicket As New System.Web.Security.FormsAuthenticationTicket(1, objUser.Username, CurrentDateTime, CurrentDateTime.AddHours(1), False, strPortalRoles)
                            ' encrypt the ticket
                            Dim strRoles As String = System.Web.Security.FormsAuthentication.Encrypt(RolesTicket)
                            ' send roles cookie to client
                            Response.Cookies("portalroles").Value = strRoles
                            Response.Cookies("portalroles").Path = "/"
                            Response.Cookies("portalroles").Expires = CurrentDateTime.AddMinutes(1)
                        End If

                        If Not Request.Cookies("portalroles") Is Nothing Then
                            ' get roles from roles cookie
                            If Request.Cookies("portalroles").Value <> "" Then
                                Dim RoleTicket As System.Web.Security.FormsAuthenticationTicket = System.Web.Security.FormsAuthentication.Decrypt(context.Request.Cookies("portalroles").Value)

                                ' convert the string representation of the role data into a string array
                                ' and store it in the Roles Property of the User
                                objUser.Roles = RoleTicket.UserData.Split(";"c)
                            End If
                            context.Items.Add("UserInfo", objUser)
                            Localization.SetLanguage(objUser.Profile.PreferredLocale)
                        End If
                    End If
                End If

                If CType(HttpContext.Current.Items("UserInfo"), UserInfo) Is Nothing Then
                    context.Items.Add("UserInfo", New UserInfo)
                End If
            End If

        End Sub
#End Region

    End Class
End Namespace
