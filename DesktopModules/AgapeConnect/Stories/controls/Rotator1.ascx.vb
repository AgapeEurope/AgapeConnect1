Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq

'Imports DotNetNuke
'Imports DotNetNuke.Security
'Imports StaffBroker
Imports StaffBrokerFunctions
Imports Stories
'Imports DotNetNuke.Services.FileSystem
Namespace DotNetNuke.Modules.AgapeConnect.Stories
    Partial Class Rotator1
        Inherits Entities.Modules.PortalModuleBase
        'Adding Stories Translation
        Dim d As New StoriesDataContext

        Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
            'Allowing dynamically loaded controls to be translated using the DNN translation system is complex...
            'However this code does the trick. Just copy this Sub (Page_Init) ,as is, to make it work
            'An App_LocalResources Folder must be located in the same location as this file - and Contain your resx files (using the usual dnn resx file naming convention)


            Dim FileName As String = System.IO.Path.GetFileNameWithoutExtension(Me.AppRelativeVirtualPath)
            If Not (Me.ID Is Nothing) Then
                'this will fix it when its placed as a ChildUserControl 
                Me.LocalResourceFile = Me.LocalResourceFile.Replace(Me.ID, FileName)
            Else
                ' this will fix it when its dynamically loaded using LoadControl method 
                Me.LocalResourceFile = Me.LocalResourceFile & FileName & ".ascx.resx"
                Dim Locale = System.Threading.Thread.CurrentThread.CurrentCulture.Name
                Dim AppLocRes As New System.IO.DirectoryInfo(Me.LocalResourceFile.Replace(FileName & ".ascx.resx", ""))
                If Locale = PortalSettings.CultureCode Then
                    'look for portal varient
                    If AppLocRes.GetFiles(FileName & ".ascx.Portal-" & PortalId & ".resx").Count > 0 Then
                        Me.LocalResourceFile = Me.LocalResourceFile.Replace("resx", "Portal-" & PortalId & ".resx")
                    End If
                Else

                    If AppLocRes.GetFiles(FileName & ".ascx." & Locale & ".Portal-" & PortalId & ".resx").Count > 0 Then
                        'lookFor a CulturePortalVarient
                        Me.LocalResourceFile = Me.LocalResourceFile.Replace("resx", Locale & ".Portal-" & PortalId & ".resx")
                    ElseIf AppLocRes.GetFiles(FileName & ".ascx." & Locale & ".resx").Count > 0 Then
                        'look for a CultureVarient
                        Me.LocalResourceFile = Me.LocalResourceFile.Replace("resx", Locale & ".resx")
                    ElseIf AppLocRes.GetFiles(FileName & ".ascx.Portal-" & PortalId & ".resx").Count > 0 Then
                        'lookFor a PortalVarient
                        Me.LocalResourceFile = Me.LocalResourceFile.Replace("resx", "Portal-" & PortalId & ".resx")
                    End If
                End If
            End If
        End Sub

        Public Sub Initialize(ByVal Stories As System.Linq.IOrderedQueryable(Of AP_Stories_Module_Channel_Cache), settings As Hashtable)
            

            Dim out As String = ""

            For Each row In Stories

                Try
                    If (CultureInfo.CurrentCulture.Name.ToLower.Contains(row.Langauge.ToLower) Or row.Langauge.ToLower.Contains(CultureInfo.CurrentCulture.TwoLetterISOLanguageName.ToLower)) Then



                        '  Dim Photo = FileManager.Instance.GetFile(row.PhotoId)
                        ' Dim PhotoURL = FileManager.Instance.GetUrl(Photo)

                        '   Dim distanceWeight = (CDbl(1.0) + ((CDbl(1.0) - CDbl(Math.Max(CDbl(200), CDbl((CDbl(Math.Acos(Math.Sin(deg2Rad * CDbl(lt)) * Math.Sin(deg2Rad * CDbl(row.Latitude)) + Math.Cos(deg2Rad * CDbl(lt)) * Math.Cos(deg2Rad * CDbl(row.Latitude)) * Math.Cos(deg2Rad * (CDbl(lg) - CDbl(row.Longitude)))) / Math.PI * CDbl(180.0)) * CDbl(1.1515)))) / CDbl(200.0))) / CDbl(2.0)))
                        '   Dim distanceMiles = StoryFunctions.distance(lt, lg, row.Latitude, row.Longitude) ' (CDbl(1.0) + (G * (CDbl(1.0) - (Math.Min(200, ((Math.Acos(Math.Sin(deg2Rad * (lt)) * Math.Sin(deg2Rad * CDbl(row.Latitude)) + Math.Cos(deg2Rad * (lt)) * Math.Cos(deg2Rad * CDbl(row.Latitude)) * Math.Cos(deg2Rad * (lg - CDbl(row.Longitude))))) / Math.PI * CDbl(180.0)) * CDbl(1.1515) * CDbl(60)) / CDbl(200))))) / CDbl(2)

                        'Dim PreCal = CDbl(row.Precal) * (CDbl(1.0) + (G * (CDbl(1.0) - (Math.Min(200, ((CDbl(Math.Acos(Math.Sin(deg2Rad * (lt))) * CDbl(Math.Sin(deg2Rad * CDbl(row.Latitude))) + CDbl(Math.Cos(deg2Rad * CDbl(lt))) * CDbl(Math.Cos(deg2Rad * CDbl(row.Latitude))) * CDbl(Math.Cos(deg2Rad * (CDbl(lg) - CDbl(row.Longitude)))))) / CDbl(Math.PI) * CDbl(180.0)) * CDbl(1.1515) * CDbl(60)) / CDbl(200))))) / CDbl(2)
                        'Dim PreCal = ((CDbl(Math.Acos(Math.Sin(deg2Rad * (lt))) * CDbl(Math.Sin(deg2Rad * CDbl(row.Latitude))) + CDbl(Math.Cos(deg2Rad * CDbl(lt))) * CDbl(Math.Cos(deg2Rad * CDbl(row.Latitude))) * CDbl(Math.Cos(deg2Rad * (CDbl(lg) - CDbl(row.Longitude)))))) / CDbl(Math.PI) * CDbl(180.0)) * CDbl(1.1515) * CDbl(60)


                        'Dim PreCal = CDbl(row.Precal) * (CDbl(1 + (row.Clicks * P))) * (1.0 + (G * (1.0 - (CDbl(Math.Min(200, ((Math.Acos(CDbl(Math.Sin(deg2Rad * (lt))) * CDbl(Math.Sin(deg2Rad * CDbl(row.Latitude))) + CDbl(Math.Cos(deg2Rad * CDbl(lt))) * CDbl(Math.Cos(deg2Rad * CDbl(row.Latitude))) * CDbl(Math.Cos(deg2Rad * (lg - CDbl(row.Longitude)))))) / CDbl(Math.PI) * 180.0) * 1.1515 * 60.0)) / 200.0)))) / 2.0


                        '  Dim dist As Double = CDbl(Math.Sin(deg2Rad * lt)) * CDbl(Math.Sin(deg2Rad * (row.lat))) + Math.Cos(deg2Rad(lat1)) * Math.Cos(deg2Rad(lat2)) * Math.Cos(deg2Rad(theta))



                        'StoryFunctions.distance(lt, lg, row.Latitude, row.Longitude) ' CDbl((CDbl(Math.Acos(Math.Sin(deg2Rad * CDbl(lt)) * Math.Sin(deg2Rad * CDbl(row.Latitude)) + Math.Cos(deg2Rad * CDbl(lt)) * Math.Cos(deg2Rad * CDbl(row.Latitude)) * Math.Cos(deg2Rad * (CDbl(lg) - CDbl(row.Longitude)))) / Math.PI * CDbl(180.0)) * CDbl(1.1515)))


                        Dim target = "_blank"
                        If row.Link.Contains(PortalSettings.DefaultPortalAlias) Then
                            target = "_self"
                        End If
                        out &= "<a href=""javascript: registerClick(" & row.CacheId & "); window.open('" & row.Link & "', '" & target & "');"" > "
                        out &= "<img src=""" & row.ImageId & """ style=""width: 420px; height: " & CInt((420 * row.ImageHeight) / row.ImageWidth) & "px;"" data-thumb=""" & row.ImageId & """ alt=""" & row.Headline & """  title=""" & row.Headline & """ /></a>"
                    End If
                Catch ex As Exception

                End Try

            Next

            ltStories.Text = out
        End Sub

    




    End Class
End Namespace
