Imports Billboard
Imports System.Linq
Imports System.Web.UI
Imports DotNetNuke
Imports System.Data.Linq

Partial Class DesktopModules_Billboard_controls_FeatArchive
    Inherits System.Web.UI.UserControl
    Dim ThisMode As Integer = -1
    'Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
    '    fillPlace()
    '    Dim t As Type = btnNewType.GetType()
    '    Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
    '    sb.Append("<script language='javascript'>")
    '    sb.Append("setUpMyFeat();")
    '    sb.Append("</script>")
    '    ScriptManager.RegisterStartupScript(btnNewType, t, "popupAdd2", sb.ToString, False)
    'End Sub
    Public Sub Initialise(ByVal Mode As Integer)
        ThisMode = Mode
        hfMode.Value = Mode
        'fillPlace()
        'Dim t As Type = btnNewType.GetType()
        'Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
        'sb.Append("<script language='javascript'>")
        'sb.Append("setUpMyFeat();")
        'sb.Append("</script>")
        'ScriptManager.RegisterStartupScript(btnNewType, t, "popupAdd2", sb.ToString, False)
        'accFeat.DataBind()
        If Mode = 1 Then
            pnlKey.Visible = False
            pnlFeatType.Visible = False
        Else
            pnlKey.Visible = True
            pnlFeatType.Visible = True
        End If
    End Sub
    Public Function GetArcData(ByVal ThisType As Integer) As IQueryable(Of Billboard.Agape_Billboard_Feature)
        If hfMode.Value = "" Or hfMode.Value Is Nothing Then
            ThisMode = 1
        Else
            ThisMode = hfMode.Value
        End If

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Features Where 1 = 0 Select c
        If ThisMode = 1 Then
            q = From c In d.Agape_Billboard_Features Where c.Current = False And c.Sent = True And c.Visible = True And c.FeatType = ThisType Select c
        ElseIf ThisMode = 2 Then
            q = From c In d.Agape_Billboard_Features Where c.FeatType = ThisType Select c

        End If
        Return q
    End Function

    Public Function IsVisible() As Boolean
        Dim Out As Boolean = False
        If ThisMode = 2 Then
            Out = True
        End If
        Return Out
    End Function
    Public Function ColourMeGray(ByVal ThisVisible As Boolean, ByVal ThisSent As Boolean) As String
        Dim Out As String = ""

        If hfMode.Value = "" Or hfMode.Value Is Nothing Then
            ThisMode = 1
        End If

        If ThisMode = 2 Then
            If ThisVisible And Not ThisSent Then
                Out = "BackClear"
            ElseIf Not ThisVisible And Not ThisSent Then
                Out = "BackBlue"
            ElseIf ThisVisible And ThisSent Then
                Out = "BackYellow"
            ElseIf Not ThisVisible And ThisSent Then
                Out = "BackGreen"
            End If
        End If


        Return Out
    End Function
    Public Function CleanText(ByVal ThisText As String) As String
        Dim Out = ""

        Out = Billboard.BillboardFunctions.StripBillTags(ThisText)
        Out = Out.Substring(0, Math.Min(500, Out.Length)) & "..."

        Return Out
    End Function
    Public Function NameCategory(ByVal ThisCatId As Integer) As String
        Dim out = ""

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Feature_Types Where c.TypeNumber = ThisCatId

        If q.Count = 1 Then
            out = q.First.TypeName
        End If

        Return out
    End Function

    Public Delegate Sub MyEventHandler(ByVal sender As Object, ByVal e As ArchEventArgs)
    Public Event MyEvent As MyEventHandler
    Protected Overridable Sub OnEvent(ByVal e As ArchEventArgs)
        RaiseEvent MyEvent(Me, e)
    End Sub
    Protected Sub gvNextFeat_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvNextFeat.RowCommand
        If e.CommandName = "SetToNext" Then
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = CInt(e.CommandArgument)

            If q.Count = 1 Then
                If q.First.Next = False And q.First.Visible = True And q.First.Current = False And q.First.Sent = False Then
                    Dim r = From c In d.Agape_Billboard_Features Where c.Next = True
                    If r.Count > 0 Then
                        r.First.Next = False
                    End If
                    q.First.Next = True
                    d.SubmitChanges()
                    gvNextFeat.DataBind()
                End If
            End If
        End If
    End Sub
    Protected Sub dlMain2_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        If e.CommandName = "MyEdit" Then
            Try
                OnEvent(New ArchEventArgs(CInt(e.CommandArgument) * -1, hfMode.Value))
            Catch ex As Exception
                lblControlError.Text = ex.Message
                lblControlError.Visible = True
            End Try
        ElseIf e.CommandName = "GoTo" Then
            Try
                OnEvent(New ArchEventArgs(CInt(e.CommandArgument), hfMode.Value))
            Catch ex As Exception
                lblControlError.Text = ex.Message
                lblControlError.Visible = True
            End Try

        End If
    End Sub
    Protected Sub updateAccordian(sender As Object, e As System.EventArgs) Handles gvFeatType.DataBound
        'accFeat.DataBind()
    End Sub
    Protected Sub btnNewType_Click(sender As Object, e As System.EventArgs) Handles btnNewType.Click
        If Not tbNewType.Text = "" Then
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Feature_Types Where c.TypeName = tbNewType.Text Select c
            If q.Count = 0 Then
                Dim insert As New Billboard.Agape_Billboard_Feature_Type
                Dim r = From c In d.Agape_Billboard_Feature_Types Where 1 = 1 Order By c.TypeNumber Descending
                insert.TypeName = tbNewType.Text
                If r.Count = 0 Then
                    insert.TypeNumber = 1
                Else
                    insert.TypeNumber = r.First.TypeNumber + 1
                End If
                d.Agape_Billboard_Feature_Types.InsertOnSubmit(insert)
                d.SubmitChanges()
                lblNewTypeError.Visible = False
                gvFeatType.DataBind()
                tbNewType.Text = ""
            Else
                lblNewTypeError.Text = "There is already a Feature Type with this name."
                lblNewTypeError.Visible = True
            End If
        Else
            lblNewTypeError.Text = "You must type a Feature Type name into the box."
            lblNewTypeError.Visible = True
        End If
        Initialise(hfMode.Value)
    End Sub
End Class
Public Class ArchEventArgs
    Inherits EventArgs
    Private ReadOnly DoSomething As Integer
    Private ReadOnly ThisMode As Integer
    Public Sub New(ByVal Switch As Integer, ByVal Mode As Integer)
        Me.DoSomething = Switch
        Me.ThisMode = Mode
    End Sub
    Public ReadOnly Property Switch() As Integer
        Get
            Return DoSomething
        End Get
    End Property
    Public ReadOnly Property Mode() As Integer
        Get
            Return ThisMode
        End Get
    End Property
End Class
