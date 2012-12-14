Imports System.Linq
Imports Billboard

Partial Class DesktopModules_Billboard_controls_EditPrayer
    Inherits System.Web.UI.UserControl
    Private Sub updatePanel1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles UpdatePanel1.Load
        If Not Page.IsPostBack Then
            hfEditPrayerId.Value = -1
        End If
        Dim NowLessMonth As Date
        NowLessMonth = DateAdd(DateInterval.Month, -1.0, Now())
        hfNowLessMonth.Value = NowLessMonth
        pnlEdit.Visible = False
        pnlTable.Visible = True
        gvPrayer.DataBind()


    End Sub
    Public Sub Initialise(Optional ByVal ThisUser As Integer = -1)
        If Not Page.IsPostBack Then
            hfEditPrayerId.Value = -1
        End If
        Dim NowLessMonth As Date
        NowLessMonth = DateAdd(DateInterval.Month, -1.0, Now())
        hfNowLessMonth.Value = NowLessMonth
        pnlEdit.Visible = False
        pnlTable.Visible = True
        gvPrayer.DataBind()
        If ThisUser > 0 Then
            hfThisUser.Value = ThisUser
            tbSubmittedBy.Text = DisplayThisName(hfThisUser.Value)
        End If

    End Sub
    Protected Sub LinkButton3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton3.Click
        gvPrayer.DataBind()
        UpdatePanel1.Update()
    End Sub
    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Dim d As New Billboard.BillboardDataContext
        Dim insert As New Billboard.Agape_Billboard_Prayer
        insert.PrayerText = tbText.Text
        insert.PrayerTitle = tbTitle.Text
        If cbVisible.Checked Then
            insert.Visible = True
            insert.Current = True
        Else
            insert.Visible = False
            insert.Current = False
        End If
        insert.SubmittedDate = CDate(Now())
        insert.SubmittedBy = hfThisUser.Value
        insert.Sent = False
        If tbSubmittedBy.Text <> DisplayThisName(hfThisUser.Value) Then
            insert.SubBehalf = tbSubmittedBy.Text
        End If
        d.Agape_Billboard_Prayers.InsertOnSubmit(insert)
        d.SubmitChanges()
        gvPrayer.DataBind()
        pnlEdit.Visible = False
        pnlTable.Visible = True
        tbText.Text = ""
        tbTitle.Text = ""
        cbVisible.Checked = True
        tbSubmittedBy.Text = DisplayThisName(hfThisUser.Value)
    End Sub

    Protected Sub gvPrayer_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvPrayer.RowCommand
        Dim d As New Billboard.BillboardDataContext
        If e.CommandName = "MyEdit" Then
            Dim ThisPrayerId As Integer = CInt(e.CommandArgument)
            Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = ThisPrayerId
            If q.Count > 0 Then
                hfEditPrayerId.Value = ThisPrayerId
                lblAuthorDate.Text = (From c In d.Users Where c.UserID = q.First.SubmittedBy Select c.DisplayName).First & ", " & CDate(q.First.SubmittedDate).ToString("dd/MM/yyyy")
                If q.First.Sent = True Then
                    lblEditError.Text = "You can only make this visible or invisble as it has already been sent"
                    lblEditError.Visible = True
                    tbEditText.Enabled = False
                    tbEditTitle.Enabled = False
                    tbEditSub.Enabled = False
                Else
                    lblEditError.Visible = False
                    tbEditText.Enabled = True
                    tbEditTitle.Enabled = True
                End If
                tbEditText.Text = q.First.PrayerText
                tbEditTitle.Text = q.First.PrayerTitle
                If q.First.SubBehalf = Nothing Then
                    tbEditSub.Text = DisplayThisName(hfThisUser.Value)
                Else
                    tbEditSub.Text = q.First.SubBehalf
                End If
                cbEditVisible.Checked = q.First.Visible
                pnlTable.Visible = False
                pnlEdit.Visible = True
            End If
        ElseIf e.CommandName = "MyDelete" Then
            Dim deletePrayerId As Integer = CInt(e.CommandArgument)
            Dim r = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = deletePrayerId
            If r.Count > 0 Then
                d.Agape_Billboard_Prayers.DeleteOnSubmit(r.First)
                d.SubmitChanges()
                gvPrayer.DataBind()
            End If
        End If
    End Sub
    Public Sub ClearOld()
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Prayers Where c.SubmittedDate <= DateAdd(DateInterval.Month, -1.0, Now()) Select c
        If q.Count > 0 Then
            For Each OldPrayer In q
                OldPrayer.Current = 0
            Next
            d.SubmitChanges()
        End If
        gvPrayer.DataBind()
    End Sub
    Public Function ButtonEnabled(ByVal PrayerId As Integer) As Boolean
        Dim Out As Boolean = False

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = PrayerId
        If q.Count > 0 Then
            If q.First.Sent = False Then
                Out = True
            End If
        End If

        Return Out
    End Function
    Public Function ButtonEnabled2(ByVal PrayerId As Integer) As Boolean
        Dim Out As Boolean = False

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = PrayerId
        Dim r = From c In d.Agape_Billboard_Prayers Where c.Visible = True And c.Sent = False
        If q.Count > 0 And r.Count > 1 Then
            If q.First.Visible = True And q.First.Sent = False Then
                Out = True
            End If
        End If

        Return Out
    End Function
    Public Function DisplayThisName(ByVal ThisUser As Integer) As String
        Dim Out As String = ""

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Users Where c.UserID = ThisUser
        If q.Count > 0 Then
            Out = q.First.DisplayName
        End If

        Return Out
    End Function
    Public Function DisplayThisName2(ByVal ThisPrayer As Integer) As String
        Dim Out As String = ""

        Dim d As New Billboard.BillboardDataContext
        Dim r = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = ThisPrayer

        If r.Count > 0 Then
            Dim q = From c In d.Users Where c.UserID = r.First.SubmittedBy
            If q.Count > 0 Then
                Out = q.First.DisplayName
            End If
            If Not (r.First.SubBehalf = Nothing) Then
                Out &= " on behalf of " & r.First.SubBehalf
            End If
        End If


        Return Out
    End Function

    Protected Sub gvPrayer_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvPrayer.RowDataBound
        Try
            Dim PrayerId As Integer = DataBinder.Eval(e.Row.DataItem, "BillboardPrayerId")
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = PrayerId
            If q.Count > 0 Then
                If q.First.Visible Then
                    If q.First.Sent Then
                        e.Row.BackColor = Color.FromArgb(16777113)
                    Else
                        e.Row.BackColor = Color.Transparent
                    End If
                Else
                    If q.First.Sent Then
                        e.Row.BackColor = Color.FromArgb(13434828)
                    Else
                        e.Row.BackColor = Color.FromArgb(13434879)
                    End If
                End If
            End If
        Catch ex As Exception
            lblError.Text = "Error in row colouring: " & ex.Message
            lblError.Visible = True
        End Try
    End Sub
    Protected Sub btnCanceleEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelEdit.Click
        pnlEdit.Visible = False
        pnlTable.Visible = True
    End Sub
    Protected Sub btnUpdateEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateEdit.Click
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = hfEditPrayerId.Value
        If q.Count > 0 Then
            Dim VisibleCurrent As Boolean = cbEditVisible.Checked
            Dim TextCurrent As String = tbEditText.Text
            Dim TitleCurrent As String = tbEditTitle.Text
            Dim SubCurrent As String = tbEditSub.Text
            If (TextCurrent = "" Or TitleCurrent = "" Or tbEditSub.Text = "") And VisibleCurrent Then
                lblEditError.Text = "Each Prayer request must have a title and some text and a submitter."
                lblEditError.Visible = True
            Else
                If q.First.Visible = False And VisibleCurrent Then
                    If q.First.Sent Then
                        q.First.Current = False
                        q.First.Visible = True
                    Else
                        q.First.Visible = True
                        q.First.Current = True
                    End If
                ElseIf q.First.Visible = True And VisibleCurrent = False Then
                    q.First.Current = False
                    q.First.Visible = False
                End If
                q.First.PrayerText = TextCurrent
                q.First.PrayerTitle = TitleCurrent
                If Not (SubCurrent = DisplayThisName(hfThisUser.Value)) Then
                    q.First.SubBehalf = SubCurrent
                End If
                d.SubmitChanges()
                lblError.Visible = False
                gvPrayer.DataBind()
                pnlEdit.Visible = False
                pnlTable.Visible = True
            End If
        Else
            lblEditError.Text = "There was an error finding this prayer request to save it."
            lblEditError.Visible = True
        End If
    End Sub

    Protected Sub gvPrayer_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvPrayer.PageIndexChanged
        UpdatePanel1.Update()
    End Sub
End Class
