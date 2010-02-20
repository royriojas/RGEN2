<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vEditorPolizaAjuste.aspx.cs"
  Inherits="vEditorPolizaAjuste" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Pólizas Asociadas</title>
  <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/subModal.css' />

  <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script type='text/javascript'>
    
    
    window.onload = function()
    {
        if (window.winOnLoad) window.winOnLoad();
    	
    }
    window.onunload = function()
    {
        if (window.winOnUnload) window.winOnUnload();
    }
    
    function muestraPopUp(ajusteId,polizaId) {
        
        showPopWin('vDetallesPoliza.aspx?AjusteId=' +ajusteId+'&PolizaId='+ polizaId,  758, 540, null);
        return false;
        
    }    
    function muestraBusquedaPolizas() {
            var aseguradora = document.getElementById('txtAseguradora');
            var asegurado = document.getElementById('txtAsegurado');
            var aseguradoId = document.getElementById('txtAseguradoId');
            var aseguradoraId = document.getElementById('txtAseguradoraId');

            showPopWin("vBusquedaPolizasAsociadas.aspx?AjusteId=<%=qStringAjusteId%>&Asegurado="+asegurado.value+"&Aseguradora="+aseguradora.value+"&aseguradoraId="+aseguradoraId.value+"&aseguradoId="+aseguradoId.value, 820, 480, null);
            
	}
    function doReload() {
       /* var place = document.location.href;
        document.location.href = place;*/
        __doPostBack('doPost','');
    }
    
    function CheckIfMustValidate() {
        if (<%=RowCount %> == 1) 
        {
            /*alert('No puede desasociar la única póliza existente, asocie otra póliza antes de proceder a eliminar la actual');
            return false;*/            
        }
        return true;
    }
    
  </script>

