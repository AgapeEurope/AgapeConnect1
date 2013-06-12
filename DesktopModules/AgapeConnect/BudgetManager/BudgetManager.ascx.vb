Imports DotNetNuke
Imports System.Web.UI
Imports System.Collections.Generic
Imports System.Reflection
Imports System.Math
Imports System.Net
Imports System.IO
Imports System.Text
Imports System.Net.Mail
Imports System.Collections.Specialized
Imports System.Xml.Linq
Imports System.Linq
Imports Budget
Namespace DotNetNuke.Modules.Budget



    Partial Class BudgetManager
        Inherits Entities.Modules.PortalModuleBase
        Dim d As New BudgetDataContext

        Dim currentFiscalYear As Integer
        Dim firstFiscalMonth As Integer
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            hfPortalId.Value = PortalId

             Dim tmp = StaffBrokerFunctions.GetSetting("FirstFiscalMonth", PortalId)
            If Not String.IsNullOrEmpty(tmp) Then
                firstFiscalMonth = tmp
            End If
            tmp = StaffBrokerFunctions.GetSetting("CurrentFiscalPeriod", PortalId)
            If Not String.IsNullOrEmpty(tmp) Then
                currentFiscalYear = Left(tmp, 4)
            End If
            If (Not Page.IsPostBack) Then
                Dim RCs = From c In d.AP_StaffBroker_CostCenters Where c.PortalId = PortalId Select c.CostCentreCode, Name = c.CostCentreCode & " (" & c.CostCentreName & ")" Order By CostCentreCode

                ddlRC.DataSource = RCs

                ddlRC.DataBind()
                ddlRCNew.DataSource = RCs
                ddlRCNew.DataBind()

                Dim Accs = From c In d.AP_StaffBroker_AccountCodes Where c.PortalId = PortalId Select c.AccountCode, Name = c.AccountCode & " (" & c.AccountCodeName & ")" Order By AccountCode

                ddlAccountNew.DataSource = Accs
                ddlAccountNew.DataBind()
                If firstFiscalMonth <> 1 Then
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear - 2) & "-" & (currentFiscalYear - 1), currentFiscalYear - 2))
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear - 1) & "-" & (currentFiscalYear), currentFiscalYear - 1))
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear) & "-" & (currentFiscalYear + 1), currentFiscalYear))
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear + 1) & "-" & (currentFiscalYear + 2), currentFiscalYear + 1))
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear + 2) & "-" & (currentFiscalYear + 3), currentFiscalYear + 2))
                Else
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear - 2), currentFiscalYear - 2))
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear - 1), currentFiscalYear - 1))
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear), currentFiscalYear))
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear + 1), currentFiscalYear + 1))
                    ddlFiscalYear.Items.Add(New ListItem((currentFiscalYear + 2), currentFiscalYear + 2))
                End If
                


                ddlFiscalYear.SelectedValue = currentFiscalYear
            End If


        End Sub

        Protected Sub GridView1_DataBound(sender As Object, e As EventArgs) Handles GridView1.DataBound
            Dim q = From c In d.AP_Budget_Summaries Where c.Portalid = PortalId And c.FiscalYear = CInt(ddlFiscalYear.SelectedValue) And (c.RC = ddlRC.SelectedValue Or ddlRC.SelectedValue = "All" Or (ddlRC.SelectedValue = "AllStaff" And c.AP_StaffBroker_CostCenter.Type = 1))

            lblPTD1.Text = q.Sum(Function(c) c.P1).Value.ToString("0.00")
            lblPTD2.Text = q.Sum(Function(c) c.P2).Value.ToString("0.00")
            lblPTD3.Text = q.Sum(Function(c) c.P3).Value.ToString("0.00")
            lblPTD4.Text = q.Sum(Function(c) c.P4).Value.ToString("0.00")
            lblPTD5.Text = q.Sum(Function(c) c.P5).Value.ToString("0.00")
            lblPTD6.Text = q.Sum(Function(c) c.P6).Value.ToString("0.00")
            lblPTD7.Text = q.Sum(Function(c) c.P7).Value.ToString("0.00")
            lblPTD8.Text = q.Sum(Function(c) c.P8).Value.ToString("0.00")
            lblPTD9.Text = q.Sum(Function(c) c.P9).Value.ToString("0.00")
            lblPTD10.Text = q.Sum(Function(c) c.P10).Value.ToString("0.00")
            lblPTD11.Text = q.Sum(Function(c) c.P11).Value.ToString("0.00")
            lblPTD12.Text = q.Sum(Function(c) c.P12).Value.ToString("0.00")

            lblYTD1.Text = q.Sum(Function(c) c.P1).Value.ToString("0.00")
            lblYTD2.Text = q.Sum(Function(c) c.P1 + c.P2).Value.ToString("0.00")
            lblYTD3.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3).Value.ToString("0.00")
            lblYTD4.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4).Value.ToString("0.00")
            lblYTD5.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4 + c.P5).Value.ToString("0.00")
            lblYTD6.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4 + c.P5 + c.P6).Value.ToString("0.00")
            lblYTD7.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4 + c.P5 + c.P6 + c.P7).Value.ToString("0.00")
            lblYTD8.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4 + c.P5 + c.P6 + c.P7 + c.P8).Value.ToString("0.00")
            lblYTD9.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4 + c.P5 + c.P6 + c.P7 + c.P8 + c.P9).Value.ToString("0.00")
            lblYTD10.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4 + c.P5 + c.P6 + c.P7 + c.P8 + c.P9 + c.P10).Value.ToString("0.00")
            lblYTD11.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4 + c.P5 + c.P6 + c.P7 + c.P8 + c.P9 + c.P10 + c.P11).Value.ToString("0.00")
            lblYTD12.Text = q.Sum(Function(c) c.P1 + c.P2 + c.P3 + c.P4 + c.P5 + c.P6 + c.P7 + c.P8 + c.P9 + c.P10 + c.P11 + c.P12).Value.ToString("0.00")

            lblTotal.Text = lblYTD12.Text
           
            If Not firstFiscalMonth = Nothing Then

                lblP1.Text = GetCalendarStartForPeriod(1, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP2.Text = GetCalendarStartForPeriod(2, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP3.Text = GetCalendarStartForPeriod(3, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP4.Text = GetCalendarStartForPeriod(4, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP5.Text = GetCalendarStartForPeriod(5, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP6.Text = GetCalendarStartForPeriod(6, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP7.Text = GetCalendarStartForPeriod(7, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP8.Text = GetCalendarStartForPeriod(8, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP9.Text = GetCalendarStartForPeriod(9, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP10.Text = GetCalendarStartForPeriod(10, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP11.Text = GetCalendarStartForPeriod(11, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")
                lblP12.Text = GetCalendarStartForPeriod(12, firstFiscalMonth, ddlFiscalYear.SelectedValue).ToString("MMM ""'""yy")


            End If

        End Sub
       

        Protected Function GetCalendarStartForPeriod(ByVal period As Integer, ByVal firstMonth As Integer, ByVal FiscalYear As Integer) As Date
            If period + firstMonth - 1 <= 12 Then
                Return New Date(FiscalYear, period + firstMonth - 1, 1)
            Else
                Return New Date(FiscalYear + 1, period + firstMonth - 13, 1)
            End If
        End Function

        Protected Sub btnInsertRow_Click(sender As Object, e As EventArgs) Handles btnInsertRow.Click
            Dim q = From c In d.AP_Budget_Summaries Where c.Portalid = PortalId And c.FiscalYear = ddlFiscalYear.SelectedValue And c.Account = ddlAccountNew.SelectedValue And c.RC = ddlRCNew.SelectedValue
            If q.Count = 0 Then
                Dim insert As New AP_Budget_Summary
                insert.Portalid = PortalId
                insert.FiscalYear = ddlFiscalYear.SelectedValue
                insert.Account = ddlAccountNew.SelectedValue
                insert.RC = ddlRCNew.SelectedValue
                insert.P1 = tbP1new.Text
                insert.P2 = tbP2new.Text
                insert.P3 = tbP3new.Text
                insert.P4 = tbP4new.Text
                insert.P5 = tbP5new.Text
                insert.P6 = tbP6new.Text
                insert.P7 = tbP7new.Text
                insert.P8 = tbP8new.Text
                insert.P9 = tbP9new.Text
                insert.P10 = tbP10new.Text
                insert.P11 = tbP11new.Text
                insert.P12 = tbP12new.Text
                insert.Changed = True
                insert.LastUpdated = Now
                d.AP_Budget_Summaries.InsertOnSubmit(insert)
                d.SubmitChanges()
                GridView1.DataBind()
                ddlFiscalYear.SelectedValue = ddlFiscalYear.SelectedValue
                ddlRCNew.SelectedIndex = 0
                ddlAccountNew.SelectedIndex = 0
                tbP1new.Text = "0"
                tbP2new.Text = "0"
                tbP3new.Text = "0"
                tbP4new.Text = "0"
                tbP5new.Text = "0"
                tbP6new.Text = "0"
                tbP7new.Text = "0"
                tbP8new.Text = "0"
                tbP9new.Text = "0"
                tbP10new.Text = "0"
                tbP11new.Text = "0"
                tbP12new.Text = "0"
                lblTotalNew.Text = "0"


            Else
                'Budget already exists... replace or addto.
            End If



        End Sub


    End Class
End Namespace
