Imports Microsoft.VisualBasic

Public Class mpdFunctions



    Public Shared Function getBudgetForStaffPeriod(ByVal StaffId As Integer, ByVal Period As String) As Double
        Dim d As New MPD.MPDDataContext

        Dim q = From c In d.AP_mpdCalc_StaffBudgets Where c.StaffId = StaffId And (c.Status = StaffRmb.RmbStatus.Processed Or c.Status = StaffRmb.RmbStatus.Approved) Order By c.BudgetPeriodStart Descending
        Dim r = q.Where(Function(c) c.BudgetPeriodStart <= Period).OrderByDescending(Function(c) c.BudgetPeriodStart)
        If r.Count > 0 Then
            Return r.First.ToRaise
        End If
        If q.Count > 0 Then
            Return q.First.ToRaise
        End If
        q = From c In d.AP_mpdCalc_StaffBudgets Where c.StaffId = StaffId And (c.Status = StaffRmb.RmbStatus.Draft) Order By c.BudgetPeriodStart Descending
        If q.Count > 0 Then
            Return q.First.ToRaise
        End If

        Return 0
    End Function

    Public Shared Function getAverageMonthlyIncomeOver12Periods(ByVal StaffId As Integer) As Double
        Try


            Dim d As New MPD.MPDDataContext
            Dim q = (From c In d.Ap_mpd_Users Where c.StaffId = StaffId Select c.AvgIncome12).First

            Return q
        Catch ex As Exception

        End Try

        Return 0.0

    End Function

End Class
