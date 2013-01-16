Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.IO
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DotNetNuke
Imports StaffBroker

Namespace DotNetNuke.Modules.AgapeUK.GivePage
    Partial Class ViewGivePage
        Inherits Entities.Modules.PortalModuleBase
        Private d As New StaffBroker.StaffBrokerDataContext
        Public listItems As IQueryable(Of StaffBroker.AP_StaffBroker_Staff)
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            SetData()
        End Sub
        Private Sub SetData()
            Dim incList() As String = {"National Staff", "National Staff, Overseas", "Overseas Staff, Overseas"}

            listItems = From s In d.AP_StaffBroker_Staffs _
                        Where incList.Contains(s.AP_StaffBroker_StaffType.Name) _
                        And s.PortalId = PortalId _
                        And Not (From sp In d.AP_StaffBroker_StaffProfiles _
                        Join spd In d.AP_StaffBroker_StaffPropertyDefinitions On spd.StaffPropertyDefinitionId Equals sp.StaffPropertyDefinitionId _
                        Where spd.PropertyName = "UnNamedStaff" And sp.PropertyValue = "True" Select sp.StaffId).Contains(s.StaffId) _
                        Order By s.User.LastName

            Dim q = From c In listItems Select theLetter = (c.User.LastName).Substring(0, 1).ToLower() Distinct
            dlLetters.DataSource = q
            dlLetters.DataBind()

            Dim thisA = From c In q Where c.ToString() = "a"
            If thisA.Any() Then
                lA.HRef = "http://localhost:37879/en-us/giving.aspx#anchorA"
                lA.Attributes("class") = "normBox"
            Else
                lA.Attributes("class") = "disBox"
            End If
            Dim thisB = From c In q Where c.ToString() = "b"
            If thisB.Any() Then
                lB.HRef = "http://localhost:37879/en-us/giving.aspx#anchorB"
                lB.Attributes("class") = "normBox"
            Else
                lB.Attributes("class") = "disBox"
            End If
            Dim thisC = From c In q Where c.ToString() = "c"
            If thisC.Any() Then
                lC.HRef = "http://localhost:37879/en-us/giving.aspx#anchorC"
                lC.Attributes("class") = "normBox"
            Else
                lC.Attributes("class") = "disBox"
            End If
            Dim thisD = From c In q Where c.ToString() = "d"
            If thisD.Any() Then
                lD.HRef = "http://localhost:37879/en-us/giving.aspx#anchorD"
                lD.Attributes("class") = "normBox"
            Else
                lD.Attributes("class") = "disBox"
            End If
            Dim thisE = From c In q Where c.ToString() = "e"
            If thisE.Any() Then
                lE.HRef = "http://localhost:37879/en-us/giving.aspx#anchorE"
                lE.Attributes("class") = "normBox"
            Else
                lE.Attributes("class") = "disBox"
            End If
            Dim thisF = From c In q Where c.ToString() = "f"
            If thisF.Any() Then
                lF.HRef = "http://localhost:37879/en-us/giving.aspx#anchorF"
                lF.Attributes("class") = "normBox"
            Else
                lF.Attributes("class") = "disBox"
            End If
            Dim thisG = From c In q Where c.ToString() = "g"
            If thisG.Any() Then
                lG.HRef = "http://localhost:37879/en-us/giving.aspx#anchorG"
                lG.Attributes("class") = "normBox"
            Else
                lG.Attributes("class") = "disBox"
            End If
            Dim thisH = From c In q Where c.ToString() = "h"
            If thisH.Any() Then
                lH.HRef = "http://localhost:37879/en-us/giving.aspx#anchorH"
                lH.Attributes("class") = "normBox"
            Else
                lH.Attributes("class") = "disBox"
            End If
            Dim thisI = From c In q Where c.ToString() = "i"
            If thisI.Any() Then
                lI.HRef = "http://localhost:37879/en-us/giving.aspx#anchorI"
                lI.Attributes("class") = "normBox"
            Else
                lI.Attributes("class") = "disBox"
            End If
            Dim thisJ = From c In q Where c.ToString() = "j"
            If thisJ.Any() Then
                lJ.HRef = "http://localhost:37879/en-us/giving.aspx#anchorJ"
                lJ.Attributes("class") = "normBox"
            Else
                lJ.Attributes("class") = "disBox"
            End If
            Dim thisK = From c In q Where c.ToString() = "k"
            If thisK.Any() Then
                lK.HRef = "http://localhost:37879/en-us/giving.aspx#anchorK"
                lK.Attributes("class") = "normBox"
            Else
                lK.Attributes("class") = "disBox"
            End If
            Dim thisL = From c In q Where c.ToString() = "l"
            If thisL.Any() Then
                lL.HRef = "http://localhost:37879/en-us/giving.aspx#anchorL"
                lL.Attributes("class") = "normBox"
            Else
                lL.Attributes("class") = "disBox"
            End If
            Dim thisM = From c In q Where c.ToString() = "m"
            If thisM.Any() Then
                lM.HRef = "http://localhost:37879/en-us/giving.aspx#anchorM"
                lM.Attributes("class") = "normBox"
            Else
                lM.Attributes("class") = "disBox"
            End If
            Dim thisN = From c In q Where c.ToString() = "n"
            If thisN.Any() Then
                lN.HRef = "http://localhost:37879/en-us/giving.aspx#anchorN"
                lN.Attributes("class") = "normBox"
            Else
                lN.Attributes("class") = "disBox"
            End If
            Dim thisO = From c In q Where c.ToString() = "o"
            If thisO.Any() Then
                lO.HRef = "http://localhost:37879/en-us/giving.aspx#anchorO"
                lO.Attributes("class") = "normBox"
            Else
                lO.Attributes("class") = "disBox"
            End If
            Dim thisP = From c In q Where c.ToString() = "p"
            If thisP.Any() Then
                lP.HRef = "http://localhost:37879/en-us/giving.aspx#anchorP"
                lP.Attributes("class") = "normBox"
            Else
                lP.Attributes("class") = "disBox"
            End If
            Dim thisQ = From c In q Where c.ToString() = "q"
            If thisQ.Any() Then
                lQ.HRef = "http://localhost:37879/en-us/giving.aspx#anchorQ"
                lQ.Attributes("class") = "normBox"
            Else
                lQ.Attributes("class") = "disBox"
            End If
            Dim thisR = From c In q Where c.ToString() = "r"
            If thisR.Any() Then
                lR.HRef = "http://localhost:37879/en-us/giving.aspx#anchorR"
                lR.Attributes("class") = "normBox"
            Else
                lR.Attributes("class") = "disBox"
            End If
            Dim thisS = From c In q Where c.ToString() = "s"
            If thisS.Any() Then
                lS.HRef = "http://localhost:37879/en-us/giving.aspx#anchorS"
                lS.Attributes("class") = "normBox"
            Else
                lS.Attributes("class") = "disBox"
            End If
            Dim thisT = From c In q Where c.ToString() = "t"
            If thisT.Any() Then
                lT.HRef = "http://localhost:37879/en-us/giving.aspx#anchorT"
                lT.Attributes("class") = "normBox"
            Else
                lT.Attributes("class") = "disBox"
            End If
            Dim thisU = From c In q Where c.ToString() = "u"
            If thisU.Any() Then
                lU.HRef = "http://localhost:37879/en-us/giving.aspx#anchorU"
                lU.Attributes("class") = "normBox"
            Else
                lU.Attributes("class") = "disBox"
            End If
            Dim thisV = From c In q Where c.ToString() = "v"
            If thisV.Any() Then
                lV.HRef = "http://localhost:37879/en-us/giving.aspx#anchorV"
                lV.Attributes("class") = "normBox"
            Else
                lV.Attributes("class") = "disBox"
            End If
            Dim thisW = From c In q Where c.ToString() = "w"
            If thisW.Any() Then
                lW.HRef = "http://localhost:37879/en-us/giving.aspx#anchorW"
                lW.Attributes("class") = "normBox"
            Else
                lW.Attributes("class") = "disBox"
            End If
            Dim thisX = From c In q Where c.ToString() = "x"
            If thisX.Any() Then
                lX.HRef = "http://localhost:37879/en-us/giving.aspx#anchorX"
                lX.Attributes("class") = "normBox"
            Else
                lX.Attributes("class") = "disBox"
            End If
            Dim thisY = From c In q Where c.ToString() = "y"
            If thisY.Any() Then
                lY.HRef = "http://localhost:37879/en-us/giving.aspx#anchorY"
                lY.Attributes("class") = "normBox"
            Else
                lY.Attributes("class") = "disBox"
            End If
            Dim thisZ = From c In q Where c.ToString() = "z"
            If thisZ.Any() Then
                lZ.HRef = "http://localhost:37879/en-us/giving.aspx#anchorZ"
                lZ.Attributes("class") = "normBox"
            Else
                lZ.Attributes("class") = "disBox"
            End If



        End Sub
        Public Function SortHref(ByVal thisLetter As String) As String
            Dim out = ""
            out = "#anchor" & thisLetter
            Return out
        End Function
        Public Function MakeMeAnchor(ByVal thisLetter As String) As String
            Return "<a id='anchor" & thisLetter.ToUpper() & "' class='normBox2'>" & thisLetter & "</a>"
        End Function
        Public Function GetLetterData(ByVal thisLetter As String) As IQueryable(Of StaffBroker.AP_StaffBroker_Staff)
            Dim q = From c In listItems Where c.User.LastName.Substring(0, 1) = thisLetter.ToUpper() Select c
            Return q
        End Function
        Public Function GiveToLink(ByVal dataId As Integer) As String
            Dim shortcut As String = StaffBrokerFunctions.GetStaffProfileProperty(dataId, "givingshortcut")
            Dim mc As New Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frGiveView")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Return (NavigateURL(x.TabID) & "?giveto=" & shortcut)
                End If
            End If
            Return "http://www.agapefrance.org"
        End Function
        Public Function CreateDisplay(ByVal thisStaff As Integer) As String
            Dim q = From c In listItems Where c.StaffId = thisStaff
            If q.Any() Then
                If q.First.UserId2 > 0 Then
                    Return q.First.User.LastName.ToUpper() & ", " & q.First.User.FirstName & " & " & q.First.User2.FirstName
                Else
                    Return q.First.User.LastName.ToUpper() & ", " & q.First.User.FirstName
                End If
            Else
                Return "ERROR"
            End If
        End Function

    End Class
End Namespace
