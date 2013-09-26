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
    Partial Class mpdDashboard
        Inherits Entities.Modules.PortalModuleBase


        Public jsonMap As String = ""


        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            Dim d As New MPDDataContext
            jsonMap = ""
            Dim tableData As New ArrayList

            Dim dt As New DataTable()
            dt.Columns.Add("Name")
            dt.Columns.Add("Year")
            dt.Columns.Add("Quarter")
            dt.Columns.Add("Month")
            dt.Columns.Add("Budget")
            dt.Columns.Add("Accuracy")
            dt.Columns.Add("ISO")

            For Each thisCountry In d.AP_mpd_Countries
                Dim ds As New StaffBroker.StaffBrokerDataContext
                Dim localStaffTypes = {"National Staff", "National Staff, Overseas"}
                Dim allLocalStaff = From c In ds.AP_StaffBroker_Staffs Where c.PortalId = thisCountry.portalId And localStaffTypes.Contains(c.AP_StaffBroker_StaffType.Name) Select c.StaffId


             
                Dim lastPeriod As String = thisCountry.AP_mpd_UserAccountInfos.Where(Function(c) c.income > 0).Max(Function(c) c.period)
                If String.IsNullOrEmpty(lastPeriod) Then
                    lastPeriod = Today.ToString("yyyyMM")
                End If
                Dim LastPeriodDate = New Date(CInt(Left(lastPeriod, 4)), CInt(Right(lastPeriod, 2)), 1)

                Dim firstPeriod As String = LastPeriodDate.AddMonths(-12).ToString("yyyyMM")
                Dim quateerPeriod As String = LastPeriodDate.AddMonths(-3).ToString("yyyyMM")
                Dim monthPeriod As String = LastPeriodDate.AddMonths(-1).ToString("yyyyMM")




                Dim incomeData = From c In thisCountry.AP_mpd_UserAccountInfos Where c.period >= firstPeriod And c.period <= lastPeriod And allLocalStaff.Contains(c.staffId) And c.AP_mpd_Country.AP_mpdCalc_Definitions.AP_mpdCalc_StaffBudgets.Where(Function(x) x.StaffId = c.staffId).Count > 0 _
                    Select Period = c.period, staffId = c.staffId, income = c.income, expense = c.expense, Budget = mpdFunctions.getBudgetForStaffPeriod(c.staffId, c.period)


               
                Dim avgSupport = (From c In incomeData Where c.Budget > 0 Select 100 * c.income / c.Budget).Average

                jsonMap &= "['" & thisCountry.isoCode & "', " & avgSupport.ToString("0.0") & "],"

                Dim Quarter = incomeData.Where(Function(c) c.Period >= quateerPeriod).Average(Function(c) c.income / c.Budget)
                Dim Month = incomeData.Where(Function(c) c.Period >= monthPeriod).Average(Function(c) c.income / c.Budget)
                Dim Accuracy = (From c In incomeData Where c.Budget > 0 And c.expense < 0 Select c.Budget / -c.expense).Average
                Dim withBud = incomeData.Where(Function(c) c.Period >= monthPeriod And c.Period < lastPeriod And c.Budget > 0).Count / allLocalStaff.Count
                

                dt.Rows.Add(thisCountry.name, avgSupport.ToString("0.0") & "%", Quarter.ToString("0.0%"), Month.ToString("0.0%"), withBud.ToString("0.0%"), Accuracy.ToString("0.0%"), thisCountry.isoCode)


            Next
            rpCountriesSummaryData.DataSource = dt
            rpCountriesSummaryData.DataBind()
           
        End Sub


    End Class
End Namespace
