<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAsignarMail.aspx.cs" Inherits="vAsignarMail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Asignar Mails a Usuario</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="margin-bottom: 5px; position: relative; height: 24px;
                padding: 5px; background-color: #2c84bd; left: 0px; top: 0px;">
                <asp:Label ID="lblTitulo" runat="server" Font-Size="18px" Font-Bold="True">Agregar Correo Electrónico</asp:Label>
            </div>
            <div style="background-color: #2c84bd; padding: 5px; position:relative;">
                <asp:FormView ID="frmCorreoUpdate" runat="server" DataKeyNames="personaId" DataSourceID="odsCorreoPersona"
                    DefaultMode="Edit" OnItemUpdated="frmCorreoUpdate_ItemUpdated">
                    <EditItemTemplate>
                        <div class="DataTable" style="padding: 10px;">
                            <table width="500" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="150" style="height: 22px">
                                        Nombre del Usuario</td>
                                    <td width="350" style="height: 22px">
                                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Text='<%# Eval("persona") %>'></asp:Label>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Correo Electr&oacute;nico
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="debe ingresar una dirección de correo válida"
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="grupo1" ControlToValidate="emailTextBox">(*)</asp:RegularExpressionValidator></td>
                                    <td>
                                        <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' CssClass="FormText"
                                            Width="334px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="height: 13px">&nbsp;
                                        </td>
                                    <td style="height: 13px">&nbsp;
                                        </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="personaIdLabel1" runat="server" Style="display: none;" Text='<%# Bind("personaId") %>'></asp:Label></td>
                                    <td style="color: #cc0033">
                                        (*) Esta Dirección de Correo será usada para contactarse con el Usuario a través
                                        de las notificaciones automáticas. Asegúrese que la dirección es válida.</td>
                                </tr>
                            </table>
                        </div>
                        <br />
                        &nbsp;
                        <div align="right" style="position:relative;">
                        <div id="pnlMsg" runat="server" style="position:absolute;width:409px;height:10px;padding:5px;background-color:#ffcc33; left: -444px; top: 3px; font-weight: bold; vertical-align: middle; color: #336699; text-align: center;" visible="false">La dirección de Correo ha sido actualizada</div>

                            <asp:ImageButton ID="imgBtnSave" runat="server" CommandName="Update" ImageUrl="~/images/IconSave32Dark.gif" />&nbsp;
                            <asp:ImageButton OnClientClick="window.top.hidePopWin();return false;" ID="imgBtnCancel" runat="server" ImageUrl="~/images/IconExit32Dark.gif" CommandName="Cancel" />
                        </div>
                                            </EditItemTemplate>
                </asp:FormView>
            </div>
            <asp:ObjectDataSource ID="odsCorreoPersona" runat="server"
                SelectMethod="GetData" TypeName="dsUsuariosTableAdapters.correoPersonaTableAdapter"
                UpdateMethod="Update">
                <UpdateParameters>
                    <asp:Parameter Name="personaId" Type="Decimal" />
                    <asp:Parameter Name="email" Type="String" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="personaId" QueryStringField="personaId" Type="Decimal" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </form>
</body>
</html>
