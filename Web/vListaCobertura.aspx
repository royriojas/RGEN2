<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaCobertura.aspx.cs"
  Inherits="vListaCobertura" %>

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
            btn_ocultar = new CollapsibleDiv('openCloseBtn',
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
    <div id="cont" style="padding: 5px">
      <div id="nuevoTipoDiv" style="display: none;" runat="server">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="riesgoId" DataSourceID="sdsCoberturaRiesgo"
          DefaultMode="Insert" Width="551px" OnItemInserting="FormView1_ItemInserting">
          <InsertItemTemplate>
            <div style="padding: 5px; position: relative; top: 0px; padding: 1%; background-color: #2c84bd">
              <asp:Label ID="lblListaGastos" runat="server" Font-Size="18px" Font-Bold="True">Nueva Cobertura - Riesgo</asp:Label>
            </div>
            <div style="padding: 10px;" class="DataTable">
              <table id="tbl" style="width: 626px" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td style="width: 105px; height: 24px" valign="top">
                    Producto</td>
                  <td style="height: 24px">
                    <asp:TextBox ID="tipoSiniestroTextBox" runat="server" Text='<%# Bind("nombre") %>'
                      CssClass="FormText" Width="489px" Height="70px" TextMode="MultiLine"></asp:TextBox></td>
                </tr>
                <tr>
                  <td style="width: 105px; height: 93px" valign="top">
                    Descripción</td>
                  <td style="height: 93px">
                    <asp:TextBox ID="descripcionTextBox" runat="server" Text='<%# Bind("descripcion") %>'
                      CssClass="FormText" Height="70px" TextMode="MultiLine" Width="490px"></asp:TextBox></td>
                </tr>
                <tr>
                  <td style="height: 22px; width: 105px;">
                  </td>
                  <td style="height: 22px">
                    <asp:Button ID="btnGuardar" runat="server" CssClass="FormButton" Text="Insertar"
                      CommandName="Insert" Width="105px" /></td>
                </tr>
              </table>
            </div>
          </InsertItemTemplate>
        </asp:FormView>
      </div>
      <div style="margin-top: 10px; margin-bottom: 5px; position: relative; background-color: #2c84bd;
        left: 0px; width: 647px; top: 0px; padding-top: 5px;">
        &nbsp;
        <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px">Cobertura - Riesgo</asp:Label>
        <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Cobertura" title="Agregar Cobertura"
          style="position: absolute; left: 623px; top: 6px;" id="openCloseBtn" />
        <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
          onclick="return separar();" Style="left: 204px; position: absolute; top: 4px" Width="22px"></asp:HyperLink>
      </div>
      <div style="padding: 1%;">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="riesgoId"
          DataSourceID="sdsCoberturaRiesgo" Width="646px" AllowPaging="True" PageSize="15"
          AllowSorting="True" OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating">
          <Columns>
            <asp:BoundField DataField="riesgoId" HeaderText="riesgoId" InsertVisible="False"
              ReadOnly="True" SortExpression="riesgoId">
              <ItemStyle CssClass="invisible" />
              <HeaderStyle CssClass="invisible" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Nombre Producto" SortExpression="nombre">
              <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" Height="90px" Text='<%# Bind("nombre") %>'
                  TextMode="MultiLine" Width="300px"></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("nombre") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Descripci&#243;n" SortExpression="descripcion">
              <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Height="90px" Text='<%# Bind("descripcion") %>'
                  TextMode="MultiLine" Width="300px"></asp:TextBox>
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
              <ItemStyle Width="50px" />
              <ItemTemplate>
                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
                  ImageUrl="~/imgRGen/button_edit.gif" />&nbsp;<asp:ImageButton ID="ImageButton2" runat="server"
                    CausesValidation="False" CommandName="Delete" ImageUrl="~/imgRGen/deleteItem.gif"
                    OnClientClick="return confirm('¿Confirma la Eliminación de este Producto?');" />
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
          <RowStyle CssClass="ItemStyle" />
          <HeaderStyle CssClass="HeaderStyle" />
        </asp:GridView>
      </div>
    </div>
    <asp:SqlDataSource ID="sdsCoberturaRiesgo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      DeleteCommand="sp_rgen_RiesgoCoberturaDelete" DeleteCommandType="StoredProcedure"
      InsertCommand="sp_rgen_RiesgoCoberturaInsert" InsertCommandType="StoredProcedure"
      SelectCommand="sp_rgen_RiesgoCoberturaSelectAll" SelectCommandType="StoredProcedure"
      UpdateCommand="sp_rgen_RiesgoCoberturaUpdate" UpdateCommandType="StoredProcedure">
      <DeleteParameters>
        <asp:Parameter Name="riesgoId" Type="Decimal" />
        <asp:Parameter Name="uupdate" Type="String" />
      </DeleteParameters>
      <UpdateParameters>
        <asp:Parameter Direction="InputOutput" Name="riesgoId" Type="Decimal" />
        <asp:Parameter Name="nombre" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
        <asp:Parameter Name="uupdate" Type="String" />
      </UpdateParameters>
      <InsertParameters>
        <asp:Parameter Direction="InputOutput" Name="riesgoId" Type="Decimal" />
        <asp:Parameter Name="nombre" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
      </InsertParameters>
    </asp:SqlDataSource>
  </form>
</body>
</html>
