#region Copyright
// 
// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2012
// by DotNetNuke Corporation
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
// to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial portions 
// of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
#endregion
#region Usings

using System;
using System.Collections;
using System.Globalization;
using System.Web.UI.WebControls;

using DotNetNuke.Common.Lists;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Framework;
using DotNetNuke.Security.Roles;
using DotNetNuke.Security.Roles.Internal;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Services.Localization;
using DotNetNuke.UI.Skins.Controls;
using DotNetNuke.UI.Utilities;
using DotNetNuke.Web.UI.WebControls.Extensions;

using Globals = DotNetNuke.Common.Globals;

#endregion

namespace DotNetNuke.Modules.Admin.Security
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The EditRoles PortalModuleBase is used to manage a Security Role
    /// </summary>
    /// <remarks>
    /// </remarks>
    /// <history>
    /// 	[cnurse]	9/10/2004	Updated to reflect design changes for Help, 508 support
    ///                       and localisation
    /// </history>
    /// -----------------------------------------------------------------------------
    public partial class EditRoles : PortalModuleBase
    {
        #region Private Members

        private int _roleID = -1;

        #endregion

        #region Private Methods

        private void ActivateControls(bool enabled)
        {
            cboRoleGroups.Enabled = enabled;
            chkIsPublic.Enabled = enabled;
            chkAutoAssignment.Enabled = enabled;
            txtServiceFee.Enabled = enabled;
            txtBillingPeriod.Enabled = enabled;
            cboBillingFrequency.Enabled = enabled;
            txtTrialFee.Enabled = enabled;
            txtTrialPeriod.Enabled = enabled;
            cboTrialFrequency.Enabled = enabled;
            txtRSVPCode.Enabled = enabled;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindGroups gets the role Groups from the Database and binds them to the DropDown
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        ///     [cnurse]    01/05/2006  Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindGroups()
        {
            var arrGroups = RoleController.GetRoleGroups(PortalId);

            cboRoleGroups.Items.Add(new ListItem(Localization.GetString("GlobalRoles"), "-1"));

            foreach (RoleGroupInfo roleGroup in arrGroups)
            {
                cboRoleGroups.Items.Add(new ListItem(roleGroup.RoleGroupName, roleGroup.RoleGroupID.ToString()));
            }
        }

        private void UpdateFeeTextBoxes()
        {
            if (cboBillingFrequency.SelectedValue == "O")
            {
                txtBillingPeriod.Text = "1";
                txtBillingPeriod.Enabled = false;
            }
            else
            {
                txtBillingPeriod.Enabled = true;
            }
            if (cboTrialFrequency.SelectedValue == "O")
            {
                txtTrialPeriod.Text = "1";
                txtTrialPeriod.Enabled = false;
            }
            else
            {
                txtTrialPeriod.Enabled = true;
            }
        }

        #endregion

        #region Event Handlers

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Page_Load runs when the control is loaded
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	9/10/2004	Updated to reflect design changes for Help, 508 support
        ///                       and localisation
        /// </history>
        /// -----------------------------------------------------------------------------
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            jQuery.RequestDnnPluginsRegistration();

            cboBillingFrequency.SelectedIndexChanged += OnBillingFrequencyIndexChanged;
            cboTrialFrequency.SelectedIndexChanged += OnTrialFrequencyIndexChanged;
            cmdDelete.Click += OnDeleteClick;
            cmdManage.Click += OnManageClick;
            cmdUpdate.Click += OnUpdateClick;
            txtRSVPCode.TextChanged += OnRsvpCodeChanged;

            try
            {
                if ((Request.QueryString["RoleID"] != null))
                {
                    _roleID = Int32.Parse(Request.QueryString["RoleID"]);
                }
                var objPortalController = new PortalController();
                var objPortalInfo = objPortalController.GetPortal(PortalSettings.PortalId);
                if ((objPortalInfo == null || string.IsNullOrEmpty(objPortalInfo.ProcessorUserId)))
                {
					//Warn users about fee based roles if we have a Processor Id
                    lblProcessorWarning.Visible = true;
                }
                else
                {
                    divServiceFee.Visible = true;
                    divBillingPeriod.Visible = true;
                    divTrialFee.Visible = true;
                    divTrialPeriod.Visible = true;
                }
                if (Page.IsPostBack == false)
                {
                    cmdCancel.NavigateUrl = Globals.NavigateURL();

                    var ctlList = new ListController();
                    var colFrequencies = ctlList.GetListEntryInfoItems("Frequency", "");

                    cboBillingFrequency.DataSource = colFrequencies;
                    cboBillingFrequency.DataBind();
                    cboBillingFrequency.Items.FindByValue("N").Selected = true;

                    cboTrialFrequency.DataSource = colFrequencies;
                    cboTrialFrequency.DataBind();
                    cboTrialFrequency.Items.FindByValue("N").Selected = true;

                    securityModeList.Items.Clear();
                    foreach(var enumValue in Enum.GetValues(typeof(SecurityMode)))
                    {
                        var enumName = Enum.GetName(typeof(SecurityMode), enumValue);
                        var enumItem = new ListItem(enumName, ((int)enumValue).ToString(CultureInfo.InvariantCulture));

                        securityModeList.Items.Add(enumItem);
                    }

                    statusList.Items.Clear();
                    foreach (var enumValue in Enum.GetValues(typeof(RoleStatus)))
                    {
                        var enumName = Enum.GetName(typeof(RoleStatus), enumValue);
                        var enumItem = new ListItem(enumName, ((int)enumValue).ToString(CultureInfo.InvariantCulture));

                        statusList.Items.Add(enumItem);
                    }

                    BindGroups();

                    ctlIcon.FileFilter = Globals.glbImageFileTypes;
                    if (_roleID != -1)
                    {
                        lblRoleName.Visible = true;
                        txtRoleName.Visible = false;
                        valRoleName.Enabled = false;

                        var role = TestableRoleController.Instance.GetRole(PortalSettings.PortalId, r => r.RoleID == _roleID);
                        if (role != null)
                        {
                            lblRoleName.Text = role.RoleName;
                            txtDescription.Text = role.Description;
                            if (cboRoleGroups.Items.FindByValue(role.RoleGroupID.ToString(CultureInfo.InvariantCulture)) != null)
                            {
                                cboRoleGroups.ClearSelection();
                                cboRoleGroups.Items.FindByValue(role.RoleGroupID.ToString(CultureInfo.InvariantCulture)).Selected = true;
                            }
                            if (!String.IsNullOrEmpty(role.BillingFrequency))
                            {
                                txtServiceFee.Text = role.ServiceFee.ToString("N2", CultureInfo.CurrentCulture);
                                txtBillingPeriod.Text = role.BillingPeriod.ToString(CultureInfo.InvariantCulture);
                                if (cboBillingFrequency.Items.FindByValue(role.BillingFrequency) != null)
                                {
                                    cboBillingFrequency.ClearSelection();
                                    cboBillingFrequency.Items.FindByValue(role.BillingFrequency).Selected = true;
                                }
                            }
                            if (!String.IsNullOrEmpty(role.TrialFrequency))
                            {
                                txtTrialFee.Text = role.TrialFee.ToString("N2", CultureInfo.CurrentCulture);
                                txtTrialPeriod.Text = role.TrialPeriod.ToString(CultureInfo.InvariantCulture);
                                if (cboTrialFrequency.Items.FindByValue(role.TrialFrequency) != null)
                                {
                                    cboTrialFrequency.ClearSelection();
                                    cboTrialFrequency.Items.FindByValue(role.TrialFrequency).Selected = true;
                                }
                            }

                            if (securityModeList.Items.FindByValue(Convert.ToString((int)role.SecurityMode)) != null)
                            {
                                securityModeList.ClearSelection();
                                securityModeList.Items.FindByValue(Convert.ToString((int)role.SecurityMode)).Selected = true;
                            }

                            if (statusList.Items.FindByValue(Convert.ToString((int)role.Status)) != null)
                            {
                                statusList.ClearSelection();
                                statusList.Items.FindByValue(Convert.ToString((int)role.Status)).Selected = true;
                            }

                            chkIsPublic.Checked = role.IsPublic;
                            chkAutoAssignment.Checked = role.AutoAssignment;
                            txtRSVPCode.Text = role.RSVPCode;
                            if (!String.IsNullOrEmpty(txtRSVPCode.Text))
                            {
                                lblRSVPLink.Text = Globals.AddHTTP(Globals.GetDomainName(Request)) + "/" + Globals.glbDefaultPage + "?rsvp=" + txtRSVPCode.Text + "&portalid=" + PortalId;
                            }
                            ctlIcon.Url = role.IconFile;

                            UpdateFeeTextBoxes();
                            cmdManage.Visible = role.Status == RoleStatus.Approved;
                        }
                        else //security violation attempt to access item not related to this Module
                        {
                            Response.Redirect(Globals.NavigateURL("Security Roles"));
                        }

                        if (_roleID == PortalSettings.AdministratorRoleId || _roleID == PortalSettings.RegisteredRoleId)
                        {
                            cmdDelete.Visible = false;
                            ActivateControls(false);
                        }
                        if (_roleID == PortalSettings.RegisteredRoleId)
                        {
                            cmdManage.Visible = false;
                        }
                    }
                    else
                    {
                        cmdDelete.Visible = false;
                        cmdManage.Visible = false;
                        lblRoleName.Visible = false;
                        txtRoleName.Visible = true;

                        statusList.SelectedIndex = 1;

						//select default role group id
						if(Request.QueryString["RoleGroupID"] != null)
						{
							var roleGroupID = Request.QueryString["RoleGroupID"];
							if (cboRoleGroups.Items.FindByValue(roleGroupID) != null)
							{
								cboRoleGroups.ClearSelection();
								cboRoleGroups.Items.FindByValue(roleGroupID).Selected = true;
							}
						}
                    }
                }
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        protected void OnBillingFrequencyIndexChanged(object sender, EventArgs e)
        {
            UpdateFeeTextBoxes();
        }

        protected void OnTrialFrequencyIndexChanged(object sender, EventArgs e)
        {
            UpdateFeeTextBoxes();
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// cmdUpdate_Click runs when the update Button is clicked
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	9/10/2004	Updated to reflect design changes for Help, 508 support
        ///                       and localisation
        /// 	[jlucarino]	2/23/2009	Added CreatedByUserID and LastModifiedByUserID
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void OnUpdateClick(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    float sglServiceFee = 0;
                    var intBillingPeriod = 1;
                    var strBillingFrequency = "N";

                    if (cboBillingFrequency.SelectedItem.Value == "N" && !String.IsNullOrEmpty(txtServiceFee.Text))
                    {
                        UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("IncompatibleFee", LocalResourceFile), ModuleMessage.ModuleMessageType.RedError);
                        return;
                    }
                    if (!String.IsNullOrEmpty(txtServiceFee.Text) && !String.IsNullOrEmpty(txtBillingPeriod.Text) && cboBillingFrequency.SelectedItem.Value != "N")
                    {
                        sglServiceFee = float.Parse(txtServiceFee.Text);
                        intBillingPeriod = int.Parse(txtBillingPeriod.Text);
                        strBillingFrequency = cboBillingFrequency.SelectedItem.Value;
                    }
                    float sglTrialFee = 0;
                    var intTrialPeriod = 1;
                    var strTrialFrequency = "N";

                    if (sglServiceFee != 0 && !String.IsNullOrEmpty(txtTrialFee.Text) && !String.IsNullOrEmpty(txtTrialPeriod.Text) && cboTrialFrequency.SelectedItem.Value != "N")
                    {
                        sglTrialFee = float.Parse(txtTrialFee.Text);
                        intTrialPeriod = int.Parse(txtTrialPeriod.Text);
                        strTrialFrequency = cboTrialFrequency.SelectedItem.Value;
                    }

                    var role = new RoleInfo
                                   {
                                       PortalID = PortalId,
                                       RoleID = _roleID,
                                       RoleGroupID = int.Parse(cboRoleGroups.SelectedValue),
                                       RoleName = txtRoleName.Text,
                                       Description = txtDescription.Text,
                                       ServiceFee = sglServiceFee,
                                       BillingPeriod = intBillingPeriod,
                                       BillingFrequency = strBillingFrequency,
                                       TrialFee = sglTrialFee,
                                       TrialPeriod = intTrialPeriod,
                                       TrialFrequency = strTrialFrequency,
                                       IsPublic = chkIsPublic.Checked,
                                       AutoAssignment = chkAutoAssignment.Checked,
                                       SecurityMode = (SecurityMode)Enum.Parse(typeof(SecurityMode), securityModeList.SelectedValue),
                                       Status = (RoleStatus)Enum.Parse(typeof(RoleStatus), statusList.SelectedValue),
                                       RSVPCode = txtRSVPCode.Text,
                                       IconFile = ctlIcon.Url
                                   };
                    if (_roleID == -1)
                    {
                        if (TestableRoleController.Instance.GetRole(PortalId, r => r.RoleName == role.RoleName) == null)
                        {
                            TestableRoleController.Instance.AddRole(role);
                        }
                        else
                        {
                            UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("DuplicateRole", LocalResourceFile), ModuleMessage.ModuleMessageType.RedError);
                            return;
                        }
                    }
                    else
                    {
                        TestableRoleController.Instance.UpdateRole(role);
                    }
					
                    //Clear Roles Cache
                    DataCache.RemoveCache("GetRoles");

                    Response.Redirect(Globals.NavigateURL());
                }
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// cmdDelete_Click runs when the delete Button is clicked
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	9/10/2004	Updated to reflect design changes for Help, 508 support
        ///                       and localisation
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void OnDeleteClick(object sender, EventArgs e)
        {
            try
            {
                var role = TestableRoleController.Instance.GetRole(PortalSettings.PortalId, r => r.RoleID == _roleID);

                TestableRoleController.Instance.DeleteRole(role);
              
                //Clear Roles Cache
                DataCache.RemoveCache("GetRoles");

                Response.Redirect(Globals.NavigateURL());
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// cmdManage_Click runs when the Manage Users Button is clicked
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	9/10/2004	Updated to reflect design changes for Help, 508 support
        ///                       and localisation
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void OnManageClick(Object sender, EventArgs e)
        {
            try
            {
                Response.Redirect(EditUrl("RoleId", _roleID.ToString(), "User Roles"));
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        protected void OnRsvpCodeChanged(object sender, EventArgs e)
        {
            lblRSVPLink.Text = Globals.AddHTTP(Globals.GetDomainName(Request)) + @"/" + Globals.glbDefaultPage + @"?rsvp=" + txtRSVPCode.Text + @"&portalid=" + PortalId;
        }

        #endregion
    }
}