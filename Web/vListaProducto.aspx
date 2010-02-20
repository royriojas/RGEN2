<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaProducto.aspx.cs" Inherits="vListaProducto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Tipo de Siniestro</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript">
    
    window.onload = function () {
        try {
            btn_ocultar = new CollapsibleDiv('trigger_nuevoTipoDiv',
						     'nuevoTipoDiv',						 
						     false,
						     null);
	    }
	    catch (e) {
	        alert (e.message);
	    }
    }
    
  </script>

</head>
<body>
  <form id="form1" runat="server">
    <div style="width: 620px; position: relative; overflow: auto; left: 0px; top: 0px;
      height: 469px;">
      <div id="cont" style="width: 600px; position: relative;">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding: 1%;">
            <div class="PanelEncabezado">
              <asp:Label ID="Label3" runat="server" Font-Size="18px" Font-Bold="True">Nuevo Producto</asp:Label>
              <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Producto" title="Agregar Producto"
                id="trigger_nuevoTipoDiv" />
            </div>
            <div class="hr">
            </div>
            <div id="nuevoTipoDiv" style="display: none;">
              <div class="DataTable" style="position: relative; padding: 1%;">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="productoId" DataSourceID="sdsProducto"
                  DefaultMode="Insert" OnItemInserting="FormView1_ItemInserting" Style="left: 0px;
                  top: 0px" CellPadding="0">
                  <InsertItemTemplate>
                    <table border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="width: 90px; padding-top: 2px" valign="top">
                          Producto</td>
                        <td style="width: 410px">
                          &nbsp;<asp:TextBox ID="tipoSiniestroTextBox" runat="server" Text='<%# Bind("nombre") %>'
                            CssClass="FormText" Width="400px" TextMode="MultiLine" Rows="4"></asp:TextBox></td>
                        <td style="width: 19px">
                        </td>
                        <td>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tipoSiniestroTextBox"
                            ErrorMessage="Ingrese un Producto" ValidationGroup="InsertVG"></asp:RequiredFieldValidator></td>
                      </tr>
                      <tr>
                        <td style="padding-top: 2px; width: 90px;" valign="top">
                          Descripción</td>
                        <td style="width: 410px">
                          &nbsp;<asp:TextBox ID="descripcionTextBox" runat="server" Text='<%# Bind("descripcion") %>'
                            CssClass="FormText" TextMode="MultiLine" Width="400px" Rows="4"></asp:TextBox></td>
                        <td style="width: 19px">
                        </td>
                        <td>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="descripcionTextBox"
                            ErrorMessage="Ingrese una Descripción" ValidationGroup="InsertVG"></asp:RequiredFieldValidator></td>
                      </tr>
                      <tr>
                        <td style="width: 90px">
                          &nbsp;</td>
                        <td style="width: 410px">
                        </td>
                        <td style="width: 19px">
                        </td>
                        <td>
                        </td>
                      </tr>
                      <tr>
                        <td style="width: 90px">
                        </td>
                        <td style="width: 410px">
                          <asp:ImageButton ID="btnGuardar" runat="server" CommandName="Insert" ImageUrl="~/images/IconSave24.gif"
                            ValidationGroup="InsertVG" /></td>
                        <td style="width: 19px">
                        </td>
                        <td>
                        </td>
                      </tr>
                    </table>
                  </InsertItemTemplate>
                </asp:FormView>
              </div>
            </div>
            <br />
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
              <div class="PanelEncabezado">
                <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px">Productos</asp:Label>
                <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
                  onclick="return separar();" Width="22px" CssClass="BtnSeparar"></asp:HyperLink>
              </div>
              <div style="padding: 1px;">
                <div class="hr">
                </div>
                <table>
                  <tr>
                    <td>
                      Producto
                    </td>
                    <td style="width: 10px;">
                    </td>
                    <td>
                      <asp:TextBox ID="txtProducto" CssClass="FormText" Width="150px" runat="server"></asp:TextBox>
                    </td>
                    <td style="width: 10px;">
                    </td>
                    <td>
                      <asp:Button ID="btnSearch" CssClass="FormButton" runat="server" Text="Buscar" OnClick="btnSearch_Click" /></td>                      
                  </tr>
                  <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>&nbsp;</td>
                  </tr>
                </table>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductoId"
                  DataSourceID="sdsProducto" Width="577px" AllowPaging="True" AllowSorting="True"
                  OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating">
                  <Columns>
                    <asp:BoundField DataField="productoId" HeaderText="ProductoId" InsertVisible="False"
                      ReadOnly="True" SortExpression="productoId">
                      <ItemStyle CssClass="invisible" />
                      <HeaderStyle CssClass="invisible" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Nombre Producto" SortExpression="nombre">
                      <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" Text='<%# Bind("nombre") %>'
                          TextMode="MultiLine" Width="230px" Rows="4"></asp:TextBox>
                      </EditItemTemplate>
                      <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("nombre") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Descripci&#243;n" SortExpression="descripcion">
                      <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Text='<%# Bind("descripcion") %>'
                          TextMode="MultiLine" Width="230px" Rows="4"></asp:TextBox>
                      </EditItemTemplate>
                      <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("descripcion") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                      <EditItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update"
                          ImageUrl="~/imgRGen/button_ok.gif" Text="Update" />&nbsp;<asp:ImageButton ID="ImageButton2"
                            runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/imgRGen/iconCancel.gif"
                            Text="Cancel" />
                      </EditItemTemplate>
                      <ItemStyle Width="70px" />
                      <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
                          ImageUrl="~/imgRGen/button_edit.gif" />&nbsp;<asp:ImageButton ID="ImageButton2" runat="server"
                            CausesValidation="False" CommandName="Delete" ImageUrl="~/imgRGen/deleteItem.gif"
                            OnClientClick="return confirm('¿Confirma la Eliminación de este Producto?');" />
                        <asp:HyperLink ID="lnkAsociaRamos" NavigateUrl='<%# setNavigateUrl(Eval("productoId"),Eval("nombre")) %>'
                          runat="server" ImageUrl="~/images/btnsListas/icon_edit2.jpg"></asp:HyperLink>
                      </ItemTemplate>
                    </asp:TemplateField>
                  </Columns>
                  <RowStyle CssClass="ItemStyle" />
                  <HeaderStyle CssClass="HeaderStyle" />
                </asp:GridView>
              </div>
              <br />
            </div>
          </div>
        </div>
        <div class="DataBottom">
          <div class="DataBottomLeft">
          </div>
          <div class="DataBottomRight">
          </div>
        </div>
      </div>
    </div>
    <asp:SqlDataSource ID="sdsProducto" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      DeleteCommand="sp_rgen_productoDeleteX" DeleteCommandType="StoredProcedure" InsertCommand="sp_rgen_ProductoInsertX"
      InsertCommandType="StoredProcedure" SelectCommand="sp_rgen_ProductoSelectAll" SelectCommandType="StoredProcedure"
      UpdateCommand="sp_rgen_productoUpdateX" UpdateCommandType="StoredProcedure" OnInserted="sdsProducto_Inserted">
      <DeleteParameters>
        <asp:Parameter Name="productoid" Type="Decimal" />
        <asp:Parameter Name="uupdate" Type="String" />
      </DeleteParameters>
      <UpdateParameters>
        <asp:Parameter Name="productoid" Type="Decimal" />
        <asp:Parameter Name="nombre" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
      </UpdateParameters>
      <InsertParameters>
        <asp:Parameter Direction="InputOutput" Name="productoId" Type="Decimal" />
        <asp:Parameter Name="nombre" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
      </InsertParameters>
      <SelectParameters>
        <asp:ControlParameter ControlID="txtProducto" ConvertEmptyStringToNull="False" Name="nombre"
          PropertyName="Text" Type="String" />
      </SelectParameters>
    </asp:SqlDataSource>
  </form>
</body>
</html>
