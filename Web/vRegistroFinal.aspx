<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroFinal.aspx.cs" Inherits="vRegistroFinal"
    Culture="es-PE" UICulture="es-PE" ValidateRequest="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Riesgos Generales | Registro Del Informe Final</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript" src="Scripts/calendar/datetimepicker.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_core.js" language="javascript"></script>

    <script type="text/javascript" src="Scripts/lib/x_dom.js" language="javascript"></script>

    <script type="text/javascript" src="Scripts/lib/x_event.js" language="javascript"></script>

    <script type="text/javascript" src="Scripts/lib/xCaseOperations.js" language="javascript"></script>

    <script type="text/javascript" src="Scripts/functions.js" language="javascript"></script>

     <link href="Scripts/calendar/calendar-blue2.css" rel="Stylesheet" type="text/css" />

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

  <script type="text/javascript" language="javascript" src="Scripts/calendar/calendar-setup.js">
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
        function GenerarInforme(ajusteId, observado)
        {
          window.top.showPopWin('generarStatus.aspx?ajusteId='+ajusteId+'&tipoInforme=<%=qStringTipoInforme %>&observado='+observado, 229, 75, null);
        
        }
        function GenerarVistaPreviaPdf(ajusteId, tipoInforme) {    
         ShowReport('genPreview.aspx?AjusteId='+ajusteId+'&TI=' + tipoInforme+'&NOW=NOW', 229, 75, null);         
        }
    
    </script>

    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-image: none; background-color: #3785B9;">
    <form id="form1" runat="server">
        <div style="width: 855px; margin-left: auto; margin-right: auto; position: relative;">
            <div style="background-color: #3785B9; margin-bottom: 5px; height: 20px; position: relative;">
                <div style="position: absolute; left: 832px; width: 22px; top: 2px; height: 19px;
                    cursor: pointer;">
                    <img src="imgRGen/openCloseCollapse.jpg" onclick="muestraOcultaTodo();" alt="Mostrar/Ocultar Todo"
                        width="19" height="17" /></div>
            </div>
            <div style="background-color: #3785B9; padding: 10px;">
                <!-- seccion de divs collapsibles -->
                <div>
            <asp:LinkButton ID="lnkSeccionesAdicionales" runat="server" Font-Bold="True" Font-Size="16px"
                OnClick="lnkSeccionesAdicionales_Click">Secciones Adicionales</asp:LinkButton>&nbsp;</div>
                <br />
                <div style="margin-bottom: 5px;">
          <asp:Label Style="cursor: hand; cursor: pointer;" onclick="muestraOcultaDiv(this)"
            ID="DatosGenerales" Font-Bold="true" Font-Size="16px" runat="server" Text="Datos Generales">
          </asp:Label>
        </div>
        <div id="divDatosGenerales" class="collapsibleContent" style="width: 810px">
          <asp:FormView ID="FormViewDatosGenerales" runat="server" DataSourceID="odsDatosGenerales"
            DefaultMode="Edit" Width="806px">
            <EditItemTemplate>
              <table width="784" border="0" cellpadding="0" cellspacing="0" class="DataTable">
                <tr>
                                    <td width="21">
                                        &nbsp;
                  </td>
                                    <td style="width: 386px">
                                        &nbsp;
                  </td>
                                    <td width="11">
                                        &nbsp;
                  </td>
                                    <td width="382">
                                        &nbsp;
                  </td>
                                    <td width="56">
                                        &nbsp;
                  </td>
                </tr>
                <tr>
                                    <td width="21">
                                        &nbsp;
                  </td>
                  <td valign="top" style="width: 386px">
                    <table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="20" style="width: 174px">
                          Contratante</td>
                        <td height="20">
                          <asp:TextBox Width="230px" CssClass="FormText" ID="txtContratante" runat="server"
                            Text='<%# Bind("contratante") %>' ReadOnly="True" /></td>
                      </tr>
                      <tr>
                        <td style="width: 174px">
                          Asegurado</td>
                        <td>
                          <asp:TextBox Width="230px" CssClass="FormText" ID="txtAsegurado" runat="server" Text='<%# Bind("asegurado") %>'
                            ReadOnly="True" /></td>
                      </tr>
                      <tr>
                        <td style="width: 174px">
                          Giro del Negocio
                        </td>
                        <td>
                          <asp:TextBox Width="230px" Height="40px" CssClass="FormText" ID="txtGiroDelNegocio"
                            runat="server" TextMode="MultiLine" Text='<%# Bind("gruponegocio") %>' /></td>
                      </tr>
                      <tr>
                        <td height="40" style="width: 174px">
                          Grupo Econ&oacute;mico
                        </td>
                        <td height="40">
                          <asp:TextBox Width="230px" Height="40px" CssClass="FormText" ID="txtGrupoEconomico"
                            runat="server" TextMode="MultiLine" Text='<%# Bind("grupoeconomico") %>' /></td>
                      </tr>
                    </table>
                  </td>
                                    <td valign="top">
                                        &nbsp;
                  </td>
                  <td valign="top">
                    <table width="382" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="147" height="20">
                          Compa&ntilde;&iacute;a de Seguros
                        </td>
                        <td width="235" height="20">
                          <asp:TextBox Width="230px" CssClass="FormText" ID="txtCiaSeguros" runat="server"
                            Text='<%# Bind("aseguradora") %>' ReadOnly="True" /></td>
                      </tr>
                      <tr>
                        <td height="20">
                          Responsable</td>
                        <td height="20">
                          <asp:TextBox Width="230px" CssClass="FormText" ID="txtContactoCiaSeguros" runat="server"
                            Text='<%# Bind("respaseguradora") %>' ReadOnly="True" /></td>
                      </tr>
                      <tr>
                        <td height="20">
                          Broker</td>
                        <td height="20">
                          <asp:TextBox Width="230px" CssClass="FormText" ID="txtBroker" runat="server" Text='<%# Bind("broker") %>'
                            ReadOnly="True" /></td>
                      </tr>
                      <tr>
                        <td>
                          Responsable</td>
                        <td>
                          <asp:TextBox Width="230px" CssClass="FormText" ID="txtContactoBroker" runat="server"
                            Text='<%# Bind("respbroker") %>' ReadOnly="True" /></td>
                      </tr>
                    </table>
                  </td>
                                    <td width="56">
                                        &nbsp;
                  </td>
                </tr>
                <tr>
                                    <td width="21">
                                        &nbsp;
                  </td>
                  <td style="width: 386px">
                    &nbsp;<asp:TextBox ID="aseguradoidTextBox" Style="display: none" runat="server" Text='<%# Bind("aseguradoid") %>'>
                    </asp:TextBox>
                    <asp:TextBox ID="aseguradoraidTextBox" Style="display: none" runat="server" Text='<%# Bind("aseguradoraid") %>'>
                    </asp:TextBox></td>
                                    <td>
                                        &nbsp;
                  </td>
                  <td>
                    &nbsp;<asp:TextBox ID="brokeridTextBox" Style="display: none" runat="server" Text='<%# Bind("brokerid") %>'>
                    </asp:TextBox></td>
                                    <td width="56">
                                        &nbsp;
                  </td>
                </tr>
              </table>
            </EditItemTemplate>
            <InsertItemTemplate>
              contratante:
              <asp:TextBox ID="contratanteTextBox" runat="server" Text='<%# Bind("contratante") %>'>
              </asp:TextBox><br />
              asegurado:
              <asp:TextBox ID="aseguradoTextBox" runat="server" Text='<%# Bind("asegurado") %>'>
              </asp:TextBox><br />
              gruponegocio:
              <asp:TextBox ID="gruponegocioTextBox" runat="server" Text='<%# Bind("gruponegocio") %>'>
              </asp:TextBox><br />
              grupoeconomico:
              <asp:TextBox ID="grupoeconomicoTextBox" runat="server" Text='<%# Bind("grupoeconomico") %>'>
              </asp:TextBox><br />
              aseguradora:
              <asp:TextBox ID="aseguradoraTextBox" runat="server" Text='<%# Bind("aseguradora") %>'>
              </asp:TextBox><br />
              respaseguradora:
              <asp:TextBox ID="respaseguradoraTextBox" runat="server" Text='<%# Bind("respaseguradora") %>'>
              </asp:TextBox><br />
              broker:
              <asp:TextBox ID="brokerTextBox" runat="server" Text='<%# Bind("broker") %>'>
              </asp:TextBox><br />
              respbroker:
              <asp:TextBox ID="respbrokerTextBox" runat="server" Text='<%# Bind("respbroker") %>'>
              </asp:TextBox><br />
              ajusteid:
              <asp:TextBox ID="ajusteidTextBox" runat="server" Text='<%# Bind("ajusteid") %>'>
              </asp:TextBox><br />
              aseguradoid:
              <asp:TextBox ID="aseguradoidTextBox" runat="server" Text='<%# Bind("aseguradoid") %>'>
              </asp:TextBox><br />
              aseguradoraid:
              <asp:TextBox ID="aseguradoraidTextBox" runat="server" Text='<%# Bind("aseguradoraid") %>'>
              </asp:TextBox><br />
              brokerid:
              <asp:TextBox ID="brokeridTextBox" runat="server" Text='<%# Bind("brokerid") %>'>
              </asp:TextBox><br />
              <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
              </asp:LinkButton>
              <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
              </asp:LinkButton>
            </InsertItemTemplate>
          </asp:FormView>
          <asp:ObjectDataSource ID="odsDatosGenerales" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsRegistroBasicoTableAdapters.DatosGeneralesTableAdapter"
            UpdateMethod="Update">
            <UpdateParameters>
              <asp:Parameter Name="contratante" Type="String" />
              <asp:Parameter Name="asegurado" Type="String" />
              <asp:Parameter Name="gruponegocio" Type="String" />
              <asp:Parameter Name="grupoeconomico" Type="String" />
              <asp:Parameter Name="aseguradora" Type="String" />
              <asp:Parameter Name="respaseguradora" Type="String" />
              <asp:Parameter Name="broker" Type="String" />
              <asp:Parameter Name="respbroker" Type="String" />
              <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
              <asp:Parameter Name="aseguradoid" Type="Decimal" />
              <asp:Parameter Name="aseguradoraid" Type="Decimal" />
              <asp:Parameter Name="brokerid" Type="Decimal" />
            </UpdateParameters>
            <SelectParameters>
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
          </asp:ObjectDataSource>
        </div>
        <br />
        <div style="margin-bottom: 5px;">
          <asp:Label Style="cursor: hand; cursor: pointer;" onclick="muestraOcultaDiv(this)"
            ID="Coordinacion" Font-Bold="True" Font-Size="16px" runat="server" Text="Fecha - Hora de Aviso & Coordinación"></asp:Label>
        </div>
        <div id="divCoordinacion" class="collapsibleContent" style="width: 810px">
          &nbsp;<asp:FormView ID="FormView1" runat="server" DataSourceID="odsCoordinacion">
            <ItemTemplate>
              <table width="777" border="0" cellpadding="0" cellspacing="0" class="DataTable">
                <tr>
                                    <td width="16">
                                        &nbsp;
                  </td>
                                    <td style="width: 524px">
                                        &nbsp;
                  </td>
                                    <td width="248">
                                        &nbsp;
                  </td>
                                    <td width="11">
                                        &nbsp;
                  </td>
                                    <td width="36">
                                        &nbsp;
                  </td>
                                    <td width="158">
                                        &nbsp;
                  </td>
                                    <td width="8">
                                        &nbsp;
                  </td>
                                    <td width="48">
                                        &nbsp;
                  </td>
                                    <td width="185">
                                        &nbsp;
                  </td>
                                    <td width="28">
                                        &nbsp;
                  </td>
                </tr>
                <tr>
                                    <td width="16" height="20">
                                        &nbsp;
                  </td>
                  <td style="width: 524px">
                    Aviso</td>
                  <td width="248">
                    <asp:TextBox Width="195px" CssClass="FormText" ID="txFechatAviso" runat="server"
                      Text='<%# Bind("faviso") %>' /></td>
                                    <td width="11">
                                        &nbsp;
                  </td>
                  <td width="36">
                    Qui&eacute;n</td>
                  <td width="158">
                    <asp:TextBox Width="155px" CssClass="FormText" ID="txtQuienAviso" runat="server"
                      Text='<%# Bind("quienNotifico") %>' /></td>
                                    <td width="8">
                                        &nbsp;
                  </td>
                  <td width="48">
                    V&iacute;a
                  </td>
                  <td width="185">
                    <asp:TextBox Width="155px" CssClass="FormText" ID="txtVia" runat="server" Text='<%# Bind("MediodeNotificacion") %>' /></td>
                                    <td width="28">
                                        &nbsp;
                  </td>
                </tr>
                <tr>
                                    <td width="16" height="20">
                                        &nbsp;
                  </td>
                  <td style="width: 524px">
                    Coordinaci&oacute;n</td>
                  <td width="248">
                    <asp:TextBox Width="195px" CssClass="FormText" ID="txtFechaCoordinacion" runat="server"
                      Text='<%# Bind("FechaHoraCoordinacion") %>' /></td>
                                    <td width="11">
                                        &nbsp;
                  </td>
                  <td width="36">
                    Con</td>
                  <td width="158">
                    <asp:TextBox Width="155px" CssClass="FormText" ID="txtContactoCoordinacion" runat="server"
                      Text='<%# Bind("QuienCoordino") %>' /></td>
                                    <td width="8">
                                        &nbsp;
                  </td>
                  <td width="48">
                    Es</td>
                  <td width="185">
                    <asp:TextBox Style="display: none;" Width="155px" CssClass="FormText" ID="txtCargoContactoCoordinacion"
                      runat="server" Text='<%# Bind("cargocontacto") %>' /></td>
                                    <td width="28">
                                        &nbsp;
                  </td>
                </tr>
                <tr>
                                    <td width="16" height="20">
                                        &nbsp;
                  </td>
                  <td valign="top" style="width: 524px">
                    Inspecci&oacute;n</td>
                  <td valign="top">
                    <asp:TextBox Width="195px" CssClass="FormText" ID="txtFechaInspeccion" runat="server"
                      Text='<%# Bind("finspeccion") %>' /></td>
                                    <td valign="top">
                                        &nbsp;
                  </td>
                                    <td valign="top">
                                        &nbsp;
                  </td>
                                    <td colspan="4" valign="top">
                                        &nbsp;
                  </td>
                                    <td width="28">
                                        &nbsp;
                  </td>
                </tr>
                <tr>
                                    <td width="16" height="20">
                                        &nbsp;
                  </td>
                                    <td style="width: 524px">
                                        &nbsp;
                  </td>
                                    <td>
                                        &nbsp;
                  </td>
                                    <td>
                                        &nbsp;
                  </td>
                                    <td>
                                        &nbsp;
                  </td>
                                    <td>
                                        &nbsp;
                  </td>
                                    <td>
                                        &nbsp;
                  </td>
                                    <td>
                                        &nbsp;
                  </td>
                                    <td>
                                        &nbsp;
                  </td>
                                    <td width="28">
                                        &nbsp;
                  </td>
                </tr>
              </table>
            </ItemTemplate>
          </asp:FormView>
          <asp:ObjectDataSource ID="odsCoordinacion" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsRegistroBasicoTableAdapters.CoordinacionTableAdapter">
            <SelectParameters>
              <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
          </asp:ObjectDataSource>
        </div>
        <br />
        <div style="margin-bottom: 5px;">
          <asp:Label Style="cursor: hand; cursor: pointer;" onclick="muestraOcultaDiv(this)"
            ID="Ocurrencia" Font-Bold="True" Font-Size="16px" runat="server" Text="De La Ocurrencia"></asp:Label>
        </div>
        <div id="divOcurrencia" class="collapsibleContent" style="width: 809px">
          <asp:FormView ID="FormViewOcurrencia" runat="server" DataSourceID="odsOcurrencia"
            DefaultMode="Edit" Width="796px">
            <EditItemTemplate>
              <table width="765" border="0" cellpadding="0" cellspacing="0" class="DataTable">
                <tr>
                                    <td width="4">
                                        &nbsp;
                  </td>
                                    <td style="width: 170px">
                                        &nbsp;
                  </td>
                                    <td width="604">&nbsp;
                                        &nbsp;
                  </td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                  </td>
                  <td colspan="2">
                    <table width="765" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="20" style="width: 170px">
                          Tipo de Siniestro
                        </td>
                        <td width="226" height="20">
                          <asp:DropDownList ID="cbxTipoSiniestro" runat="server" CssClass="FormSelect" DataSourceID="odsTipoSiniestro"
                            DataTextField="tipoSiniestro" DataValueField="tipoSiniestroId" SelectedValue='<%# Bind("tiposiniestroid") %>'
                            Width="200px">
                          </asp:DropDownList>
                        </td>
                                                <td width="20" height="20">
                                                    &nbsp;
                        </td>
                        <td width="134" height="20">
                          Lugar del Siniestro
                        </td>
                        <td width="227" height="20">
                          <asp:TextBox Width="195px" CssClass="FormText" ID="txtLugarSiniestro" runat="server"
                            Text='<%# Bind("lugarsiniestro") %>' /></td>
                      </tr>
                      <tr>
                        <td height="20" style="width: 170px">
                          Fecha y Hora Siniestro
                        </td>
                        <td height="20">
                          <table width="224" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td width="195" height="20">
                                <asp:TextBox Width="195px" CssClass="FormText" ID="txtFechaHoraSiniestro" runat="server"
                                  Text='<%# Bind("fsiniestro") %>' /></td>
                              <td width="45" height="20">
                                <div align="center">
                                  <button style="width: 17px; height: 17px;" class="FormButton" id="btnFechaAviso"
                                    type="button">
                                    <img style="cursor: pointer;" src="img/cal.gif" width="16" height="16" border="0"
                                      alt="Escoja una fecha" /></button>

                                  <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'FormViewOcurrencia$txtFechaHoraSiniestro',
                                                                        ifFormat       :    '%d/%m/%Y %H:%M',
                                                                        button         :    'btnFechaAviso',
                                                                        showsTime      :    true,
                                                                        timeFormat     :    '24',
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                                  </script>

                                </div>
                              </td>
                            </tr>
                          </table>
                        </td>
                                                <td width="20" height="20">
                                                    &nbsp;
                        </td>
                        <td height="20">
                          Distrito - Prov. - Dpto.
                        </td>
                        <td width="227" height="20">
                          <asp:TextBox Width="195px" CssClass="FormText" ID="txtDistrito" runat="server" Text='<%# Bind("ubigeosiniestro") %>' /></td>
                      </tr>
                      <tr>
                                                <td height="20" style="width: 170px">
                                                    &nbsp;
                        </td>
                                                <td height="20">
                                                    &nbsp;
                        </td>
                                                <td height="20">
                                                    &nbsp;
                        </td>
                                                <td height="20">
                                                    &nbsp;
                        </td>
                                                <td height="20">
                                                    &nbsp;
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                  </td>
                  <td valign="top" style="width: 170px">
                    Detalle de la Ocurrencia</td>
                                    <td valign="top" style="width: 604px">
                    <asp:TextBox Width="570px" Height="100px" CssClass="FormText" ID="txtDetalleOcurrencia"
                      runat="server" TextMode="MultiLine" Text='<%# Bind("detalle") %>' /></td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                  </td>
                  <td valign="top" style="width: 170px">
                    Causas del Siniestro
                  </td>
                                    <td valign="top" style="width: 604px">
                    <asp:TextBox Width="570px" Height="100px" CssClass="FormText" ID="txtCausaSiniestro"
                      runat="server" TextMode="MultiLine" Text='<%# Bind("causas") %>' /></td>
                </tr>
                <tr>
                                    <td>
                                        &nbsp;
                  </td>
                  <td valign="top" style="width: 170px">
                    Investigaciones</td>
                                    <td valign="top" style="width: 604px">
                                        <FTB:FreeTextBox ID="txtInvestigaciones" runat="Server" AutoGenerateToolbarsFromString="True"
                                            DownLevelRows="50" Height="150px" HtmlModeCssClass="CssClassForTextBox" Language="es-ES"
                                            RenderMode="Rich" SupportFolder="aspnet_client/FreeTextBox/" ToolbarLayout="Bold, Italic, Underline,&#13;&#10;                                     RemoveFormat, JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, &#13;&#10;                                     NumberedList, Indent, Outdent, Cut, Copy, Paste, Delete, Undo, Redo, Print, Save &#13;&#10;                                     ,ieSpellCheck,InsertTable, EditTable, InsertTableRowBefore, &#13;&#10;                                     InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter, &#13;&#10;                                     DeleteTableColumn"
                                            ToolbarStyleConfiguration="Office2003" Width="560px" AllowHtmlMode="False" AssemblyResourceHandlerPath="" AutoConfigure="" AutoHideToolbar="True" AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="Paragraph" ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20" ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath="" ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False" DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50" DownLevelMessage="" DownLevelMode="TextArea" EditorBorderColorDark="128, 128, 128" EditorBorderColorLight="128, 128, 128" EnableHtmlMode="True" EnableSsl="False" EnableToolbars="True" Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="128, 128, 128" GutterBorderColorLight="255, 255, 255" HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode" StripAllScripting="False" TabIndex="-1" TabMode="InsertSpaces" Text='<%# Bind("investigaciones") %>' TextDirection="LeftToRight" ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource" UpdateToolbar="True" UseToolbarBackGroundImage="True">
                                        </FTB:FreeTextBox>
                                    </td>
                </tr>
                <tr>
                                    <td>
                                        &nbsp;
                  </td>
                  <td style="width: 170px">
                    &nbsp;
                    <asp:TextBox ID="ubigeoidTextBox" Style="display: none" runat="server" Text='<%# Bind("ubigeoid") %>'>                  </asp:TextBox></td>
                                    <td style="width: 604px">
                    <asp:TextBox ID="siniestroidTextBox" Style="display: none" runat="server" Text='<%# Bind("siniestroid") %>'>                    </asp:TextBox></td>
                </tr>
              </table>
            </EditItemTemplate>
          </asp:FormView>
          <asp:ObjectDataSource ID="odsOcurrencia" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsRegistroBasicoTableAdapters.OcurrenciaTableAdapter"
            UpdateMethod="Update">
            <UpdateParameters>
              <asp:Parameter Name="tiposiniestroid" Type="Decimal" />
              <asp:Parameter Name="fsiniestro" Type="DateTime" />
              <asp:Parameter Name="lugarsiniestro" Type="String" />
              <asp:Parameter Name="ubigeosiniestro" Type="String" />
              <asp:Parameter Name="ubigeoid" Type="String" />
              <asp:Parameter Name="detalle" Type="String" />
              <asp:Parameter Name="causas" Type="String" />
              <asp:Parameter Name="investigaciones" Type="String" />
              <asp:Parameter Name="siniestroid" Type="Decimal" />
              <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
            </UpdateParameters>
            <SelectParameters>
              <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
          </asp:ObjectDataSource>
          <asp:ObjectDataSource ID="odsTipoSiniestro" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoSiniestroComboTableAdapter">
          </asp:ObjectDataSource>
        </div>
        <br />
        <div>
          <asp:Label Style="cursor: hand; cursor: pointer;" onclick="muestraOcultaDiv(this)"
            ID="Inspeccion" Font-Bold="True" Font-Size="16px" runat="server" Text="De La Inspección"></asp:Label>
        </div>
        <div id="divInspeccion" class="collapsibleContent" style="height: 100px; width: 808px;">
          <asp:FormView ID="FormViewInspeccion" runat="server" DataSourceID="odsInpeccion"
                        DefaultMode="Edit" >
            <EditItemTemplate>
                          <table width="747" border="0" cellpadding="0" cellspacing="0" class="DataTable">
                <tr>
                                    <td width="4">
                                        &nbsp;
                                    </td>
                                    <td style="width: 175px">
                                        &nbsp;
                                    </td>
                                    <td width="571">
                                        &nbsp;
                                    </td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                                    </td>
                  <td colspan="2">
                    <table width="743" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="20" style="width: 187px">
                                                    Lugar de la Inspecci&oacute;n
                                                </td>
                        <td width="158" height="20">
                          <asp:TextBox Width="195px" CssClass="FormText" ID="txtLugarInspeccionEdit" runat="server"
                            Text='<%# Bind("lugarDeReunion") %>' /></td>
                                                <td width="22" height="20">
                                                    &nbsp;
                                                </td>
                                                <td width="141" height="20">
                                                    &nbsp;
                                                </td>
                                                <td width="250" height="20">
                                                    &nbsp;
                                                </td>
                      </tr>
                      <tr>
                                                <td height="20" style="width: 187px" >
                          Distrito - Prov. - Dpto.</td>
                        <td width="158" height="20">
                          <cc1:AutoSuggestBox ID="absDistrito" runat="server" CssClass="FormText" IncludeMoreMenuItem="False"
                            DataType="Distrito" KeyPressDelay="300" MaxSuggestChars="5" MenuCSSClass="asbMenu"
                            MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NumMenuItems="10" ResourcesDir="./asb_includes"
                            SelMenuItemCSSClass="asbSelMenuItem" Text='<%# Bind("distrito") %>' UseIFrame="True"
                            Width="195px" SelectedValue='<%# Bind("ubigeoId") %>'></cc1:AutoSuggestBox></td>
                                                <td width="22" height="20">
                                                    &nbsp;
                                                </td>
                                                <td height="20">
                                                    &nbsp;
                                                </td>
                                                <td width="250" height="20">
                                                    &nbsp;
                                                </td>
                      </tr>
                      <tr>
                                                <td style="width: 187px">
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                      </tr>
                                        </table>
                                    </td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                                    </td>
                  <td valign="top" style="width: 175px">
                                        Persona Entrevistada
                                    </td>
                  <td valign="top">
                    <asp:TextBox Width="560px" Height="70px" CssClass="FormText" ID="txtPersonaEntrevistada"
                      runat="server" TextMode="MultiLine" Text='<%# Bind("PersonaEntrevistada") %>' /></td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                                    </td>
                  <td valign="top" style="width: 175px">
                                        Descripci&oacute;n del Riesgo
                                    </td>
                  <td valign="top">
                    <asp:TextBox Width="560px" Height="70px" CssClass="FormText" ID="txtDescripcionRiesgo"
                      runat="server" TextMode="MultiLine" Text='<%# Bind("descripcionRiesgo") %>' /></td>
                </tr>
                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                  <td style="width: 175px">
                                  </td>
                                    <td >
                    <asp:TextBox ID="txtActividad" Style="display: none" runat="server" Text='<%# Bind("actividadId") %>'></asp:TextBox></td>
                </tr>
