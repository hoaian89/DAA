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
Option Strict On
Option Explicit On

Imports System.Collections.Specialized
Imports System.Text

Imports DotNetNuke
Imports DotNetNuke.Entities.Modules



Namespace DotNetNuke.Modules.XML

    ''' <summary>
    ''' xml Module controller.
    ''' </summary>
    ''' <history>
    '''     [flanakin]   03/16/2006     Genesis
    ''' </history>
    Public Class ParameterController
#Region "| Fields |"

        Private _dataProvider As DataProvider
        Private _purpose As String

#End Region

#Region "| Initialisation |"
        Public Sub New()
            _purpose = ""
        End Sub

        Public Sub New(ByVal Purpose As String)
            _purpose = Purpose
        End Sub
#End Region


#Region "| Data Access |"

        ''' <summary>
        ''' Gets the single instance of the current <see cref="DataProvider"/>.
        ''' </summary>
        Protected ReadOnly Property DataProvider() As DataProvider
            Get
                If Me._dataProvider Is Nothing Then
                    Me._dataProvider = DataProvider.Instance()
                End If
                Return Me._dataProvider
            End Get
        End Property


        ''' <summary>
        ''' Creates a new  object in the data store.
        ''' </summary>
        ''' <param name="Parameter">Parameter object.</param>
        Public Sub AddParameter(ByVal Parameter As ParameterInfo)
            DataProvider.AddParameter(Parameter.ModuleID, _purpose, Parameter.Name, Parameter.Type, Parameter.TypeArgument, Parameter.IsValueRequired)
        End Sub


        ''' <summary>
        ''' Retrieves an existing  object from the data store.
        ''' </summary>
        ''' <param name="Key">Parameter identifier.</param>
        Public Function GetParameter(ByVal Key As ParameterInfo.UniqueKey) As ParameterInfo
            Dim objReader As IDataReader = DataProvider.GetParameter(Key.ID)
            Dim objParam As ParameterInfo

            ' loop thru data
            If objReader.Read Then
                objParam = FillParameterInfo(objReader)
            Else
                objParam = New ParameterInfo
            End If
            objReader.Close()

            ' return
            Return objParam
        End Function


        ''' <summary>
        ''' Retrieves a collection of  objects from the data store.
        ''' </summary>
        ''' <param name="ModuleID">Module identifier.</param>
        Public Function GetParameters(ByVal ModuleID As Integer) As ParameterList

            Dim objReader As IDataReader = DataProvider.GetParameters(ModuleID, _purpose)
            Dim colParams As New ParameterList

            ' loop thru data
            While objReader.Read
                colParams.Add(FillParameterInfo(objReader))
            End While
            objReader.Close()

            ' return
            Return colParams
        End Function

        ''' <summary>
        ''' Updates an existing  object in the data store.
        ''' </summary>
        ''' <param name="Parameter">Parameter object.</param>
        Public Sub UpdateParameter(ByVal Parameter As ParameterInfo)
            DataProvider.UpdateParameter(Parameter.ID, Parameter.Name, Parameter.Type.ToString, Parameter.TypeArgument, Parameter.IsValueRequired)
        End Sub


        ''' <summary>
        ''' Removes an existing  object from the data store.
        ''' </summary>
        ''' <param name="Key">Parameter identifier.</param>
        Public Sub DeleteParameter(ByVal Key As ParameterInfo.UniqueKey)
            DataProvider.DeleteParameter(Key.ID)
        End Sub



#End Region

        Private Function FillParameterInfo(ByVal objreader As IDataReader) As ParameterInfo
            Dim objParam As New ParameterInfo
            objParam.ID = objreader.GetInt32(0)
            objParam.ModuleID = objreader.GetInt32(1)
            objParam.Name = objreader.GetString(2)
            objParam.Type = objreader.GetString(3)
            If Not objreader.IsDBNull(4) Then _
                objParam.TypeArgument = objreader.GetString(4)
            objParam.IsValueRequired = objreader.GetBoolean(5)
            Return objParam
        End Function
    End Class

End Namespace
