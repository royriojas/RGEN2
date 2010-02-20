<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroBienesAfectados.aspx.cs" Inherits="vRegistroBienesAfectados" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Bienes Afectados</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="Scripts/calendar/datetimepicker.js"></script>
    
    <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>
    <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>
	<script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>
	<script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>
    <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>
    
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
     
    <script type="text/javascript" language="javascript">
		function seteaOcultadoresDeDivs() {
			btn_ocultar = new CollapsibleDiv('nuevoBienesAfectados',
						 'ContenidoBienesAfectados',						 
						 false,
						 null);
		}
		window.onload = function () {
			seteaOcultadoresDeDivs();
		}
	</script>
	<script type="text/javascript" >
  
    function cargaTipoDeCambio(selector) {
        //declaramos una variable del tipo HTMLOBJECT que reciba el valor de la busqueda del nuevo tipo cambio
        var montoTipoCambio = $('txtTipoCambio');        
        //le asignamos el tipo de cambio
        // este sale del metodo de AJAX 
        //para utilizar un metodo ajax, la pagina debe tener en el onload registrado el tipo de la libreria
        // donde se define el metodo a utilizar 
        montoTipoCambio.value = utiles.ajax.gestorAjax.getTipoDeCambio(selector.value).value;
        
        //llamamos al monto en soles
        calculaMontoSoles();
    }
    
    function calculaMontoSoles() {
        var tipoCambio = $('txtTipoCambio');
        var cantidadMonedaOrigen = $('txtMontoRep');
        var cantidadSoles = $('txtMontoSoles');
        var cadena = tipoCambio.value;
        var posicion = cadena.indexOf(',') 
        if (posicion != -1) {
        
            cadena.charAt(posicion) = '.';
            
        }
        cantidadSoles.value = cantidadMonedaOrigen.value * cadena;

    }
    </script>
	
</head>

<body style="background-image:none;background-color:#4C96C9;">
<div style="margin-left: auto; margin-right: auto; position: relative; width: 700px; left: 0px; top: 0px;">
    <form id="formRegistroBienesAfectados" runat="server">    
    <div style="position:relative">
    
   <div id="ContenidoBienesAfectados" style="margin-top:15px; display:none;">
     <table width="700" border="0" cellpadding="0" cellspacing="0" class="DataTable">
  <tr>
    <td height="20" style="width: 20px">&nbsp;</td>
    <td width="132" height="20">&nbsp;</td>
    <td width="188" height="20">&nbsp;</td>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">&nbsp;</td>
    <td width="188" height="20">&nbsp;</td>
    <td width="20" height="20">&nbsp;</td>
  </tr>
       <tr>
         <td height="20" style="width: 20px">
         </td>
         <td height="20" width="132">
        Local</td>
         <td colspan="3" height="20">
        <asp:TextBox ID="txtLocal" runat="server" CssClass="FormText" Width="300px"></asp:TextBox></td>
         <td height="20" width="188">
         </td>
         <td height="20" width="20">
         </td>
       </tr>
  <tr>
    <td height="20" style="width: 20px">&nbsp;</td>
    <td width="132" height="20">
        Bien Afectado</td>
    <td height="20" colspan="3"><asp:TextBox ID="txtBien" runat="server" CssClass="FormText" Width="300px"></asp:TextBox>&nbsp;<span style="height: 17px"></span></td>
    <td height="20"></td>
    <td width="20" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td height="20" style="width: 20px">&nbsp;</td>
    <td width="132" height="20">
      Estimación del Daño</td>
    <td height="20" colspan="3">
      <asp:DropDownList ID="cbxMoneda" runat="server" CssClass="FormSelect"
                                datasourceid="odsMoneda" DataTextField="simbolo" onchange="cargaTipoDeCambio(this);" DataValueField="monedaId"
                                Width="45px">
        <asp:ListItem>US$</asp:ListItem>
      </asp:DropDownList>    
      <asp:TextBox ID="txtMontoRep" runat="server" CssClass="FormText" Width="182px"></asp:TextBox>&nbsp;</td>
    <td height="20">
      &nbsp;</td>
    <td width="20" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td height="20" style="width: 20px">&nbsp;</td>
    <td height="20" valign="top"><span style="height: 24px">Descripci&oacute;n</span></td>
    <td height="20" colspan="3"><span style="width: 314px"><asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Width="300px" Height="70px" TextMode="MultiLine"></asp:TextBox></span></td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
  </tr>
  <tr>
    <td style="height: 20px; width: 20px;">&nbsp;</td>
    <td style="height: 20px">&nbsp;</td>
    <td style="height: 20px"><asp:TextBox style="display:none;" ID="txtMontoSoles" runat="server" CssClass="FormText" Width="182px" BorderStyle="None"></asp:TextBox></td>
    <td style="height: 20px">&nbsp;</td>
    <td style="height: 20px">&nbsp;</td>
    <td style="height: 20px"><div align="right"><span style="height: 17px"><span style="width: 127px; height: 24px">
    </span></span><span style="height: 17px"><span style="width: 127px; height: 24px">
    <asp:TextBox ID="txtTipoCambio" style="display:none;" runat="server" CssClass="FormText" Width="182px"></asp:TextBox>&nbsp;</span></span></div>      </td>
    <td style="height: 20px">&nbsp;</td>
  </tr>
  <tr>
    <td height="20" style="width: 20px">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">
    <asp:Button ID="btnAgregar" runat="server" CssClass="FormButton"
                                Text="Agregar" OnClick="btnAgregar_Click" /></td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
  </tr>
         <tr>
             <td height="20" style="width: 20px">
             </td>
             <td height="20">
             </td>
             <td height="20">
             </td>
             <td height="20">
             </td>
             <td height="20">
             </td>
             <td height="20">
             </td>
             <td height="20">
             </td>
         </tr>
