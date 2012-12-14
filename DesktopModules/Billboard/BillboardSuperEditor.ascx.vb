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
Imports System.Net.Mail
Imports DotNetNuke
Imports DotNetNuke.Security
Imports DotNetNuke.Modules.FeatArchive.ArchEventArgs
Imports DotNetNuke.Modules.ArtArchive.ArtArchEventArgs
Imports Billboard
Imports StaffBroker


Namespace DotNetNuke.Modules.Billboard
    Public Class MyBdayStruct

        Private MyTextValue As String
        Public Property MyText() As String
            Get
                Return MyTextValue
            End Get
            Set(ByVal value As String)
                MyTextValue = value
            End Set
        End Property

        Private ThisDateValue As Date
        Public Property ThisDate() As Date
            Get
                Return ThisDateValue
            End Get
            Set(ByVal value As Date)
                ThisDateValue = value
            End Set
        End Property




        Public Sub New()

        End Sub
    End Class
    Partial Class BillboardSuperEditor
        Inherits Entities.Modules.PortalModuleBase
        Private ThisSuccess As String = ""
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            If Not Page.IsPostBack Then
                Dim d As New BillboardDataContext
                Try
                    Dim ThisSession As Integer = Session("BillboardSuperTab")
                    If ThisSession > -1 Then
                        hfCurrentPanel.Value = Session("BillboardSuperTab")
                    Else
                        Session("BillboardSuperTab") = 0
                        hfCurrentPanel.Value = 0
                    End If
                Catch ex As Exception
                    Session("BillboardSuperTab") = 0
                    hfCurrentPanel.Value = 0
                End Try
                billArch.Initialise(2)
                artArch.Initialise(2)
                'billComm.Initialise(Me.UserId, 2)
                InitLinks()
                InitAnn()
                InitComm()
                editPrayer.Initialise(Me.UserId)



                Dim q = From c In d.Agape_Billboard_Sends Where c.ErrorSend = "Success-multiple sent" Order By c.SendDate Descending
                If q.Count > 0 Then
                    lblLastBillboard.Text = CDate(q.First.SendDate).ToString("dd/MM/yyyy")
                    lblLastBillboard.Visible = True
                Else
                    lblLastBillboard.Text = ""
                    lblLastBillboard.Visible = False
                End If

            End If

        End Sub
        Protected Sub btnEditAnn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEditAnn.Click
            Response.Redirect(EditUrl("editAnn") & "?Mode=2")
        End Sub
        Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSend.Click
            Dim d As New BillboardDataContext
            Dim r = From c In d.Agape_Billboard_Features Where c.Next = True
            If r.Count = 1 Then
                UpdateSend(3)
                If ThisSuccess <> "" Then
                    lblBillSendOut.Text = ThisSuccess
                    lblBillSendOut.ForeColor = Color.Red
                    lblBillSendOut.Visible = True
                Else
                    RefreshPanel()
                    Dim q = From c In d.Agape_Billboard_Sends Where c.ErrorSend = "Success-multiple sent" Order By c.SendDate Descending
                    If q.Count > 0 Then
                        lblLastBillboard.Text = CDate(q.First.SendDate).ToString("dd/MM/yyyy")
                        lblLastBillboard.Visible = True
                    Else
                        lblLastBillboard.Text = ""
                        lblLastBillboard.Visible = False
                    End If
                End If

            Else
                lblBillSendOut.Text = "There is no feature article set to be the next visible feature. Please set one and then try again."
                lblBillSendOut.Visible = True
            End If

        End Sub
        Protected Sub btnTest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTest.Click
            Try
                Dim d As New BillboardDataContext
                Dim r = From c In d.Agape_Billboard_Features Where c.Next = True
                If r.Count = 1 Then
                    UpdateSend(1)
                    RefreshPanel()
                Else
                    lblBillSendOut.Text = "There is no feature article set to be the next visible feature. Please set one and then try again."
                    lblBillSendOut.Visible = True
                End If
            Catch ex As Exception
                lblBillSendOut.Text = ex.Message
                lblBillSendOut.Visible = True
            End Try
            
        End Sub
        Protected Sub btnTestSend_Click(sender As Object, e As System.EventArgs) Handles btnTestSend.Click
            Try
                Dim d As New BillboardDataContext
                Dim r = From c In d.Agape_Billboard_Features Where c.Next = True
                If r.Count = 1 And Not tbTestSend.Text = "" Then
                    UpdateSend(4)
                    If ThisSuccess <> "" Then
                        lblBillSendOut.Text = ThisSuccess
                        lblBillSendOut.ForeColor = Color.Red
                        lblBillSendOut.Visible = True
                    Else
                        RefreshPanel()
                    End If

                Else
                    lblBillSendOut.Text = "There is no feature article set to be the next visible feature. Please set one and then try again."
                    lblBillSendOut.Visible = True
                End If
            Catch ex As Exception
                lblBillSendOut.Text = ex.Message
                lblBillSendOut.Visible = True
            End Try
        End Sub
        Protected Sub btnFake_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFake.Click
            Try
                Dim d As New BillboardDataContext
                Dim r = From c In d.Agape_Billboard_Features Where c.Next = True
                If r.Count = 1 Then
                    UpdateSend(2)
                    RefreshPanel()
                Else
                    lblBillSendOut.Text = "There is no feature article set to be the next visible feature. Please set one and then try again."
                    lblBillSendOut.Visible = True
                End If
            Catch ex As Exception
                lblBillSendOut.Text = ex.Message
                lblBillSendOut.Visible = True
            End Try

        End Sub
        Private Sub billArch_MyEvent(ByVal sender As Object, ByVal e As ArchEventArgs) Handles billArch.MyEvent
            Session("BillboardSuperTab") = 0
            If e.Switch > 0 Then
                Response.Redirect(EditUrl("ViewFeat") & "?FeatId=" & e.Switch & "&Mode=2")
            ElseIf e.Switch < 0 Then
                Response.Redirect(EditUrl("EditFeat") & "?FeatId=" & e.Switch * -1)
            End If
        End Sub

        Private Sub artArch_MyEvent(ByVal sender As Object, ByVal e As ArtArchEventArgs) Handles artArch.MyEvent
            Session("BillboardSuperTab") = 1
            If e.Switch > 0 Then
                Response.Redirect(EditUrl("ViewArt") & "?ArtId=" & e.Switch & "&Mode=2")
            ElseIf e.Switch < 0 Then
                Response.Redirect(EditUrl("EditArt") & "?ArtId=" & (e.Switch * -1) & "&Mode=1")
            End If
        End Sub

        Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
            Session("BillboardSuperTab") = 0
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Feature_Types Where 1 = 1
            If q.Count > 0 Then
                lblErrorFeat.Visible = False
                Response.Redirect(EditUrl("EditFeat") & "?FeatId=-1")
            Else
                lblErrorFeat.Text = "You must add at least one feature type before you try and add a feature article."
                lblErrorFeat.Visible = True
            End If
        End Sub
        Protected Sub ChangeTab(ByVal sender As Object, ByVal e As System.EventArgs) Handles hfCurrentPanel.ValueChanged
            Session("BillboardSuperTab") = hfCurrentPanel.Value
        End Sub
        Public Sub InitLinks()
            Dim d As New BillboardDataContext
            GridView1.DataSource = From c In d.Agape_Billboard_Links Where c.Current = True Order By c.LinkDate Descending Select c
            GridView1.DataBind()
        End Sub
        Public Sub InitAnn()
            Dim d As New BillboardDataContext
            Dim r = From c In d.Agape_Billboard_Announcements Where c.Current = True And c.Visible = True Order By c.AnnouncementDate Descending Select AnnText = ("<b>" & c.AnnouncementTitle & "</b>" & " , <i>" & CDate(c.AnnouncementDate).Day & "/" & CDate(c.AnnouncementDate).Month & "/" & CDate(c.AnnouncementDate).Year & "</i><br/>" & c.AnnouncementText), ThisCurrent = c.Sent, AttText = c.FileAttach

            gvAnn.DataSource = r
            gvAnn.DataBind()
        End Sub
        Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
            Dim d As New BillboardDataContext
            If e.CommandName = "MyEdit" Then
                Try
                    Dim HF As HiddenField
                    HF = GridView1.Rows(e.CommandArgument).FindControl("hfLinkId")
                    Dim q = From c In d.Agape_Billboard_Links Where c.BillboardLinkId = CInt(HF.Value)
                    If q.Count = 1 Then
                        Dim TB As TextBox
                        Dim CB As CheckBox
                        TB = GridView1.Rows(e.CommandArgument).FindControl("tbTitle1")
                        q.First.LinkTitle = TB.Text
                        TB = GridView1.Rows(e.CommandArgument).FindControl("tbDesc1")
                        q.First.LinkDesc = TB.Text
                        TB = GridView1.Rows(e.CommandArgument).FindControl("tbURL1")
                        q.First.LinkURL = TB.Text
                        CB = GridView1.Rows(e.CommandArgument).FindControl("cbVis1")
                        q.First.Visible = CB.Checked
                        d.SubmitChanges()
                        GridView1.DataSource = From c In d.Agape_Billboard_Links Where c.Current = True Order By c.LinkDate Descending Select c
                        GridView1.DataBind()
                        Dim IMG As System.Web.UI.WebControls.Image
                        IMG = GridView1.Rows(e.CommandArgument).FindControl("imgTick")
                        Dim t As Type = GridView1.GetType()
                        Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                        sb.Append("<script language='javascript'>")
                        sb.Append("$('.theTicks').hide(); $('#" & IMG.ClientID & "').show();  setTimeout(function () { $('#" & IMG.ClientID & "').fadeOut(350); }, 5000);")
                        sb.Append("</script>")
                        ScriptManager.RegisterStartupScript(GridView1, t, "popupAdd1", sb.ToString, False)
                        'IMG.Visible = True
                    Else
                        lblGVError.Text = "More than one problem."
                        lblGVError.Visible = True
                    End If
                Catch ex As Exception
                    lblGVError.Text = ex.Message
                    lblGVError.Visible = True
                End Try
            ElseIf e.CommandName = "MyDelete" Then
                Try
                    Dim r = From c In d.Agape_Billboard_Links Where c.BillboardLinkId = CInt(e.CommandArgument)
                    If r.Count = 1 Then
                        d.Agape_Billboard_Links.DeleteOnSubmit(r.First)
                        d.SubmitChanges()
                        GridView1.DataSource = From c In d.Agape_Billboard_Links Where c.Current = True Order By c.LinkDate Descending Select c
                        GridView1.DataBind()
                        For Each row As IDataItemContainer In GridView1.Rows
                            Dim IMG2 As System.Web.UI.WebControls.Image = GridView1.Rows(row.DataItemIndex).FindControl("imgTick")
                            If IMG2.Visible = True Then
                                IMG2.Visible = False
                            End If
                        Next
                    Else
                        lblGVError.Text = "More than one problem."
                        lblGVError.Visible = True
                    End If
                Catch ex As Exception
                    lblGVError.Text = ex.Message
                    lblGVError.Visible = True
                End Try
            End If
        End Sub
        
        Public Sub RefreshPanel()


            billArch.Initialise(2)
            InitLinks()
            editPrayer.Initialise()


        End Sub

        Protected Sub btnNewArt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNewArt.Click
            Session("BillboardSuperTab") = 1
            Response.Redirect(EditUrl("EditArt") & "?ArtId=-1&Mode=1")
        End Sub
        Public Sub clearQuery(ByVal pChange As Integer)
            If Not (Request.QueryString("ArtId") Is Nothing And Request.QueryString("ArtId") = "" And Request.QueryString("FaId") Is Nothing And Request.QueryString("FaId") = "") Then
                If (Request.QueryString("ArtId") > -2 And Request.QueryString("ArtId") < 0) Or (Request.QueryString("FaId") > -2 And Request.QueryString("FaId") < 0) Then
                    Dim t As Type = btnAdd.GetType()
                    Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                    sb.Append("<script language='javascript'>")
                    sb.Append("clearQuery(" & pChange & ");")
                    sb.Append("</script>")
                    ScriptManager.RegisterStartupScript(btnAdd, t, "popupAdd5", sb.ToString, False)
                End If
            End If
        End Sub
        Public Sub InitComm()
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Communities Join b In d.Users On c.AuthorId Equals b.UserID Where c.ReplyId = -3 Order By c.DateSub Descending Select c.BillboardCommId, CommOut = ("<i>" & b.DisplayName & "&nbsp;" & CDate(c.DateSub).Day & "/" & CDate(c.DateSub).Month & "/" & CDate(c.DateSub).Year & ":</i><br/>" & c.Text)
            dlComm.DataSource = q
            dlComm.DataBind()
            dlComm.Visible = True
        End Sub

        Public Function DateString(ByVal inDate As Date) As String
            Dim out As String = ""
            out = CDate(inDate).ToString("dd/MMM/yyyy")
            Return out
        End Function
        Public Function IsReplies(ByVal BillCommId As Integer) As Boolean
            Dim out As Boolean = False
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Communities Where c.ReplyId = BillCommId
            If q.Count > 0 Then
                out = True
            End If
            Return out
        End Function
        Protected Sub dlComm_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlComm.ItemDataBound
            Dim d As New BillboardDataContext
            Dim hfValue As Integer = CType(e.Item.FindControl("hfCommId"), HiddenField).Value
            Dim dtl As DataList = CType(e.Item.FindControl("dlCommReply"), DataList)
            Dim q = From c In d.Agape_Billboard_Communities Join b In d.Users On c.AuthorId Equals b.UserID Where c.ReplyId = hfValue Order By c.DateSub Descending Select c.BillboardCommId, BillRepText = ("<i>" & b.DisplayName & "&nbsp;" & CDate(c.DateSub).Day & "/" & CDate(c.DateSub).Month & "/" & CDate(c.DateSub).Year & ":</i><br/>" & c.Text)
            If q.Count > 0 Then
                dtl.DataSource = q
                dtl.DataBind()
            End If
        End Sub

        Public Sub DeleteStuff(ByVal BillCommId As Integer)
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Communities Where c.BillboardCommId = BillCommId
            If q.Count = 1 Then
                Dim r = From c In d.Agape_Billboard_Communities Where c.ReplyId = BillCommId
                If r.Count > 0 Then
                    d.Agape_Billboard_Communities.DeleteAllOnSubmit(r)
                End If
                d.Agape_Billboard_Communities.DeleteOnSubmit(q.First)
                d.SubmitChanges()
            End If
        End Sub

        Protected Sub lbInvis_Click(sender As Object, e As System.EventArgs) Handles lbInvis.Click
            DeleteStuff(hfDeleteComm.Value)
            InitComm()
        End Sub

