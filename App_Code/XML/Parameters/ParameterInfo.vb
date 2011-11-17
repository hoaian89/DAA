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
Option Strict On
Option Explicit On

Imports System
Imports System.Web

Imports DotNetNuke.Entities.Users

Namespace DotNetNuke.Modules.XML

    ''' <summary>
    ''' Represents a parameter
    ''' </summary>
    Public Class ParameterInfo



#Region "| Fields |"

        Private _key As ParameterInfo.UniqueKey
        Private _moduleID As Integer
        Private _name As String
        Private _type As String
        Private _typeArgument As String
        Private _IsValueRequired As Boolean
        Private _InvalidCharacters As Char() = ", ;""'?".ToCharArray
#End Region


#Region "| Initialization |"

        ''' <summary>
        ''' Instantiates a new instance of the <c>Parameter</c> module.
        ''' </summary>
        Public Sub New()
            Me._key = New ParameterInfo.UniqueKey
            Type = ParameterType.StaticValue.ToString
            IsValueRequired = False
            TypeArgument = ""
        End Sub

#End Region


#Region "| Sub-Classes |"

        ''' <summary>
        ''' Represents a unique <see cref="ParameterInfo"/>.
        ''' </summary>
        Public Class UniqueKey

            ' fields
            Private _id As Integer = -1

            ''' <summary>
            ''' Gets or sets the unique identifier
            ''' </summary>
            Public Property ID() As Integer
                Get
                    Return Me._id
                End Get
                Set(ByVal Value As Integer)
                    Me._id = Value
                End Set
            End Property

            ''' <summary>
            ''' Gets a value indicating whether the <see cref="ParameterInfo"/> is new.
            ''' </summary>
            Public ReadOnly Property IsNew() As Boolean
                Get
                    Return (Me._id <= 0)
                End Get
            End Property
        End Class

#End Region


#Region "| Properties |"

#Region "| Key |"

        ''' <summary>
        ''' Gets or sets the unique key.
        ''' </summary>
        Public Property Key() As UniqueKey
            Get
                Return Me._key
            End Get
            Set(ByVal Value As UniqueKey)
                Me._key = Value
            End Set
        End Property


        ''' <summary>
        ''' Gets or sets the unique identifier.
        ''' </summary>
        Public Property ID() As Integer
            Get
                Return Key.ID
            End Get
            Set(ByVal Value As Integer)
                Key.ID = Value
            End Set
        End Property


        ''' <summary>
        ''' Gets a value indicating whether the object is new.
        ''' </summary>
        Public ReadOnly Property IsNew() As Boolean
            Get
                Return Key.IsNew
            End Get
        End Property

