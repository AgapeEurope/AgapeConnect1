Imports Microsoft.VisualBasic
Imports System.Linq
Imports System.Drawing
Imports Billboard

Namespace Billboard
    Public Class BillboardFunctions

        Public Shared Function CropImageFromCropper(ByVal img As Byte(), ByVal X As Integer, ByVal Y As Integer, ByVal IWidth As Integer, ByVal IHeight As Integer) As Byte()

            Dim SelectFile, thumbnail As System.Drawing.Image
            Dim d As New Billboard.BillboardDataContext

            Dim ms As System.IO.MemoryStream = New System.IO.MemoryStream(img)
            Dim profPic As System.Drawing.Image = System.Drawing.Image.FromStream(ms)

            SelectFile = ResizeImage(profPic, 200)

            Dim Point1 As Point = New Point(X, Y)
            Dim Point2 As Point = New Point(X + IWidth, Y + IHeight)
            thumbnail = CropImage(SelectFile, Point1, Point2)

            thumbnail = ResizeImage(thumbnail, 200)

            ms = New System.IO.MemoryStream()
            Dim ImageBytes As Byte()
            Using (ms)
                thumbnail.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
                ImageBytes = ms.ToArray()
            End Using

            Return ImageBytes

        End Function
        Public Shared Function ResizeImage(ByVal mg As Image, ByVal newSize As Integer) As Image

            Dim ratio As Double = 0D
            Dim myThumbWidth As Double = 0D
            Dim myThumbHeight As Double = 0D
            Dim bp As Bitmap

            ratio = mg.Width / mg.Height
            myThumbWidth = newSize
            myThumbHeight = newSize / ratio

            Dim thumbSize As Size = New Size(CInt(myThumbWidth), CInt(myThumbHeight))
            bp = New Bitmap(CInt(myThumbWidth), CInt(myThumbHeight))

            Dim g As Graphics = Graphics.FromImage(bp)
            g.SmoothingMode = Drawing2D.SmoothingMode.HighQuality
            g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
            g.PixelOffsetMode = Drawing2D.PixelOffsetMode.HighQuality
            Dim rect As Rectangle = New Rectangle(0, 0, thumbSize.Width, thumbSize.Height)
            g.DrawImage(mg, rect, 0, 0, mg.Width, mg.Height, GraphicsUnit.Pixel)

            Return bp

        End Function
        Public Shared Function CropImage(ByVal OriginalImage As Bitmap, ByVal TopLeft As Point, ByVal BottomRight As Point) As Bitmap

            Dim btmCropped As New Bitmap((BottomRight.X - TopLeft.X), (BottomRight.Y - TopLeft.Y))
            Dim grpOriginal As Graphics = Graphics.FromImage(btmCropped)

            grpOriginal.DrawImage(OriginalImage, New Rectangle(0, 0, btmCropped.Width, btmCropped.Height), _
                TopLeft.X, TopLeft.Y, btmCropped.Width, btmCropped.Height, GraphicsUnit.Pixel)
            grpOriginal.Dispose()

            Return btmCropped

        End Function
        Public Shared Sub SetToCurrent(ByVal CurrentFeature As Integer)
            Dim d As New Billboard.BillboardDataContext
            Dim CurrentFeat = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = CurrentFeature Select c
            If CurrentFeat.Count > 0 Then
                Dim Other = From c In d.Agape_Billboard_Features Where c.Current = True And c.BillboardFeatureId <> CurrentFeature Select c
                For Each feat In Other
                    feat.Current = False
                Next
                CurrentFeat.First.Current = True
                d.SubmitChanges()
            End If
        End Sub
        Public Shared Function StripBillTags(ByVal HTML As String) As String
            ' Removes tags from passed HTML

            Dim pattern As String = "<(.|\n)*?>"
            Dim pattern2 As String = "\[.*?]]\]"
            Dim pattern3 As String = "\[.*?]\]"

            Dim s As String = Regex.Replace(HTML, pattern, String.Empty)
            s = Regex.Replace(Regex.Replace(s, pattern2, String.Empty), pattern3, String.Empty)

            If s.LastIndexOf("<") > 0 And s.LastIndexOf("<") > 0 Then
                If s.LastIndexOf("<") > s.LastIndexOf(">") Then
                    s = s.Replace(s.Substring(s.LastIndexOf("<")), "")
                End If
            ElseIf s.LastIndexOf(">") > 0 And s.LastIndexOf("<") = Nothing Then
                If s.LastIndexOf("<") > s.LastIndexOf(">") Then
                    s = s.Replace(s.Substring(s.LastIndexOf("<")), "")
                End If
            End If
            If s.IndexOf("&") > 0 Then
                If Not (s.Substring(s.LastIndexOf("&")).IndexOf(" ") > 0 And s.Substring(s.LastIndexOf("&")).IndexOf(";") > 0) Then
                    s = s.Replace(s.Substring(s.LastIndexOf("&")), "")
                End If
            End If


            Return s

        End Function
        Public Shared Function CreateReminders(ByVal StaffId As Integer) As String
            Dim Output As String = ""

            Try
                'Dim staff As New AgapeStaff.AgapeStaffDataContext
                'Dim bill As New BillboardDataContext
                'Dim full As New FullStory.FullStoryDataContext


            'You have reimbursements to approve
                'Dim rmbCount As Integer = 0
                'Dim q = From c In staff.Agape_Staff_Rmbs Where c.Status = 2 And c.CostCenter.Substring(3) <> "X"
                'For Each rmb In q
                '    Dim r = From c In (AgapeStaffFunctions.GetAllLeaders(rmb.UserId)) Where c.UserID = StaffId
                '    If r.Count > 0 Then
                '        rmbCount = rmbCount + 1
                '    End If
                'Next
                '    Dim myDepts = StaffBrokerFunctions.GetDepartments(StaffId)
                'Dim s = From c In staff.Agape_Staff_Rmbs Where c.Status = 2 And c.CostCenter.Substring(3) = "X"
                '    For Each rmb In s

                '        If (From c In myDepts Where c.CostCentre = rmb.CostCenter).Count > 0 Then
                '            rmbCount += 1
                '        End If


                'Dim t = From c In (AgapeStaffFunctions.GetAllManagers((From c In staff.Agape_Main_AvailableCostCentres Where c.CostCentreCode = rmb.CostCenter).First.AvailableCostCentreId)) Where c.UserID = StaffId
                'If t.Count > 0 Then
                '    rmbCount = rmbCount + 1
                'End If
                'Next

                'If rmbCount > 0 Then
                '    If full.Agape_Main_GlobalDatas.Count > 0 Then
                '        Output = Output & "<a style=""font-size:7pt;"" href=""" & NavigateURL(CInt(full.Agape_Main_GlobalDatas.First.RmbTabId)) & """>You have " & rmbCount & " reimbursements to approve.</a><br/>"
                '    End If
                'End If

                'You have budgets to approve
                'Dim u = From c In Staff.Agape_Staff_Budgets Where c.Approver = StaffId
                'If u.Count > 0 Then
                '    Output = Output & "<br/>"
                '    If full.Agape_Main_GlobalDatas.Count > 0 Then
                '        Output = Output & "<a style=""font-size:7pt;"" href=""" & NavigateURL(CInt(full.Agape_Main_GlobalDatas.First.BudgetTabId)) & """>You have " & u.Count & " budgets to approve.</a><br/>"
                '    End If
                'End If

                'You have yet to submit a budget
                'If CDate(Now()).Month > 6 Then
                '    Dim realStaffId = StaffBrokerFunctions.GetStaffMember(StaffId).StaffId
                '    Dim v = From c In Staff.Agape_Staff_Budgets Order By c.StartYear Descending Where c.StaffId = realStaffId
                '    If v.First.StartYear <> Now().Year Or v.Count = 0 Then
                '        Output = Output & "<br/>"
                '        If full.Agape_Main_GlobalDatas.Count > 0 Then
                '            Output = Output & "<a style=""font-size:7pt"" href=""" & NavigateURL(CInt(full.Agape_Main_GlobalDatas.First.BudgetTabId)) & """>"
                '            If Now().Month = 6 And Now().Day < 15 Then
                '                Output = Output & "You need to submit a new budget by 15th June."
                '            Else
                '                Output = Output & "Your budget is overdue. Go and do it now."
                '            End If
                '            Output = Output & "<br/>"
                '        End If
                '    End If
                'End If
            Catch ex As Exception
                Output = "There are no reminders for you this week."
            End Try

            If Output = "" Then
                Output = "There are no reminders for you this week."
            End If

            Return Output

        End Function
        Public Shared Function BillHtml(ByVal inText As String) As String
            Dim out = ""

            If Not (inText = "" Or inText Is Nothing) Then
                out = inText.Replace("[b]", "<b>").Replace("[/b]", "</b>").Replace("[i]", "<i>").Replace("[/i]", "</i>").Replace("[ul]", "<u>").Replace("[/ul]", "</u>")
            End If

            Return out
        End Function
    End Class
End Namespace
