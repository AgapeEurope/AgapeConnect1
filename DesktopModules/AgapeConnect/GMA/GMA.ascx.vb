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

Imports StaffBroker

Imports StaffBrokerFunctions
Imports GmaServices

Namespace DotNetNuke.Modules.GMA
    Partial Class GMA
        Inherits Entities.Modules.PortalModuleBase

        'Dim dStaff As New AgapeStaffDataContext
        ' Dim dBroke As New StaffBrokerDataContext
        '  Dim d As New DNNProfileDataContextDataContext
        Private gmaServers As New List(Of gmaServer)

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            If Not Page.IsPostBack Then
                gmaServers.Clear()
                Dim insert As New gmaServer
                insert.name = "AgapeConnect"

                insert.URL = "http://gma.agapeconnect.me/index.php"
                insert.gma = New GmaServices(insert.URL, UserInfo.Profile.GetPropertyValue("GCXPGTIOU"))
                Dim Reports = insert.gma.GetStaffReports()
                Dim DirectorReports = insert.gma.GetDirectorReports()

                insert.nodes = insert.gma.GetUserNodes(Reports, DirectorReports)

                gmaServers.Add(insert)


                Session("gmaServers") = gmaServers


                rpGmaServers.DataSource = From c In gmaServers Select name = c.name, url = c.URL, nodes = (From b In c.nodes Select shortName = b.shortName, nodeId = b.nodeId, url = c.URL)

                rpGmaServers.DataBind()

                Try
                    Dim firstServer = gmaServers.Where(Function(c) c.nodes.Count > 0).First

                    SelectNode(firstServer.URL & ":::" & firstServer.nodes.First.nodeId)
                Catch ex As Exception

                End Try

            End If



        End Sub

        Private Sub SelectNode(ByVal ref As String)
            If gmaServers.Count = 0 Then
                gmaServers = Session("gmaServers")
            End If


            Dim myNodeId = ref.Substring(ref.IndexOf(":::") + 3)
            Dim myUrl = ref.Substring(0, ref.IndexOf(":::"))
            hfNodeId.Value = myNodeId
            hfURL.Value = myUrl
            Dim gmaServer = (From c In gmaServers Where c.URL = myUrl).First

            Dim gmaNode = (From c In gmaServer.nodes Where c.nodeId = myNodeId).First




            ddlPeriods.DataSource = From c In gmaNode.Reports Select LabelName = c.startDate.ToString("dd MMM yy") & " - " & c.endDate.ToString("dd MMM yy"), c.ReportId
            ddlPeriods.DataBind()
            ddlPeriods.SelectedValue = gmaNode.Reports.Last.ReportId
            ddlPeriods_SelectedIndexChanged(Me, Nothing)
            ddlPeriodsD.DataSource = From c In gmaNode.DirectorReports Select LabelName = c.startDate.ToString("dd MMM yy") & " - " & c.endDate.ToString("dd MMM yy"), c.ReportId
            ddlPeriodsD.DataBind()
            ddlPeriodsD.SelectedValue = gmaNode.DirectorReports.Last.ReportId
            ddlPeriodsD_SelectedIndexChanged(Me, Nothing)
        End Sub








        Protected Sub rpNodes_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
            If e.CommandName = "nodeSelected" Then
                SelectNode(e.CommandArgument)

                'Label1.Text = gma.GetStaffReport(reports.Last.ReportId).First.measurementName
                If gmaServers.Count = 0 Then
                    gmaServers = Session("gmaServers")
                End If

                rpGmaServers.DataSource = From c In gmaServers Select name = c.name, url = c.URL, nodes = (From b In c.nodes Select shortName = b.shortName, nodeId = b.nodeId, url = c.URL)

                rpGmaServers.DataBind()


            End If
        End Sub

        Protected Sub ddlPeriods_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPeriods.SelectedIndexChanged
            If gmaServers.Count = 0 Then
                gmaServers = Session("gmaServers")
            End If

            ' Dim myNodeId As Integer = hfNodeId.Value
            Dim myURL As String = hfURL.Value
            Dim gmaServer = (From c In gmaServers Where c.URL = myURL).First

            rpStaffMeasurements.DataSource = From c In gmaServer.gma.GetStaffReport(CInt(ddlPeriods.SelectedValue)) Select c.measurementName, c.measurementValue, c.measurementDescription, c.measurementType, c.measurementId
            rpStaffMeasurements.DataBind()
           
            lbPrevPeriod.Enabled = Not (ddlPeriods.SelectedIndex = 0 Or ddlPeriods.Items.Count = 0)

            lbNextPeriod.Enabled = Not (ddlPeriods.SelectedIndex = ddlPeriods.Items.Count - 1 Or ddlPeriods.Items.Count = 0)


        End Sub


        Protected Sub lbPrevPeriod_Click(sender As Object, e As EventArgs) Handles lbPrevPeriod.Click
            If ddlPeriods.SelectedIndex > 0 Then
                ddlPeriods.SelectedIndex = ddlPeriods.SelectedIndex - 1
                ddlPeriods_SelectedIndexChanged(Me, Nothing)
            End If


        End Sub

        Protected Sub lbNextPeriod_Click(sender As Object, e As EventArgs) Handles lbNextPeriod.Click
            If ddlPeriods.SelectedIndex < ddlPeriods.Items.Count() - 1 Then
                ddlPeriods.SelectedIndex = ddlPeriods.SelectedIndex + 1
                ddlPeriods_SelectedIndexChanged(Me, Nothing)
            End If
        End Sub
        Protected Sub lbPrevPeriodD_Click(sender As Object, e As EventArgs) Handles lbPrevPeriodD.Click
            If ddlPeriodsD.SelectedIndex > 0 Then
                ddlPeriodsD.SelectedIndex = ddlPeriodsD.SelectedIndex - 1
                ddlPeriodsD_SelectedIndexChanged(Me, Nothing)
            End If


        End Sub

        Protected Sub lbNextPeriodD_Click(sender As Object, e As EventArgs) Handles lbNextPeriodD.Click
            If ddlPeriodsD.SelectedIndex < ddlPeriodsD.Items.Count() - 1 Then
                ddlPeriodsD.SelectedIndex = ddlPeriodsD.SelectedIndex + 1
                ddlPeriodsD_SelectedIndexChanged(Me, Nothing)
            End If
        End Sub

        Protected Sub ddlPeriodsD_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPeriodsD.SelectedIndexChanged
            If gmaServers.Count = 0 Then
                gmaServers = Session("gmaServers")
            End If

            ' Dim myNodeId As Integer = hfNodeId.Value
            Dim myURL As String = hfURL.Value
            Dim gmaServer = (From c In gmaServers Where c.URL = myURL).First

            rpDirectorMeasuremts.DataSource = From c In gmaServer.gma.GetDirectorReport(CInt(ddlPeriodsD.SelectedValue)) Select c.measurementName, c.measurementValue, c.measurementDescription, c.measurementType, c.measurementId
            rpDirectorMeasuremts.DataBind()
            





            lbPrevPeriodD.Enabled = Not (ddlPeriodsD.SelectedIndex = 0 Or ddlPeriodsD.Items.Count = 0)

            lbNextPeriodD.Enabled = Not (ddlPeriodsD.SelectedIndex = ddlPeriodsD.Items.Count - 1 Or ddlPeriodsD.Items.Count = 0)


        End Sub

        
        Protected Sub rpStaffMeasurements_ItemCommand(source As Object, e As DataListCommandEventArgs) Handles rpStaffMeasurements.ItemCommand
            If e.CommandName = "SaveReport" Then
                Dim SaveReport As New gma_Report
                SaveReport.measurements = New List(Of gma_measurements)
                SaveReport.nodeId = hfNodeId.Value
                SaveReport.ReportId = ddlPeriods.SelectedValue
                For Each row As DataListItem In rpStaffMeasurements.Items
                    Dim m As New gma_measurements
                    'For Each c In row.Controls
                    '    Dim test = c.Id
                    'Next
                    m.measurementType = CType(row.FindControl("hfAnswerType"), HiddenField).Value
                    m.measurementId = CType(row.FindControl("hfMeasurementId"), HiddenField).Value


                    If m.measurementType = "numeric" Then
                        m.measurementValue = CType(row.FindControl("tbAnswer"), TextBox).Text

                    ElseIf m.measurementType = "text" Then
                        m.measurementValue = CType(row.FindControl("tbAnswerText"), TextBox).Text
                    End If
                    SaveReport.measurements.Add(m)

                Next

                If gmaServers.Count = 0 Then
                    gmaServers = Session("gmaServers")
                End If
                Dim myURL As String = hfURL.Value
                Dim gmaServer = (From c In gmaServers Where c.URL = myURL).First
                gmaServer.gma.SaveReport(SaveReport)
            End If
        End Sub

        Protected Sub rpDirectorMeasuremts_ItemCommand(source As Object, e As DataListCommandEventArgs) Handles rpDirectorMeasuremts.ItemCommand
            If e.CommandName = "SaveReport" Then
                Dim SaveReport As New gma_Report
                SaveReport.measurements = New List(Of gma_measurements)
                SaveReport.nodeId = hfNodeId.Value
                SaveReport.ReportId = ddlPeriodsD.SelectedValue
                For Each row As DataListItem In rpDirectorMeasuremts.Items
                    Dim m As New gma_measurements
                    
                    m.measurementType = CType(row.FindControl("hfAnswerType"), HiddenField).Value
                    m.measurementId = CType(row.FindControl("hfMeasurementId"), HiddenField).Value


                    If m.measurementType = "numeric" Then
                        m.measurementValue = CType(row.FindControl("tbAnswer"), TextBox).Text

                    ElseIf m.measurementType = "text" Then
                        m.measurementValue = CType(row.FindControl("tbAnswerText"), TextBox).Text
                    End If
                    SaveReport.measurements.Add(m)

                Next

                If gmaServers.Count = 0 Then
                    gmaServers = Session("gmaServers")
                End If
                Dim myURL As String = hfURL.Value
                Dim gmaServer = (From c In gmaServers Where c.URL = myURL).First
                gmaServer.gma.SaveReport(SaveReport, "Director")
            End If
        End Sub
    End Class
End Namespace
