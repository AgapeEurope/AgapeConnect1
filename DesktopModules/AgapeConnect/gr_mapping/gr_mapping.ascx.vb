﻿Imports System
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
Imports DotNetNuke
Imports DotNetNuke.Security

Imports GR_NET
Imports gr_mapping
Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class gr_mapping_mod
        Inherits Entities.Modules.PortalModuleBase




        Dim gr As GR

        Private Sub ResetLocalDDL()
            Dim ds As New StaffBroker.StaffBrokerDataContext
            ddlProfileMap.Items.Clear()
            ddlProfileMap.Items.Add(New ListItem("User: Email", "U-Email"))
            ddlProfileMap.Items.Add(New ListItem("User: DisplayName", "U-DisplayName"))
            ddlProfileMap.Items.Add(New ListItem("User: FirstName", "U-FirstName"))
            ddlProfileMap.Items.Add(New ListItem("User: LastName", "U-LastName"))
            ddlProfileMap.Items.Add(New ListItem("User: UserId", "U-UserId"))

           

            Dim ups = From c In ds.ProfilePropertyDefinitions Where c.PortalID = PortalId Order By c.PropertyName Select c.PropertyName, c.PropertyDefinitionID

            For Each row In ups
                ddlProfileMap.Items.Add(New ListItem("User Profile: " & row.PropertyName, "UP-" & row.PropertyDefinitionID))

            Next

            ddlProfileMap.Items.Add(New ListItem("Staff: R/C", "S-CostCenter"))
            ddlProfileMap.Items.Add(New ListItem("Staff: StaffId", "S-StaffId"))
            ddlProfileMap.Items.Add(New ListItem("Staff: DisplayName", "S-DisplayName"))

            Dim sps = From c In ds.AP_StaffBroker_StaffPropertyDefinitions Order By c.PropertyName Where c.PortalId = PortalId
            For Each row In sps
                ddlProfileMap.Items.Add(New ListItem("Staff Profile: " & row.PropertyName, "SP-" & row.StaffPropertyDefinitionId))

            Next

        End Sub


        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
           
            If Not Page.IsPostBack Then


                tbApiKey.Text = StaffBrokerFunctions.GetSetting("gr_api_key", PortalId)


                Dim d As New gr_mappingDataContext
                Dim mappings = From c In d.gr_mappings Where c.PortalId = PortalId

                gvMappings.DataSource = mappings
                gvMappings.DataBind()

              
                ResetLocalDDL()
               


                If Not tbApiKey.Text = "" Then
                    Try

                   
                        gr = New GR(tbApiKey.Text, "http://192.168.2.244:3000/")



                    Dim leaves = From c In gr.GetFlatEntityLeafList("person") Select Name = c.GetDotNotation, c.ID Order By Name

                    gr_entity_types.DataSource = leaves
                    gr_entity_types.DataTextField = "Name"
                    gr_entity_types.DataValueField = "ID"
                    gr_entity_types.DataBind()
                    Dim parents = From c In gr.GetFlatEntityLeafList("person", "All") Select Name = c.GetDotNotation, c.ID Order By Name

                    ddlGrParent.DataSource = parents
                    ddlGrParent.DataTextField = "Name"
                    ddlGrParent.DataValueField = "ID"
                    ddlGrParent.DataBind()

                    ddlFieldType.DataSource = FieldType.type_list
                    ddlFieldType.DataBind()



                        For Each row In gr.entity_types_def
                            tv_gr_types.Nodes.Add(ProcessEntityTypesIntoTV(row))

                        Next
                    Catch ex As Exception
                        pnlMain.Visible = False
                    End Try
                End If

            End If
        End Sub
        Private Function ProcessEntityTypesIntoTV(ByVal et As EntityType) As TreeNode
            Dim rtn As New TreeNode(et.Name, et.GetDotNotation)
            For Each row In et.Children
                rtn.ChildNodes.Add(ProcessEntityTypesIntoTV(row))
            Next
            Return rtn

        End Function

        Protected Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
            Dim d As New gr_mappingDataContext
            Dim q = From c In d.gr_mappings Where c.PortalId = PortalId And c.LocalName = ddlProfileMap.SelectedItem.Text _
              And c.LocalSource = "UP" And c.gr_dot_notated_name = gr_entity_types.SelectedItem.Text

            If q.Count = 0 Then
                Dim insert As New gr_mapping.gr_mapping()
                insert.PortalId = PortalId
                insert.LocalName = ddlProfileMap.SelectedItem.Text.Substring(ddlProfileMap.SelectedItem.Text.IndexOf(":") + 2)
                insert.LocalSource = ddlProfileMap.SelectedValue.Substring(0, ddlProfileMap.SelectedValue.IndexOf("-"))
                insert.gr_dot_notated_name = gr_entity_types.SelectedItem.Text
                insert.FieldType = "string"
                d.gr_mappings.InsertOnSubmit(insert)
                d.SubmitChanges()

                Dim mappings = From c In d.gr_mappings Where c.PortalId = PortalId

                gvMappings.DataSource = mappings
                gvMappings.DataBind()

            End If



        End Sub

        Protected Sub gvMappings_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvMappings.RowCommand
            If e.CommandName = "myDelete" Then
                Dim d As New gr_mappingDataContext
                Dim q = From c In d.gr_mappings Where c.Id = CInt(e.CommandArgument)

                d.gr_mappings.DeleteAllOnSubmit(q)
                d.SubmitChanges()
                Dim mappings = From c In d.gr_mappings Where c.PortalId = PortalId

                gvMappings.DataSource = mappings
                gvMappings.DataBind()

            End If
        End Sub
        Public Function getLocalTypeName(ByVal LocalType As String) As String
            Select Case LocalType
                Case "UP"
                    Return "User Profile:"
                Case "U"
                    Return "User:"
                Case "SP"
                    Return "Staff Profile:"
                Case "S"
                    Return "Staff"

                Case Else
                    Return ""
            End Select
        End Function

        Protected Sub btnCreateGrType_Click(sender As Object, e As EventArgs) Handles btnCreateGrType.Click
            gr = New GR(StaffBrokerFunctions.GetSetting("gr_api_key", PortalId), "http://192.168.1.35:3000/")
            gr.addNewEntityType(tbNewType.Text, ddlFieldType.SelectedValue, IIf(ddlGrParent.SelectedItem.Text = "root", "", ddlGrParent.SelectedItem.Text))
            'do a total reset
            Response.Redirect(NavigateURL())
        End Sub

        Protected Sub btnSaveKey_Click(sender As Object, e As EventArgs) Handles btnSaveKey.Click
            StaffBrokerFunctions.SetSetting("gr_api_key", tbApiKey.Text, PortalId)
            Response.Redirect(NavigateURL())
        End Sub
    End Class
End Namespace
