<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SuperPowers.ascx.vb" Inherits="DesktopModules_SuperPowers" %>

<div style="white-space: nowrap; ">
                <asp:Button ID="btnTranslate" runat="server" Text="Translate"  Font-Size="X-Small" class="aButton" style="float: left;"  />
              
                 <asp:Button ID="btnEdit" runat="server" Text="Edit" Font-Size="X-Small" class="aButton" style="float: left;" />
              
                  <asp:Button ID="btnNew" runat="server" Text="New"  Font-Size="X-Small" class="aButton" style="float: left;"  />
              
              <input type="checkbox" id="boost" class="boost" style="height:20px;" /><label for="boost" style="height:20px; float: left;" >Boost</label>
	            <input type="checkbox" id="block" class="block" style="height:20px;"  /><label for="block" style="height:20px; float: left;" >Block</label>
              
              
               <br />
                  <div style="clear: both;"></div>
                
               
               </div>
                 <asp:Label ID="lblPowerStatus" runat="server" Text="" ForeColor="Red" Font-Italic="true" ></asp:Label>
               