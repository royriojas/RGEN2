<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistrarGasto.aspx.cs" Inherits="vRegistrarGasto" UICulture="en-US" Culture="en-US"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Registro de Gastos</title>
    
    <script language="javascript" type="text/javascript" src="Scripts/calendar/datetimepicker.js"></script>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>
	<script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>
	<script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>
	<script type="text/javascript" src="Scripts/lib/xCaseOperations.js" language="javascript"></script>
	 <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>
    <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>
   
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    
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
        var cantidadMonedaOrigen = $('txtMontoGasto');
        var cantidadSoles = $('txtMontoSoles');
        var cadena = tipoCambio.value;
        var posicion = cadena.indexOf(',') 
        if (posicion != -1) {
        
            cadena.charAt(posicion) = '.';
            
        }
        cantidadSoles.value = cantidadMonedaOrigen.value * cadena;

    }
    </script>
    
    <script type="text/javascript" language="javascript">
		function seteaOcultadoresDeDivs() {
			btn_ocultar = new CollapsibleDiv('nuevoGasto',
						 'ContenidoGasto',						 
						 false,
						 null);
		}
		window.onload = function () {
			seteaOcultadoresDeDivs();
		}
	</script>
         <script type="text/javascript" src="Scripts/calendar/calendar.js"></script>


 <link rel="stylesheet" type="text/css" href="Scripts/calendar/calendar-blue2.css" />

  <script type="text/javascript">
	// ** I18N

// Calendar ES (spanish) language
// Author: Mihai Bazon, <mihai_bazon@yahoo.com>
// Updater: Servilio Afre Puentes <servilios@yahoo.com>
// Updated: 2004-06-03
// Encoding: utf-8
// Distributed under the same terms as the calendar itself.

// For translators: please use UTF-8 if possible.  We strongly believe that
// Unicode is the answer to a real internationalized world.  Also please
// include your contact information in the header, as can be seen above.

// full day names
Calendar._DN = new Array
("Domingo",
 "Lunes",
 "Martes",
 "Miércoles",
 "Jueves",
 "Viernes",
 "Sábado",
 "Domingo");

// Please note that the following array of short day names (and the same goes
// for short month names, _SMN) isn't absolutely necessary.  We give it here
// for exemplification on how one can customize the short day names, but if
// they are simply the first N letters of the full name you can simply say:
//
//   Calendar._SDN_len = N; // short day name length
//   Calendar._SMN_len = N; // short month name length
//
// If N = 3 then this is not needed either since we assume a value of 3 if not
// present, to be compatible with translation files that were written before
// this feature.

// short day names
Calendar._SDN = new Array
("Dom",
 "Lun",
 "Mar",
 "Mié",
 "Jue",
 "Vie",
 "Sáb",
 "Dom");

// First day of the week. "0" means display Sunday first, "1" means display
// Monday first, etc.
Calendar._FD = 1;

// full month names
Calendar._MN = new Array
("Enero",
 "Febrero",
 "Marzo",
 "Abril",
 "Mayo",
 "Junio",
 "Julio",
 "Agosto",
 "Septiembre",
 "Octubre",
 "Noviembre",
 "Diciembre");

// short month names
Calendar._SMN = new Array
("Ene",
 "Feb",
 "Mar",
 "Abr",
 "May",
 "Jun",
 "Jul",
 "Ago",
 "Sep",
 "Oct",
 "Nov",
 "Dic");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "Acerca del calendario";

Calendar._TT["ABOUT"] =
"Selector DHTML de Fecha/Hora\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"Para conseguir la última versión visite: http://www.dynarch.com/projects/calendar/\n" +
"Distribuido bajo licencia GNU LGPL. Visite http://gnu.org/licenses/lgpl.html para más detalles." +
"\n\n" +
"Selección de fecha:\n" +
"- Use los botones \xab, \xbb para seleccionar el año\n" +
"- Use los botones " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " para seleccionar el mes\n" +
"- Mantenga pulsado el ratón en cualquiera de estos botones para una selección rápida.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"Selección de hora:\n" +
"- Pulse en cualquiera de las partes de la hora para incrementarla\n" +
"- o pulse las mayúsculas mientras hace clic para decrementarla\n" +
"- o haga clic y arrastre el ratón para una selección más rápida.";

Calendar._TT["PREV_YEAR"] = "Año anterior (mantener para menú)";
Calendar._TT["PREV_MONTH"] = "Mes anterior (mantener para menú)";
Calendar._TT["GO_TODAY"] = "Ir a hoy";
Calendar._TT["NEXT_MONTH"] = "Mes siguiente (mantener para menú)";
Calendar._TT["NEXT_YEAR"] = "Año siguiente (mantener para menú)";
Calendar._TT["SEL_DATE"] = "Seleccionar fecha";
Calendar._TT["DRAG_TO_MOVE"] = "Arrastrar para mover";
Calendar._TT["PART_TODAY"] = " (hoy)";

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = "Hacer %s primer día de la semana";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = "Cerrar";
Calendar._TT["TODAY"] = "Hoy";
Calendar._TT["TIME_PART"] = "(Mayúscula-)Clic o arrastre para cambiar valor";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%d/%m/%Y";
Calendar._TT["TT_DATE_FORMAT"] = "%A, %e de %B de %Y";

