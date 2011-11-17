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

Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient

Imports Microsoft.ApplicationBlocks.Data

Imports DotNetNuke.Common.Utilities
Imports DotNetNuke.Framework.Providers



Namespace DotNetNuke.Modules.XML

    ''' <summary>
    ''' IFrame Module data provider for Microsoft SQL Server.
    ''' </summary>
    ''' <history>
    '''     [flanakin]   04/08/2006     Genesis
    ''' </history>
    Public Class SqlDataProvider
        Inherits DataProvider

#Region "| Fields |"

        ' provider constants
        Private Const ObjectPrefix As String = "XML_Parameter_"
        Private Const ConnectionStringProperty As String = "connectionString"
        Private Const ConnectionStringNameProperty As String = "connectionStringName"
        Private Const ProviderPathProperty As String = "providerPath"
        Private Const ObjectQualifierProperty As String = "objectQualifier"
        Private Const DatabaseOwnerProperty As String = "databaseOwner"

        ' sproc constants
        Private Const AddParamProc As String = "Add"
        Private Const GetParamProc As String = "Get"
        Private Const GetParamsProc As String = "GetList"
        Private Const UpdateParamProc As String = "Update"
        Private Const DeleteParamProc As String = "Delete"

        ' private
        Private _providerConfiguration As ProviderConfiguration = ProviderConfiguration.GetProviderConfiguration(ProviderType)
        Private _connectionString As String
        Private _providerPath As String
        Private _objectQualifier As String
        Private _databaseOwner As String

#End Region


#Region "| Initialization |"

        ''' <summary>
        ''' Instantiates a new instance of the <c>SqlDataProvider</c> class.
        ''' </summary>
        Public Sub New()
            ' init vars
            Dim objProvider As Provider = CType(Me._providerConfiguration.Providers(Me._providerConfiguration.DefaultProvider), Provider)

            'Get Connection string from web.config
            _connectionString = Config.GetConnectionString()

            If _connectionString = "" Then
                ' Use connection string specified in provider
                _connectionString = objProvider.Attributes("connectionString")
            End If

            ' path
            Me._providerPath = objProvider.Attributes(ProviderPathProperty)

            ' qualifier
            Me._objectQualifier = objProvider.Attributes(ObjectQualifierProperty)
            If Me._objectQualifier <> "" AndAlso Not Me._objectQualifier.EndsWith("_") Then Me._objectQualifier += "_"

            ' dbo
            Me._databaseOwner = objProvider.Attributes(DatabaseOwnerProperty)
            If Me._databaseOwner <> "" AndAlso Not Me._databaseOwner.EndsWith(".") Then Me._databaseOwner += "."
        End Sub

#End Region


#Region "| Properties |"

        ''' <summary>
        ''' Gets the connection string.
        ''' </summary>
        Public ReadOnly Property ConnectionString() As String
            Get
                Return Me._connectionString
            End Get
        End Property


        ''' <summary>
        ''' Gets the provider path.
        ''' </summary>
        Public ReadOnly Property ProviderPath() As String
            Get
                Return Me._providerPath
            End Get
        End Property


        ''' <summary>
        ''' Gets the object qualifier.
        ''' </summary>
        Public ReadOnly Property ObjectQualifier() As String
            Get
                Return Me._objectQualifier
            End Get
        End Property


        ''' <summary>
        ''' Gets the database owner.
        ''' </summary>
        Public ReadOnly Property DatabaseOwner() As String
            Get
                Return Me._databaseOwner
            End Get
        End Property

#End Region


#Region "| Methods [Public] |"


        Public Overloads Overrides Sub AddParameter(ByVal ModuleID As Integer, ByVal Purpose As String, ByVal Name As String, ByVal Type As String, ByVal TypeArgument As String, ByVal ValueIsRequired As Boolean)
            SqlHelper.ExecuteNonQuery(ConnectionString, GetName(AddParamProc), ModuleID, Purpose, Name, Type, TypeArgument, ValueIsRequired)
        End Sub

        Public Overloads Overrides Sub DeleteParameter(ByVal Key As Integer)
            SqlHelper.ExecuteNonQuery(ConnectionString, GetName(DeleteParamProc), Key)
        End Sub

        Public Overloads Overrides Function GetParameter(ByVal Key As Integer) As System.Data.IDataReader
            Return (SqlHelper.ExecuteReader(ConnectionString, GetName(GetParamProc), Key))
        End Function

        Public Overrides Function GetParameters(ByVal ModuleID As Integer, ByVal Purpose As String) As System.Data.IDataReader
            Return (SqlHelper.ExecuteReader(ConnectionString, GetName(GetParamsProc), ModuleID, Purpose))
        End Function

        Public Overloads Overrides Sub UpdateParameter(ByVal Key As Integer, ByVal Name As String, ByVal Type As String, ByVal TypeArgument As String, ByVal ValueIsRequired As Boolean)
            SqlHelper.ExecuteNonQuery(ConnectionString, GetName(UpdateParamProc), Key, Name, Type, TypeArgument, ValueIsRequired)
        End Sub

#End Region


#Region "| Methods [Private] |"

        ''' <summary>
        ''' Returns the fully-qualified database object name.
        ''' </summary>
        ''' <param name="Name">Base object name.</param>
        Private Function GetName(ByVal Name As String) As String
            Return DatabaseOwner + ObjectQualifier + ObjectPrefix + Name
        End Function


        ''' <summary>
        ''' Returns <see cref="DBNull.Value"/> if <paramref name="Value"/> is null.
        ''' </summary>
        ''' <param name="Value">Object to evaluate.</param>
        Private Function GetNull(ByVal Value As Object) As Object
            Return Null.GetNull(Value, DBNull.Value)
        End Function

#End Region



    End Class

End Namespace

