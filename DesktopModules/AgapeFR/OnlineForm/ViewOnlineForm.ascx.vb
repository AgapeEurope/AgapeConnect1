﻿Imports DotNetNuke
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
Imports System.Xml

Imports UK.OnlineForm
Imports DotNetNuke.UI.Skins.Controls.ModuleMessage
Imports DotNetNuke.Entities.Modules

Namespace DotNetNuke.Modules.AgapeFR.OnlineForm

    Partial Class ViewOnlineForm
        Inherits PortalModuleBase
        Implements IActionable



        'Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        ' Add admin actions
        'Dim addEditAction = MyBase.Actions.Add(GetNextActionID, LocalizeString("AdminSectionTitle"), "OnlineForm", "", "", "", "", True, SecurityAccessLevel.Edit, True, False)
        ' addEditAction.Actions.Add(GetNextActionID, LocalizeString("AdminEditAction"), "OnlineFormEdit", "", "action_settings.gif", EditUrl("Edit"), False, SecurityAccessLevel.Edit, True, False)
        ' addEditAction.Actions.Add(GetNextActionID, LocalizeString("AdminResultsAction"), "OnlineFormResults", "", "action_source.gif", EditUrl("Results"), False, SecurityAccessLevel.Edit, True, False)
        ' End Sub
        Public ReadOnly Property ModuleActions() As Entities.Modules.Actions.ModuleActionCollection Implements Entities.Modules.IActionable.ModuleActions
            Get
                Dim Actions As New Entities.Modules.Actions.ModuleActionCollection
                Actions.Add(GetNextActionID, "Form Edit", "OnlineFormEdit", "", "action_settings.gif", EditUrl("Edit"), False, SecurityAccessLevel.Edit, True, False)
                Actions.Add(GetNextActionID, "Form Results", "OnlineFormResults", "", "action_source.gif", EditUrl("Results"), False, SecurityAccessLevel.Edit, True, False)
                Return Actions
            End Get
        End Property

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            Dim d As New OnlineFormDataContext
            Try
                Dim q = (From c In d.Agape_Public_OnlineForms Where c.ModuleId = Me.ModuleId Select c).First
                PrefixLabel.Text = q.Intro
                SuffixLabel.Text = q.FootNote
                EmailPanel.Visible = q.Ack
                ReqEmail.Enabled = q.ReqEmail
                SubmitButton.Visible = True

                If UserInfo.Email <> "" And Not Page.IsPostBack Then
                    Email.Text = UserInfo.Email
                End If

                Dim questions = From c In d.Agape_Public_OnlineForm_Questions Where c.FormId = q.FormId

                For Each question In questions
                    QuPlaceHolder.Controls.Add(New LiteralControl("<div class=""FieldRow""><span class=""FieldLabel"">" & question.QuestionText & "</span>"))
                    If (question.Required) Then
                        QuPlaceHolder.Controls.Add(New LiteralControl("<span class=""MandatoryField Star"">*</span>"))
                    Else
                        QuPlaceHolder.Controls.Add(New LiteralControl("<span class=""MandatoryField"">&nbsp;</span>"))
                    End If
                    Select Case question.QuestionType
                        Case 0 'TextBox
                            Dim c As New TextBox()
                            c.ID = "Q" & question.FormQuestionId
                            QuPlaceHolder.Controls.Add(c)

                        Case 1 ' Multiline Text Box
                            Dim c As New TextBox()
                            c.ID = "Q" & question.FormQuestionId
                            c.TextMode = TextBoxMode.MultiLine
                            c.Rows = 5
                            QuPlaceHolder.Controls.Add(c)
                        Case 2 ' Yes/No
                            Dim c As New DropDownList
                            c.ID = "Q" & question.FormQuestionId
                            c.Items.Add(LocalizeString("No"))
                            c.Items.Add(LocalizeString("Yes"))

                            c.DataBind()
                            c.SelectedValue = LocalizeString("Yes")
                            QuPlaceHolder.Controls.Add(c)
                        Case 3 ' DropDownList
                            Dim c As New DropDownList
                            c.ID = "Q" & question.FormQuestionId
                            Dim qid As Integer = question.FormQuestionId
                            Dim ddl = From b In d.Agape_Public_OnlineForm_DDLs Where b.QuestionId = qid
                            For Each row In ddl
                                c.Items.Add(New ListItem(row.RowText))

                            Next
                            c.DataBind()
                            QuPlaceHolder.Controls.Add(c)
                        Case 4 'checkbox
                            Dim c As New CheckBox
                            c.ID = "Q" & question.FormQuestionId
                            QuPlaceHolder.Controls.Add(c)


                        Case 5 'radiobutton
                            Dim c As New RadioButtonList
                            c.ID = "Q" & question.FormQuestionId
                            Dim qid As Integer = question.FormQuestionId
                            Dim ddl = From b In d.Agape_Public_OnlineForm_DDLs Where b.QuestionId = qid
                            For Each row In ddl
                                c.Items.Add(New ListItem(row.RowText))

                            Next
                            c.DataBind()
                            QuPlaceHolder.Controls.Add(c)
                    End Select
                    If (question.Required) Then
                        Dim req As New RequiredFieldValidator()
                        req.ID = "req" & question.FormQuestionId
                        req.ControlToValidate = "Q" & question.FormQuestionId
                        req.Text = LocalizeString("Required")
                        req.ErrorMessage = LocalizeString("MsgRequiredQuestion") & " " & question.QuestionText
                        req.Display = ValidatorDisplay.Dynamic
                        QuPlaceHolder.Controls.Add(New LiteralControl("<div class=""MandatoryFieldErrorMsg"">"))
                        QuPlaceHolder.Controls.Add(req)
                        QuPlaceHolder.Controls.Add(New LiteralControl("</div>"))
                    End If

                    QuPlaceHolder.Controls.Add(New LiteralControl("</div>"))

                Next

            Catch ex As Exception
                PrefixLabel.Text = LocalizeString("MsgModuleNotConfigured")
                SuffixLabel.Text = ""
                SubmitButton.Visible = False
            End Try

        End Sub

        Protected Sub SubmitButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SubmitButton.Click
            Dim sendResult = ""
            Dim d As New OnlineFormDataContext
            Dim q = (From b In d.Agape_Public_OnlineForms Where b.ModuleId = Me.ModuleId).First
            Dim questions = From b In d.Agape_Public_OnlineForm_Questions Where b.FormId = q.FormId
            Dim Answerset As Integer = 1
            Try
                Answerset = (From b In d.Agape_Public_OnlineForm_Answers Order By b.AnswerId Descending).First.AnswerSet + 1
            Catch ex As Exception
            End Try

            For Each question In questions
                Dim answer As New Agape_Public_OnlineForm_Answer
                Select Case question.QuestionType
                    Case 0 To 1 'TextBox
                        Dim c As TextBox = FindControl("Q" & question.FormQuestionId)
                        answer.AnswerText = c.Text
                    Case 2 To 3 ' Yes/No
                        Dim c As DropDownList = FindControl("Q" & question.FormQuestionId)
                        answer.AnswerText = c.SelectedValue
                    Case 4
                        Dim c As CheckBox = FindControl("Q" & question.FormQuestionId)
                        answer.AnswerText = IIf(c.Checked, LocalizeString("Yes"), LocalizeString("No"))
                    Case 5
                        Dim c As RadioButtonList = FindControl("Q" & question.FormQuestionId)
                        answer.AnswerText = c.SelectedValue
                End Select
                Try
                    answer.UserId = Me.UserId
                Catch ex As Exception
                End Try
                answer.AnswerSet = Answerset
                answer.DateSubmitted = Date.Now
                answer.FormId = q.FormId
                answer.Questionid = question.FormQuestionId
                answer.UserIP = Request.ServerVariables("remote_addr")
                d.Agape_Public_OnlineForm_Answers.InsertOnSubmit(answer)
                d.SubmitChanges()

            Next

            'Prepare email message
            Dim message As String = LocalizeString("SentMsgIntro") & "<br />"

            If Not String.IsNullOrEmpty(q.EmailTo) Then
                Try
                    If Not String.IsNullOrEmpty(Me.UserInfo.DisplayName) Then
                        message = message & LocalizeString("SentMsgFrom") & " " & Me.UserInfo.DisplayName & "<br />"
                    End If
                    If Not String.IsNullOrEmpty(Email.Text) Then
                        message = message & LocalizeString("SentMsgEmailAddress") & " " & Email.Text & "<br />"
                    End If
                    message = message & LocalizeString("SentMsgIPAddress") & " " & Request.ServerVariables("remote_addr") & "<br />"
                    message = message & LocalizeString("SentMsgDateSubmitted") & " " & Date.Now.ToString & "<br />"

                    message = message & "<table cellpadding=""10"">"
                    Dim answers = From b In d.Agape_Public_OnlineForm_Answers Where b.AnswerSet = Answerset
                    For Each row In answers
                        Dim qid = row.Questionid
                        message = message & "<tr><td valign=""top"" style=""font-weight: bolder;"" width=""200""> "
                        message = message & (From b In d.Agape_Public_OnlineForm_Questions Where b.FormQuestionId = qid).First.QuestionText & "</td><td>"

                        message = message & row.AnswerText

                        message = message & "</td></tr>"

                    Next

                    message = message & "</table>"

                    sendResult = DotNetNuke.Services.Mail.Mail.SendMail("Site Web Agapé France <noreply@agapefrance.org>", q.EmailTo, "", LocalizeString("SentMsgSubjectPart1") & " - " & ModuleConfiguration.ModuleTitle, message, "", "HTML", "", "", "", "")
                    If String.IsNullOrEmpty(sendResult) Then
                        'Display Success message
                        UI.Skins.Skin.AddModuleMessage(Me, LocalizeString("LblMsgSent"), ModuleMessageType.GreenSuccess)
                    Else
                        'Display error message
                        UI.Skins.Skin.AddModuleMessage(Me, LocalizeString("ErrorMsgNotSent"), ModuleMessageType.RedError)
                        AgapeLogger.Error(UserId, "Error while sending Online Form message\nForm title:" & ModuleConfiguration.ModuleTitle & "\nRecipient address: " & q.EmailTo & "\nMessage: " & message & "\Error: " & sendResult)
                    End If

                Catch ex As Exception
                    'Display error message
                    UI.Skins.Skin.AddModuleMessage(Me, LocalizeString("ErrorMsgNotSent"), ModuleMessageType.RedError)
                    AgapeLogger.Error(UserId, "Error while sending Online Form message\nForm title:" & ModuleConfiguration.ModuleTitle & "\nRecipient address: " & q.EmailTo & "\nMessage: " & message & "\Error: " & ex.StackTrace)
                End Try
            Else
                UI.Skins.Skin.AddModuleMessage(Me, LocalizeString("ErrorMsgNotSent"), ModuleMessageType.RedError)
                AgapeLogger.Error(UserId, "Error while sending Online Form message\nForm title:" & ModuleConfiguration.ModuleTitle & "\nMessage: " & message & "\Error: No 'EmailTo' configured in the module.")
            End If

            Try

                If q.Ack And Not String.IsNullOrEmpty(Email.Text) Then
                    message = q.AckText

                    message = message & "<table cellpadding=""10"">"
                    Dim answers = From b In d.Agape_Public_OnlineForm_Answers Where b.AnswerSet = Answerset
                    For Each row In answers
                        Dim qid = row.Questionid
                        message = message & "<tr><td valign=""top"" style=""font-weight: bolder;"" width=""200""> "
                        message = message & (From b In d.Agape_Public_OnlineForm_Questions Where b.FormQuestionId = qid).First.QuestionText & "</td><td>"
                        message = message & row.AnswerText
                        message = message & "</td></tr>"
                    Next

                    message = message & "</table>"

                    Dim acknResult = DotNetNuke.Services.Mail.Mail.SendMail("Agapé France <noreply@agapefrance.org>", Email.Text, "", LocalizeString("AcknowledgementMsgSubject"), message, "", "HTML", "", "", "", "")
                    If Not String.IsNullOrEmpty(acknResult) Then
                        'Trace error message
                        AgapeLogger.Error(UserId, "Error while sending Online Form acknowledgement\nForm title:" & ModuleConfiguration.ModuleTitle & "\nRecipient address: " & Email.Text & "\nMessage: " & message & "\Error: " & acknResult)
                    End If

                End If

            Catch ex As Exception
                AgapeLogger.Error(UserId, "Error while sending Online Form acknowledgement\nForm title:" & ModuleConfiguration.ModuleTitle & "\nRecipient address: " & Email.Text & "\nMessage: " & message & "\Error: " & ex.StackTrace)
            End Try

            'Empty the page fields if email sent successfully
            If String.IsNullOrEmpty(sendResult) Then
                For Each ctrl In QuPlaceHolder.Controls
                    If TypeOf ctrl Is TextBox Then
                        ctrl.Text = ""
                    End If
                Next
                Email.Text = ""
            End If

        End Sub

    End Class
End Namespace
