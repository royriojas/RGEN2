<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vDocumentosSolicitados.aspx.cs"
  Inherits="vDocumentosSolicitados" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <style type="text/css">
    .invisible {
        display: none;
    }

</style>
  <title>Documentos Solicitados</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_core.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_event.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_dom.js"></script>

  <script type="text/javascript" language="javascript">
	
	 function ocultaMuestraFechas(e){
	    var fechita = new Date();
	    var evt = new xEvent(e);
	    //alert(evt.target.id);
	    var elemento = xGetElementById(evt.target.id+'fentrega');
	    if (evt.target.checked) {	 
	        elemento.style.display = "inline";
	        elemento.value = ((fechita.getUTCDate()<10)? "0"+fechita.getUTCDate():fechita.getUTCDate())+ "/" + 
	                        ((fechita.getUTCMonth()<10)? "0"+fechita.getUTCMonth():fechita.getUTCMonth()) + "/" 
	                        + fechita.getUTCFullYear();
	    }
	    else {
	        elemento.style.display = "none";
	    }
	    
	 }  
	 function activaComportamientosCheckBox() {
	    var checks = xGetElementsByClassName('FormCheck');
	    for (i = 0; i < checks.length; i++) {
	        xAddEventListener(checks[i],'click',ocultaMuestraFechas,true);
	    }
	  
	 }
	
	 window.onload = function() {
	    activaComportamientosCheckBox();
	 }
	
  </script>

</head>
<body style="background-image: none; background-color: #4C96C9; color: #ffffff;">
  <div align="center">
    <form id="formDocumentosSolicitados" runat="server">
        <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative; left: 0px; top: 0px; width: 700px;">
          <asp:Label ID="lblListaDocumentos" runat="server" Font-Bold="True" Font-Size="18px">Lista de Documentos</asp:Label>
          <br />
          <br />
          <div id="ListaDocumentos" style="margin-left: auto; margin-right: auto; position: relative">
            <div id="grillaDocumentos">
              <asp:GridView ID="GridView1" runat="server" CssClass="DataTable" AutoGenerateColumns="False"
                DataSourceID="odsDocumentosSolicitados" OnRowDataBound="GridView1_RowDataBound">
                <HeaderStyle CssClass="HeaderStyle" />
                <Columns>
                  <asp:BoundField DataField="requisitoId" HeaderText="requisitoId" SortExpression="requisitoId">
                    <ItemStyle CssClass="invisible" />
                    <HeaderStyle CssClass="invisible" />
                    <FooterStyle CssClass="invisible" />
                  </asp:BoundField>
                  <asp:BoundField DataField="solicitudDocumentosId" HeaderText="solicitudDocumentosId"
                    SortExpression="solicitudDocumentosId">
                    <ItemStyle CssClass="invisible" />
                    <HeaderStyle CssClass="invisible" />
                    <FooterStyle CssClass="invisible" />
                  </asp:BoundField>
                  <asp:TemplateField HeaderText="N&#176;">
                    <ItemStyle HorizontalAlign="Left" Width="10px" />
                    <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="nombre" HeaderText="Documento" SortExpression="nombre">
                    <ItemStyle HorizontalAlign="Center" Width="200px" />
                  </asp:BoundField>
                  <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" SortExpression="descripcion">
                    <ItemStyle HorizontalAlign="Center" Width="200px" />
                  </asp:BoundField>
                  <asp:BoundField DataField="numeroSolicitud" HeaderText="N&#176; Sol." SortExpression="numeroSolicitud">
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                  </asp:BoundField>
                  <asp:BoundField DataField="fcrea" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Pedido"
                    HtmlEncode="False" SortExpression="fcrea">
                    <ItemStyle HorizontalAlign="Center" Width="150px" />
                  </asp:BoundField>
                  <asp:TemplateField HeaderText="Fecha Entrega">
                    <ItemStyle Width="200px" />
                    <ItemTemplate>
                      <asp:CheckBox ID="chk" runat="server" CssClass="FormCheck" />
                      <asp:TextBox ID="chkfentrega" runat="server" CssClass="FormText" Width="100px" Style="display: none;"></asp:TextBox>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="fupdate" HeaderText="fupdate" SortExpression="fupdate"
                    Visible="False" />
                  <asp:BoundField DataField="estado" HeaderText="estado" SortExpression="estado" Visible="False" />
                  <asp:BoundField DataField="ajusteId" HeaderText="ajusteId" SortExpression="ajusteId"
                    Visible="False" />
                  <asp:BoundField DataField="ucrea" HeaderText="ucrea" SortExpression="ucrea" Visible="False" />
                  <asp:BoundField DataField="uupdate" HeaderText="uupdate" SortExpression="uupdate"
                    Visible="False" />
                </Columns>
              </asp:GridView>
            </div>
          </div>
          <div>
            &nbsp;<br />
            <asp:ObjectDataSource ID="odsDocumentosSolicitados" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsDocumentosTableAdapters.DocumentosSolicitadosTableAdapter"
              UpdateMethod="Update">
              <UpdateParameters>
                <asp:Parameter Name="requisitoId" Type="Decimal" />
                <asp:Parameter Name="FechaEntrega" Type="DateTime" />
                <asp:Parameter Name="fupdate" Type="DateTime" />
                <asp:Parameter Name="estado" Type="String" />
                <asp:Parameter Name="uupdate" Type="String" />
                <asp:Parameter Name="solicitudDocumentosId" Type="Decimal" />
                <asp:Parameter Name="ajusteId" Type="Decimal" />
              </UpdateParameters>
              <SelectParameters>
                <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
              </SelectParameters>
            </asp:ObjectDataSource>
          </div>
          <div style="width: 300px; height: 80px; position: relative; left: 0px; top: 0px;"
            id="Div1">
            <div style="position: absolute; left: 15px; top: 17px;">
              <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/imgRGen/save.gif" ToolTip="Guardar El Registro"
                TabIndex="26" OnClick="btnGuardar_Click" /></div>
          </div>
        </div>
    </form>
  </div>
</body>
</html>