</table>
            </EditItemTemplate>
          </asp:FormView>
          <asp:ObjectDataSource ID="odsInpeccion" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsRegistroBasicoTableAdapters.InspeccionTableAdapter"
            UpdateMethod="Update" OnUpdating="odsInpeccion_Updating">
            <UpdateParameters>
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
              <asp:Parameter Name="descripcionRiesgo" Type="String" />
              <asp:Parameter Name="actividadId" Type="Decimal" />
              <asp:Parameter Name="PersonaEntrevistada" Type="String" />
              <asp:Parameter Name="lugarDeReunion" Type="String" />
              <asp:Parameter Name="ubigeoId" Type="String" />
              <asp:Parameter Name="Distrito" Type="String" />
            </UpdateParameters>
            <SelectParameters>
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
          </asp:ObjectDataSource>
          &nbsp;
        </div>
        <br />
        <div>
                    <asp:LinkButton Font-Bold="True" Font-Size="16px" ID="LinkButton1" runat="server"
                        OnClick="LinkButton1_Click">Detalle de los Sublímites Afectados</asp:LinkButton>
                    </div>
        <!--<div id="divDetalleDamage" class="collapsibleContent" style="width: 806px">
                    
                    script type="text/javascript">
                               document.write('<iframe frameborder="0" id="iframeDetalle" src="vRegistroBienesAfectados.aspx?AjusteId=<%=qStringAjusteId %>" scrolling="auto" style="border-style:none; width:806px;height:480px;"></iframe>') 
                    </script

                </div>-->
        <br />
        <div>
                    <asp:LinkButton ID="LinkButton2" Font-Bold="True" Font-Size="16px" runat="server"
                        OnClick="LinkButton2_Click">De La Póliza</asp:LinkButton></div>
        <!-- div id="divPoliza" class="collapsibleContent">

                    <script type="text/javascript">
                               //document.write('<iframe frameborder="0" id="iframePolizasAsociadas" src="vEditorPolizaAjuste.aspx?AjusteId=" scrolling="auto" style="border-style:none; width:835px;height:560px;"></iframe>') 
                    </script>

                </div -->
        <br />
        <div>
          <asp:Label Style="cursor: hand; cursor: pointer;" onclick="muestraOcultaDiv(this)"
            ID="Reclamo" Font-Bold="True" Font-Size="16px" runat="server" Text="Del Reclamo"></asp:Label>
        </div>
        <div id="divReclamo" class="collapsibleContent" style="width: 804px">
          &nbsp;<asp:FormView ID="FormViewReclamo" runat="server" DataSourceID="odsReclamo"
            DefaultMode="Edit" Width="796px">
            <EditItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="DataTable" width="725">
                <tr>
                                    <td width="5">
                                        &nbsp;
                                    </td>
                                    <td width="227">
                                        &nbsp;
                                    </td>
                                    <td style="width: 98px">
                                        &nbsp;
                                    </td>
                                    <td width="235">
                                        &nbsp;
                                    </td>
                </tr>
                <tr>
                                    <td style="height: 34px" width="5">
                                        &nbsp;
                                    </td>
                  <td colspan="2" style="height: 34px">
                    <table border="0" cellpadding="0" cellspacing="0" width="642">
                      <tr>
                        <td height="20" style="width: 170px">
                                                    Reclamo del Asegurado
                                                </td>
                        <td colspan="3" height="20" style="width: 481px">
                          <asp:DropDownList ID="cbxMonedaReclamo" runat="server" CssClass="FormSelect" DataSourceID="odsMoneda"
                            DataTextField="simbolo" DataValueField="monedaId" SelectedValue='<%# Bind("monedaReclamo") %>'
                            Width="47px">
                          </asp:DropDownList>
                          <asp:TextBox ID="txtReclamo" runat="server" CssClass="FormText NUMBERS" Text='<%# Bind("Reclamo") %>'
                            Width="195px"></asp:TextBox></td>
                        <td height="20" style="width: 97px">
                          &nbsp;
                          <asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.MonedaComboTableAdapter"></asp:ObjectDataSource>
                                              </td>
                      </tr>
                                      </table>
                  </td>
                                    <td style="height: 34px" width="235">
                                        &nbsp;
                                    </td>
                </tr>
                <tr>
                                    <td style="height: 2px">
                                        &nbsp;
                                  </td>
                                    <td style="height: 2px" width="227">
                                        &nbsp;
                                    </td>
                                    <td style="height: 2px; width: 98px;">
                                        &nbsp;
                                  </td>
                                    <td style="height: 2px">
                                        &nbsp;
                                  </td>
                </tr>
