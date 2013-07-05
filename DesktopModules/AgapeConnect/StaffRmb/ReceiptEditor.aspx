<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReceiptEditor.aspx.vb" Inherits="DesktopModules_AgapeConnect_StaffRmb_ReceiptEditor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <asp:FileUpload ID="fuReceipt" runat="server" /> 
                                          <asp:Image ID="imgReceipt" runat="server" width="300px" />
                                    <asp:Button ID="btnUploadReceipt" runat="server" Text="Upload" Width="100px" CssClass="aButton"  />
        <asp:Button ID="btnRotateLeft" runat="server" Text="Rotate Left" />
                                            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
    </div>
    </form>
</body>
</html>
