<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaRamo.aspx.cs" Inherits="vListaRamo"
  MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Riesgos Generales / Lista de Ramos</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="Scripts/popUpWin/css/style.css" rel="stylesheet" type="text/css" />
  <link href="Scripts/popUpWin/css/subModal.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript">
 
      window.onload = function() {
        try {
                btn_ocultar = new CollapsibleDiv('trigger_nuevoTipoDiv',
						         'nuevoRamoDiv',						 
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
    <div>
      <div id="cont" style="width: 512px; position: relative;">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding: 1%">
            <div class="PanelEncabezado">
              <asp:Label ID="Label1" runat="server" Font-Size="18px" Font-Bold="True" ForeColor="White">Nuevo Ramo</asp:Label>
              <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Producto" title="Agregar Producto"
                id="trigger_nuevoTipoDiv" /></div>
            <div class="hr">
            </div>
            <div id="nuevoRamoDiv" style="display: none;">
              <div class="DataTable" style="padding: 5px; position: relative;">
                <asp:FormView ID="ramoFormView" runat="server" DefaultMode="Insert" DataKeyNames="ramoId"
                  DataSourceID="sdsRamo">
                  <InsertItemTemplate>
                    <table border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="width: 100px; padding-top: 2px" valign="top">
                          Nombre<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="nombreTextBox"
                            ErrorMessage="Ingrese el nombre del ramo" ValidationGroup="insert">(*)</asp:RequiredFieldValidator></td>
                        <td>
                          <asp:TextBox ID="nombreTextBox" runat="server" CssClass="FormText" MaxLength="250"
                            Text='<%# Bind("nombre") %>' Width="350px" Height="10px"></asp:TextBox>&nbsp;</td>
                      </tr>
                      <tr>
                        <td style="padding-top: 2px" valign="top">
                          Descripción<asp:RequiredFieldValidator ID="nombreRFV" runat="server" ControlToValidate="descripcionTextBox"
                            ErrorMessage="Ingrese una descripción para el ramo" ValidationGroup="insert">(*)</asp:RequiredFieldValidator></td>
                        <td>
                          <asp:TextBox ID="descripcionTextBox" runat="server" CssClass="FormText" MaxLength="250"
                            Text='<%# Bind("descripcion") %>' TextMode="MultiLine" Width="350px" Rows="4"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          &nbsp;</td>
                        <td>
                          &nbsp;</td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                          <asp:ImageButton ID="imgBtnGuardar" runat="server" ImageUrl="~/images/IconSave24.gif"
                            CommandName="Insert" ValidationGroup="insert" /></td>
                      </tr>
                    </table>
                  </InsertItemTemplate>
                </asp:FormView>
              </div>
              <br />
            </div>
            <div style="clear: both">
            </div>
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
            <div class="PanelEncabezado">
              <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px" ForeColor="White">Lista de Ramos</asp:Label>
              <asp:HyperLink ID="lnkSeparar" runat="server" CssClass="BtnSeparar" ImageUrl="~/imgRGen/separar.gif"
                NavigateUrl="~/vBitacoras.aspx" onclick="return separar();" Width="22px"></asp:HyperLink></div>
            <div style="padding: 5px;">
              <div class="hr">
              </div>
              <table>
                <tr>
                  <td>
                    Ramo</td>
                  <td style="width: 5px;">
                  </td>
                  <td>
                    <asp:TextBox ID="txtRamo" CssClass="FormText" Width="150px" runat="server"></asp:TextBox>
                  </td>
                  <td style="width:5px;">
                  </td>
                  <td>
                    <asp:Button CssClass="FormButton" ID="btnSearch" runat="server" Text="Buscar" />
                  </td>
                </tr>
                <tr>
                  <td>
                  </td>
                  <td style="width: 5px">
                  </td>
                  <td>
                  </td>
                  <td style="width: 5px">
                  </td>
                  <td>
                  </td>
                </tr>
              </table>
              <asp:GridView ID="listaRamoGridView" runat="server" Width="480px" DataSourceID="sdsRamo"
                CssClass="DataTable" CellPadding="1" AutoGenerateColumns="False" DataKeyNames="ramoId"
                OnRowDeleted="listaRamoGridView_RowDeleted" OnSelectedIndexChanged="listaRamoGridView_SelectedIndexChanged"
                AllowPaging="True" AllowSorting="True" Style="left: 0px; top: 0px">
                <Columns>
                  <asp:TemplateField HeaderText="Ramo">
                    <HeaderStyle Width="200px" />
                    <ItemTemplate>
                      <asp:Label ID="nombreLabel" runat="server" Text='<%# Eval("nombre") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                      <asp:TextBox ID="nombreTextBox" runat="server" Text='<%# Bind("nombre") %>' CssClass="FormText"
                        MaxLength="250" Rows="3" TextMode="MultiLine" Width="185px"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="nombreRFV" runat="server" ControlToValidate="nombreTextBox"
                        Display="None" ErrorMessage="Ingrese el nomre del ramo" ValidationGroup="edit"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Descripci&#243;n">
                    <HeaderStyle Width="320px" />
                    <ItemTemplate>
                      <asp:Label ID="descripcionLabel" runat="server" Text='<%# Eval("descripcion") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                      <asp:TextBox ID="descripcionTextBox" runat="server" Text='<%# Bind("descripcion") %>'
                        CssClass="FormText" MaxLength="250" Rows="3" TextMode="MultiLine" Width="220px"></asp:TextBox><asp:RequiredFieldValidator
                          ID="descripcionRFV" runat="server" ControlToValidate="descripcionTextBox" Display="None"
                          ErrorMessage="Ingrese una descripción para el ramo" ValidationGroup="edit"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Acci&#243;n">
                    <HeaderStyle Width="60px" HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                      <asp:ImageButton ID="editImageButton" runat="server" ImageUrl="~/imgRGen/button_edit.gif"
                        ToolTip="Editar registro" CommandName="Edit" CausesValidation="False" />
                      <asp:ImageButton ID="deleteImageButton" runat="server" ImageUrl="~/imgRGen/deleteItem.gif"
                        ToolTip="Eliminar registro" CommandName="Delete" CausesValidation="False" OnClientClick="return confirm('¿Desea proceder a eliminar el registro?');" />
                    </ItemTemplate>
                    <EditItemTemplate>
                      <asp:ImageButton ID="updateImageButton" runat="server" ImageUrl="~/imgRGen/button_ok.gif"
                        ToolTip="Guardar registro" CommandName="Update" ValidationGroup="edit" />
                      <asp:ImageButton ID="exitImageButton" runat="server" ImageUrl="~/imgRGen/iconCancel.gif"
                        ToolTip="Cancelar" CausesValidation="False" CommandName="Cancel" />
                    </EditItemTemplate>
                  </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="ItemStyle" />
                <HeaderStyle CssClass="HeaderStyle" Height="20px" ForeColor="White" />
                <EmptyDataTemplate>
                  <div style="padding: 10px;">
                    No hay ramos registrados
                  </div>
                </EmptyDataTemplate>
              </asp:GridView>
            </div>
            <asp:ValidationSummary ID="editVS" runat="server" ShowMessageBox="True" ShowSummary="False"
              ValidationGroup="edit" />
            <asp:ValidationSummary ID="ramoVS" runat="server" ShowMessageBox="True" ShowSummary="False"
              ValidationGroup="insert" />
            <br />
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
  </form>
  <asp:SqlDataSource ID="sdsRamo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
    SelectCommand="proc_Ramo_GetByRamo" InsertCommand="INSERT INTO RGN_RAMO(nombre, descripcion, fcrea, fupdate, estado, ucrea, uupdate) VALUES (@nombre, @descripcion, GETDATE(), GETDATE(), 'A', @uupdate, @uupdate)"
    DeleteCommand="DELETE FROM RGN_RAMO WHERE (ramoId = @ramoId)" UpdateCommand="UPDATE RGN_RAMO SET nombre = @nombre, descripcion = @descripcion, fupdate = GETDATE(), uupdate = @uupdate WHERE (ramoId = @ramoId)" SelectCommandType="StoredProcedure">
    <InsertParameters>
      <asp:SessionParameter Name="uupdate" SessionField="usuario" />
    </InsertParameters>
    <DeleteParameters>
      <asp:Parameter Name="ramoId" />
    </DeleteParameters>
    <UpdateParameters>
      <asp:Parameter Name="nombre" />
      <asp:Parameter Name="descripcion" />
      <asp:SessionParameter Name="uupdate" SessionField="usuario" />
      <asp:Parameter Name="ramoId" />
    </UpdateParameters>
    <SelectParameters>
      <asp:ControlParameter ControlID="txtRamo" ConvertEmptyStringToNull="False" Name="Ramo"
        PropertyName="Text" Type="String" />
    </SelectParameters>
  </asp:SqlDataSource>
</body>
</html>