</table>
            </EditItemTemplate>
            <InsertItemTemplate>
              Reclamo:
              <asp:TextBox ID="ReclamoTextBox" runat="server" Text='<%# Bind("Reclamo") %>'>
              </asp:TextBox><br />
              monedaReclamo:
              <asp:TextBox ID="monedaReclamoTextBox" runat="server" Text='<%# Bind("monedaReclamo") %>'>
              </asp:TextBox><br />
              <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
              </asp:LinkButton>
              <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
              </asp:LinkButton>
            </InsertItemTemplate>
          </asp:FormView>
          <asp:ObjectDataSource ID="odsReclamo" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsRegistroBasicoTableAdapters.ReclamoTableAdapter"
            UpdateMethod="Update">
            <UpdateParameters>
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
              <asp:Parameter Name="reclamo" Type="String" />
              <asp:Parameter Name="monedareclamo" Type="Decimal" />
            </UpdateParameters>
            <SelectParameters>
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
          </asp:ObjectDataSource>
        </div>
        <br />
        <div>
          <asp:Label Style="cursor: hand; cursor: pointer;" onclick="muestraOcultaDiv(this)"
            ID="InformacionComplementaria" Font-Bold="true" Font-Size="16px" runat="server"
            Text="Información Complementaria">
          </asp:Label>
        </div>
        <div id="divInformacionComplementaria" class="collapsibleContent">
          <asp:FormView ID="FormViewInformacionComplementaria" runat="server" DataSourceID="odsInformacionComplementaria"
            DefaultMode="Edit">
            <EditItemTemplate>
                          <table border="0" cellpadding="0" cellspacing="0" class="DataTable" width="827">
                <tr>
                                    <td width="4">
                                        &nbsp;
                                    </td>
                                    <td width="226">
                                        &nbsp;
                                    </td>
                                    <td width="638">
                                        &nbsp;
                                    </td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                                    </td>
                  <td colspan="2">
                    <table border="0" cellpadding="0" cellspacing="0" width="709">
                      <tr>
                                                <td style="width: 204px" >
                          Reserva Estimada</td>
                        <td colspan="3" style="width: 270px">
                          <asp:DropDownList ID="cbxMonedaReserva" runat="server" CssClass="FormSelect" DataSourceID="odsMoneda"
                            DataTextField="simbolo" DataValueField="monedaId" SelectedValue='<%# Bind("monedaReserva") %>'
                                                        Width="48px">
                                                    </asp:DropDownList>
                          <asp:TextBox ID="txtReservaEstimada" runat="server" CssClass="FormText NUMBERS" Text='<%# Bind("Reserva") %>'
                            Width="195px"></asp:TextBox></td>
                        <td width="238">
                                                    <asp:Button ID="Button1" runat="server" CssClass="FormText" Text="Agregar Subtítulos"
                                                        Width="150px" OnClick="Button1_Click" />
                                              <asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
                                                        SelectMethod="GetData" TypeName="dsComboTableAdapters.MonedaComboTableAdapter"></asp:ObjectDataSource>
                                                </td>
                      </tr>
                                        </table>
                                    </td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                                    </td>
                  <td valign="top" width="226">
                                        Situaci&oacute;n del Siniestro
                                    </td>
                                    <td  valign="top">
                    <asp:TextBox ID="txtSituacionSiniestro" runat="server" CssClass="FormText" Height="70px"
                      Text='<%# Bind("situacionajuste") %>' TextMode="MultiLine" Width="560px"></asp:TextBox></td>
                </tr>
                <tr>
                                    <td width="4">
                                        &nbsp;
                                    </td>
                                    <td  valign="top" width="226">
                                        Verificaci&oacute;n de Garant&iacute;as
                                    </td>
                                    <td  valign="top">
                    <asp:TextBox ID="txtVerificacion" runat="server" CssClass="FormText" Height="70px"
                      Text='<%# Bind("verificaciongarantias") %>' TextMode="MultiLine" Width="560px"></asp:TextBox></td>
                </tr>
                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                  <td width="226">
                    SiniestrosAnteriores</td>
                  <td style="width: 638px">
                    <asp:TextBox ID="txtSiniestrosAnteriores" runat="server" CssClass="FormText" Height="70px"
                      Text='<%# Bind("siniestrosanteriores") %>' TextMode="MultiLine" Width="560px"></asp:TextBox></td>
                </tr>
                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                  <td>
                                        Salvamento y/o Recupero
                                    </td>
                                    <td >
                    <asp:TextBox ID="txtSalvamento" runat="server" CssClass="FormText" Height="70px"
                      Text='<%# Bind("salvamentoyrecupero") %>' TextMode="MultiLine" Width="560px"></asp:TextBox></td>
                </tr>
                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                  <td>
                                        Opini&oacute;n del Ajustador
                                    </td>
                                    <td >
                    <asp:TextBox ID="txtOpinionAjustador" runat="server" CssClass="FormText" Height="70px"
                      Text='<%# Bind("opinionAjustador") %>' TextMode="MultiLine" Width="560px"></asp:TextBox></td>
                </tr>
                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                  <td>
                    Recomendaciones</td>
                                    <td >
                    <asp:TextBox ID="txtRecomendaciones" runat="server" CssClass="FormText" Height="70px"
                      Text='<%# Bind("recomendaciones") %>' TextMode="MultiLine" Width="560px"></asp:TextBox></td>
                </tr>
                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                </tr>
              </table>
            </EditItemTemplate>
            <InsertItemTemplate>
              Reserva:
              <asp:TextBox ID="ReservaTextBox" runat="server" Text='<%# Bind("Reserva") %>'>
              </asp:TextBox><br />
              monedaReserva:
              <asp:TextBox ID="monedaReservaTextBox" runat="server" Text='<%# Bind("monedaReserva") %>'>
              </asp:TextBox><br />
              situacionajuste:
              <asp:TextBox ID="situacionajusteTextBox" runat="server" Text='<%# Bind("situacionajuste") %>'>
              </asp:TextBox><br />
              verificaciongarantias:
              <asp:TextBox ID="verificaciongarantiasTextBox" runat="server" Text='<%# Bind("verificaciongarantias") %>'>
              </asp:TextBox><br />
              siniestrosanteriores:
              <asp:TextBox ID="siniestrosanterioresTextBox" runat="server" Text='<%# Bind("siniestrosanteriores") %>'>
              </asp:TextBox><br />
              salvamentoyrecupero:
              <asp:TextBox ID="salvamentoyrecuperoTextBox" runat="server" Text='<%# Bind("salvamentoyrecupero") %>'>
              </asp:TextBox><br />
              opinionAjustador:
              <asp:TextBox ID="opinionAjustadorTextBox" runat="server" Text='<%# Bind("opinionAjustador") %>'>
              </asp:TextBox><br />
              recomendaciones:
              <asp:TextBox ID="recomendacionesTextBox" runat="server" Text='<%# Bind("recomendaciones") %>'>
              </asp:TextBox><br />
              <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
              </asp:LinkButton>
              <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
              </asp:LinkButton>
            </InsertItemTemplate>
          </asp:FormView>
          <asp:ObjectDataSource ID="odsInformacionComplementaria" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsRegistroBasicoTableAdapters.InformacionComplementariaTableAdapter"
            UpdateMethod="Update">
            <UpdateParameters>
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
              <asp:Parameter Name="reserva" Type="String" />
              <asp:Parameter Name="monedareserva" Type="Decimal" />
              <asp:Parameter Name="situacionajuste" Type="String" />
              <asp:Parameter Name="verificaciongarantias" Type="String" />
              <asp:Parameter Name="siniestrosanteriores" Type="String" />
              <asp:Parameter Name="salvamentoyrecupero" Type="String" />
              <asp:Parameter Name="opinionAjustador" Type="String" />
              <asp:Parameter Name="recomendaciones" Type="String" />
            </UpdateParameters>
            <SelectParameters>
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
          </asp:ObjectDataSource>
        </div>
        <br />
        <!-- fin seccion de divs collapsibles -->
      </div>
      <br />
      <div style="background-color: #3785B9; padding: 10px; height: 20px;">
        <asp:ImageButton ID="ImageButton1" runat="server" OnClick="ImageButton1_Click" ImageUrl="~/imgRGen/btnSave.gif" />&nbsp;
        <asp:HyperLink ID="generarHyperLink" runat="server" ImageUrl="images/IconApprove48.jpg">Generar Informe</asp:HyperLink>&nbsp;
        <asp:HyperLink ID="observarHyperLink" runat="server" ImageUrl="~/images/IconReject48.gif">Generar Informe Observado</asp:HyperLink>
        <asp:HyperLink ID="hlnlVistaPrevia" runat="server" ImageUrl="~/images/IconPreviewInfomr.jpg"
          NavigateUrl="~/vVistaPreviaInforme.aspx" Target="_blank">Vista Previa</asp:HyperLink>
        <asp:HyperLink ID="hlnVistaPreviaPdf" runat="server" ImageUrl="~/images/IconPreviewInformPDF.jpg"
          NavigateUrl="~/vVistaPreviaInforme.aspx">Vista Previa</asp:HyperLink></div>
    </div>
  </form>
</body>
</html>
