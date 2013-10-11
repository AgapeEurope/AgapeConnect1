Imports Microsoft.VisualBasic
Imports Give
Imports System.Linq
Imports System.Data.Linq
Imports StaffBroker

#Region "Modules defining constant values"

' List of values for giving type (used for URL parameters)
Public Module GiveType
    Public Const Staff As Integer = 0
    Public Const Dept As Integer = 1
    Public Const Project As Integer = 2
    Public Function GetName(ByVal GiveTypeNumber As Integer) As String
        Select Case GiveTypeNumber
            Case 0 : Return "Staff"
            Case 1 : Return "Dept"
            Case 2 : Return "Project"
            Case Else : Return "Unknown"
        End Select
    End Function
End Module

#End Region ' Modules defining constant values

Public Class GiveFunctions

#Region ""



#End Region


End Class