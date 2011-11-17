'
' DotNetNuke® - http://www.dotnetnuke.com
' Copyright (c) 2002-2007
' by DotNetNuke Corporation
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
Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.ApplicationBlocks.Data
Imports DotNetNuke
Imports DotNetNuke.Framework.Providers

Namespace DotNetNuke.Modules.Survey

    Public Class SqlDataProvider

        Inherits DataProvider

#Region "Private Members"

        Private Const ProviderType As String = "data"

        Private _providerConfiguration As ProviderConfiguration = ProviderConfiguration.GetProviderConfiguration(ProviderType)
        Private _connectionString As String
        Private _providerPath As String
        Private _objectQualifier As String
        Private _databaseOwner As String

#End Region

#Region "Constructors"

        Public Sub New()

            ' Read the configuration specific information for this provider
            Dim objProvider As Provider = CType(_providerConfiguration.Providers(_providerConfiguration.DefaultProvider), Provider)

            ' Read the attributes for this provider

            'Get Connection string from web.config
            _connectionString = Config.GetConnectionString()

            If _connectionString = "" Then
                ' Use connection string specified in provider
                _connectionString = objProvider.Attributes("connectionString")
            End If

            _providerPath = objProvider.Attributes("providerPath")

            _objectQualifier = objProvider.Attributes("objectQualifier")
            If _objectQualifier <> "" And _objectQualifier.EndsWith("_") = False Then
                _objectQualifier += "_"
            End If

            _databaseOwner = objProvider.Attributes("databaseOwner")
            If _databaseOwner <> "" And _databaseOwner.EndsWith(".") = False Then
                _databaseOwner += "."
            End If

        End Sub

#End Region

#Region "Properties"

        Public ReadOnly Property ConnectionString() As String
            Get
                Return _connectionString
            End Get
        End Property

        Public ReadOnly Property ProviderPath() As String
            Get
                Return _providerPath
            End Get
        End Property

        Public ReadOnly Property ObjectQualifier() As String
            Get
                Return _objectQualifier
            End Get
        End Property

        Public ReadOnly Property DatabaseOwner() As String
            Get
                Return _databaseOwner
            End Get
        End Property

#End Region

        ' general
        Private Function GetNull(ByVal Field As Object) As Object
            Return DotNetNuke.Common.Utilities.Null.GetNull(Field, DBNull.Value)
        End Function

        Public Overrides Function GetSurveys(ByVal ModuleId As Integer) As IDataReader
            Return CType(SqlHelper.ExecuteReader(ConnectionString, DatabaseOwner & ObjectQualifier & "GetSurveys", ModuleId), IDataReader)
        End Function
        Public Overrides Function GetSurvey(ByVal SurveyID As Integer, ByVal ModuleId As Integer) As IDataReader
            Return CType(SqlHelper.ExecuteReader(ConnectionString, DatabaseOwner & ObjectQualifier & "GetSurvey", SurveyID, ModuleId), IDataReader)
        End Function
        Public Overrides Function GetSurveyResultData(ByVal ModuleId As Integer) As IDataReader
            Return CType(SqlHelper.ExecuteReader(ConnectionString, DatabaseOwner & ObjectQualifier & "GetSurveyResultData", ModuleId), IDataReader)
        End Function
        Public Overrides Function AddSurvey(ByVal ModuleId As Integer, ByVal Question As String, ByVal ViewOrder As Integer, ByVal OptionType As String, ByVal UserId As Integer) As Integer
            Return CType(SqlHelper.ExecuteScalar(ConnectionString, DatabaseOwner & ObjectQualifier & "AddSurvey", ModuleId, Question, GetNull(ViewOrder), OptionType, UserId), Integer)
        End Function
        Public Overrides Sub UpdateSurvey(ByVal SurveyId As Integer, ByVal Question As String, ByVal ViewOrder As Integer, ByVal OptionType As String, ByVal UserId As Integer, ByVal ModuleId As Integer)
            SqlHelper.ExecuteNonQuery(ConnectionString, DatabaseOwner & ObjectQualifier & "UpdateSurvey", SurveyId, Question, GetNull(ViewOrder), OptionType, UserId, ModuleId)
        End Sub
        Public Overrides Sub DeleteSurvey(ByVal SurveyID As Integer, ByVal ModuleId As Integer)
            SqlHelper.ExecuteNonQuery(ConnectionString, DatabaseOwner & ObjectQualifier & "DeleteSurvey", SurveyID, ModuleId)
        End Sub
        Public Overrides Function GetSurveyOptions(ByVal SurveyId As Integer) As IDataReader
            Return CType(SqlHelper.ExecuteReader(ConnectionString, DatabaseOwner & ObjectQualifier & "GetSurveyOptions", SurveyId), IDataReader)
        End Function
        Public Overrides Function AddSurveyOption(ByVal SurveyId As Integer, ByVal OptionName As String, ByVal ViewOrder As Integer, ByVal IsCorrect As Boolean) As Integer
            Return CType(SqlHelper.ExecuteScalar(ConnectionString, DatabaseOwner & ObjectQualifier & "AddSurveyOption", SurveyId, OptionName, GetNull(ViewOrder), IsCorrect), Integer)
        End Function
        Public Overrides Sub UpdateSurveyOption(ByVal SurveyOptionId As Integer, ByVal OptionName As String, ByVal ViewOrder As Integer, ByVal IsCorrect As Boolean)
            SqlHelper.ExecuteNonQuery(ConnectionString, DatabaseOwner & ObjectQualifier & "UpdateSurveyOption", SurveyOptionId, OptionName, GetNull(ViewOrder), IsCorrect)
        End Sub
        Public Overrides Sub DeleteSurveyOption(ByVal SurveyOptionID As Integer)
            SqlHelper.ExecuteNonQuery(ConnectionString, DatabaseOwner & ObjectQualifier & "DeleteSurveyOption", SurveyOptionID)
        End Sub
        Public Overrides Sub AddSurveyResult(ByVal SurveyOptionId As Integer, ByVal UserId As Integer)
            SqlHelper.ExecuteNonQuery(ConnectionString, DatabaseOwner & ObjectQualifier & "AddSurveyResult", SurveyOptionId, UserId)
        End Sub
        Public Overrides Sub AddSurveyResult_cookie(ByVal SurveyOptionId As Integer, ByVal UserId As Integer)
            SqlHelper.ExecuteNonQuery(ConnectionString, DatabaseOwner & ObjectQualifier & "AddSurveyResult_cookie", SurveyOptionId, UserId)
        End Sub
        Public Overrides Sub DeleteSurveyResultData(ByVal ModuleId As Integer)
            SqlHelper.ExecuteNonQuery(ConnectionString, DatabaseOwner & ObjectQualifier & "DeleteSurveyResultData", ModuleId)
        End Sub
    End Class

End Namespace
