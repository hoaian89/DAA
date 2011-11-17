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

Imports System

Imports DotNetNuke
Imports DotNetNuke.Modules.XML



Namespace DotNetNuke.Modules.XML

    ''' <summary>
    ''' Represents an abstract data provider for the xml Module.
    ''' </summary>
    ''' <history>
    '''     [flanakin]   04/10/2006     Genesis
    ''' </history>
    Public MustInherit Class DataProvider

#Region "| Fields |"

        Private Shared _provider As DataProvider = Nothing

        Public Const ProviderType As String = "data"
        Public Const ProviderNamespace As String = "DotNetNuke.Modules.XML"
        Public Const ProviderBaseAssemblyName As String = "" '"DotNetNuke.Modules.XML"

#End Region


#Region "| Initialization |"

        ''' <summary>
        ''' Instantiates a new instance of the <c>DataProvider</c> class.
        ''' </summary>
        Shared Sub New()
        End Sub

#End Region


#Region "| Properties |"

        ''' <summary>
        ''' Gets the single instance of the <c>DataProvider</c> object.
        ''' </summary>
        Public Shared ReadOnly Property Instance() As DataProvider
            Get
                If _provider Is Nothing Then
                    'DotNetNuke.Modules.XML.SqlDataProvider, DotNetNuke.Modules.XML.SqlDataProvider
                    _provider = CType(Framework.Reflection.CreateObject(ProviderType, ProviderNamespace, ProviderBaseAssemblyName), DataProvider)
                End If
                Return _provider
            End Get
        End Property

#End Region


#Region "| Methods [Public] |"

        ''' <summary>
        ''' Creates a new  parameter in the data store.
        ''' </summary>
        ''' <param name="ModuleID"></param>
        ''' <param name="Purpose"></param>
        ''' <param name="Name"></param>
        ''' <param name="Type"></param>
        ''' <param name="TypeArgument"></param>
        ''' <param name="IsValueRequired" ></param>
        ''' <remarks></remarks>
        Public MustOverride Sub AddParameter(ByVal ModuleID As Integer, ByVal Purpose As String, ByVal Name As String, ByVal Type As String, ByVal TypeArgument As String, ByVal IsValueRequired As Boolean)


        ''' <summary>
        ''' Retrieves an existing  object from the data store.
        ''' </summary>
        ''' <param name="Key">Parameter identifier.</param>
        Public MustOverride Function GetParameter(ByVal Key As Integer) As IDataReader

        ''' <summary>
        ''' Retrieves a collection of  objects from the data store.
        ''' </summary>
        ''' <param name="ModuleID">Module identifier.</param>
        ''' <param name="Purpose">Purpose to distinguish between different parameter collections per module.</param>
        Public MustOverride Function GetParameters(ByVal ModuleID As Integer, ByVal Purpose As String) As IDataReader


        ''' <summary>
        ''' Updates an existing  object in the data store.
        ''' </summary>
        ''' <param name="Key"></param>
        ''' <param name="Name"></param>
        ''' <param name="Type"></param>
        ''' <param name="TypeArgument"></param>
        ''' <param name="IsValueRequired"></param>
        ''' <remarks></remarks>
        Public MustOverride Sub UpdateParameter(ByVal Key As Integer, ByVal Name As String, ByVal Type As String, ByVal TypeArgument As String, ByVal IsValueRequired As Boolean)


        ''' <summary>
        ''' Removes an existing  object from the data store.
        ''' </summary>
        ''' <param name="Key">Parameter identifier.</param>
        Public MustOverride Sub DeleteParameter(ByVal Key As Integer)


#End Region

    End Class

End Namespace

