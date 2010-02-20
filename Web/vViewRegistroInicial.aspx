<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vViewRegistroInicial.aspx.cs" Culture="es-PE" UICulture="es-PE" Inherits="vViewRegistroInicial" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>

<%@ Register TagPrefix="Custom" Namespace="ASB" Assembly="AutoSuggestBox" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Riesgos Generales | Registro Inicial Del Ajuste</title>

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_core.js" language="javascript"></script>

  <script type="text/javascript" src="Scripts/lib/x_dom.js" language="javascript"></script>

  <script type="text/javascript" src="Scripts/lib/x_event.js" language="javascript"></script>
  
  <script type="text/javascript" src="Scripts/lib/xCaseOperations.js" language="javascript"></script>

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
window.onload = function ()
{
    arregloDivs = xGetElementsByClassName('collapsibleContent',null,'div',null);
    //muestraOcultaTodo();
}
function muestraOcultaTodo()
{
    for (i= 0; i < arregloDivs.length; i++)
    {
        divDummy = arregloDivs[i];
        var diplayAll = divDummy.style.display == "none";
        divDummy.style.display = (diplayAll)?"block":"none";
    }
}
function muestraOcultaDiv(element)
{
    var identificadorElemento = element.id;
    var divDummy = xGetElementById('div'+identificadorElemento);
    var diplayAll = divDummy.style.display == "none";
    divDummy.style.display = (diplayAll)?"block":"none";
}
function GenerarInforme(ajusteId, observado)
{
    window.top.showPopWin('generarStatus.aspx?ajusteId='+ajusteId+'&tipoInforme=B&observado='+observado, 229, 75, null);
}

  </script>

  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-image: none; background-color: #3785B9;">
  <form id="form2" runat="server">
    <div style="margin-left: auto; margin-right: auto; position: relative;">
      <div style="background-color: #3785B9; padding: 10px;">
        <!-- seccion de divs collapsibles -->
        <div style="margin-bottom: 5px;">
          <asp:Label Style="cursor: hand; cursor: pointer;" onclick="muestraOcultaDiv(this)"
            ID="DatosGenerales" Font-Bold="True" Font-Size="18px" runat="server" Text="Registro Inicial"></asp:Label>
        </div>
      </div>
      <asp:FormView ID="FormView1" runat="server" DataSourceID="sdsRegistroInicial"
        Height="663px" OnDataBound="FormView1_DataBound" 
        PagerStyle-HorizontalAlign="Left" RowStyle-VerticalAlign="Top">
        <ItemTemplate>
          <div>
            <div id="notificacion" style="margin-left: 10px;">
              <table border="0" cellpadding="0" cellspacing="0" class="DataTable" width="855">
                <tr>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="194">
                    &nbsp;
                  </td>
                  <td width="202">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    &nbsp;
                  </td>
                  <td width="200">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20" width="20">
                    &nbsp;
                  </td>
                  <td>
                    Quien notific&oacute;
                  </td>
                  <td>
                    <asp:DropDownList ID="cbxQuienNotifico" runat="server" CssClass="FormText" SelectedValue='<%# Bind("quiennotifico") %>'
                      TabIndex="1" Width="200px" Enabled="False">
                      <asp:ListItem Value="Cia Seguros">Compa&#241;&#236;a Seguros</asp:ListItem>
                      <asp:ListItem>Broker</asp:ListItem>
                      <asp:ListItem>Asegurado</asp:ListItem>
                      <asp:ListItem>Otro</asp:ListItem>
                    </asp:DropDownList></td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    Nombre Notificante
                  </td>
                  <td width="200">
                    <asp:TextBox ID="txtNotificante" runat="server" CssClass="FormText" TabIndex="2"
                      Text='<%# Bind("NombreDelNotificante") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20" width="20">
                    &nbsp;
                  </td>
                  <td>
                    Medio de Notificacion
                  </td>
                  <td>
                    <asp:DropDownList ID="cbxTipoComunicacion" runat="server" CssClass="FormText" DataSourceID="odsTipoComunicacion"
                      DataTextField="nombre" DataValueField="tcomunicacionId" SelectedValue='<%# Bind("medionotificacionId") %>'
                      TabIndex="3" Width="200px" Enabled="False">
                    </asp:DropDownList>
                    <asp:ObjectDataSource ID="odsTipoComunicacion" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoComunicacionTableAdapter">
                    </asp:ObjectDataSource>
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    Fecha y Hora
                  </td>
                  <td width="200">
                    <table border="0" cellpadding="0" cellspacing="0" width="200">
                      <tr>
                        <td width="190">
                          <span style="width: 83%">
                            <asp:TextBox ID="txtFechaHoraAviso" runat="server" CssClass="FormText" TabIndex="4"
                              Text='<%# Bind("faviso") %>' Width="195px" ReadOnly="True"></asp:TextBox>
                          </span>
                        </td>
                        <td style="width: 10px">

                        </td>
                      </tr>
                    </table>
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
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
              <div class="hr">
              </div>
            </div>
            <div id="confirmacion" runat="server" style="margin-left: 10px;">
              <table border="0" cellpadding="0" cellspacing="0" class="DataTable" width="855">
                <tr>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="194">
                    &nbsp;
                  </td>
                  <td width="202">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    &nbsp;
                  </td>
                  <td width="200">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20" width="20">
                    &nbsp;
                  </td>
                  <td>
                    Quien Confirmó (Aseguradora)</td>
                  <td>
                    <asp:TextBox ID="txtNombreConfirmante" runat="server" CssClass="FormText" TabIndex="5"
                      Text='<%# Bind("nombrequienconfirma") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    Cargo Confirmante
                  </td>
                  <td width="200">
                    <asp:TextBox ID="txtPuesto" runat="server" CssClass="FormText" TabIndex="6" Text='<%# Bind("cargoconfirmante") %>'
                      Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20" width="20">
                    &nbsp;
                  </td>
                  <td>
                    Medio de Confirmaci&oacute;n
                  </td>
                  <td>
                    <span style="height: 20px">
                      <asp:DropDownList ID="cbxTipoComunicacionConfirmacion" runat="server" CssClass="FormText"
                        DataSourceID="odsTipoComunicacion" DataTextField="nombre" DataValueField="tcomunicacionId"
                        SelectedValue='<%# Bind("medioconfirmacionid") %>' TabIndex="7" Width="200px" Enabled="False">
                      </asp:DropDownList>
                    </span>
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    Fecha y Hora
                  </td>
                  <td width="200">
                    <table border="0" cellpadding="0" cellspacing="0" width="200">
                      <tr>
                        <td width="190">
                          <asp:TextBox ID="txtFechaConfirmacion" runat="server" CssClass="FormText" TabIndex="8"
                            Text='<%# Bind("fechayhoraconfirmacion") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                        <td width="10">
                        </td>

                          <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'FormView1$txtFechaConfirmacion',
                                                                        ifFormat       :    '%d/%m/%Y %H:%M',
                                                                        button         :    'btnFechaConfirmacion',
                                                                        showsTime      :    true,
                                                                        timeFormat     :    '24',
                                                                        singleClick    :    false
                                                                    }); 
                          </script>
                      </tr>
                    </table>
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                </tr>
              </table>
              <div class="hr">
              </div>
            </div>
            <div style="margin-left: 10px;">
              <table border="0" cellpadding="0" cellspacing="0" class="DataTable" width="855">
                <tr>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="194">
                    &nbsp;
                  </td>
                  <td style="width: 202px">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    &nbsp;
                  </td>
                  <td width="200">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20" width="20">
                    &nbsp;
                  </td>
                  <td>
                    Aseguradora</td>
                  <td style="width: 202px">
                    <asp:DropDownList ID="cbxCiaSeguros" runat="server" CssClass="FormText" DataSourceID="odsCiaSeguros"
                      DataTextField="persona" DataValueField="personaid" SelectedValue='<%# Bind("aseguradoraid") %>'
                      TabIndex="9" Width="200px" Enabled="False">
                    </asp:DropDownList>
                    <asp:ObjectDataSource ID="odsCiaSeguros" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter"></asp:ObjectDataSource>
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    Broker</td>
                  <td width="200">
                    <asp:DropDownList ID="cbxCorredorSeguros" runat="server" CssClass="FormText" DataSourceID="odsBroker"
                      DataTextField="persona" DataValueField="personaId" SelectedValue='<%# Bind("brokerid") %>'
                      TabIndex="10" Width="200px" Enabled="False">
                    </asp:DropDownList><asp:ObjectDataSource ID="odsBroker" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="dsComboTableAdapters.BrokerComboTableAdapter"></asp:ObjectDataSource>
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td style="height: 20px" width="20">
                  </td>
                  <td style="height: 20px">
                    Responsable</td>
                  <td style="width: 202px; height: 20px;">
                    <asp:TextBox ID="txtContactoCiaSeguros" runat="server" CssClass="FormText" TabIndex="11"
                      Text='<%# Bind("nombreresponsable") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="height: 20px" width="20">
                  </td>
                  <td style="height: 20px" width="199">
                    Responsable</td>
                  <td style="height: 20px" width="200">
                    <asp:TextBox ID="txtContactoCorredor" runat="server" CssClass="FormText" TabIndex="12"
                      Text='<%# Bind("nombreresponsablebroker") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="height: 20px" width="20">
                  </td>
                </tr>
                <tr>
                  <td style="height: 20px" width="20">
                  </td>
                  <td style="height: 20px">
                    Teléfono Responsable</td>
                  <td style="width: 202px; height: 20px;">
                    <asp:TextBox ID="txtTelefonoContactoCia" runat="server" CssClass="FormText" TabIndex="13"
                      Text='<%# Bind("telefonoresponsable") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="height: 20px" width="20">
                  </td>
                  <td style="height: 20px" width="199">
                    Teléfono Responsable</td>
                  <td style="height: 20px" width="200">
                    <asp:TextBox ID="txtTelefonoContactoCorredor" runat="server" CssClass="FormText"
                      TabIndex="14" Text='<%# Bind("telefonoresponsablebroker") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="height: 20px" width="20">
                  </td>
                </tr>
                <tr>
                  <td style="height: 20px" width="20">
                    &nbsp;
                  </td>
                  <td style="height: 20px">
                    Correo Electrónico</td>
                  <td style="width: 202px; height: 20px;">
                    <asp:TextBox ID="txtEmailContactoCia" runat="server" CssClass="FormText" TabIndex="15"
                      Text='<%# Bind("emailresponsable") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="height: 20px" width="20">
                    &nbsp;
                  </td>
                  <td style="height: 20px" width="199">
                    Correo Electrónico</td>
                  <td style="height: 20px" width="200">
                    <asp:TextBox ID="txtEmailContactoCorredor" runat="server" CssClass="FormText" TabIndex="16"
                      Text='<%# Bind("emailresponsablebroker") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="height: 20px" width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20">
                    &nbsp;
                  </td>
                  <td>
                    N&ordm; de P&oacute;liza
                  </td>
                  <td style="width: 202px">
                    <table border="0" cellpadding="0" cellspacing="0" width="200">
                      <tr>
                        <td colspan="2" style="height: 17px">
                          <asp:TextBox ID="txtNumPoliza" runat="server" BorderColor="#C04000" CssClass="FormText"
                            onclick="this.blur();" onfocus="this.blur();" TabIndex="17" Text='<%# Bind("numeroPoliza") %>'
                            Width="195px" ReadOnly="True"></asp:TextBox></td>
                      </tr>
                    </table>
                  </td>
                  <td>
                    &nbsp;
                  </td>
                  <td>
                    N&ordm; de Siniestro</td>
                  <td>
                    <asp:TextBox ID="txtNumeroSiniestro" runat="server" CssClass="FormText" TabIndex="19"
                      Text='<%# Bind("numerosiniestroCia") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td>
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px; width: 202px;">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                </tr>
              </table>
              <div class="hr">
              </div>
            </div>
            <div id="AseguradoSiniestro" style="margin-left: 10px; z-index: 300;">
              <table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="z-index: 302"
                width="855">
                <tr>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="194">
                    &nbsp;
                  </td>
                  <td width="202">
                    &nbsp;
                  </td>
                  <td style="width: 20px">
                    &nbsp;
                  </td>
                  <td width="199">
                    &nbsp;
                  </td>
                  <td width="200">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20" width="20">
                    &nbsp;
                  </td>
                  <td>
                    Contratante</td>
                  <td>
                    <asp:TextBox ID="txtContratante" runat="server" BorderColor="#C04000" CssClass="FormText"
                      onclick="this.blur();" onfocus="this.blur();" TabIndex="20" Text='<%# Bind("contratante") %>'
                      Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="width: 20px">
                    &nbsp;
                  </td>
                  <td width="199">
                    Persona de Contacto</td>
                  <td width="200">
                    <asp:TextBox ID="txtContactoPersona" runat="server" CssClass="FormText" TabIndex="21"
                      Text='<%# Bind("nombreresponsablesiniestro") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td style="height: 20px" width="20">
                    &nbsp;
                  </td>
                  <td style="height: 20px">
                    Asegurado</td>
                  <td style="height: 20px">
                    <asp:TextBox ID="txtPersonaAsegurada" runat="server" BorderColor="#C04000" CssClass="FormText"
                      onclick="this.blur();" onfocus="this.blur();" TabIndex="22" Text='<%# Bind("asegurado") %>'
                      Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="width: 20px; height: 20px;">
                    &nbsp;
                  </td>
                  <td style="height: 20px" width="199">
                    Teléfono</td>
                  <td style="height: 20px" width="200">
                    <asp:TextBox ID="txtTelefonoContacto" runat="server" CssClass="FormText" TabIndex="23"
                      Text='<%# Bind("telefonoresponsablesiniestro") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="height: 20px" width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20">
                    &nbsp;
                  </td>
                  <td>
                    Fecha y Hora del Siniestro&nbsp;</td>
                  <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="200">
                      <tr>
                        <td width="190">
                          <asp:TextBox ID="txtFechaHoraSiniestro" runat="server" CssClass="FormText" TabIndex="24"
                            Text='<%# Bind("fsiniestro") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                        <td style="width: 10px">

                        </td>
                      </tr>
                    </table>
                  </td>
                  <td style="width: 20px">
                    &nbsp;
                  </td>
                  <td>
                    Correo Electrónico</td>
                  <td>
                    <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="FormText" TabIndex="25"
                      Text='<%# Bind("emailresponsablesiniestro") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td>
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="20" style="height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    Lugar del Siniestro</td>
                  <td style="height: 13px">
                    <asp:TextBox ID="txtLugarDelSiniestro" runat="server" CssClass="FormText" TabIndex="26"
                      Text='<%# Bind("lugarsiniestro") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="width: 20px; height: 13px">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                    Descripci&oacute;n del Siniestro</td>
                  <td style="height: 13px">
                    <asp:TextBox ID="txtTipoSiniestroId" runat="server" Style="display: none;" Text='<%# Eval("tiposiniestroId") %>'
                      Width="27px"></asp:TextBox>&nbsp;
                    <asp:TextBox ID="txtRamoId" runat="server" Style="display: none;" Text='<%# Eval("RamoId") %>'
                      Width="37px"></asp:TextBox></td>
                  <td style="height: 13px">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td style="height: 13px">
                  </td>
                  <td style="height: 13px">
                    Distrito - Prov. - Dpto.</td>
                  <td style="height: 13px">
                    <custom:autosuggestbox id="txtDatoUbigeo" runat="server" cssclass="FormText" datatype="Distrito"
                      includemoremenuitem="False" keypressdelay="300" maxsuggestchars="18" menucssclass="asbMenu"
                      menuitemcssclass="asbMenuItem" moremenuitemlabel="..." nummenuitems="10" resourcesdir="./asb_includes"
                      selectedvalue='<%# Bind("ubigeo") %>' selmenuitemcssclass="asbSelMenuItem" style="z-index: 300"
                      tabindex="27" text='<%# Eval("distrito") %>' useiframe="True" width="195px" ReadOnly="True"></custom:autosuggestbox>
                  </td>
                  <td style="width: 20px; height: 13px">
                  </td>
                  <td colspan="2" rowspan="3">
                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Height="40px"
                      TabIndex="30" Text='<%# Bind("descripcion") %>' TextMode="MultiLine" Width="392px" ReadOnly="True"></asp:TextBox>
                    <asp:SqlDataSource ID="sdsTiposDeSiniestroByRamoId" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                      SelectCommand="sp_rgnx_selectTipoSiniestroByRamoId" SelectCommandType="StoredProcedure">
                      <SelectParameters>
                        <asp:ControlParameter ControlID="txtRamoId" Name="ramoId" PropertyName="Text" Type="Decimal" />
                      </SelectParameters>
                    </asp:SqlDataSource>
                  </td>
                  <td style="height: 13px">
                  </td>
                </tr>
                <tr>
                  <td height="20" style="height: 13px">
                  </td>
                  <td style="height: 13px">
                    Ramo Afectado</td>
                  <td style="height: 13px">
                    <asp:TextBox ID="txtRamoAfectado" runat="server" BorderColor="#C04000" CssClass="FormText"
                      onclick="this.blur();" onfocus="this.blur();" TabIndex="28" Text='<%# Bind("RamoAfectado") %>'
                      Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="width: 20px; height: 13px">
                  </td>
                  <td style="height: 13px">
                  </td>
                </tr>
                <tr>
                  <td height="20" style="height: 13px">
                  </td>
                  <td style="height: 13px">
                    Tipo de Siniestro</td>
                  <td style="height: 13px">
                    <asp:DropDownList ID="cbxTipoSiniestro" runat="server" CssClass="FormSelect" DataSourceID="sdsTiposDeSiniestroByRamoId"
                      DataTextField="tipoSiniestro" DataValueField="tipoSiniestroId" Width="200px" Enabled="False">
                    </asp:DropDownList>
                  </td>
                  <td style="width: 20px; height: 13px">
                  </td>
                  <td style="height: 13px">
                  </td>
                </tr>
                <tr>
                  <td style="height: 13px">
                  </td>
                  <td style="height: 13px">
                  </td>
                  <td style="height: 13px">
                  </td>
                  <td style="width: 20px; height: 13px">
                  </td>
                  <td style="height: 13px">
                    <asp:Button ID="btnFillTiposSiniestro" runat="server" OnClick="btnFillTiposSiniestro_Click"
                      Style="display: none" Text="Button" /><asp:TextBox ID="TextBox1" runat="server" onblur="fillCbxTipoSiniestro();"
                        Style="display: none"></asp:TextBox></td>
                  <td style="height: 13px">
                  </td>
                  <td style="height: 13px">
                  </td>
                </tr>
              </table>
              <div class="hr">
              </div>
            </div>
            <div id="Div2" style="margin-left: 10px; z-index: 1;">
              <table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="font-family: Verdana"
                width="855">
                <tr>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="194">
                    &nbsp;
                  </td>
                  <td style="width: 202px">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                  <td width="199">
                    &nbsp;
                  </td>
                  <td width="200">
                    &nbsp;
                  </td>
                  <td width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td width="20" style="height: 55px">
                    &nbsp;
                  </td>
                  <td style="height: 55px">
                    Ejecutivo de Ajuste</td>
                  <td style="height: 55px; width: 202px;">
                    <asp:DropDownList ID="cbxAjustador" runat="server" CssClass="FormText" DataSourceID="odsAjustador"
                      DataTextField="persona" DataValueField="personaid" SelectedValue='<%# Bind("ajustadorid") %>'
                      TabIndex="31" Width="200px" Enabled="False">
                    </asp:DropDownList><asp:ObjectDataSource ID="odsAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="dsComboTableAdapters.AjustadorComboTableAdapter">
                    </asp:ObjectDataSource>
                  </td>
                  <td width="20" style="height: 55px">
                    &nbsp;
                  </td>
                  <td width="199" style="height: 55px">
                    Tipo de Ajuste
                  </td>
                  <td width="200" style="height: 55px">
                    <asp:DropDownList ID="cbxTipoAjuste" runat="server" CssClass="FormText" DataSourceID="odsTipoAjuste"
                      DataTextField="tajuste" DataValueField="tajusteid" SelectedValue='<%# Bind("tajusteid") %>'
                      TabIndex="32" Width="200px" Enabled="False">
                    </asp:DropDownList><asp:ObjectDataSource ID="odsTipoAjuste" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoAjusteComboTableAdapter">
                    </asp:ObjectDataSource>
                  </td>
                  <td width="20" style="height: 55px">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td style="height: 13px" width="20">
                    &nbsp;
                  </td>
                  <td style="height: 13px">
                  </td>
                  <td style="height: 13px; width: 202px;">
                    <span style="height: 20px">&nbsp;</span></td>
                  <td style="height: 13px" width="20">
                    &nbsp;
                  </td>
                  <td style="height: 13px" width="199">
                  </td>
                  <td style="height: 13px" width="200">
                  </td>
                  <td style="height: 13px" width="20">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td style="height: 31px">
                    &nbsp;
                  </td>
                  <td style="height: 31px">
                    Fecha y Hora en la que se Coordina la Inspección</td>
                  <td style="height: 31px; width: 202px;">
                    <table border="0" cellpadding="0" cellspacing="0" width="200">
                      <tr>
                        <td style="width: 190px; height: 18px">
                          <asp:TextBox ID="txtFechaHoraCoordinacion" runat="server" CssClass="FormText" TabIndex="33"
                            Text='<%# Bind("fechahoracoordinacion") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                        <td style="width: 10px; height: 18px">

                        </td>
                      </tr>
                    </table>
                  </td>
                  <td style="height: 31px">
                    &nbsp;
                  </td>
                  <td style="height: 31px">
                    Direccion de Inspecci&oacute;n
                  </td>
                  <td style="height: 31px">
                    <asp:TextBox ID="txtDireccionReunion" runat="server" CssClass="FormText" TabIndex="35"
                      Text='<%# Bind("lugareunion") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td style="height: 31px">
                    &nbsp;
                  </td>
                </tr>
                <tr>
                  <td height="31">
                  </td>
                  <td height="31">
                    Fecha y Hora para la que se programa la Inspección</td>
                  <td height="31" style="width: 202px">
                    <table border="0" cellpadding="0" cellspacing="0" width="200">
                      <tr>
                        <td width="190">
                          <asp:TextBox ID="txtFechaHoraReunion" runat="server" CssClass="FormText" TabIndex="34"
                            Text='<%# Bind("fechahorareunion") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                        <td style="width: 10px">

                        </td>
                      </tr>
                    </table>
                  </td>
                  <td height="31">
                  </td>
                  <td height="31">
                    Distrito-Provincia-Departamento</td>
                  <td height="31">
                    <custom:autosuggestbox id="txtDatoUbigeoInspeccion" runat="server" cssclass="FormText"
                      datatype="Distrito" height="11px" includemoremenuitem="False" keypressdelay="300"
                      maxsuggestchars="18" menucssclass="asbMenu" menuitemcssclass="asbMenuItem" moremenuitemlabel="..."
                      nummenuitems="10" resourcesdir="./asb_includes" selectedvalue='<%# Bind("ubigeoIDinspeccion") %>'
                      selmenuitemcssclass="asbSelMenuItem" tabindex="36" text='<%# Bind("distritoInspeccion") %>'
                      useiframe="False" width="195px" ReadOnly="True"></custom:autosuggestbox>
                  </td>
                  <td>
                  </td>
                </tr>
                <tr>
                  <td height="20">
                  </td>
                  <td>
                    Fecha y Hora de Realización de la Inspección</td>
                  <td style="width: 202px">
                    <table border="0" cellpadding="0" cellspacing="0" width="200">
                      <tr>
                        <td style="width: 190px; height: 18px">
                          <asp:TextBox ID="txtFechaHoraProgramacionInspeccion" runat="server" CssClass="FormText"
                            TabIndex="33" Text='<%# Bind("fechahoraprogramacion") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                        <td style="width: 10px; height: 18px">

                        </td>
                      </tr>
                    </table>
                  </td>
                  <td>
                  </td>
                  <td>
                    Referencia de la Dirección</td>
                  <td>
                    <asp:TextBox ID="txtReferenciaReunion" runat="server" CssClass="FormText" TabIndex="37"
                      Text='<%# Bind("referencia") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td>
                  </td>
                </tr>
                <tr>
                  <td height="20">
                  </td>
                  <td>
                    &nbsp;Persona de Contacto</td>
                  <td style="width: 202px">
                    <asp:TextBox ID="txtPersonaContactoInspeccion" runat="server" CssClass="FormText"
                      TabIndex="38" Text='<%# Bind("personacontacto") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td>
                  </td>
                  <td>
                    Teléfono de Contacto</td>
                  <td>
                    <asp:TextBox ID="txtTelefonoContactoInspeccion" runat="server" CssClass="FormText"
                      TabIndex="39" Text='<%# Bind("telefonopersonacontacto") %>' Width="195px" ReadOnly="True"></asp:TextBox></td>
                  <td>
                  </td>
                </tr>
                <tr>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td style="width: 202px">
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                  </td>
                  <td>
                    &nbsp;
                  </td>
                </tr>
              </table>
              <div class="hr" style="font-family: Verdana">
              </div>
            </div>
            <asp:TextBox ID="txtAjusteId" runat="server" CssClass="FormText" Style="display: none;"
              Text='<%# Bind("ajusteId") %>'></asp:TextBox>
            <asp:TextBox ID="txtPolizaId" runat="server" CssClass="FormText" Style="display: none;"
              Text='<%# Bind("polizaid") %>'></asp:TextBox>
          </div>
        </ItemTemplate>
        <EditRowStyle BorderStyle="None" BorderWidth="0px" CssClass="sinPadding" />
        <RowStyle CssClass="sinPadding" VerticalAlign="Top" />
        <PagerStyle HorizontalAlign="Left" />
      </asp:FormView>
      <asp:SqlDataSource ID="sdsRegistroInicial" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
        SelectCommand="sp_rgen_Ajuste_Total_Select" SelectCommandType="StoredProcedure"
        UpdateCommand="sp_rgen_Ajuste_Total_Update" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
          <asp:Parameter Name="ajusteid" Type="Decimal" />
          <asp:Parameter Name="quiennotifico" Type="String" />
          <asp:Parameter Name="NombreDelNotificante" Type="String" />
          <asp:Parameter Name="faviso" Type="DateTime" />
          <asp:Parameter Name="medionotificacionid" Type="Decimal" />
          <asp:Parameter Name="nombrequienconfirma" Type="String" />
          <asp:Parameter Name="fechayhoraconfirmacion" Type="DateTime" />
          <asp:Parameter Name="medioconfirmacionid" Type="Decimal" />
          <asp:Parameter Name="cargoconfirmante" Type="String" />
          <asp:Parameter Name="aseguradoraid" Type="Decimal" />
          <asp:Parameter Name="nombreresponsable" Type="String" />
          <asp:Parameter Name="telefonoresponsable" Type="String" />
          <asp:Parameter Name="emailresponsable" Type="String" />
          <asp:Parameter Name="brokerid" Type="Decimal" />
          <asp:Parameter Name="nombreresponsablebroker" Type="String" />
          <asp:Parameter Name="telefonoresponsablebroker" Type="String" />
          <asp:Parameter Name="emailresponsablebroker" Type="String" />
          <asp:Parameter Name="numerosiniestroCia" Type="String" />
          <asp:Parameter Name="fsiniestro" Type="DateTime" />
          <asp:Parameter Name="lugarsiniestro" Type="String" />
          <asp:Parameter Name="ubigeo" Type="String" />
          <asp:Parameter Name="distrito" Type="String" />
          <asp:Parameter Name="tiposiniestroId" Type="Decimal" />
          <asp:Parameter Name="nombreresponsablesiniestro" Type="String" />
          <asp:Parameter Name="telefonoresponsablesiniestro" Type="String" />
          <asp:Parameter Name="emailresponsablesiniestro" Type="String" />
          <asp:Parameter Name="descripcion" Type="String" />
          <asp:Parameter Name="polizaid" Type="Decimal" />
          <asp:Parameter Name="ajustadorid" Type="Decimal" />
          <asp:Parameter Name="fechahoracoordinacion" Type="DateTime" />
          <asp:Parameter Name="fechahoraprogramacion" Type="DateTime" />
          <asp:Parameter Name="fechahorareunion" Type="DateTime" />
          <asp:Parameter Name="ubigeoIDinspeccion" Type="String" />
          <asp:Parameter Name="distritoInspeccion" Type="String" />
          <asp:Parameter Name="personacontacto" Type="String" />
          <asp:Parameter Name="tajusteid" Type="Decimal" />
          <asp:Parameter Name="lugareunion" Type="String" />
          <asp:Parameter Name="referencia" Type="String" />
          <asp:Parameter Name="telefonopersonacontacto" Type="String" />
          <asp:Parameter Name="contratante" Type="String" />
          <asp:Parameter Name="asegurado" Type="String" />
          <asp:Parameter Name="numeroPoliza" Type="String" />
          <asp:Parameter Name="RamoAfectado" Type="String" />
        </UpdateParameters>
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
        </SelectParameters>
      </asp:SqlDataSource>
    </div>
  </form>
</body>
</html>