#Region "Updating and Sending"
        Private Sub UpdateSend(ByVal Sendout As Integer)
            Try
                Dim insertKey As Integer = -5
                Dim d As New BillboardDataContext
                Dim insert As New Agape_Billboard_Send
                insert.SendDate = CDate(Now())
                Dim log As String = "Starting"
                insert.ErrorSend = log
                d.Agape_Billboard_Sends.InsertOnSubmit(insert)
                d.SubmitChanges()
                insertKey = insert.BillboardSendId

                'Dim message2 As New MailMessage()
                Dim atts As New ArrayList

                Try
                    Dim FinalOutput As String = System.IO.File.ReadAllText(Server.MapPath("DesktopModules\Billboard\BillOut.htm"))
                    Dim message As String = ""
                    'Announcements
                    Dim q = From c In d.Agape_Billboard_Announcements Where c.Sent = False And c.Visible = True And c.Current = True
                    Dim annOld = From c In d.Agape_Billboard_Announcements Where c.Sent = True And c.Current = True
                    If q.Count = 0 Then
                        message = "<div style=""color: #666666;font-size: 10pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">"
                        message = message & "There are currently no announcements.</div><br/>"
                    Else
                        If Sendout = 3 Or Sendout = 2 Then
                            For Each ann In annOld
                                ann.Current = False
                                ann.ViewOrder = -1
                            Next
                        End If
                        Dim annCount As Integer = 0
                        For Each anno In q

                            message = message & "<div style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">"
                            message = message & anno.AnnouncementTitle & "</div>"
                            'message = message & "<div style=""color: #808080;font-size: 7pt; font-family:  Verdana, Geneva, sans-serif; font-style: italic; text-align:right;"">" & CDate(anno.AnnouncementDate).ToString("dd MMM yyyy") & "</div>"
                            message = message & "<div style=""color: #666666;font-size: 8pt; font-family:  Verdana, Geneva, sans-serif;"">"
                            message = message & BillboardFunctions.BillHtml(anno.AnnouncementText) & "</div><br/>"
                            If Sendout = 3 Or Sendout = 2 Then
                                anno.Sent = True
                                anno.Current = True
                            End If
                            If Sendout = 2 Or Sendout = 3 Or Sendout = 4 Or Sendout = 17 Then
                                If Not (anno.FileAttach = "" Or anno.FileAttach Is Nothing) Then

                                    atts.Add(Server.MapPath("/AnnounceFiles/" & anno.FileAttach))

                                End If
                            End If

                        Next

                    End If

                    FinalOutput = FinalOutput.Replace("[ANNOUNCEMENTS]", message)
                    log = "build-announcements"

                    If Sendout = 3 Or Sendout = 2 Then
                        d.SubmitChanges()
                        Dim t = From c In d.Agape_Billboard_Announcements Where c.Current = True Order By c.AnnouncementDate Ascending
                        Dim thisOrder As Integer = 1
                        For Each annouce In t
                            annouce.ViewOrder = thisOrder
                            thisOrder = thisOrder + 1
                        Next
                    End If


                    message = ""
                    'Feature Articles
                    Dim r = From c In d.Agape_Billboard_Features Where c.Next = True
                    If Sendout = 3 Or Sendout = 2 Then
                        Dim s = From c In d.Agape_Billboard_Features Where c.Current = True
                        If s.Count > 0 Then
                            s.First.Current = False
                        End If
                    End If
                    If r.Count > 0 Then
                        message = "<table><tr><td width=""115px""><img height=""100px"" width=""100px"" style=""border-color:#0670A3; border-width: 1px; border-style:solid; text-align:center;""src=""http://france.myagape.co.uk/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & r.First.BillboardPhotoId & "&Size=100""></td>"
                        message = message & "<td valign=""top""><table width=""305px""><tr><td style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"" width=""305px"">" & r.First.Headline & "</td></tr>"
                        message = message & "<tr><td style=""font-family: verdana; font-size: 7pt; font-style: italic; color: #808080; text-align: right"" width=""305px"">" & (From c In d.Agape_Billboard_Feature_Types Where c.FeatureTypeId = r.First.FeatType Select c.TypeName).First & "</td></tr>"
                        message = message & "<tr><td style=""font-size:8pt; font-family:Verdana; color:#666666;"" width=""305px"">" & (BillboardFunctions.StripBillTags(r.First.StoryText)).Substring(0, Math.Min(CStr(BillboardFunctions.StripBillTags(r.First.StoryText)).Length, 250)) & "...</td></tr></table></td></tr></table>"
                    End If
                    If Sendout = 3 Or Sendout = 2 Then
                        For Each featart In r
                            featart.Current = True
                            featart.Sent = True
                            featart.Next = False
                        Next
                    End If
                    FinalOutput = FinalOutput.Replace("[FEATURE]", message)
                    If Sendout = 3 Or Sendout = 2 Then
                        d.SubmitChanges()
                    End If
                    log = "build-feature"
                    
                    message = ""
                    'Articles
                    Dim u = From c In d.Agape_Billboard_Articles Where c.Sent = False And c.Visible = True
                    If u.Count = 0 Then
                        message = "<div style=""color: #666666;font-size: 10pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">There are no new articles this week. Why not write one yourself? Go to the Billboard page on the StaffWeb and hit Write New Article.</div><br/>"
                    End If
                    If Sendout = 3 Or Sendout = 2 Then
                        Dim y = From c In d.Agape_Billboard_Articles Where c.Current = True And c.Sent = True
                        If y.Count > 0 Then
                            For Each art In y
                                art.Current = False
                            Next
                            d.SubmitChanges()
                        End If
                    End If

                    For Each arti In u
                        Dim auth As String = ""
                        If arti.AuthorName = "" Or arti.AuthorName Is Nothing Then
                            auth = (From c In d.Users Where c.UserID = arti.Author Select c.DisplayName).First
                        Else
                            auth = arti.AuthorName
                        End If
                        message = message & "<table><tr><td width=""115px""><img height=""100px"" width=""100px"" style=""border-color:#0670A3; border-width: 1px; border-style:solid; text-align:center;""src=""http://france.myagape.co.uk/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & arti.Agape_Billboard_Photo.BillboardPhotoId & "&Size=100""></td>"
                        message = message & "<td valign=""top""><table width=""305px""><tr><td style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">" & arti.Headline & "</td></tr>"
                        message = message & "<tr><td style=""font-family: verdana; font-size: 7pt; font-style: italic; color: #808080; text-align: right"">" & auth & ",&nbsp;" & CDate(arti.StoryDate).ToString("dd MMM yyyy") & "</td></tr>"
                        message = message & "<tr><td style=""font-size:8pt; font-family:Verdana; color:#666666;"">" & (BillboardFunctions.StripBillTags(arti.StoryText)).Substring(0, Math.Min(CStr(BillboardFunctions.StripBillTags(arti.StoryText)).Length, 150)) & "...</td></tr></table></td></tr></table>"

                        'message = message & "<div style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">" & arti.Headline & "</div>"
                        'message = message & "<div style=""font-family: verdana; font-size: 7pt; font-style: italic; color: #808080; text-align: right"">"
                        'message = message & "By:&nbsp;" & (From c In d.Users Where c.UserID = arti.Author Select c.DisplayName).First & ",&nbsp;" & CDate(arti.StoryDate).ToString("dd MMM yyyy") & "</div>"
                        'message = message & "<div style=""font-size:8pt; font-family:Verdana; color:#666666;"">" & (BillboardFunctions.StripBillTags(arti.StoryText)).Substring(0, Math.Min(CStr(BillboardFunctions.StripBillTags(arti.StoryText)).Length, 150)) & "..."
                        'message = message & "</div><br/>"
                        If Sendout = 3 Or Sendout = 2 Then
                            arti.Current = True
                            arti.Sent = True
                        End If

                    Next
                    FinalOutput = FinalOutput.Replace("[ARTICLES]", message)

                    If Sendout = 3 Or Sendout = 2 Then
                        d.SubmitChanges()
                    End If
                    log = "build-articles"
                    
                    message = ""
                    'Links
                    Dim v = From c In d.Agape_Billboard_Links Where c.Visible = True = True Order By c.LinkDate Descending
                    If v.Count = 0 Then
                        message = "There are currently no links this week."
                    Else
                        Dim links = From c In v Take 5
                        For Each Linker In links
                            Dim url As String = ""
                            url = Linker.LinkURL.Replace("http://", "").Replace("https://", "")
                            If url.Length < 36 Then
                                message = message & "<b>" & Linker.LinkTitle & "</b>" & "<br/>(<span style=""text-decoration:none !important; color: white !important"">" & url & "</span>)<br/><br/>"
                            Else
                                message = message & "<b>" & Linker.LinkTitle & "</b><br/>(<span style=""text-decoration:none !important; color: white !important"">" & url.Substring(0, 35) & "<br/>" & url.Substring(35) & "</span>)<br/><br/>"
                            End If

                        Next
                    End If
                    FinalOutput = FinalOutput.Replace("[LINKS]", "<div style=""font-size:7pt; color:white;"">" & message & "</div>")
                    log = "build-links"

                    message = ""
                    'Community
                    Dim w = From c In d.Agape_Billboard_Communities Where c.Sent = False And c.ReplyId = -3
                    If w.Count = 0 Then
                        message = "There are no new community items this week."
                    Else
                        For Each Commune In w
                            message = message & "<table><tr><td style=""font-size:7pt; color:white;"">" & Commune.Text & "</td></tr><tr><td align=""right"" valign=""middle"" style=""font-size:7pt; color:white;"">"
                            message = message & "-" & (From c In d.Users Where c.UserID = Commune.AuthorId Select c.DisplayName).First & ",&nbsp;" & CDate(Commune.DateSub).ToString("dd MMM yyyy")
                            message = message & "</td></tr></table><br/>"
                            If Sendout = 3 Or Sendout = 2 Then
                                Commune.Sent = True
                            End If

                        Next
                    End If
                    FinalOutput = FinalOutput.Replace("[COMMUNITY]", "<div style=""font-size:7pt; color:white;"">" & message & "</div>")

                    If Sendout = 3 Or Sendout = 2 Then
                        d.SubmitChanges()
                    End If
                    log = "build-community"

                    message = ""
                    'Prayer
                    Dim x = From c In d.Agape_Billboard_Prayers Where c.Sent = False And c.Visible = True
                    Dim oldPray = From c In d.Agape_Billboard_Prayers Where c.Sent = True And c.Current = True And c.Visible = True
                    If Sendout = 3 Or Sendout = 2 Then
                        For Each pray In oldPray
                            pray.Current = False
                        Next
                    End If
                    If x.Count = 0 Then
                        message = "<div style=""color: #666666;font-size: 10pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">There are no new prayer requests this week. If you’d like to ask our staff family to pray for something why not add a prayer request onto next week’s Billboard? Go to the Billboard page on the StaffWeb and hit Add Prayer Request.</div><br/>"
                    Else

                        For Each PrayerItem In x
                            message = message & "<div style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold;"">"
                            message = message & PrayerItem.PrayerTitle & "</div>"
                            message = message & "<div style=""font-family: verdana; font-size: 7pt; font-style: italic; color: #808080; text-align: right"">"
                            message = message & "Submitted By:&nbsp;" & (From c In d.Users Where c.UserID = PrayerItem.SubmittedBy Select c.DisplayName).First & ", on&nbsp;"
                            message = message & CDate(PrayerItem.SubmittedDate).ToString("dd MMM yyyy") & "</div>"
                            message = message & "<div style=""font-size:8pt; font-family:Verdana; color:#666666;"">" & BillboardFunctions.BillHtml(BillboardFunctions.StripBillTags(PrayerItem.PrayerText)) & "</div><br/>"
                            If Sendout = 3 Or Sendout = 2 Then
                                PrayerItem.Sent = True
                                PrayerItem.Current = True
                            End If

                        Next
                    End If
                    FinalOutput = FinalOutput.Replace("[PRAYERS]", message)

                    If Sendout = 3 Or Sendout = 2 Then
                        d.SubmitChanges()
                    End If
                    log = "build-prayer"
                    Dim attOut As String() = CType(atts.ToArray(GetType(String)), String())
                    Dim logFile = From c In d.Agape_Billboard_Sends Where 1 = 0
                    If insertKey > 0 Then
                        logFile = From c In d.Agape_Billboard_Sends Where c.BillboardSendId = insertKey
                    Else
                        ThisSuccess = "Unable to recover db key, insert didn't work. Contact system admin."
                        lblBillSendOut.Text = ThisSuccess
                        lblBillSendOut.Visible = True
                        Return
                    End If

                    logFile.First.EmailSent = FinalOutput
                    d.SubmitChanges()

                    If Sendout = 3 Then
                        log = SendEmail(FinalOutput, attOut)
                        If log = "Worked!" Then
                            lblBillSendOut.Text = "Sending Successful!"
                            logFile.First.ErrorSend = "Success-multiple sent"
                            lblBillSendOut.ForeColor = Color.Green
                            lblBillSendOut.Visible = True
                            d.SubmitChanges()
                        Else
                            ThisSuccess = "ERROR - " & log
                            lblBillSendOut.Text = ThisSuccess
                            lblBillSendOut.ForeColor = Color.Red
                            lblBillSendOut.Visible = True
                        End If
                    ElseIf Sendout = 4 Then
                        log = SendOneEmail(FinalOutput, attOut)
                        If log = "Worked!" Then
                            lblBillSendOut.Text = "Sending Successful!"
                            logFile.First.ErrorSend = "Test-one sent"
                            lblBillSendOut.ForeColor = Color.Green
                            lblBillSendOut.Visible = True
                            d.SubmitChanges()
                        Else
                            ThisSuccess = "ERROR - " & log
                            lblBillSendOut.Text = ThisSuccess
                            lblBillSendOut.ForeColor = Color.Red
                            lblBillSendOut.Visible = True
                        End If
                    ElseIf Sendout = 17 Then
                        'log = SendEmail(FinalOutput, attOut)
                        d.Agape_Billboard_Sends.DeleteOnSubmit(logFile.First)
                        d.SubmitChanges()
                        If log = "Worked!" Then
                            lblBillSendOut.Text = "Testing Successful!"
                            lblBillSendOut.ForeColor = Color.Green
                            lblBillSendOut.Visible = True
                        Else
                            ThisSuccess = "ERROR - " & log
                            lblBillSendOut.Text = ThisSuccess
                            lblBillSendOut.ForeColor = Color.Red
                            lblBillSendOut.Visible = True
                        End If
                    Else
                        DisplayEmail(FinalOutput)
                        d.Agape_Billboard_Sends.DeleteOnSubmit(logFile.First)
                        d.SubmitChanges()
                    End If


                Catch ex As Exception
                    ThisSuccess = "ERROR - " & log & ", " & ex.Message
                    lblBillSendOut.Text = ThisSuccess
                    lblBillSendOut.ForeColor = Color.Red
                    lblBillSendOut.Visible = True
                    If Sendout = 3 Or Sendout = 4 Then
                        Dim extraLog = From c In d.Agape_Billboard_Sends Where c.BillboardSendId = insertKey
                        If extraLog.Count > 0 Then
                            extraLog.First.ErrorSend = log & ex.Message
                            d.SubmitChanges()
                        End If
                    End If
                End Try
            Catch ex As Exception
                lblTestWork.Text = ex.Message
                lblTestWork.Visible = True
            End Try
        End Sub
        Private Function SendEmail(ByVal FinalOutput As String, ByVal attachments As String()) As String
            Dim log As String = ""

            Try


                'Prepare birthdays and reminders and send
                Dim d As New BillboardDataContext
                Dim message As String = ""

                'Birthdays

                'Dim dn As New DNNProfile.DNNProfileDataContextDataContext
                'Dim da As New AgapeStaff.AgapeStaffDataContext
                'Dim dF As New FullStory.FullStoryDataContext

                Dim outList As New Generic.List(Of MyBdayStruct)


                Dim objUserInfo As UserInfo

                Dim onlyStaff = StaffBrokerFunctions.GetStaffExcl(PortalId, {"Associate Staff", "Foreign Staff", "Council", "Other", "Office", "Ex-Staff"})
                'Dim onlyStaff = AgapeStaffFunctions.GetStaff("Associate Staff", "Foreign Staff", "Council", "Other", "Office", "Ex-Staff")

                Dim rc As New DotNetNuke.Security.Roles.RoleController
                'Dim staff = rc.GetUsersByRoleName(PortalId, "Staff")
                Dim staff = onlyStaff
                'For Each row As UserInfo In staff
                For Each row In staff
                    objUserInfo = UserController.GetUserById(0, row.UserID)
                    If objUserInfo.Profile.GetPropertyValue("DOB") <> "" Then
                        Dim bday As Date = CDate(objUserInfo.Profile.GetPropertyValue("DOB"))
                        Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                        bday = DateAdd(DateInterval.Year, Age, bday)
                        If (bday >= CDate(Today())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Today()))) Then
                            'If bday.Day = Now.Day And bday.Month = Now.Month Then

                            Dim HL As New HyperLink()
                            'HL.Font.Size = 7
                            'HL.CssClass = "Bill_Text_Side"
                            Dim thisText As String = row.DisplayName & " - " & bday.ToString("dd MMM")
                            'HL.Text = row.DisplayName & " - " & bday.ToString("dd MMM")

                            'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                            '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserID

                            'End If
                            Dim ThisOutput As New MyBdayStruct
                            ThisOutput.MyText = thisText
                            ThisOutput.ThisDate = bday
                            outList.Add(ThisOutput)
                            'PlaceHolder1.Controls.Add(HL)
                            'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))

                        End If
                    End If



                Next

                Dim dBroke As New StaffBroker.StaffBrokerDataContext
                For Each row In (From c In dBroke.AP_StaffBroker_Staffs Where c.UserId2 = -1)
                    Dim ThisContinue As Boolean = False
                    For Each member In onlyStaff
                        If row.UserId1 = member.UserID Then
                            ThisContinue = True
                        End If
                    Next
                    If ThisContinue Then
                        'For Each row In (From c In da.Agape_Staff_Finances Where c.USerId2 = -1 Join b In staff On c.UserId1 Equals b.UserID Select c)
                        Dim bday As Date = StaffBrokerFunctions.GetStaffProfileProperty(row.StaffId, "SpouseDOB")
                        Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                        bday = DateAdd(DateInterval.Year, Age, bday)
                        If (bday >= CDate(Now())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                            'If bday.Day = Now.Day And bday.Month = Now.Month Then
                            'Dim HL As New HyperLink()
                            'HL.Font.Size = 7
                            'HL.CssClass = "Bill_Text_Side"
                            'HL.Text = row.SpouseName & " " & UserController.GetUser(PortalId, row.UserId1, False).LastName & " - " & bday.ToString("dd MMM")
                            'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                            '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserId1

                            'End If
                            Dim sName As String = StaffBrokerFunctions.GetStaffProfileProperty(row.StaffId, "SpouseName")
                            Dim thisText As String = sName & " " & UserController.GetUserById(PortalId, row.UserId1).LastName & " - " & bday.ToString("dd MMM")
                            Dim ThisOutput As New MyBdayStruct()
                            ThisOutput.MyText = thisText
                            ThisOutput.ThisDate = bday
                            outList.Add(ThisOutput)

                            'PlaceHolder1.Controls.Add(HL)
                            'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))

                        End If
                    End If
                Next

                For Each row In dBroke.AP_StaffBroker_Childrens
                    Dim bday As Date = row.Birthday
                    Dim Age2 As Double = DateDiff(DateInterval.Year, bday, Now())
                    bday = DateAdd(DateInterval.Year, Age2, bday)
                    If (bday >= CDate(Now())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                        'Dim q = From c In da.Agape_Staff_Finances Where c.FamilyId = row.FamilyId
                        Dim q = From c In dBroke.AP_StaffBroker_Staffs Where c.StaffId = row.StaffId


                        If q.Count > 0 Then
                            Dim ThisContinue2 As Boolean = False
                            For Each member In onlyStaff
                                If q.First.UserId1 = member.UserID Or q.First.UserId2 = member.UserID Then
                                    ThisContinue2 = True
                                End If
                            Next
                            If ThisContinue2 Then
                                'Dim HL As New HyperLink()
                                'HL.Font.Size = 7
                                'HL.CssClass = "Bill_Text_Side"
                                'HL.Text = row.FirstName & " " & UserController.GetUser(PortalId, q.First.UserId1, False).LastName
                                Dim thisText As String = row.FirstName & " " & UserController.GetUserById(PortalId, q.First.UserId1).LastName
                                Dim Age As Integer
                                Age = DateTime.Today.Year - row.Birthday.Year
                                If Age < 17 Then
                                    thisText = thisText & " (" & Age & ")" & " - " & bday.ToString("dd MMM")
                                Else
                                    thisText = thisText & " - " & bday.ToString("dd MMM")
                                End If
                                'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                                '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & q.First.UserId1
                                'End If

                                Dim ThisOutput As New MyBdayStruct()
                                ThisOutput.MyText = thisText
                                ThisOutput.ThisDate = bday
                                outList.Add(ThisOutput)

                                'PlaceHolder1.Controls.Add(HL)
                                'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))
                            End If
                        End If

                    End If
                Next

                If outList.Count = 0 Then
                    message = "There are no birthdays this week."
                Else
                    outList.Sort(AddressOf sortDates)
                    For Each birth As MyBdayStruct In outList
                        message = message & birth.MyText & "<br/>"
                    Next
                End If


                FinalOutput = FinalOutput.Replace("[BIRTHDAYS]", "<div style=""font-size:7pt; color:white;"">" & message & "</div>")
                log = "birthdays done"
                'Loop around people to send to and add reminders before sending

                Dim dStaff As New StaffBroker.StaffBrokerDataContext
                Dim includeList As String() = {"National Staff", "Overseas Staff, in Country", "Centrally Funded"}
                Dim r = From c In dStaff.AP_StaffBroker_Staffs Where c.DisplayName <> "" And includeList.Contains(c.AP_StaffBroker_StaffType.Name) Select c

                log = "staff list number = " & r.Count

                For Each biller In r
                    'If biller.UserId1 = 13 Or biller.UserId2 = 13 Or biller.UserId1 = 12 Or biller.UserId2 = 12 Then
                    If biller.UserId2 > 0 Then
                        Dim ThisFinalOutput As String = ""
                        'User1
                        'Reminders
                        message = BillboardFunctions.CreateReminders(biller.UserId1)
                        ThisFinalOutput = FinalOutput.Replace("[REMINDERS]", "<div style=""font-size:7pt; color:white;"">" & Regex.Replace(Regex.Replace(message, "<a(.|\n)*?>", ""), "<\/a>", "") & "</div>")
                        'Send Email
                        Try
                            If attachments.Count > 0 Then
                                DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", biller.User.Email, "", "", Services.Mail.MailPriority.Normal, "Billboard: " & Now().ToString("dd/MM/yyyy"), Services.Mail.MailFormat.Html, System.Text.Encoding.Unicode, ThisFinalOutput, attachments, "", "", "", "", False)
                            Else
                                DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", biller.User.Email, "", "Billboard: " & Now().ToString("dd/MM/yyyy"), ThisFinalOutput, "", "HTML", "", "", "", "")
                            End If
                            log = "Worked!"
                        Catch ex As Exception
                            log = log & ex.Message
                        End Try
                        'User2
                        'Reminders
                        message = BillboardFunctions.CreateReminders(biller.UserId2)
                        ThisFinalOutput = FinalOutput.Replace("[REMINDERS]", "<div style=""font-size:7pt; color:white;"">" & Regex.Replace(Regex.Replace(message, "<a(.|\n)*?>", ""), "<\/a>", "") & "</div>")
                        'Send Email
                        Try
                            If attachments.Count > 0 Then
                                DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", biller.User2.Email, "", "", Services.Mail.MailPriority.Normal, "Billboard: " & Now().ToString("dd/MM/yyyy"), Services.Mail.MailFormat.Html, System.Text.Encoding.Unicode, ThisFinalOutput, attachments, "", "", "", "", False)
                            Else
                                DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", biller.User2.Email, "", "Billboard: " & Now().ToString("dd/MM/yyyy"), ThisFinalOutput, "", "HTML", "", "", "", "")
                            End If
                            log = "Worked!"
                        Catch ex As Exception
                            log = log & ex.Message
                        End Try
                    Else
                        Dim ThisFinalOutput2 As String = ""
                        'Reminders
                        message = BillboardFunctions.CreateReminders(biller.UserId1)
                        ThisFinalOutput2 = FinalOutput.Replace("[REMINDERS]", "<div style=""font-size:7pt; color:white;"">" & Regex.Replace(Regex.Replace(message, "<a(.|\n)*?>", ""), "<\/a>", "") & "</div>")
                        'Send Email
                        Try
                            If attachments.Count > 0 Then
                                DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", biller.User.Email, "", "", Services.Mail.MailPriority.Normal, "Billboard: " & Now().ToString("dd/MM/yyyy"), Services.Mail.MailFormat.Html, System.Text.Encoding.Unicode, ThisFinalOutput2, attachments, "", "", "", "", False)
                            Else
                                DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", biller.User.Email, "", "Billboard: " & Now().ToString("dd/MM/yyyy"), ThisFinalOutput2, "", "HTML", "", "", "", "")
                            End If
                            log = "Worked!"
                        Catch ex As Exception
                            log = log & ex.Message
                        End Try
                    End If
                    'End If
                Next
            Catch ex As Exception
                log = log & ex.Message
            End Try

            Return log
        End Function
        Private Sub DisplayEmail(ByVal FinalOutput As String)

            Try

                'Prepare birthdays and reminders and send
                Dim d As New BillboardDataContext
                Dim message As String = ""

                'Birthdays

                'Dim dn As New DNNProfile.DNNProfileDataContextDataContext
                'Dim da As New AgapeStaff.AgapeStaffDataContext
                'Dim dF As New FullStory.FullStoryDataContext

                Dim outList As New Generic.List(Of MyBdayStruct)


                Dim objUserInfo As UserInfo

                Dim onlyStaff = StaffBrokerFunctions.GetStaffExcl(PortalId, {"Associate Staff", "Foreign Staff", "Council", "Other", "Office", "Ex-Staff"})
                'Dim onlyStaff = AgapeStaffFunctions.GetStaff("Associate Staff", "Foreign Staff", "Council", "Other", "Office", "Ex-Staff")

                Dim rc As New DotNetNuke.Security.Roles.RoleController
                'Dim staff = rc.GetUsersByRoleName(PortalId, "Staff")
                Dim staff = onlyStaff
                'For Each row As UserInfo In staff

                For Each row In staff
                    objUserInfo = UserController.GetUserById(0, row.UserID)
                    If objUserInfo.Profile.GetPropertyValue("DOB") <> "" Then
                        Dim bday As Date = CDate(objUserInfo.Profile.GetPropertyValue("DOB"))
                        Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                        bday = DateAdd(DateInterval.Year, Age, bday)
                        If (bday >= CDate(Today())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Today()))) Then
                            'If bday.Day = Now.Day And bday.Month = Now.Month Then

                            Dim HL As New HyperLink()
                            'HL.Font.Size = 7
                            'HL.CssClass = "Bill_Text_Side"
                            Dim thisText As String = row.DisplayName & " - " & bday.ToString("dd MMM")
                            'HL.Text = row.DisplayName & " - " & bday.ToString("dd MMM")

                            'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                            '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserID

                            'End If
                            Dim ThisOutput As New MyBdayStruct
                            ThisOutput.MyText = thisText
                            ThisOutput.ThisDate = bday
                            outList.Add(ThisOutput)
                            'PlaceHolder1.Controls.Add(HL)
                            'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))

                        End If
                    End If



                Next
                Dim dBroke As New StaffBroker.StaffBrokerDataContext
                For Each row In (From c In dBroke.AP_StaffBroker_Staffs Where c.UserId2 = -1)
                    Dim ThisContinue As Boolean = False
                    For Each member In onlyStaff
                        If row.UserId1 = member.UserID Then
                            ThisContinue = True
                        End If
                    Next
                    If ThisContinue Then
                        'For Each row In (From c In da.Agape_Staff_Finances Where c.USerId2 = -1 Join b In staff On c.UserId1 Equals b.UserID Select c)

                        Dim bday As Date = StaffBrokerFunctions.GetStaffProfileProperty(row.StaffId, "SpouseDOB")
                        Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                        bday = DateAdd(DateInterval.Year, Age, bday)
                        If (bday >= CDate(Now())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                            'If bday.Day = Now.Day And bday.Month = Now.Month Then
                            'Dim HL As New HyperLink()
                            'HL.Font.Size = 7
                            'HL.CssClass = "Bill_Text_Side"
                            'HL.Text = row.SpouseName & " " & UserController.GetUser(PortalId, row.UserId1, False).LastName & " - " & bday.ToString("dd MMM")
                            'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                            '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserId1

                            'End If
                            Dim sName = StaffBrokerFunctions.GetStaffProfileProperty(row.StaffId, "SpouseName")
                            Dim thisText As String = sName & " " & UserController.GetUserById(PortalId, row.UserId1).LastName & " - " & bday.ToString("dd MMM")
                            Dim ThisOutput As New MyBdayStruct()
                            ThisOutput.MyText = thisText
                            ThisOutput.ThisDate = bday
                            outList.Add(ThisOutput)

                            'PlaceHolder1.Controls.Add(HL)
                            'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))

                        End If
                    End If
                Next

                For Each row In dBroke.AP_StaffBroker_Childrens
                    Dim bday As Date = row.Birthday
                    Dim Age2 As Double = DateDiff(DateInterval.Year, bday, Now())
                    bday = DateAdd(DateInterval.Year, Age2, bday)
                    If (bday >= CDate(Now())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                        Dim q = From c In dBroke.AP_StaffBroker_Staffs Where c.StaffId = row.StaffId
                        If q.Count > 0 Then
                            Dim ThisContinue2 As Boolean = False
                            For Each member In onlyStaff
                                If q.First.UserId1 = member.UserID Or q.First.UserId2 = member.UserID Then
                                    ThisContinue2 = True
                                End If
                            Next
                            If ThisContinue2 Then
                                'Dim HL As New HyperLink()
                                'HL.Font.Size = 7
                                'HL.CssClass = "Bill_Text_Side"
                                'HL.Text = row.FirstName & " " & UserController.GetUser(PortalId, q.First.UserId1, False).LastName
                                Dim thisText As String = row.FirstName & " " & UserController.GetUserById(PortalId, q.First.UserId1).LastName
                                Dim Age As Integer
                                Age = DateTime.Today.Year - row.Birthday.Year
                                If Age < 17 Then
                                    thisText = thisText & " (" & Age & ")" & " - " & bday.ToString("dd MMM")
                                Else
                                    thisText = thisText & " - " & bday.ToString("dd MMM")
                                End If
                                'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                                '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & q.First.UserId1
                                'End If

                                Dim ThisOutput As New MyBdayStruct()
                                ThisOutput.MyText = thisText
                                ThisOutput.ThisDate = bday
                                outList.Add(ThisOutput)

                                'PlaceHolder1.Controls.Add(HL)
                                'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))
                            End If
                        End If

                    End If
                Next

                If outList.Count = 0 Then
                    message = "There are no birthdays this week."
                Else
                    outList.Sort(AddressOf sortDates)
                    For Each birth As MyBdayStruct In outList
                        message = message & birth.MyText & "<br/>"
                    Next
                End If

                FinalOutput = FinalOutput.Replace("[BIRTHDAYS]", "<div style=""font-size:7pt; color:white;"">" & message & "</div>")

                'Loop around people to send to and add reminders before sending
                Dim r = From c In d.UserRoles Where c.UserID = Me.UserId Select c.UserID, c.User.Email

                For Each biller In r
                    'Reminders
                    message = BillboardFunctions.CreateReminders(biller.UserID)
                    FinalOutput = FinalOutput.Replace("[REMINDERS]", "<div style=""font-size:7pt; color:white;"">" & Regex.Replace(Regex.Replace(message, "<a(.|\n)*?>", ""), "<\/a>", "") & "</div>")
                Next

                Dim s = From c In d.Agape_Billboard_Tests Where 1 = 1
                If s.Count > 0 Then
                    s.First.BillboardTest = FinalOutput
                Else
                    Dim insert As New Agape_Billboard_Test
                    insert.BillboardTest = FinalOutput
                    d.Agape_Billboard_Tests.InsertOnSubmit(insert)
                End If
                d.SubmitChanges()
                hfGoAhead.Value = 27
            Catch ex As Exception
                lblTestWork.Text = ex.Message
                lblTestWork.Visible = True
            End Try
        End Sub
        Private Function SendOneEmail(ByVal FinalOutput As String, ByVal attachments As String()) As String
            Dim log As String = ""
            Try


                'Prepare birthdays and reminders and send
                Dim d As New BillboardDataContext
                Dim message As String = ""
                Dim sendTo As String = tbTestSend.Text

                'Birthdays

                'Dim dn As New DNNProfile.DNNProfileDataContextDataContext
                'Dim da As New AgapeStaff.AgapeStaffDataContext
                'Dim dF As New FullStory.FullStoryDataContext

                Dim outList As New Generic.List(Of MyBdayStruct)


                Dim objUserInfo As UserInfo

                Dim onlyStaff = StaffBrokerFunctions.GetStaffExcl(PortalId, {"Associate Staff", "Foreign Staff", "Council", "Other", "Office", "Ex-Staff"})
                'Dim onlyStaff = AgapeStaffFunctions.GetStaff("Associate Staff", "Foreign Staff", "Council", "Other", "Office", "Ex-Staff")

                Dim rc As New DotNetNuke.Security.Roles.RoleController
                'Dim staff = rc.GetUsersByRoleName(PortalId, "Staff")
                Dim staff = onlyStaff
                'For Each row As UserInfo In staff
                For Each row In staff
                    objUserInfo = UserController.GetUserById(0, row.UserID)
                    If objUserInfo.Profile.GetPropertyValue("DOB") <> "" Then
                        Dim bday As Date = CDate(objUserInfo.Profile.GetPropertyValue("DOB"))
                        Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                        bday = DateAdd(DateInterval.Year, Age, bday)
                        If (bday >= CDate(Today())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Today()))) Then
                            'If bday.Day = Now.Day And bday.Month = Now.Month Then

                            Dim HL As New HyperLink()
                            'HL.Font.Size = 7
                            'HL.CssClass = "Bill_Text_Side"
                            Dim thisText As String = row.DisplayName & " - " & bday.ToString("dd MMM")
                            'HL.Text = row.DisplayName & " - " & bday.ToString("dd MMM")

                            'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                            '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserID

                            'End If
                            Dim ThisOutput As New MyBdayStruct
                            ThisOutput.MyText = thisText
                            ThisOutput.ThisDate = bday
                            outList.Add(ThisOutput)
                            'PlaceHolder1.Controls.Add(HL)
                            'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))

                        End If
                    End If



                Next
                Dim dBroke As New StaffBroker.StaffBrokerDataContext
                For Each row In (From c In dBroke.AP_StaffBroker_Staffs Where c.UserId2 = -1)
                    Dim ThisContinue As Boolean = False
                    For Each member In onlyStaff
                        If row.UserId1 = member.UserID Then
                            ThisContinue = True
                        End If
                    Next
                    If ThisContinue Then
                        'For Each row In (From c In da.Agape_Staff_Finances Where c.USerId2 = -1 Join b In staff On c.UserId1 Equals b.UserID Select c)
                        Dim bday As Date = StaffBrokerFunctions.GetStaffProfileProperty(row.StaffId, "SpouseDOB")
                        Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                        bday = DateAdd(DateInterval.Year, Age, bday)
                        If (bday >= CDate(Now())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                            'If bday.Day = Now.Day And bday.Month = Now.Month Then
                            'Dim HL As New HyperLink()
                            'HL.Font.Size = 7
                            'HL.CssClass = "Bill_Text_Side"
                            'HL.Text = row.SpouseName & " " & UserController.GetUser(PortalId, row.UserId1, False).LastName & " - " & bday.ToString("dd MMM")
                            'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                            '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserId1

                            'End If
                            Dim sName As String = StaffBrokerFunctions.GetStaffProfileProperty(row.StaffId, "SpouseName")
                            Dim thisText As String = sName & " " & UserController.GetUserById(PortalId, row.UserId1).LastName & " - " & bday.ToString("dd MMM")
                            Dim ThisOutput As New MyBdayStruct()
                            ThisOutput.MyText = thisText
                            ThisOutput.ThisDate = bday
                            outList.Add(ThisOutput)

                            'PlaceHolder1.Controls.Add(HL)
                            'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))

                        End If
                    End If
                Next

                For Each row In dBroke.AP_StaffBroker_Childrens
                    Dim bday As Date = row.Birthday
                    Dim Age2 As Double = DateDiff(DateInterval.Year, bday, Now())
                    bday = DateAdd(DateInterval.Year, Age2, bday)
                    If (bday >= CDate(Now())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                        'Dim q = From c In da.Agape_Staff_Finances Where c.FamilyId = row.FamilyId
                        Dim q = From c In dBroke.AP_StaffBroker_Staffs Where c.StaffId = row.StaffId


                        If q.Count > 0 Then
                            Dim ThisContinue2 As Boolean = False
                            For Each member In onlyStaff
                                If q.First.UserId1 = member.UserID Or q.First.UserId2 = member.UserID Then
                                    ThisContinue2 = True
                                End If
                            Next
                            If ThisContinue2 Then
                                'Dim HL As New HyperLink()
                                'HL.Font.Size = 7
                                'HL.CssClass = "Bill_Text_Side"
                                'HL.Text = row.FirstName & " " & UserController.GetUser(PortalId, q.First.UserId1, False).LastName
                                Dim thisText As String = row.FirstName & " " & UserController.GetUserById(PortalId, q.First.UserId1).LastName
                                Dim Age As Integer
                                Age = DateTime.Today.Year - row.Birthday.Year
                                If Age < 17 Then
                                    thisText = thisText & " (" & Age & ")" & " - " & bday.ToString("dd MMM")
                                Else
                                    thisText = thisText & " - " & bday.ToString("dd MMM")
                                End If
                                'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                                '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & q.First.UserId1
                                'End If

                                Dim ThisOutput As New MyBdayStruct()
                                ThisOutput.MyText = thisText
                                ThisOutput.ThisDate = bday
                                outList.Add(ThisOutput)

                                'PlaceHolder1.Controls.Add(HL)
                                'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))
                            End If
                        End If

                    End If
                Next

                If outList.Count = 0 Then
                    message = "There are no birthdays this week."
                Else
                    outList.Sort(AddressOf sortDates)
                    For Each birth As MyBdayStruct In outList
                        message = message & birth.MyText & "<br/>"
                    Next
                End If

                FinalOutput = FinalOutput.Replace("[BIRTHDAYS]", "<div style=""font-size:7pt; color:white;"">" & message & "</div>")
                log = "birthdays done"




                'Reminders
                message = BillboardFunctions.CreateReminders(Me.UserId)
                FinalOutput = FinalOutput.Replace("[REMINDERS]", "<div style=""font-size:7pt; color:white;"">" & Regex.Replace(Regex.Replace(message, "<a(.|\n)*?>", ""), "<\/a>", "") & "</div>")

                'Send Email
                Try
                    If attachments.Count > 0 Then
                        DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", sendTo, "", "", Services.Mail.MailPriority.Normal, "Billboard: " & Now().ToString("dd/MM/yyyy"), Services.Mail.MailFormat.Html, System.Text.Encoding.Unicode, FinalOutput, attachments, "", "", "", "", False)
                    Else
                        DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", sendTo, "", "Billboard: " & Now().ToString("dd/MM/yyyy"), FinalOutput, "", "HTML", "", "", "", "")
                    End If
                    log = "Worked!"
                Catch ex As Exception
                    log = log & ex.Message
                End Try
            Catch ex As Exception
                log = log & ex.Message
            End Try

            Return log
        End Function
        Private Shared Function sortDates( _
    ByVal x As MyBdayStruct, ByVal y As MyBdayStruct) As Integer
            Return x.ThisDate.CompareTo(y.ThisDate)
        End Function
#End Region


        
        'Protected Sub btnTestThis_Click(sender As Object, e As System.EventArgs) Handles btnTestThis.Click
        '    UpdateSend(17)
        '    If ThisSuccess <> "" Then
        '        lblBillSendOut.Text = ThisSuccess
        '        lblBillSendOut.ForeColor = Color.Red
        '        lblBillSendOut.Visible = True
        '    End If
        'End Sub
    End Class
End Namespace