Calendar._TT["WK"] = "sem";
Calendar._TT["TIME"] = "Hora:";

 
  </script>
  <script type="text/javascript" language="javascript" src="Scripts/calendar/calendar-setup.js"></script>
   
    
</head>
<body style="background-image:none;">
<div style="margin-left: auto; margin-right: auto; position: relative; width: 700px; left: 0px; top: 0px;">
    <form id="formRegistroGastos" runat="server">    
    <div style="position:relative">
    
   <div id="ContenidoGasto" style="display:none;" runat="server">
     <table width="700" border="0" cellpadding="0" cellspacing="0" class="DataTable">
  <tr>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">&nbsp;</td>
    <td width="188" height="20">&nbsp;</td>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">&nbsp;</td>
    <td width="188" height="20">&nbsp;</td>
    <td width="20" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">Fecha de Gasto </td>
    <td width="188" height="20"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="30">
		 <button  style="width: 17px; height: 17px;" class="FormButton" id="btnFechaAviso">
                              <img style="cursor: pointer;" src="img/cal.gif" width="16" height="16" border="0"
                                alt="Escoja una fecha" /></button>
		</td>
        <td><asp:TextBox ID="txtFecha" runat="server" CssClass="FormText" Width="151px"></asp:TextBox>
				<script type="text/javascript">                           
                            Calendar.setup({
                                inputField     :    'txtFecha',
                                ifFormat       :    '%d/%m/%Y',
                                button         :    'btnFechaAviso',
                                showsTime      :    true,
                                timeFormat     :    '24',
                                singleClick    :    false
                             
                           }); 
                    </script>
		</td>
      </tr>
    </table></td>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20"><span style="height: 17px">N&deg; Documento </span></td>
    <td height="20"><asp:TextBox ID="txtNroDocumento" runat="server" CssClass="FormText" Width="182px"></asp:TextBox></td>
    <td width="20" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">Concepto Gasto
      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConceptoGasto"
                ErrorMessage="Ingrese el Concepto del Gasto">(*)</asp:RequiredFieldValidator></td>
    <td width="188" height="20"><span style="width: 314px">
      <asp:TextBox ID="txtConceptoGasto" runat="server" CssClass="FormText" Width="182px"></asp:TextBox></span></td>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">Monto del Gasto </td>
    <td height="20"><span style="width: 182px">
      <asp:TextBox ID="txtMontoGasto" runat="server" CssClass="FormText NUMBERS" Width="182px"></asp:TextBox>
    </span></td>
    <td width="20" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">Girado a:
      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtGiradoa"
                ErrorMessage="Ingrese a quien se giró">(*)</asp:RequiredFieldValidator></td>
    <td width="188" height="20">
      <asp:TextBox ID="txtGiradoa" runat="server" CssClass="FormText" Width="182px"></asp:TextBox></td>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">Moneda</td>
    <td height="20">
      <asp:DropDownList ID="cbxMoneda" runat="server" CssClass="FormSelect"
                                datasourceid="odsMoneda" DataTextField="nombre" onchange="cargaTipoDeCambio(this);" DataValueField="monedaId"
                                Width="182px">
        <asp:ListItem>US$</asp:ListItem>
      </asp:DropDownList>    </td>
    <td width="20" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">&nbsp;</td>
    <td width="188" height="20"><asp:TextBox style="display:none;" ID="txtMontoSoles" runat="server" CssClass="FormText" Width="182px" BorderStyle="None"></asp:TextBox></td>
    <td width="20" height="20">&nbsp;</td>
    <td width="132" height="20">&nbsp;</td>
    <td height="20"><asp:TextBox ID="txtTipoCambio" style="display:none;" runat="server" CssClass="FormText" Width="182px"></asp:TextBox></td>
    <td width="20" height="20">&nbsp;</td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td>
    <td height="20" valign="top"><span style="height: 24px">Descripci&oacute;n</span></td>
    <td height="20" colspan="3"><span style="width: 314px">
      <asp:TextBox ID="txtDescripcionGasto" runat="server" CssClass="FormText" TextMode="MultiLine"
                                    Width="300px" Height="70px"></asp:TextBox>
    </span></td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td>
    <td height="20"></td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20"><div align="right"><span style="height: 17px"><span style="width: 127px; height: 24px">
    </span></span><span style="height: 17px"><span style="width: 127px; height: 24px">
    <asp:Button ID="btnAgregar" runat="server" CssClass="FormButton"
                                Text="Agregar" OnClick="btnAgregar_Click" />    
    </span></span></div>      </td>
    <td height="20">&nbsp;</td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td height="20">&nbsp;</td>
  </tr>
