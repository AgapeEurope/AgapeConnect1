﻿Imports DotNetNuke
Imports DotNetNuke.Security
Imports StaffBroker

Partial Class DesktopModules_AgapePortal_StaffBroker_Plebs
    Inherits System.Web.UI.UserControl


    Private _UID As Integer
    Public Property UID() As Integer
        Get
            Return _UID
        End Get
        Set(ByVal value As Integer)
            _UID = value

            hfUserId.Value = _UID
        End Set
    End Property
    Private _CanRemove As Boolean = True
    Public Property CanRemove() As Boolean
        Get
            Return _CanRemove
        End Get
        Set(ByVal value As Boolean)
            _CanRemove = value

        End Set
    End Property




    Dim d As New StaffBrokerDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender

        If Not Page.IsPostBack Then
            hfUserId.Value = _UID
        End If

    End Sub





    Protected Sub DataList2_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList2.ItemCommand
        If e.CommandName = "RemovePleb" Then
            Dim q = From c In d.AP_StaffBroker_LeaderMetas Where (c.LeaderId = CInt(hfUserId.Value) Or c.DelegateId = CInt(hfUserId.Value)) And c.UserId = CInt(e.CommandArgument)
            If q.Count > 0 Then
                If q.First.LeaderId = CInt(hfUserId.Value) Then
                    d.AP_StaffBroker_LeaderMetas.DeleteAllOnSubmit(q)
                Else
                    'I am the delegate - Just remove me
                    q.First.DelegateId = Nothing
                End If
            End If

            d.SubmitChanges()
            DataList2.DataBind()

            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            StaffBrokerFunctions.SetSetting("tntFlag", "Dirty", PS.PortalId)
        ElseIf e.CommandName = "RemoveDelegate" Then
            Dim q = From c In d.AP_StaffBroker_LeaderMetas Where c.LeaderId = CInt(hfUserId.Value) And c.UserId = CInt(e.CommandArgument)
            If q.Count > 0 Then
                q.First.DelegateId = Nothing
            End If

            d.SubmitChanges()
            DataList2.DataBind()

            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            StaffBrokerFunctions.SetSetting("tntFlag", "Dirty", PS.PortalId)
        End If
        Try
            Dim x As New tntWebUsers()
            x.RefreshWebUsers({CInt(hfUserId.Value)})
        Catch ex As Exception

        End Try
    End Sub
    Public Function isDelegated(ByVal PlebId As Integer) As Boolean
        Dim q = From c In d.AP_StaffBroker_LeaderMetas Where c.LeaderId = CInt(hfUserId.Value) And c.UserId = PlebId And Not c.Delegate Is Nothing
        Return q.Count > 0
    End Function
    Public Function amIDelegate(ByVal PlebId As Integer) As Boolean
        Dim q = From c In d.AP_StaffBroker_LeaderMetas Where c.DelegateId = CInt(hfUserId.Value) And c.UserId = PlebId And Not c.Delegate Is Nothing
        Return q.Count > 0
    End Function

    Public Function GetDelegateName(ByVal PlebId As Integer) As String
        Dim q = From c In d.AP_StaffBroker_LeaderMetas Where c.LeaderId = CInt(hfUserId.Value) And c.UserId = PlebId And Not c.Delegate Is Nothing
        If q.Count > 0 Then

            Return q.First.Delegate.FirstName & " " & q.First.Delegate.LastName

        End If
        Return ""
    End Function
    Public Function GetLeaderName(ByVal PlebId As Integer) As String
        Dim q = From c In d.AP_StaffBroker_LeaderMetas Where c.DelegateId = CInt(hfUserId.Value) And c.UserId = PlebId And Not c.Delegate Is Nothing
        If q.Count > 0 Then

            Return q.First.Leaders.FirstName & " " & q.First.Leaders.LastName

        End If
        Return ""
    End Function
    Protected Sub btnDelegate_Click(sender As Object, e As System.EventArgs) Handles btnDelegate.Click


        Dim q = From c In d.AP_StaffBroker_LeaderMetas Where c.LeaderId = CInt(hfUserId.Value) And (c.UserId = CInt(hfPlebId.Value) Or CheckBox1.Checked)

        d.AP_StaffBroker_LeaderMetas.DeleteAllOnSubmit(q)
        For Each row In q
            Dim insert As New AP_StaffBroker_LeaderMeta
            insert.DelegateId = CInt(ddlDelegate.SelectedValue)
            insert.LeaderId = CInt(hfUserId.Value)
            insert.UserId = row.UserId
            d.AP_StaffBroker_LeaderMetas.InsertOnSubmit(insert)

            'If row.Delegate Is Nothing Then
            '    If ddlDelegate.SelectedIndex = 0 Then
            '        row.DelegateId = Nothing
            '    Else


            '        row.DelegateId = CInt(ddlDelegate.SelectedValue)
            '    End If
            'End If
        Next




        d.SubmitChanges()
        DataList2.DataBind()

        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        StaffBrokerFunctions.SetSetting("tntFlag", "Dirty", PS.PortalId)

        Try
            Dim x As New tntWebUsers()
            x.RefreshWebUsers({CInt(ddlDelegate.SelectedValue)})
        Catch ex As Exception

        End Try
    End Sub
End Class
