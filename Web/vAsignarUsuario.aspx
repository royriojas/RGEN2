<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAsignarUsuario.aspx.cs" Inherits="vAsignarUsuario" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Nueva Aseguradora</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="Scripts/functions.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/xCaseOperations.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>     
    
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    
</head>
<body>
    <form id="form1" runat="server">
        <div id="cont" style="padding: 5px">
            <div id="nuevoRegDiv" runat="server">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="personaId" DataSourceID="sdsUsuarioxPersona"
                    DefaultMode="Edit" Width="551px" OnItemUpdating="FormView1_ItemUpdating">
                    <EditItemTemplate>
                      <div id="UserAssign" class="DataTable" style="padding:5px;">
                        <table style="width: 438px">
                            <tr>
                                <td><b> Persona : </b>
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("persona") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                   <b> Usuario :</b>
                                </td>
                                <td>
                                     <asp:TextBox ID="usuarioTextBox" CssClass="FormText MINUSC" Width="200px"  runat="server" Text='<%# Bind("usuario") %>'></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Password : </b>
                                </td>
                                <td>
                                    <asp:TextBox ID="contrasenaTextBox" CssClass="FormText" Width="200px"  runat="server" Text='<%# Bind("contrasena") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="FormButton"
                                        Text="Grabar" /></td>
                            </tr>
                        </table>
                        </div>
                    </EditItemTemplate>
                </asp:FormView>
            </div>
            <div style="padding: 1px;">
                &nbsp;</div>
            &nbsp;<br />
        </div>
        <asp:SqlDataSource ID="sdsUsuarioxPersona" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:rgen2ConnectionString.ProviderName %>" SelectCommand="sp_rgen_usuarioByPersonaId"
            SelectCommandType="StoredProcedure" UpdateCommand="sp_rgen_asocia_usuario_a_persona"
            UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:Parameter Name="personaId" Type="Decimal" />
                <asp:Parameter Name="usuario" Type="String" />
                <asp:Parameter Name="contrasena" Type="String" />
                <asp:Parameter Name="rolId" Type="Decimal" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="personaId" QueryStringField="PersonaId" Type="Decimal" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>