</table>

    </div>
   
   <div style="height:30px; margin-top:10px;margin-bottom:5px;position:relative;">	&nbsp;
		   <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px" ForeColor="White">Lista Gastos </asp:Label>
		    <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Gasto" title="Agregar Gastos" style="position:absolute; left: 672px; top: 5px;" id="nuevoGasto" />   &nbsp;
       <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
           onclick="return separar();" Style="left: 141px; position: absolute; top: 1px"
           Width="22px"></asp:HyperLink>
       &nbsp;&nbsp;</div>
    
   <div id="ListaGastos" style="margin-left:auto;margin-right:auto;position:relative">
      <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="odsGastos"
            Width="700px" OnRowCommand="GridView1_RowCommand" CssClass="DataTable" >
            <Columns>
                <asp:TemplateField HeaderText="N&#176;">
                    <ItemTemplate>
                        &nbsp;<asp:HyperLink ID="LynkGasto" runat="server" Text="<%# num++ %>"></asp:HyperLink>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="10px" />
                </asp:TemplateField>
                <asp:BoundField DataField="numDoc" HeaderText="N&#176; Documento" SortExpression="numDoc" >
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="fechaGasto" HeaderText="Fecha" SortExpression="fechaGasto" DataFormatString="{0:MM-dd-yyyy}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Center" Width="80px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Monto">
                    <ItemStyle Width="50px" />
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td style="width: 46px">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Simbolo") %>'></asp:Label></td>
                                <td style="width: 60px">
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("monto") %>'></asp:Label></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="monto" HeaderText="Monto" SortExpression="monto" Visible="False" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="nombreMoneda" HeaderText="Moneda" SortExpression="nombreMoneda" Visible="False" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="gastoId" HeaderText="gastoId" InsertVisible="False" ReadOnly="True"
                    SortExpression="gastoId" Visible="False" />
                <asp:BoundField DataField="ajusteId" HeaderText="ajusteId" ReadOnly="True" SortExpression="ajusteId"
                    Visible="False" />
                <asp:BoundField DataField="giradoa" HeaderText="Girado a" SortExpression="giradoa" />
                <asp:BoundField DataField="concepto" HeaderText="Concepto" SortExpression="concepto" >
                    <ItemStyle HorizontalAlign="Center" Width="255px" />
                </asp:BoundField>
                <asp:BoundField DataField="descripcion" HeaderText="Descripcion" SortExpression="descripcion" Visible="False" />
                <asp:BoundField DataField="montosoles" HeaderText="montosoles" SortExpression="montosoles"
                    Visible="False" />
                <asp:BoundField DataField="monedaId" HeaderText="monedaId" SortExpression="monedaId"
                    Visible="False" />
                <asp:BoundField DataField="tipoCambio" HeaderText="tipoCambio" SortExpression="tipoCambio"
                    Visible="False" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("gastoId") %>'
                            CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="Simbolo" HeaderText="Simbolo" SortExpression="Simbolo"
                    Visible="False" />
            </Columns>
            <HeaderStyle CssClass="HeaderStyle" />
            <RowStyle CssClass="ItemStyle" />
          <EmptyDataTemplate>
            No hay gastos registrados
          </EmptyDataTemplate>
        </asp:GridView>
      </div>
    </div>
    
    <asp:ObjectDataSource ID="odsGastos" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGastoTableAdapters.GastoListaTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="gastoId" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId"
                Type="Decimal" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtGastoId" Direction="InputOutput" Name="gastoId"
                PropertyName="Text" Type="Object" />
            <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            <asp:ControlParameter ControlID="txtNroDocumento" Name="numDoc" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtFecha" Name="fechaGasto" PropertyName="Text"
                Type="DateTime" />
            <asp:ControlParameter ControlID="txtConceptoGasto" Name="concepto" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtDescripcionGasto" Name="descripcion" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtGiradoa" Name="giradoa" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtMontoGasto" Name="monto" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtMontoSoles" Name="montosoles" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="cbxMoneda" Name="monedaId" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtTipoCambio" Name="tipoCambio" PropertyName="Text"
                Type="Decimal" />
        </InsertParameters>
    </asp:ObjectDataSource>
    
    
    <asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsComboTableAdapters.MonedaComboTableAdapter"></asp:ObjectDataSource>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" />
    
    
    
    </div>
   
        
                
          
       
    </form>
 </div>
    <asp:TextBox ID="txtGastoId" runat="server" Visible="False"></asp:TextBox>&nbsp;
</body>
</html>