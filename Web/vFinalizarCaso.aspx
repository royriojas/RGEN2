<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vFinalizarCaso.aspx.cs" Inherits="vFinalizarCaso" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Finalizar Caso de Ajuste</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="Scripts/calendar/calendar-blue2.css" />

  <script type='text/javascript' src="Scripts/lib/x_core.js"></script>

  <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>

  <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_textBoxFunctions.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/xCaseOperations.js"></script>

  <script type="text/javascript">
    
    function closepnlConfirmacion() {
            $('pnlConfirmacion').style.display = 'none';
    }
    
    function closeThisPopWindow() {
         window.top.hidePopWin(true,true);
    }
    
    function cierraLaVentana() {
       setTimeout('closeThisPopWindow()',1000);
    }
    
  </script>

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

  <script type="text/javascript" language="javascript" src="Scripts/calendar/calendar-setup.js"></script>

</head>
<body>
  <form id="formRegistroObservaciones" runat="server">
    <div class="DataTop">
      <div class="DataTopLeft">
      </div>
      <div class="DataTopRight">
      </div>
    </div>
    <div class="DataContent">
      <div id="contenidoTotal" runat="server" style="margin-left: auto; margin-right: auto;
        position: relative;">
        <div class="DataContentRight" style="padding: 1%">
          <div class="PanelEncabezado" style="height: 30px;">
            <asp:Label ID="Label1" Style="margin: 5px;" runat="server" Text="Finalización de Caso de Ajuste"
              Font-Bold="True" Font-Size="18px"></asp:Label>
          </div>
          <div class="hr">
          </div>
          <div style="position: relative">
            <div id="ContenidoObservaciones" style="margin: 5px;">
              <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
                <tr>
                  <td width="10">
                  </td>
                  <td width="120">
                  </td>
                  <td width="200">
                  </td>
                  <td width="10">
                  </td>
                </tr>
                <tr>
                  <td>
                    &nbsp;</td>
                  <td width="120" height="20">
                    Comentario<asp:RequiredFieldValidator ID="observacionRFV" runat="server" ControlToValidate="comentarioTextBox"
                      ErrorMessage="Ingrese una una comentario" Font-Bold="True" Font-Size="9px">(*)</asp:RequiredFieldValidator></td>
                  <td height="20" colspan="1">
                    <span style="width: 314px">
                      <asp:TextBox ID="comentarioTextBox" runat="server" CssClass="FormText MAYUSC" TextMode="MultiLine"
                        Width="500px" Height="70px"></asp:TextBox></span></td>
                  <td>
                    &nbsp;</td>
                </tr>
                <tr>
                  <td>
                    &nbsp;</td>
                  <td width="120">
                    &nbsp;</td>
                  <td>
                    &nbsp;</td>
                  <td>
                  </td>
                </tr>
                <tr>
                  <td style="height: 17px">
                  </td>
                  <td colspan="2" style="height: 17px">
                    Constancia de recepción de informe final</td>
                  <td style="height: 17px">
                  </td>
                </tr>
                <tr>
                  <td style="height: 17px">
                  </td>
                  <td style="height: 17px">
                    Imagen</td>
                  <td style="height: 17px">
                    <asp:FileUpload ID="constanciaFileUpload" runat="server" Width="500px" CssClass="FormText" /></td>
                  <td style="height: 17px">
                  </td>
                </tr>
                <tr>
                  <td style="height: 17px">
                  </td>
                  <td style="height: 17px">
                    Fecha recepción<asp:RequiredFieldValidator ID="frecepcionRFV" runat="server" ControlToValidate="frecepcionTextBox"
                      ErrorMessage="Ingrese la fecha de recepcion de constancia" Font-Bold="True" Font-Size="9px">(*)</asp:RequiredFieldValidator></td>
                  <td style="height: 17px">
                    <asp:TextBox ID="frecepcionTextBox" runat="server" CssClass="FormText"></asp:TextBox>
                    <button id="btnFechaEliminacion" class="FormButton" style="width: 17px; height: 17px"
                      tabindex="33" type="button">
                      <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                        width="16" /></button>

                    <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'frecepcionTextBox',
                                                                        ifFormat       :    '%d/%m/%Y',
                                                                        button         :    'btnFechaEliminacion',
                                                                        showsTime      :    true,
                                                                        timeFormat     :    '24',
                                                                        singleClick    :    false
                                                                       
                                                                    }); 
                                                                                                                                                            
                                                                    
                    </script>

                  </td>
                  <td style="height: 17px">
                  </td>
                </tr>
                <tr>
                  <td style="height: 17px">
                    &nbsp;</td>
                  <td style="height: 17px">
                    &nbsp;</td>
                  <td style="height: 17px">
                    <span style="width: 605px; height: 18px;">&nbsp;
                      <asp:Panel ID="pnlConfirmacion" runat="server" BackColor="#FF8000" BorderColor="Red"
                        Height="36px" Style="z-index: 450; left: 261px; position: absolute; top: 154px;
                        text-align: center" Visible="False" Width="363px">
                        <div style="padding-top: 5px">
                          <asp:Label ID="lblMensaje" runat="server" Font-Bold="True" Font-Size="10px" ForeColor="White"
                            Text="El Caso de Ajuste ha sido Actualizado" Width="286px"></asp:Label>&nbsp;</div>
                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/btnClose.jpg" onclick="closepnlConfirmacion();"
                          Style="left: 344px; cursor: pointer; position: absolute; top: 5px" />
                      </asp:Panel>
                    </span>
                  </td>
                  <td style="height: 17px">
                  </td>
                </tr>
                <tr>
                  <td style="height: 17px">
                  </td>
                  <td style="height: 17px">
                  </td>
                  <td style="height: 17px">
                    <asp:Button ID="finalizarButton" runat="server" CssClass="FormButton" Text="Finalizar ajuste"
                      OnClick="finalizarButton_Click" /></td>
                  <td style="height: 17px">
                  </td>
                </tr>
                <tr>
                  <td>
                    &nbsp;</td>
                  <td>
                    &nbsp;</td>
                  <td>
                    &nbsp;</td>
                  <td>
                  </td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </div>
      <asp:Panel Style="margin-left: auto; margin-right: auto; position: relative; text-align: center;
        background-color: Red; padding: 5px; left: 0px; top: 0px;" ID="pnlError" runat="server"
        Height="" HorizontalAlign="Center" Width="334px" Visible="False">
        <asp:Image ID="Image1" runat="server" Style="float: left;" ImageUrl="~/imgRGen/important.jpg" />
        <asp:Label ID="lblError" runat="server" Font-Bold="True" Text='Sólo Se Puede Finalizar los casos de Ajuste cuyo estado es "Con Informe Final"'
          Height="14px" Visible="False" Width="281px"></asp:Label>
        <div style="clear: both">
        </div>
        <br />
        <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" Font-Underline="true" OnClientClick="window.parent.hidePopWin(true);return false;">Cerrar Ventana</asp:LinkButton></asp:Panel>
    </div>
    <div class="DataBottom">
      <div class="DataBottomLeft">
      </div>
      <div class="DataBottomRight">
      </div>
    </div>
    <asp:ValidationSummary ID="finalizarCasoVS" runat="server" ShowMessageBox="True"
      ShowSummary="False" />
  </form>
</body>
</html>
