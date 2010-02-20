<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaUsuario.aspx.cs" Inherits="vListaUsuario" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Riesgos Generales / Usuarios</title>
    <link href="Css/layout.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/popUpWin/css/style.css" rel="stylesheet" type="text/css" />
    <link href="Scripts/popUpWin/css/subModal.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

    <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

    <script type="text/javascript" src="Scripts/functions.js"></script>

    <script type="text/javascript">

        function ShowEdit(usuarioId, acc, personaId)
        {
          showPopWin('vEditorUsuario.aspx?personaid='+personaId+'&uid='+ usuarioId +'&acc='+ acc, 650, 410, true);
        }
       
    </script>

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script type="text/javascript">creaPopUpDivs();</script>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; width:999px;">
            <table style="width: 100%;" id="Data" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td>
                        <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="opciones"/>
                        <br />
                        <div class="DataTop">
                            <div class="DataTopLeft">
                            </div>
                            <div class="DataTopRight">
                            </div>
                        </div>
                        <div class="DataContent">
                            <div class="DataContentRight">
                                <table id="Table1" cellspacing="0" cellpadding="0" border="0" style="width: 848px">
                                    <tr>
                                        <td rowspan="2" valign="top" style="width: 118px">
                                            <asp:Label ID="lbBusqueda" Font-Bold="True" Font-Size="18px" runat="server">Búsqueda</asp:Label></td>
                                        <td align="right" style="width: 66px">
                                            Nombre&nbsp;</td>
                                        <td style="width: 277px" colspan="3">
                                            <asp:TextBox ID="nombreTextBox" runat="server" CssClass="FormText" Width="339px"></asp:TextBox></td>
                                        <td width="80" rowspan="3" valign="top" style="padding-left: 3px">
                                            <asp:ImageButton ID="btnBuscar" onmouseover="MakeClear(this,1);" onmouseout="MakeClear(this,0)"
                                                runat="server" AlternateText="Buscar Certificados" ImageUrl="~/imgRGen/btnBuscar.gif"
                                                OnClick="btnBuscar_Click"></asp:ImageButton>
                                            <asp:HyperLink  ID="nuevaSolicitudHyperLink" runat="server" ImageUrl="~/imgRGen/btnNuevo.jpg"
                                                NavigateUrl="javascript:ShowEdit(0,'N')" ToolTip="Nuevo Usuario" onmouseover="MakeClear(this,1);"
                                                onmouseout="MakeClear(this,0)">HyperLink</asp:HyperLink></td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="width: 66px">
                                            Rol&nbsp;
                                        </td>
                                        <td style="width: 277px" colspan="3">
                                            <asp:DropDownList ID="rolIdCombo" runat="server" CssClass="FormText" Width="342px"
                                                DataSourceID="odsRolCombo" DataTextField="rol" DataValueField="rolId" OnDataBound="rolIdCombo_DataBound">
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr id="trControl" runat="server">
                                        <td style="height: 18px; width: 118px;">&nbsp;
                                            </td>
                                        <td align="right" style="width: 66px; height: 18px;">
                                            Estado&nbsp;
                                        </td>
                                        <td colspan="3" style="width: 277px; height: 18px;">
                                            <asp:DropDownList ID="estadoUsuarioIdCombo" runat="server" Width="342px" CssClass="FormText">
                                                <asp:ListItem Value="A">ACTIVO</asp:ListItem>
                                                <asp:ListItem Value="I">INACTIVO</asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="DataBottom">
                            <div class="DataBottomLeft">
                            </div>
                            <div class="DataBottomRight">
                            </div>
                        </div>
                        <div class="DataTop">
                            <div class="DataTopLeft">
                            </div>
                            <div class="DataTopRight">
                            </div>
                        </div>
                        <div class="DataContent">
                            <div class="DataContentRight">
                                <div id="Encabezado" style="height: 22px">
                                    <asp:Label ID="encabezadoLabel" runat="server" Style="float: left; color: White"
                                        Font-Bold="True" Font-Size="20px">Usuarios</asp:Label>
                                    <div style="float: right; height: 22px;" id="toolBar">
                                        &nbsp;</div>
                                </div>
                                <div class="hr">
                                </div>
                                <asp:GridView ID="listaUsuariosGridView" runat="server" CssClass="GridLista" BorderStyle="Solid"
                                    AutoGenerateColumns="False" AllowPaging="True" PageSize="25" OnPageIndexChanging="listaUsuariosGridView_PageIndexChanging"
                                    EmptyDataText="No se encontraron ocurrencias" EnableViewState="False" DataSourceID="odsListaUsuario"
                                    OnRowDataBound="listaUsuariosGridView_RowDataBound" OnDataBinding="listaUsuariosGridView_DataBinding"
                                    Width="972px">
                                    <HeaderStyle CssClass="HeaderStyle" />
                                    <RowStyle CssClass="ItemStyle" />
                                    <Columns>
                                        <asp:BoundField DataField="persona" HeaderText="Persona" SortExpression="persona" >
                                            <ItemStyle Width="300px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="usuario" HeaderText="Usuario" SortExpression="usuario" >
                                            <ItemStyle HorizontalAlign="Center" Width="180px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="rol" HeaderText="Rol" >
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="fcrea" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Creaci&#243;n"
                                            HtmlEncode="False" SortExpression="fcrea">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="estado" HeaderText="Estado" SortExpression="estado" >
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Acci&#243;n">
                                            <ItemStyle HorizontalAlign="Center" Width="100px" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:HyperLink ID="viewHyperLink" runat="server" ImageUrl="~/Images/IconFind16.gif">Ver registro</asp:HyperLink>
                                                <asp:HyperLink ID="editHyperLink" runat="server" ImageUrl="~/imgRGen/button_edit.gif">Editar el registro</asp:HyperLink>
                                                <asp:HyperLink ID="deleteHyperLink" runat="server" ImageUrl="~/imgRGen/deleteItem.png">Eliminar el registro</asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <br />
                            </div>
                        </div>
                        <div class="DataBottom">
                            <div class="DataBottomLeft">
                            </div>
                            <div class="DataBottomRight">
                            </div>
                        </div>
                        &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<asp:ObjectDataSource ID="odsRolCombo" runat="server"
                            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsComboTableAdapters.RolComboByUserTableAdapter"
                            OnSelecting="odsRolCombo_Selecting">
                            <SelectParameters>
                                <asp:SessionParameter Name="tipoUsuario" SessionField="TipoUsuario" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsListaUsuario" runat="server" OldValuesParameterFormatString="original_{0}"
                            OnSelected="odsListaUsuario_Selected" SelectMethod="GetData" TypeName="dsUsuariosTableAdapters.UsuarioListaTableAdapter" OnSelecting="odsListaUsuario_Selecting">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="nombreTextBox" Name="persona" PropertyName="Text"
                                    Type="String" />
                                <asp:ControlParameter ControlID="rolIdCombo" Name="rolId" PropertyName="SelectedValue"
                                    Type="Decimal" />
                                <asp:ControlParameter ControlID="estadoUsuarioIdCombo" Name="estado" PropertyName="SelectedValue"
                                    Type="String" />
                                <asp:SessionParameter Name="tipoUsuario" SessionField="TipoUsuario" Type="String" />
                              <asp:Parameter Name="companiaId" Type="Decimal" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
                </tr>
            </table>
            <br />
        </div>

        

    </form>
</body>
</html>
