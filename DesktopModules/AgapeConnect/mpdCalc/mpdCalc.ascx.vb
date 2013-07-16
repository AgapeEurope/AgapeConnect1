Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security
Imports MPD

Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class mpdCalc
        Inherits Entities.Modules.PortalModuleBase

        Private _age1 As Integer = 0
        Public Property Age1() As Integer
            Get
                Return _age1
            End Get
            Set(ByVal value As Integer)
                _age1 = value
            End Set
        End Property

        Private _age2 As Integer = 0
        Public Property Age2() As Integer
            Get
                Return _age2
            End Get
            Set(ByVal value As Integer)
                _age2 = value
            End Set
        End Property

        Private _isCouple As Boolean = False
        Public Property IsCouple() As Boolean
            Get
                Return _isCouple
            End Get
            Set(ByVal value As Boolean)
                _isCouple = value
            End Set
        End Property

        Private _staffType As String = ""
        Public Property StaffType() As String
            Get
                Return _staffType
            End Get
            Set(ByVal value As String)
                _staffType = value
            End Set
        End Property



        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then


                itemCurrent.Monthly = 3000
                Dim d As New MPDDataContext()
                Dim theForm = From c In d.AP_mpdCalc_Definitions Where c.TabModuleId = TabModuleId
                If theForm.Count > 0 Then
                    rpSections.DataSource = theForm.First.AP_mpdCalc_Sections
                    rpSections.DataBind()

                    hfAssessment.Value = theForm.First.AssessmentRate
                    If theForm.First.ShowComplience Then
                        cbCompliance.Text = theForm.First.Complience
                    End If
                    cbCompliance.Visible = theForm.First.ShowComplience
                    Age1 = 20
                    Age2 = 22
                    IsCouple = True
                    StaffType = "COOL"

                End If

            End If


        End Sub

        

    End Class
End Namespace
