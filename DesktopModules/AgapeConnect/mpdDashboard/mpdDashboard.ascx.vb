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
            For Each thisCountry In d.AP_mpd_Countries
                Dim ds As New StaffBroker.StaffBrokerDataContext
                Dim localStaffTypes = {"National Staff", "National Staff, Overseas"}
                Dim allLocalStaff = From c In ds.AP_StaffBroker_Staffs Where c.PortalId = thisCountry.portalId And localStaffTypes.Contains(c.AP_StaffBroker_StaffType.Name) Select c.StaffId





                Dim incomeData = From c In thisCountry.AP_mpd_UserAccountInfos Where c.period > Today.AddMonths(-12).ToString("yyyyMM") And allLocalStaff.Contains(c.staffId) And c.AP_mpd_Country.AP_mpdCalc_Definitions.AP_mpdCalc_StaffBudgets.Where(Function(x) x.StaffId = c.staffId).Count > 0 _
                    Select Period = c.period, staffId = c.staffId, income = c.income, expense = c.expense, Budget = mpdFunctions.getBudgetForStaffPeriod(c.staffId, c.period)


               
                Dim avgSupport = (From c In incomeData Where c.Budget > 0 Select 100 * c.income / c.Budget).Average

                jsonMap &= "['" & thisCountry.isoCode & "', " & avgSupport.ToString("0.0") & "],"

            Next

        End Sub


    End Class
End Namespace