#End Region


        ''' <summary>
        ''' Gets or sets the module identifier.
        ''' </summary>
        Public Property ModuleID() As Integer
            Get
                Return Me._moduleID
            End Get
            Set(ByVal Value As Integer)
                Me._moduleID = Value
            End Set
        End Property


        ''' <summary>
        ''' Gets or sets the parameter name.
        ''' </summary>
        Public Property Name() As String
            Get
                Return Me._name
            End Get
            Set(ByVal Value As String)
                Me._name = Value
            End Set
        End Property


        ''' <summary>
        ''' Gets or sets the parameter type.
        ''' </summary>
        Public Property Type() As String
            Get
                Return Me._type
            End Get
            Set(ByVal Value As String)
                Me._type = Value
            End Set
        End Property


        ''' <summary>
        ''' Gets or sets the parameter type argument.
        ''' </summary>
        ''' <remarks>
        ''' The parameter type argument varies in purpose and usage. For instance, the argument may 
        ''' represent a value, querystring parameter name, or custom user profile property.
        ''' It can also be used to store a fallback value that acts as replacement when no value is present.
        ''' </remarks>
        Public Property TypeArgument() As String
            Get
                Return Me._typeArgument
            End Get
            Set(ByVal Value As String)
                Me._typeArgument = Value
            End Set
        End Property

        ''' <summary>
        ''' Gets or sets whether a value is needed.
        ''' </summary>
        ''' <remarks>
        ''' The parameter is only valid if it returns a value different from nothing or empty string.
        ''' </remarks>
        Public Property IsValueRequired() As Boolean
            Get
                Return Me._IsValueRequired
            End Get
            Set(ByVal Value As Boolean)
                Me._IsValueRequired = Value
            End Set
        End Property


        ''' <summary>
        ''' Gets a value indicating whether the parameter definition is valid.
        ''' </summary>
        Public ReadOnly Property IsValidDefinition() As Boolean
            Get
                ' check name
                If CStrN(Name) = "" OrElse Name.IndexOfAny(_InvalidCharacters) <> -1 Then Return False

                ' check argument based on type
                Select Case ParseType(Type)
                    Case ParameterType.PassThrough, ParameterType.UserCustomProperty, ParameterType.StaticValue, ParameterType.FormPassThrough
                        Return (Not (TypeArgument Is Nothing OrElse TypeArgument.Length = 0))
                    Case Else
                        Return True
                End Select
            End Get
        End Property

        ''' <summary>
        ''' Gets a value indicating whether the parameter is valid.
        ''' </summary>
        Public ReadOnly Property IsValidValue() As Boolean
            Get
                Return Not IsValueRequired OrElse CStrN(GetValue()).Length > 0
            End Get
        End Property




        Public ReadOnly Property IsStatic() As Boolean
            Get
                Select Case ParseType(Type)
                    Case ParameterType.StaticValue, ParameterType.PortalName, ParameterType.PortalID, ParameterType.TabID, ParameterType.HomeDirectory
                        Return (True)
                    Case Else
                        Return False
                End Select
            End Get
        End Property




#End Region


#Region "| Methods [Public] |"

        ''' <summary>
        ''' Converts a string representation of a <see cref="ParameterType"/> to its object value.
        ''' </summary>
        ''' <param name="Type">Value to convert.</param>
        Private Shared Function ParseType(ByVal Type As String) As ParameterType
            Dim objType As ParameterType
            Try
                objType = CType([Enum].Parse(objType.GetType(), Type), ParameterType)
            Catch ex As Exception
                objType = ParameterType.StaticValue
            End Try
            Return objType
        End Function


        ''' <summary>
        ''' Determines parameter value based on applied settings.
        ''' </summary>
        Public Function GetValue() As String
            ' init vars
            Dim ArgumentIsEmpty As Boolean = (TypeArgument Is Nothing OrElse TypeArgument.Length = 0)
            Dim objSecurity As New Security.PortalSecurity
            ' get value based on type
            Select Case ParseType(Type)

                Case ParameterType.StaticValue ' static
                    Return TypeArgument

                Case ParameterType.PassThrough ' pass-thru parameter / Querystring
                    If ArgumentIsEmpty Then Return ""
                    If Not HttpContext.Current Is Nothing Then
                        Dim qString As String = CStrN(HttpContext.Current.Request.QueryString(TypeArgument))
                        Return objSecurity.InputFilter(qString, Security.PortalSecurity.FilterFlag.NoMarkup _
                                                             Or Security.PortalSecurity.FilterFlag.NoScripting)
                    End If

                Case ParameterType.FormPassThrough ' pass-thru parameter 
                    If ArgumentIsEmpty Then Return ""
                    If Not HttpContext.Current Is Nothing Then
                        Dim fString As String = CStrN(HttpContext.Current.Request.Form(TypeArgument))
                        Return objSecurity.InputFilter(fString, Security.PortalSecurity.FilterFlag.NoMarkup _
                                                             Or Security.PortalSecurity.FilterFlag.NoScripting)
                    End If

                Case ParameterType.PortalID ' portal id
                    Return Convert.ToString(GetPortalSettings().PortalId)

                Case ParameterType.PortalName ' portal name
                    Return Convert.ToString(GetPortalSettings().PortalName)

                Case ParameterType.HomeDirectory ' portal name
                    Return Convert.ToString(GetPortalSettings().HomeDirectory)

                Case ParameterType.CurrentCulture ' portal name
                    Return Convert.ToString(New Localization().CurrentCulture)

                Case ParameterType.TabID ' active tab id
                    Return Convert.ToString(GetPortalSettings().ActiveTab.TabID)

                Case Else ' user property
                    ' get current user
                    Dim objUser As UserInfo = UserController.GetCurrentUserInfo

                    ' handle user property
                    Select Case ParseType(Type)

                        Case ParameterType.UserCustomProperty ' custom property
                            If ArgumentIsEmpty Then Return ""
                            Return objUser.Profile.GetPropertyValue(TypeArgument)
                        Case ParameterType.UserID
                            Return Convert.ToString(objUser.UserID)

                        Case ParameterType.UserUsername
                            Return CStrN(objUser.Username, TypeArgument)

                        Case ParameterType.UserFirstName
                            Return CStrN(objUser.FirstName, TypeArgument)

                        Case ParameterType.UserLastName
                            Return CStrN(objUser.LastName, TypeArgument)

                        Case ParameterType.UserFullName
                            Return CStrN(objUser.DisplayName, TypeArgument)

                        Case ParameterType.UserEmail
                            Return CStrN(objUser.Membership.Email, TypeArgument)

                        Case ParameterType.UserWebsite
                            Return CStrN(objUser.Profile.Website, TypeArgument)

                        Case ParameterType.UserIM
                            Return CStrN(objUser.Profile.IM, TypeArgument)

                        Case ParameterType.UserStreet
                            Return CStrN(objUser.Profile.Street, TypeArgument)

                        Case ParameterType.UserUnit
                            Return CStrN(objUser.Profile.Unit, TypeArgument)

                        Case ParameterType.UserCity
                            Return CStrN(objUser.Profile.City, TypeArgument)

                        Case ParameterType.UserCountry
                            Return CStrN(objUser.Profile.Country, TypeArgument)

                        Case ParameterType.UserRegion
                            Return CStrN(objUser.Profile.Region, TypeArgument)

                        Case ParameterType.UserPostalCode
                            Return CStrN(objUser.Profile.PostalCode, TypeArgument)

                        Case ParameterType.UserPhone
                            Return CStrN(objUser.Profile.Telephone, TypeArgument)

                        Case ParameterType.UserCell
                            Return CStrN(objUser.Profile.Cell, TypeArgument)

                        Case ParameterType.UserFax
                            Return CStrN(objUser.Profile.Fax, TypeArgument)

                        Case ParameterType.UserLocale
                            Return CStrN(objUser.Profile.PreferredLocale, TypeArgument)

                        Case ParameterType.UserTimeZone
                            Return CStrN(objUser.Profile.TimeZone, TypeArgument)

                        Case ParameterType.UserIsAuthorized
                            Return CStrN(objUser.Membership.Approved, TypeArgument)

                        Case ParameterType.UserIsLockedOut
                            Return CStrN(objUser.Membership.LockedOut, TypeArgument)

                        Case ParameterType.UserIsSuperUser
                            Return CStrN(objUser.IsSuperUser, TypeArgument)

                    End Select

            End Select

            Return ""
        End Function


        ''' <summary>
        ''' Determines whether the <see cref="TypeArgument"/> is required based on the <see cref="ParameterType"/>.
        ''' </summary>
        Public Function IsArgumentRequired() As Boolean
            Select Case ParseType(Type)
                Case ParameterType.StaticValue, ParameterType.PassThrough, ParameterType.FormPassThrough, ParameterType.UserCustomProperty
                    Return True
                Case Else
                    Return False
            End Select
        End Function

        ''' <summary>
        ''' Determines whether the  <see cref="TypeArgument"/> is allowed as a fallback value.
        ''' </summary>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Function SupportsFallbackValue() As Boolean
            Return (Type.StartsWith("User") AndAlso ParseType(Type) <> ParameterType.UserCustomProperty)
        End Function


        ''' <summary>
        ''' Determines parameter value based on applied settings and on a given <see cref="System.Text.Encoding"/>
        ''' </summary>
        ''' <param name="encoding"></param>
        ''' <returns>paramter value pair (Param=Value)</returns>
        ''' <remarks></remarks>
        Public Overloads Function ToString(ByVal encoding As System.Text.Encoding) As String
            ' if valid, return formatted parameter; otherwise, return empty string
            If IsValidDefinition Then
                Return String.Format("{0}={1}", Name, HttpUtility.UrlEncode(GetValue(), encoding))
            Else
                Return ""
            End If
        End Function

        ''' <summary>
        ''' Determines parameter value based on applied settings
        ''' </summary>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Overloads Function ToString() As String
            Return ToString(System.Text.Encoding.UTF8)
        End Function


#End Region

    End Class

End Namespace
