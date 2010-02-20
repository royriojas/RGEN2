<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vLogIn.aspx.cs" Inherits="vLogIn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Riesgos Generales / Inicio de Sesión</title>
		<link href="css/layout.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript">
			window.onload = function () {
				var ele = document.getElementById('stlogin');
				ele.focus();
			}
		</script>
</head>
<body>
    <div>
	    <form id="Form1" runat="server">
		    <div class="Data" style="WIDTH: 304px;margin-left:auto;margin-right:auto;position:relative;">
			    <div id="LoginImage"></div>
			    <div class="DataTop">
				    <div class="DataTopLeft"></div>
				    <div class="DataTopRight"></div>
			    </div>
			    <div class="DataContent">
				    <div class="DataContentRight" style="TEXT-ALIGN: center">
					    <h2>Inicio de Sesión</h2>
					    <div class="hr"></div>
					    <table cellspacing="0" cellpadding="1" width="220" border="0">
						    <tr>
							    <td width="90" style="height: 20px">Usuario</td>
							    <td style="height: 20px"><asp:textbox id="stlogin" runat="server" CssClass="FormText" style="text-transform:none"></asp:textbox></td>
						    </tr>
						    <tr>
							    <td>Contraseña</td>
							    <td><asp:textbox id="stclave" runat="server" CssClass="FormText" TextMode="Password" style="text-transform:none"></asp:textbox></td>
						    </tr>
						    <tr valign="top">
							    <td height="25"><asp:button id="Submit" runat="server" CssClass="FormButton" Text="Ingresar" Width="90" OnClick="Submit_Click"></asp:button></td>
							    <td><input class="FormButton" id="Reset" style="WIDTH: 115px" type="reset" value="Limpiar Campos"/></td>
						    </tr>
					    </table>
				    </div>
			    </div>
			    <div class="DataBottom">
				    <div class="DataBottomLeft"></div>
				    <div class="DataBottomRight"></div>
			    </div>
			    <asp:requiredfieldvalidator id="RFVstusername" style="TEXT-ALIGN: center" runat="server" CssClass="DataValidator"
				    Width="304px" ForeColor="#FFCC00" Display="None" ErrorMessage="Ingrese su Nombre de Usuario" ControlToValidate="stlogin"></asp:requiredfieldvalidator>
				    <asp:requiredfieldvalidator id="FRVstuserpassword" style="TEXT-ALIGN: center" runat="server" CssClass="DataValidator"
				    Width="304px" ForeColor="#FFCC00" Display="None" ErrorMessage="Ingrese su Contraseña" ControlToValidate="stclave"></asp:requiredfieldvalidator>
				    <asp:label id="strespuesta" runat="server" CssClass="DataValidator" Width="304px" Visible="False">Su usuario y/o Contraseña no son válidos</asp:label>
				    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
			   </div>
	    </form>
    </div>
</body>
</html>
