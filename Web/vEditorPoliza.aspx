<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vEditorPoliza.aspx.cs" Inherits="vEditorPoliza" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="linksPoliza.ascx" TagName="linksPoliza" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Registro de Póliza</title>
  <link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_dyn.css' />

  <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/subModal.css' />
  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/style.css' />

  <script type='text/javascript' src="Scripts/lib/x_core.js"></script>

  <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>

  <script type='text/javascript' src="Scripts/lib/xtabpanelgroup.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <link href="/asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/calendar/calendar.js"></script>

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

  <link href="Scripts/calendar/calendar-blue2.css" rel="Stylesheet" type="text/css" />

  <script type="text/javascript" language="javascript" src="Scripts/calendar/calendar-setup.js">
  </script>

  <script type="text/javascript" language="javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" language="javascript">
        function muestraDetallesPoliza() {
            showPopWin("vDetallesPolizaInicial.aspx?PolizaId=<%=qStringPolizaId %>",790,420,true);
        }
  </script>

  <script type="text/javascript" language="javascript">
		var arregloDivs = new Array();
		
		window.onload = function () {		    		  
		    
			arregloDivs = xGetElementsByClassName('collapsibleContent',null,'div',null);
			muestraOcultaTodo();
			
		}
		
    function muestraOcultaTodo() {            
      for (i= 0; i < arregloDivs.length; i++) {
        divDummy = arregloDivs[i];
        var diplayAll = divDummy.style.display == "none";      
        divDummy.style.display = (diplayAll)?"block":"none";
      }
    }
    
    function muestraOcultaDiv(element) {
      var identificadorElemento = element.id;            
      //alert(identificadorElemento);
      var divDummy = xGetElementById('div'+identificadorElemento);      
      var diplayAll = divDummy.style.display == "none";      
      divDummy.style.display = (diplayAll)?"block":"none";                                                                        
    }
      
    
  </script>

  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="frmEditorPoliza" runat="server">
    <div id="ContenidoPagina" style="margin-left: auto; margin-right: auto; position: relative;
      width: 999px; left: 0px; top: 0px; height: 1019px;">
      <div>
        <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="poliza" />
        <uc2:linksPoliza ID="LinksPoliza" runat="server" />
      </div>
      <div>
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="left: 0px; top: 0px; background-color: transparent;">
            <div id="divDatosGeneralesPoliza" style="position: relative; z-index: 150;">
              <asp:FormView ID="fvDatosGenerales" runat="server" DataSourceID="odsEditorPoliza"
                DefaultMode="Edit" Style="top: 0px" Width="978px" OnItemUpdating="fvDatosGenerales_ItemUpdating"
                OnItemCommand="fvDatosGenerales_ItemCommand" OnDataBinding="fvDatosGenerales_DataBinding"
                OnDataBound="fvDatosGenerales_DataBound" OnItemUpdated="fvDatosGenerales_ItemUpdated">
                <EditRowStyle Width="980px" />
                <EditItemTemplate>
                  <div class="DataTable" style="padding: 10px; padding-bottom: 10px; position: relative;
                    background-color: #4b92c1;">
                    <div id="Div9">
                      <div style="padding: 5px; position: relative; background-color: #3e76b4;" id="Div1">
                        <asp:Label ID="lblDatosPoliza" runat="server" Font-Bold="True" Font-Size="18px" Text="Datos de la Póliza"></asp:Label>
                      </div>
                      <div id="Div6" style="padding: 10px;" class="DataTable">
                        <table width="900" border="0" cellspacing="0" cellpadding="0">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="145" height="19">
                              Aseguradora</td>
                            <td width="265" valign="top">
                              <asp:TextBox ID="txtAseguradora" runat="server" CssClass="FormText" Width="236px"
                                Text='<%# Bind("aseguradora") %>' ReadOnly="True"></asp:TextBox></td>
                            <td width="165">
                              Producto</td>
                            <td width="325" valign="top">
                              <asp:DropDownList ID="cbxProducto" runat="server" CssClass="FormSelect" Width="254px"
                                DataSourceID="odsProducto" DataTextField="descripcion" DataValueField="productoid"
                                OnSelectedIndexChanged="cbxProducto_SelectedIndexChanged" AutoPostBack="True">
                              </asp:DropDownList></td>
                          </tr>
                          <tr>
                            <td>
                              N&deg; de P&oacute;liza
                            </td>
                            <td>
                              <asp:TextBox ID="numPolizaTextBox" runat="server" CssClass="FormText" Text='<%# Bind("numPoliza") %>'
                                Width="236px"></asp:TextBox></td>
                            <td>
                              Ramo</td>
                            <td>
                              <asp:DropDownList ID="cbxRamo" runat="server" CssClass="FormSelect" Width="254px"
                                DataSourceID="sdsRamos" DataTextField="ramo" DataValueField="ramoId" OnSelectedIndexChanged="cbxRamo_SelectedIndexChanged"
                                AutoPostBack="True">
                              </asp:DropDownList></td>
                          </tr>
                          <tr>
                            <td valign="top">
                              Vigencia
                            </td>
                            <td>
                              <table cellspacing="0" cellpadding="0" width="260" border="0">
                                <!--DWLayoutTable-->
                                <tbody>
                                  <tr>
                                    <td width="44" height="19" valign="middle">
                                      Desde</td>
                                    <td valign="middle" width="40">
                                      &nbsp;
                                      <button tabindex="7" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaInicio"
                                        type="button">
                                        <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                          width="16" /></button></td>
                                    <td valign="middle" width="176">
                                      <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="FormText" Text='<%# Bind("finicio", "{0:d}") %>'
                                        Width="152px"></asp:TextBox>

                                      <script type="text/javascript">
                                                        
                                                                function getFoco(cal) {
                                                                    var date = cal.date;
                                                                    var time = date.getTime();
                                                                    time += Date.YEAR; 
                                                                    var date2 = new Date(time);
                                                                    
                                                                    $('fvDatosGenerales_ffinTextBox').value = date2.print('%d/%m/%Y'); 
                                                                    
                                                                                                                                  
                                                                    p = cal.params;
                                                                    p.inputField.focus();
                                                                    p.inputField.select();
                                                                    cal.hide();
                                                                                                                                                  
                                                                }
                                                                
                                                                  Calendar.setup({
                                                                        inputField     :    'fvDatosGenerales_txtFechaInicio',
                                                                        ifFormat       :    '%d/%m/%Y',
                                                                        button         :    'btnFechaInicio',
                                                                        showsTime      :    false,                                                                        
                                                                        singleClick    :    false,
                                                                        onClose        :    getFoco
                                                                    });                                                                                                                                    
                                            
                                      </script>

                                    </td>
                                  </tr>
                                  <tr>
                                    <td height="19" valign="middle">
                                      Hasta</td>
                                    <td valign="middle">
                                      &nbsp;
                                      <button tabindex="7" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaFin"
                                        type="button">
                                        <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                          width="16" /></button></td>
                                    <td valign="middle">
                                      <asp:TextBox ID="ffinTextBox" runat="server" CssClass="FormText" Text='<%# Bind("ffin", "{0:d}") %>'
                                        Width="152px"></asp:TextBox>

                                      <script type="text/javascript">
                                                              Calendar.setup({
                                                                    inputField     :    'fvDatosGenerales_ffinTextBox',
                                                                    ifFormat       :    '%d/%m/%Y',
                                                                    button         :    'btnFechaFin',
                                                                    showsTime      :    false,                                                                        
                                                                    singleClick    :    false
                                                                }); 
                                      </script>

                                    </td>
                                  </tr>
                                </tbody>
                              </table>
                            </td>
                            <td valign="top" style="padding-top: 1px">
                              Cobertura
                            </td>
                            <td valign="top" style="padding-top: 1px">
                              <asp:DropDownList ID="cbxCobertura" runat="server" CssClass="FormSelect" Width="254px"
                                DataSourceID="Cobertura" DataTextField="nombre" DataValueField="riesgoId" OnSelectedIndexChanged="cbxCobertura_SelectedIndexChanged">
                              </asp:DropDownList></td>
                          </tr>
                          <tr>
                            <td height="19">
                              Giro de Negocio
                            </td>
                            <td>
                              &nbsp;
                            </td>
                            <td valign="top">
                              Grupo Econ&oacute;mico
                            </td>
                            <td>
                              &nbsp;</td>
                          </tr>
                          <tr>
                            <td height="19" colspan="2" valign="top">
                              <asp:TextBox Style="z-index: 10;" ID="TextBox3" runat="server" CssClass="FormText"
                                Height="60px" TextMode="MultiLine" Width="383px" Text='<%# Bind("giroNegocio") %>'></asp:TextBox></td>
                            <td colspan="2" valign="top">
                              <asp:TextBox ID="TextBox4" runat="server" CssClass="FormText" Height="60px" TextMode="MultiLine"
                                Width="414px" Text='<%# Bind("grupoEconomico") %>'></asp:TextBox></td>
                          </tr>
                        </table>
                      </div>
                      <div style="padding: 5px; position: relative; background-color: #3e76b4;" id="Div7">
                        <asp:Label ID="Label2" runat="server" Text="Datos del Asegurado" Font-Bold="True"
                          Font-Size="18px"></asp:Label>
                      </div>
                      <div id="Div8" style="padding-left: 10px; padding-right: 10px; padding-top: 10px;
                        position: relative; z-index: 400;" class="DataTable">
                        <table width="900" border="0" cellspacing="0" cellpadding="0">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="145" height="19">
                              Asegurado</td>
                            <td width="265" valign="top">
                              <cc1:AutoSuggestBox ID="txtAsegurado" runat="server" CssClass="FormText" DataType="Asegurado"
                                MaxSuggestChars="18" ResourcesDir="./asb_includes" Width="238px" IncludeMoreMenuItem="False"
                                KeyPressDelay="300" MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..."
                                NumMenuItems="10" SelMenuItemCSSClass="asbSelMenuItem" Text='<%# Bind("asegurado") %>'
                                UseIFrame="True" SelectedValue='<%# Bind("aseguradoid") %>'></cc1:AutoSuggestBox></td>
                            <td width="165">
                              &nbsp;<!--DWLayoutEmptyCell--></td>
                            <td width="325" valign="top">
                              <button id="btnMuestraDetalles" onclick="muestraDetallesPoliza();" style="width: 141px"
                                class="FormButton" type="button">
                                Detalles de La Póliza</button><!--DWLayoutEmptyCell--></td>
                          </tr>
                        </table>
                      </div>
                      <div style="padding-left: 10px; padding-right: 10px; padding-bottom: 10px; position: relative;"
                        class="DataTable">
                        <table width="900" border="0" cellspacing="0" cellpadding="0">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="145" style="height: 20px">
                              Contratante</td>
                            <td width="265" valign="top" style="height: 20px">
                              <asp:TextBox Style="z-index: 10;" ID="txtContratante" runat="server" CssClass="FormText"
                                Width="238px" Text='<%# Bind("contratante") %>'></asp:TextBox></td>
                            <td width="165" style="height: 20px">
                              Archivo Adjunto<!--DWLayoutEmptyCell--></td>
                            <td width="325" valign="top" style="height: 20px">
                              <!--DWLayoutEmptyCell-->
                              <asp:FileUpload ID="fupArchivo" runat="server" CssClass="FormText" TabIndex="12"
                                Width="252px" /></td>
                          </tr>
                        </table>
                      </div>
                    </div>
                    <div style="padding: 5px; padding-top: 15px;">
                      <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/imgRGen/btnSave.gif"
                        OnClick="ImageButton2_Click" />
                      <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandArgument='<%# Bind("polizaId") %>'
                        CommandName="Eliminar" ImageUrl="~/images/IconDelete48Dark.gif" OnClientClick="return confirm('Esta seguro que desea eliminar la póliza');" /></div>
                    <asp:TextBox ID="polizaidTextBox" Style="display: none" runat="server" Text='<%# Bind("polizaid") %>'></asp:TextBox><asp:TextBox
                      ID="productoidTextBox" Style="display: none" runat="server" Text='<%# Eval("productoid") %>'></asp:TextBox><asp:TextBox
                        ID="ramoidTextBox" Style="display: none" runat="server" Text='<%# Eval("ramoid") %>'></asp:TextBox><asp:TextBox
                          ID="coberturaidTextBox" Style="display: none" runat="server" Text='<%# Eval("coberturaid") %>'></asp:TextBox><asp:TextBox
                            ID="aseguradoraidTextBox" Style="display: none" runat="server" Text='<%# Bind("aseguradoraid") %>'></asp:TextBox>
                    <asp:SqlDataSource ID="sdsRamos" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                      SelectCommand="sp_rgenx_RamosSelectByProductoId" SelectCommandType="StoredProcedure">
                      <SelectParameters>
                        <asp:ControlParameter ControlID="cbxProducto" Name="productoId" PropertyName="SelectedValue"
                          Type="Decimal" />
                      </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="Cobertura" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                      SelectCommand="sp_rgenx_CoberturasByRamoId" SelectCommandType="StoredProcedure">
                      <SelectParameters>
                        <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
                          Type="Decimal" />
                      </SelectParameters>
                    </asp:SqlDataSource>
                  </div>
                </EditItemTemplate>
              </asp:FormView>
              &nbsp;&nbsp;</div>
            <div style="position: relative;">
              <asp:ObjectDataSource ID="odsEditorPoliza" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsPolizaTableAdapters.polizaEditorCompletoTableAdapter"
                UpdateMethod="Update">
                <UpdateParameters>
                  <asp:Parameter Name="polizaId" Type="Decimal" />
                  <asp:Parameter Name="contratante" Type="String" />
                  <asp:Parameter Name="aseguradoId" Type="Decimal" />
                  <asp:Parameter Name="asegurado" Type="String" />
                  <asp:Parameter Name="aseguradora" Type="String" />
                  <asp:Parameter Name="productoId" Type="Decimal" />
                  <asp:Parameter Name="ramoId" Type="Decimal" />
                  <asp:Parameter Name="coberturaId" Type="Decimal" />
                  <asp:Parameter Name="finicio" Type="DateTime" />
                  <asp:Parameter Name="ffin" Type="DateTime" />
                  <asp:Parameter Name="numPoliza" Type="String" />
                  <asp:Parameter Name="aseguradoraId" Type="Decimal" />
                  <asp:Parameter Name="grupoEconomico" Type="String" />
                  <asp:Parameter Name="giroNegocio" Type="String" />
                  <asp:Parameter Name="nombreArchivo" Type="String" />
                </UpdateParameters>
                <SelectParameters>
                  <asp:QueryStringParameter Name="polizaid" QueryStringField="PolizaId" Type="Decimal" />
                </SelectParameters>
              </asp:ObjectDataSource>
              &nbsp;&nbsp;
              <asp:ObjectDataSource ID="odsProducto" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsComboTableAdapters.ProductoComboTableAdapter">
              </asp:ObjectDataSource>
              <asp:ObjectDataSource ID="odsGetPdf" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaPdfSelectTableAdapter">
                <SelectParameters>
                  <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
                </SelectParameters>
              </asp:ObjectDataSource>
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
  </form>

  <script type="text/javascript" language="javascript">
			creaPopUpDivs();
  </script>

</body>
</html>
