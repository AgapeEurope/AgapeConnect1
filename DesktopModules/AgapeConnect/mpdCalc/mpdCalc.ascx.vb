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

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

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


            End If
           



        End Sub




    End Class
End Namespace