</table>

    </div>
   
   <div style="height:30px; margin-top:10px;margin-bottom:5px;position:relative; padding:5px; background: #3785b9; left: 0px; top: 0px;">	
		   <asp:Label ID="lblListaBienesAfectados" runat="server" Font-Bold="True" Font-Size="18px">Lista Bienes Afectados </asp:Label>
		    <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Bienes Afectados" title="Agregar Bienes Afectados" style="position:absolute; left: 669px; top: 9px;" id="nuevoBienesAfectados" />   
       <asp:Button style="position:absolute; left: 595px; top: 10px;" ID="Button1" runat="server" CssClass="FormText" Text="Volver" OnClick="Button1_Click" /></div>
    
   <div id="ListaBienesAfectados" style="margin-left:auto;margin-right:auto;position:relative">
      <div>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        CssClass="DataTable" DataKeyNames="bienAfectadoId,ajusteId" DataSourceID="odsBienesAfectados"
                        OnRowCommand="GridView1_RowCommand" Width="699px">
                        <HeaderStyle CssClass="HeaderStyle" />
                        <Columns>
                            <asp:TemplateField HeaderText="Item">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text="<%# num++ %>"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="localDelBien" HeaderText="Local" SortExpression="localDelBien">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="bienAfectadoId" HeaderText="bienAfectadoId" InsertVisible="False"
                                ReadOnly="True" SortExpression="bienAfectadoId" Visible="False" />
                            <asp:BoundField DataField="ajusteId" HeaderText="ajusteId" ReadOnly="True" SortExpression="ajusteId"
                                Visible="False" />
                            <asp:BoundField DataField="item" HeaderText="Bienes y/o Personas Afectadas" SortExpression="item" />
                            <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n de los Da&#241;os"
                                SortExpression="descripcion" />
                            <asp:BoundField DataField="montorep" HeaderText="Estimaci&#243;n del Da&#241;o" SortExpression="montorep" Visible="False" />
                            <asp:BoundField DataField="montosoles" HeaderText="montosoles" SortExpression="montosoles"
                                Visible="False" />
                            <asp:BoundField DataField="monedaId" HeaderText="monedaId" SortExpression="monedaId"
                                Visible="False" />
                            <asp:BoundField DataField="tipoCambio" HeaderText="tipoCambio" SortExpression="tipoCambio"
                                Visible="False" />
                            <asp:BoundField DataField="nombreMoneda" HeaderText="nombreMoneda" SortExpression="nombreMoneda"
                                Visible="False" />
                            <asp:TemplateField HeaderText="Estimaci&#243;n del Da&#241;o">
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td style="width: 20px">
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("simboloMoneda") %>'></asp:Label></td>
                                            <td style="width: 80px">
                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("montorep") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    &nbsp;
                                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument='<%# Bind("bienAfectadoId") %>'
                                        CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
          <EmptyDataTemplate>
            No hay Bienes Afectados registrados
          </EmptyDataTemplate>
                    </asp:GridView>
      </div>
    </div>
    
    <asp:ObjectDataSource ID="odsBienesAfectados" runat="server" DeleteMethod="Delete"
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                    TypeName="dsBienesTableAdapters.BienAfectadoSelectByIdTableAdapter" UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="txtBienAfectadoId" Name="bienAfectadoId" PropertyName="Text"
                                            Type="Decimal" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="bienAfectadoId" Type="Decimal" />
                                        <asp:Parameter Name="ajusteId" Type="Decimal" />
                                        <asp:Parameter Name="item" Type="String" />
                                        <asp:Parameter Name="descripcion" Type="String" />
                                        <asp:Parameter Name="montorep" Type="Decimal" />
                                        <asp:Parameter Name="montosoles" Type="Decimal" />
                                        <asp:Parameter Name="monedaId" Type="Decimal" />
                                        <asp:Parameter Name="tipoCambio" Type="Decimal" />
                                    </UpdateParameters>
                                    <SelectParameters>
                                        <asp:QueryStringParameter DefaultValue="1" Name="ajusteId" QueryStringField="AjusteId"
                                            Type="Decimal" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="txtBienAfectadorId" Direction="InputOutput" Name="bienAfectadoId"
                                            PropertyName="Text" Type="Object" />
                                        <asp:QueryStringParameter DefaultValue="1" Name="ajusteId" QueryStringField="AjusteId"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="TxtBien" Name="item" PropertyName="Text" Type="String" />
                                        <asp:ControlParameter ControlID="txtDescripcion" Name="descripcion" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtLocal" Name="localDelBien" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="txtMontoRep" Name="montorep" PropertyName="Text"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="txtMontoSoles" Name="montosoles" PropertyName="Text"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="cbxMoneda" Name="monedaId" PropertyName="SelectedValue"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="txtTipoCambio" Name="tipoCambio" PropertyName="Text"
                                            Type="Decimal" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
        &nbsp;<asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsComboTableAdapters.MonedaComboTableAdapter"></asp:ObjectDataSource>
    
    
    
    </div>
   
        
                
          
       
    </form>
 </div>
    <asp:TextBox ID="txtBienAfectadorId" runat="server" Visible="False"></asp:TextBox>&nbsp;
</body>
</html>
