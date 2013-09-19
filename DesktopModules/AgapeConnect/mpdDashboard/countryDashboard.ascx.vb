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
Imports StaffBrokerFunctions

Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class countryDashboard
        Inherits Entities.Modules.PortalModuleBase

        Public jsonPI = ""
        Public jsonLi = ""


        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load


            'Dim dt As New dynamicTnT2.TntMPDDataServerWebService2

            'dt.Url = "https://tntdataserver.eu/dataserver/uk/dataquery/DataQueryService2.asmx"
            'dt.Discover()
            'Dim tuPass = StaffBrokerFunctions.GetSetting("TrustedUserPassword", 0)
            'Dim SessionId As String
            'If String.IsNullOrEmpty(System.Web.HttpContext.Current.Session("tntSessionId")) Then
            '    Dim objKey As New KeyUser.KeyAuthentication("trusteduser@agapeconnect.me", tuPass, "https://tntdataserver.eu/dataserver/uk/")

            '    Dim Login = dt.Auth_Login("https://tntdataserver.eu/dataserver/uk/", objKey.ProxyTicket, False)
            '    SessionId = Login.SessionID
            '    System.Web.HttpContext.Current.Session("tntSessionId") = SessionId
            'Else
            '    SessionId = System.Web.HttpContext.Current.Session("tntSessionId")
            'End If

            'Dim q = dt.WebUserMgmt_StaffProfile_GetFinancialAccountInfo(SessionId, "jon@vellacott.co.uk", "")
            'q.AllAccounts.Count()

            Dim d As New MPDDataContext
            Dim thisCountry = From c In d.AP_mpd_Countries Where c.isoCode = Request.QueryString("country")

            If thisCountry.Count > 0 Then


                Dim ds As New StaffBroker.StaffBrokerDataContext
                Dim localStaffTypes = {"National Staff", "National Staff, Overseas"}
                Dim allLocalStaff = From c In ds.AP_StaffBroker_Staffs Where c.PortalId = thisCountry.First.portalId And localStaffTypes.Contains(c.AP_StaffBroker_StaffType.Name) Select c.StaffId





                Dim incomeData = From c In thisCountry.First.AP_mpd_UserAccountInfos Where c.period > Today.AddMonths(-12).ToString("yyyyMM") And allLocalStaff.Contains(c.staffId) And c.AP_mpd_Country.AP_mpdCalc_Definitions.AP_mpdCalc_StaffBudgets.Where(Function(x) x.StaffId = c.staffId).Count > 0 _
                    Select Period = c.period, staffId = c.staffId, income = c.income, expense = c.expense, Budget = (c.AP_mpd_Country.AP_mpdCalc_Definitions.AP_mpdCalc_StaffBudgets.Where(Function(x) x.StaffId = c.staffId).First.TotalBudget)


                Dim groupedData = From c In incomeData Where c.Budget > 0 Group By c.staffId Into Group Select Group.Average(Function(x) x.income / x.Budget)


                Dim g1 = groupedData.Where(Function(c) c < 0.5).Count
                Dim g2 = groupedData.Where(Function(c) c >= 0.5 And c < 0.75).Count
                Dim g3 = groupedData.Where(Function(c) c >= 0.75 And c < 0.9).Count
                Dim g4 = groupedData.Where(Function(c) c >= 0.9 And c < 1.0).Count
                Dim g5 = groupedData.Where(Function(c) c >= 1.0).Count
                Dim g0 = allLocalStaff.Count - (g1 + g2 + g3 + g4 + g5)








                jsonPI = "['No Budget', " & g0 & "],"
                jsonPI &= "['<50% Raised', " & g1 & "],"
                jsonPI &= "['50-75% Raised', " & g2 & "],"
                jsonPI &= "['75-90% Raised', " & g3 & "],"
                jsonPI &= "['90-100% Raised', " & g4 & "],"
                jsonPI &= "['>100% Raised', " & g5 & "]"

                jsonLi = ""
                For i As Integer = -12 To -1
                    Dim AvgSupport = (From c In incomeData Where c.Period = Today.AddMonths(i).ToString("yyyyMM") Select c.income / c.Budget)
                    Dim ag = 0.0
                    Dim full = 0.0
                    If AvgSupport.Count > 0 Then
                        ag = AvgSupport.Average()
                        full = AvgSupport.Where(Function(c) c > 0.9).Count / allLocalStaff.Count
                    End If




                    jsonLi &= "['" & Today.AddMonths(i).ToString("MMM yy") & "', " & ag.ToString("0.00") & ", " & full.ToString("0.00") & " ], "



                Next

                lblAvgSupport.Text = (groupedData.Average() * 100.0).Value.ToString("0.0") & "%"
                Dim bva = (From c In incomeData Select 100 * c.expense / c.Budget).Average.Value
                lblBdgVsAct.Text = bva.ToString("0.0") & "%"
                lblBdgVsActLabel.Text = IIf(bva > 1, "(budgets under-estimated expenses)", "(budgets over-estimated expenses)")

            End If

        End Sub


    End Class
End Namespace
