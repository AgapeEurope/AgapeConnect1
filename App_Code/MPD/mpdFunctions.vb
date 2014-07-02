﻿Imports Microsoft.VisualBasic

Public Class mpdFunctions


    Public Shared Function CreateNewDef(ByVal PortalId As Integer, ByVal TabModuleId As Integer) As MPD.AP_mpdCalc_Definition
        Dim d As New MPD.MPDDataContext

        Dim template = d.AP_mpdCalc_Definitions.Where(Function(c) c.PortalId = -1).First
        Dim insert As New MPD.AP_mpdCalc_Definition
        insert.ActiveFromYear = Today.Year
        insert.Assessment = template.Assessment
        insert.AssessmentRate = template.AssessmentRate
        insert.Complience = template.Complience
        insert.Compensation = template.Compensation
        Dim ffm As String = StaffBrokerFunctions.GetSetting("FirstFiscalMonth", PortalId)
        If Not String.IsNullOrEmpty(ffm) Then
            insert.FirstBudgetPeriod = ffm
        Else
            insert.FirstBudgetPeriod = template.FirstBudgetPeriod
        End If
        insert.PortalId = PortalId
        insert.TabModuleId = TabModuleId
        insert.ShowComplience = template.ShowComplience
        Dim ds As New StaffBroker.StaffBrokerDataContext

        For Each row In ds.AP_StaffBroker_StaffTypes.Where(Function(c) c.PortalId = PortalId And c.Name.Contains("National") Or c.Name = ("Central"))
            insert.StaffTypes &= row.StaffTypeId & ";"
        Next
        d.AP_mpdCalc_Definitions.InsertOnSubmit(insert)
        d.SubmitChanges()

        For Each row In template.AP_mpdCalc_Sections
            Dim insertS As New MPD.AP_mpdCalc_Section
            insertS.mpdDefId = insert.mpdDefId
            insertS.Name = row.Name
            insertS.Number = row.Number
            insertS.TotalMode = row.TotalMode
            d.AP_mpdCalc_Sections.InsertOnSubmit(insertS)
            d.SubmitChanges()

            For Each q In row.AP_mpdCalc_Questions
                Dim insertQ As New MPD.AP_mpdCalc_Question
                insertQ.AccountCode = ""
                insertQ.Fixed = q.Fixed
                insertQ.Formula = q.Formula
                insertQ.Help = q.Help
                insertQ.Max = q.Max
                insertQ.Min = q.Min
                insertQ.Name = q.Name
                insertQ.QuestionNumber = q.QuestionNumber
                insertQ.Rate1 = q.Rate1
                insertQ.Rate2 = q.Rate2
                insertQ.Rate3 = q.Rate3
                insertQ.Rate4 = q.Rate4
                insertQ.TaxSystem = q.TaxSystem
                insertQ.SectionId = insertS.SectionId
                insertQ.Threshold1 = q.Threshold1
                insertQ.Threshold2 = q.Threshold2
                insertQ.Threshold3 = q.Threshold3
                insertQ.Type = q.Type

                d.AP_mpdCalc_Questions.InsertOnSubmit(insertQ)
                d.SubmitChanges()

            Next
        Next

        Return insert
    End Function


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