</head>
<body style="background-image: none; background-color: #4C96C9;">
  <div style="margin-left: auto; margin-right: auto; width: 650px;">
    <form id="form1" runat="server">
      <div style="margin-bottom: 5px; margin-top: 15px;">
        <asp:Label ID="DatosGenerales" Text="Datos Generales Póliza Principal" Font-Bold="true"
          Font-Size="16px" runat="server"></asp:Label>
      </div>
      <div>
        <asp:FormView ID="FwiewPolizaPrincipal" runat="server" DataSourceID="odsPolizaPrincipal">
          <ItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" class="DataTable" width="700">
              <tr>
                <td height="20" width="20">
                  &nbsp;</td>
                <td height="20" width="132">
                  &nbsp;</td>
                <td height="20" style="width: 200px">
                  &nbsp;</td>
                <td height="20" width="20">
                  &nbsp;</td>
                <td height="20" width="132">
                  &nbsp;</td>
                <td height="20" width="188">
                  &nbsp;</td>
                <td height="20" width="20">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="height: 20px">
                </td>
                <td style="height: 20px">
                  Contratante</td>
                <td style="height: 20px; width: 200px;">
                  <asp:TextBox ID="TextBoxContratante" runat="server" CssClass="FormText" Width="195px"
                    Text='<%# Bind("contratante") %>' ReadOnly="True"></asp:TextBox></td>
                <td style="height: 20px">
                </td>
                <td style="height: 20px">
                  Producto</td>
                <td style="height: 20px">
                  <asp:TextBox ID="TextBoxProducto" runat="server" CssClass="FormText" Width="195px"
                    Text='<%# Bind("producto") %>' ReadOnly="True"></asp:TextBox>
                </td>
                <td style="height: 20px">
                </td>
              </tr>
              <tr>
                <td height="20">
                </td>
                <td height="20">
                  Asegurado</td>
                <td height="20" style="width: 200px">
                  <asp:TextBox ID="TextBoxAsegurado" runat="server" CssClass="FormText" Width="195px"
                    Text='<%# Bind("asegurado") %>' ReadOnly="True"></asp:TextBox></td>
                <td height="20">
                </td>
                <td height="20">
                  Ramo
                </td>
                <td height="20">
                  <asp:TextBox ID="TextBoxRamo" runat="server" CssClass="FormText" Width="195px" Text='<%# Bind("ramo") %>'
                    ReadOnly="True"></asp:TextBox></td>
                <td height="20">
                </td>
              </tr>
              <tr>
                <td height="20">
                </td>
                <td height="20">
                  Aseguradora</td>
                <td height="20" style="width: 200px">
                  <asp:TextBox ID="TextBoxAseguradora" runat="server" CssClass="FormText" Width="195px"
                    Text='<%# Bind("aseguradora") %>' ReadOnly="True"></asp:TextBox></td>
                <td height="20">
                </td>
                <td height="20">
                  Cobertura</td>
                <td height="20">
                  <asp:TextBox ID="TextBoxCobertura" runat="server" CssClass="FormText" Width="195px"
                    Text='<%# Bind("cobertura") %>' ReadOnly="True"></asp:TextBox></td>
                <td height="20">
                </td>
              </tr>
              <tr>
                <td height="20">
                </td>
                <td height="20">
                </td>
                <td height="20" style="width: 200px">
                  <asp:TextBox ID="TextBoxAseguradoId" Style="display: none" runat="server" Text='<%# Bind("aseguradoid") %>'></asp:TextBox></td>
                <td height="20">
                </td>
                <td height="20">
                </td>
                <td height="20">
                </td>
                <td height="20">
                </td>
              </tr>
              <tr>
                <td width="20" style="height: 20px">
                  &nbsp;</td>
                <td width="132" style="height: 20px">
                </td>
                <td style="height: 20px; width: 200px;">
                  <asp:TextBox ID="TextBoxAseguradoraId" Style="display: none" runat="server" Text='<%# Bind("aseguradoraid") %>'></asp:TextBox></td>
                <td width="20" style="height: 20px">
                </td>
                <td width="132" style="height: 20px">
                </td>
                <td width="188" style="height: 20px">
                  <button onclick="muestraBusquedaPolizas();" style="width: 127px; cursor: pointer;
                    cursor: hand;" title="Asociar Pólizas o Crear Una Nueva" class="FormButton" tabindex="18"
                    type="button">
                    Asociar Póliza</button>
                </td>
                <td width="20" style="height: 20px">
                  &nbsp;</td>
              </tr>
              <tr>
                <td style="height: 20px" width="20">
                </td>
                <td style="height: 20px" width="132">
                </td>
                <td style="height: 20px; width: 200px;">
                </td>
                <td style="height: 20px" width="20">
                </td>
                <td style="height: 20px" width="132">
                </td>
                <td style="height: 20px" width="188">
                </td>
                <td style="height: 20px" width="20">
                </td>
              </tr>
            </table>
          </ItemTemplate>
        </asp:FormView>
      </div>
      <br />
      <div style="margin-bottom: 5px; position: relative;">
        <asp:Label ID="Label1" Text="Lista de Polizas Asociadas" Font-Bold="true" Font-Size="16px"
          runat="server"></asp:Label>
        <asp:Button Style="position: absolute; left: 638px; top: 2px;" ID="Button1" runat="server"
          CssClass="FormButton" Text="volver" OnClick="Button1_Click1" />
        <br />
        <br />
        <asp:GridView ID="gvPolizasAsociadas" runat="server" AutoGenerateColumns="False"
          CssClass="DataTable" DataKeyNames="polizaId,ajusteId" DataSourceID="odsListaPolizasAsociadas"
          Width="699px" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="gvPolizasAsociadas_RowCommand"
          OnRowDeleted="gvPolizasAsociadas_RowDeleted">
          <Columns>
            <asp:TemplateField HeaderText="N&#186;">
              <ItemStyle HorizontalAlign="Center" Width="10px" />
              <ItemTemplate>
                &nbsp;<asp:HyperLink ID="linkPoliza" runat="server" Text="<%# num++ %>"></asp:HyperLink>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="polizaId" HeaderText="polizaId" ReadOnly="True" SortExpression="polizaId"
              Visible="False" />
            <asp:BoundField DataField="numPoliza" HeaderText="N&#186; P&#243;liza" SortExpression="numPoliza">
              <ItemStyle HorizontalAlign="Center" Width="50px" />
            </asp:BoundField>
            <asp:BoundField DataField="asegurado" HeaderText="Asegurado" SortExpression="asegurado"
              Visible="False">
              <ItemStyle Width="200px" />
            </asp:BoundField>
            <asp:BoundField DataField="aseguradora" HeaderText="Aseguradora" SortExpression="aseguradora"
              Visible="False">
              <ItemStyle Width="200px" />
            </asp:BoundField>
            <asp:BoundField DataField="producto" HeaderText="Producto" SortExpression="producto">
              <ItemStyle Width="200px" />
            </asp:BoundField>
            <asp:BoundField DataField="ramo" HeaderText="Ramo" SortExpression="ramo">
              <ItemStyle Width="200px" />
            </asp:BoundField>
            <asp:BoundField DataField="cobertura" HeaderText="Cobertura" SortExpression="cobertura">
              <ItemStyle Width="200px" />
            </asp:BoundField>
            <asp:TemplateField ShowHeader="False">
              <ItemTemplate>
                <asp:ImageButton OnClientClick="return CheckIfMustValidate();" ID="ImageButton1"
                  runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/imgRGen/deleteItem.gif"
                  Text="Eliminar" />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Datos">
              <ItemTemplate>
                <asp:Button ID="btnGoToPolizaAjuste" runat="server" CssClass="FormButton" Text="Datos"
                  OnClientClick='<%# "return muestraPopUp("+qStringAjusteId+","+Eval("polizaId")+");" %>' />
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
          <HeaderStyle CssClass="HeaderStyle" />
          <EmptyDataTemplate>
            No hay pólizas asociadas, un caso debe tener al menos una póliza asociada
          </EmptyDataTemplate>
        </asp:GridView>
      </div>
      <asp:ObjectDataSource ID="odsPolizaPrincipal" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaPrincipalTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
      <asp:TextBox ID="txtAseguradora" Style="display: none" runat="server"></asp:TextBox>
      <asp:TextBox ID="txtAseguradoraId" Style="display: none" runat="server" Width="30px"></asp:TextBox>
      <asp:LinkButton ID="doPost" Style="display: none;" runat="server" OnClick="doPost_Click">doPost</asp:LinkButton>
      <asp:SqlDataSource ID="odsListaPolizasAsociadas" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
        DeleteCommand="sp_Rgen_PolizaAsociadaDelete" DeleteCommandType="StoredProcedure"
        SelectCommand="sp_rgen_PolizasAsociadasSelect" SelectCommandType="StoredProcedure"
        OnSelected="odsListaPolizasAsociadas_Selected">
        <DeleteParameters>
          <asp:Parameter Name="polizaId" Type="Decimal" />
          <asp:Parameter Name="ajusteId" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
        </SelectParameters>
      </asp:SqlDataSource>
      <br />
      <asp:TextBox ID="txtAsegurado" Style="display: none" runat="server"></asp:TextBox>
      <asp:TextBox ID="txtAseguradoId" Style="display: none" runat="server" Width="30px"></asp:TextBox></form>
  </div>

  <script type="text/javascript" language="javascript">
			creaPopUpDivs();
  </script>

</body>
</html>
