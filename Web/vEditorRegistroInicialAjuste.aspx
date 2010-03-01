<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vEditorRegistroInicialAjuste.aspx.cs"
  Inherits="vEditorRegistroInicialAjuste" %>

<%@ Register TagPrefix="Custom" Namespace="ASB" Assembly="AutoSuggestBox" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Editor Registro Inicial de Ajuste</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" src="Scripts/calendar/calendar.js"></script>

  <link href="Scripts/calendar/calendar-blue2.css" rel="Stylesheet" type="text/css" />

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

  <script type="text/javascript" src="scripts/popUpWin/common.js"></script>

  <link rel="stylesheet" type="text/css" href="Scripts/popUpWin/css/style.css" />
  <link rel="stylesheet" type="text/css" href="Scripts/popUpWin/css/subModal.css" />

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_emptyTextBox.js"></script>

  <script type="text/javascript">
        
        
        function validaFechas() {
            var hubo = false;
            if (xGetElementById('FormView1_txtFechaHoraReunion').value != "") {
                if (xGetElementById('FormView1_txtFechaHoraCoordinacion').value != "") {
                    hubo = true;
                }       
                else {             
                    alert('debe Ingresar también la fecha y Hora de la coordinación de la inspección');ç
                }
            }
            else {
                hubo = true;
            }
            return hubo;
        }
        
        function closepnlMsgError() {
            $('pnlMsgError').style.display = 'none';
        }
        function closepnlConfirmacion() {
            $('pnlConfirmacion').style.display = 'none';
        }
 
		function asignarEquipoAAjuste() {
		    var NumAjuste = $('FormView1_txtAjusteId');		    
			    
	      window.top.showPopWin('vAsignarEquipoAAjuste.aspx?AjusteId=<%=qStringAjusteId%>&numAjuste='+NumAjuste.value, 620, 480, null);
		}
		
		function asignaPolizaPrincipal() {
			if (($('FormView1_txtNumPoliza').value == "Especificar Póliza" ) || ($('FormView1_txtPolizaId').value == "") ) {			
				var NumAjuste = $('FormView1_txtAjusteId');		
				var NumeroSiniestro = $('FormView1_txtNumeroSiniestro');   
				var Aseguradora = $('FormView1_cbxCiaSeguros'); 			    
				var AseguradoraNombre = Aseguradora.options[Aseguradora.selectedIndex].innerHTML;
//				alert (Aseguradora.selectedIndex);
				window.top.showPopWin('vbusquedaPoliza.aspx?AjusteId='+NumAjuste.value+'&AseguradoraId='+Aseguradora.value+
				'&AseguradoraNombre=' + AseguradoraNombre + '&IndicadorLlamada=AsignarPoliza&NumSiniestro='+NumeroSiniestro.value , 640, 480, null);
			}else {
				alert ('Este Ajuste ya tiene una poliza principal, para modificarla diríjase al Mantenimiento de Polizas');
				
			}
		}			
		
		function reload() {
			var dir = document.location.href;
			document.location.href = dir;
		}
		
		window.onload = function () {
		     
		     seteaValoresCero();
		}
		
    function noFocus(nextControl)
    {
      $(nextControl).focus();
    }
  </script>

  <style type="text/css">
    <!--
    .sinPadding {
	    margin: 0px;
	    padding: 0px;
    }
    -->
    </style>
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: #4C96C9; background-image: none; margin: 0px;">
  <div style="margin: 0px;">
    <form id="form1" runat="server">
      <div id="ContenidoPagina" style="background-color: #4C96C9;">
        <asp:FormView ID="FormView1" runat="server" DataSourceID="sdsRegistroInicial" DefaultMode="Edit"
          RowStyle-VerticalAlign="Top" PagerStyle-HorizontalAlign="Left" OnDataBound="FormView1_DataBound"
          Height="663px" OnItemUpdating="FormView1_ItemUpdating">
          <EditItemTemplate>
            <div>
              <div id="notificacion" style="margin-left: 10px;">
                <table width="855" border="0" cellpadding="0" cellspacing="0" class="DataTable">
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
                    <td width="20" height="20">
                      &nbsp;
                    </td>
                    <td>
                      Quien notific&oacute;
                    </td>
                    <td>
                      <asp:DropDownList ID="cbxQuienNotifico" runat="server" CssClass="FormText" Width="200px"
                        TabIndex="1" SelectedValue='<%# Bind("quiennotifico") %>' AppendDataBoundItems="True">
                        <asp:ListItem Value="-1">[Elija]</asp:ListItem>
                        <asp:ListItem Value="Cia Seguros" Selected="True">Compa&#241;&#236;a Seguros</asp:ListItem>
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
                      <asp:TextBox ID="txtNotificante" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="2" Text='<%# Bind("NombreDelNotificante") %>'></asp:TextBox></td>
                    <td width="20">
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td width="20" height="20">
                      &nbsp;
                    </td>
                    <td>
                      Medio de Notificacion
                    </td>
                    <td>
                      <asp:DropDownList ID="cbxTipoComunicacion" runat="server" CssClass="FormText" DataSourceID="odsTipoComunicacion"
                        DataTextField="nombre" DataValueField="tcomunicacionId" Width="200px" TabIndex="3"
                        SelectedValue='<%# Bind("medionotificacionId") %>' AppendDataBoundItems="True">
                        <asp:ListItem Selected="True" Value="-1">[Elija]</asp:ListItem>
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
                      <table width="200" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="190">
                            <span style="width: 83%">
                              <asp:TextBox ID="txtFechaHoraAviso" runat="server" CssClass="FormText" TabIndex="4"
                                Text='<%# Bind("faviso") %>' Width="160px"></asp:TextBox>
                            </span>
                          </td>
                          <td width="10">
                            <button tabindex="4" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaAviso"
                              type="button">
                              <img style="cursor: pointer;" src="img/cal.gif" width="16" height="16" border="0"
                                alt="Escoja una fecha" /></button>

                            <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'FormView1_txtFechaHoraAviso',
                                                                        ifFormat       :    '%d/%m/%Y %H:%M',
                                                                        button         :    'btnFechaAviso',
                                                                        showsTime      :    true,
                                                                        timeFormat     :    '24',
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                            </script>

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
              <div id="confirmacion" style="margin-left: 10px;" runat="server">
                <table width="855" border="0" cellpadding="0" cellspacing="0" class="DataTable">
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
                    <td width="20" height="20">
                      &nbsp;
                    </td>
                    <td>
                      Quien Confirmó (Aseguradora)</td>
                    <td>
                      <asp:TextBox ID="txtNombreConfirmante" runat="server" CssClass="FormText" TabIndex="5"
                        Width="195px" Text='<%# Bind("nombrequienconfirma") %>'></asp:TextBox></td>
                    <td width="20">
                      &nbsp;
                    </td>
                    <td width="199">
                      Cargo Confirmante
                    </td>
                    <td width="200">
                      <asp:TextBox ID="txtPuesto" runat="server" CssClass="FormText" TabIndex="6" Width="195px"
                        Text='<%# Bind("cargoconfirmante") %>'></asp:TextBox></td>
                    <td width="20">
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td width="20" height="20">
                      &nbsp;
                    </td>
                    <td>
                      Medio de Confirmaci&oacute;n
                    </td>
                    <td>
                      <span style="height: 20px">
                        <asp:DropDownList TabIndex="7" ID="cbxTipoComunicacionConfirmacion" runat="server"
                          CssClass="FormText" DataSourceID="odsTipoComunicacion" DataTextField="nombre" DataValueField="tcomunicacionId"
                          Width="200px" SelectedValue='<%# Bind("medioconfirmacionid") %>' AppendDataBoundItems="True">
                          <asp:ListItem Selected="True" Value="-1">[Elija]</asp:ListItem>
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
                      <table width="200" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="190">
                            <asp:TextBox ID="txtFechaConfirmacion" runat="server" CssClass="FormText" Width="160px"
                              TabIndex="8" Text='<%# Bind("fechayhoraconfirmacion") %>'></asp:TextBox></td>
                          <td width="10">
                            <button tabindex="8" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaConfirmacion"
                              type="button">
                              <img src="img/cal.gif" width="16" height="16" border="0" alt="Escoja una fecha" /></button>

                            <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'FormView1_txtFechaConfirmacion',
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
              <div style="margin-left: 10px;">
                <table width="855" border="0" cellpadding="0" cellspacing="0" class="DataTable">
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
                    <td width="20" height="20">
                      &nbsp;
                    </td>
                    <td>
                      Aseguradora</td>
                    <td style="width: 202px">
                      <asp:DropDownList ID="cbxCiaSeguros" runat="server" CssClass="FormText" Width="200px"
                        DataSourceID="odsCiaSeguros" DataTextField="persona" DataValueField="personaid"
                        TabIndex="9" SelectedValue='<%# Bind("aseguradoraid") %>' AppendDataBoundItems="True">
                        <asp:ListItem Selected="True" Value="-1">[Elija]</asp:ListItem>
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
                      <asp:DropDownList ID="cbxCorredorSeguros" runat="server" CssClass="FormText" Width="200px"
                        DataSourceID="odsBroker" DataTextField="persona" DataValueField="personaId" TabIndex="10"
                        SelectedValue='<%# Bind("brokerid") %>' AppendDataBoundItems="True">
                        <asp:ListItem Selected="True" Value="-1">[Elija]</asp:ListItem>
                      </asp:DropDownList><asp:ObjectDataSource ID="odsBroker" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetData" TypeName="dsComboTableAdapters.BrokerComboTableAdapter"></asp:ObjectDataSource>
                    </td>
                    <td width="20">
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td width="20" style="height: 20px">
                    </td>
                    <td style="height: 20px">
                      Responsable</td>
                    <td style="width: 202px; height: 20px;">
                      <asp:TextBox ID="txtContactoCiaSeguros" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="11" Text='<%# Bind("nombreresponsable") %>'></asp:TextBox></td>
                    <td width="20" style="height: 20px">
                    </td>
                    <td width="199" style="height: 20px">
                      Responsable</td>
                    <td width="200" style="height: 20px">
                      <asp:TextBox ID="txtContactoCorredor" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="12" Text='<%# Bind("nombreresponsablebroker") %>'></asp:TextBox></td>
                    <td width="20" style="height: 20px">
                    </td>
                  </tr>
                  <tr>
                    <td width="20" style="height: 20px">
                    </td>
                    <td style="height: 20px">
                      Teléfono Responsable</td>
                    <td style="width: 202px; height: 20px;">
                      <asp:TextBox ID="txtTelefonoContactoCia" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="13" Text='<%# Bind("telefonoresponsable") %>'></asp:TextBox></td>
                    <td width="20" style="height: 20px">
                    </td>
                    <td width="199" style="height: 20px">
                      Teléfono Responsable</td>
                    <td width="200" style="height: 20px">
                      <asp:TextBox ID="txtTelefonoContactoCorredor" runat="server" CssClass="FormText"
                        Width="195px" TabIndex="14" Text='<%# Bind("telefonoresponsablebroker") %>'></asp:TextBox></td>
                    <td width="20" style="height: 20px">
                    </td>
                  </tr>
                  <tr>
                    <td width="20" style="height: 20px">
                      &nbsp;
                    </td>
                    <td style="height: 20px">
                      Correo Electrónico</td>
                    <td style="width: 202px; height: 20px;">
                      <asp:TextBox ID="txtEmailContactoCia" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="15" Text='<%# Bind("emailresponsable") %>'></asp:TextBox></td>
                    <td width="20" style="height: 20px">
                      &nbsp;
                    </td>
                    <td width="199" style="height: 20px">
                      Correo Electrónico</td>
                    <td width="200" style="height: 20px">
                      <asp:TextBox ID="txtEmailContactoCorredor" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="16" Text='<%# Bind("emailresponsablebroker") %>'></asp:TextBox></td>
                    <td width="20" style="height: 20px">
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td height="20">
                      &nbsp;
                    </td>
                    <td>
                      N&ordm; de Siniestro</td>
                    <td style="width: 202px">
                      <asp:TextBox ID="txtNumeroSiniestro" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="19" Text='<%# Bind("numerosiniestroCia") %>'></asp:TextBox></td>
                    <td>
                      &nbsp;
                    </td>
                    <td>
                      N&ordm; de Siniestro Broker</td>
                    <td>
                      <asp:TextBox ID="txtNumeroSiniestroBroker" runat="server" CssClass="FormText" TabIndex="15"
                        Text='<%# Bind("numerosiniestrobroker") %>' Width="195px"></asp:TextBox></td>
                    <td>
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 13px">
                      &nbsp;
                    </td>
                    <td style="height: 13px">
                      Nº de P&oacute;liza &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("polizaid","~/vEditorPoliza.aspx?PolizaId={0}") %>'
                        Target="_blank">Ver Póliza</asp:HyperLink></td>
                    <td style="height: 13px; width: 202px;">
                      <table width="200" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td style="height: 17px" colspan="2">
                            <asp:TextBox ID="txtNumPoliza" Width="195px" runat="server" CssClass="FormText" TabIndex="17"
                              Text='<%# Bind("numeroPoliza") %>' BorderColor="#C04000" onclick="this.blur();"
                              onfocus="this.blur();"></asp:TextBox></td>
                        </tr>
                      </table>
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
                  <tr>
                    <td style="height: 13px">
                    </td>
                    <td style="height: 13px">
                    </td>
                    <td style="width: 202px; height: 13px">
                    </td>
                    <td style="height: 13px">
                    </td>
                    <td style="height: 13px">
                    </td>
                    <td style="height: 13px">
                    </td>
                    <td style="height: 13px">
                    </td>
                  </tr>
                </table>
                <div class="hr">
                </div>
              </div>
              <div id="Div3" style="margin-left: 10px; z-index: 300;">
                <table style="z-index: 302" width="855" border="0" cellpadding="0" cellspacing="0"
                  class="DataTable">
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
                    <td width="20" height="20">
                      &nbsp;
                    </td>
                    <td>
                      Contratante</td>
                    <td>
                      <asp:TextBox ID="txtContratante" runat="server" CssClass="FormText" TabIndex="20"
                        Width="195px" Text='<%# Bind("contratante") %>' BorderColor="#C04000" onclick="this.blur();"
                        onfocus="this.blur();"></asp:TextBox></td>
                    <td style="width: 20px">
                      &nbsp;
                    </td>
                    <td width="199">
                      Persona de Contacto</td>
                    <td width="200">
                      <asp:TextBox ID="txtContactoPersona" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="21" Text='<%# Bind("nombreresponsablesiniestro") %>'></asp:TextBox></td>
                    <td width="20">
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td width="20" style="height: 20px">
                      &nbsp;
                    </td>
                    <td style="height: 20px">
                      Asegurado</td>
                    <td style="height: 20px">
                      <asp:TextBox ID="txtPersonaAsegurada" runat="server" CssClass="FormText" TabIndex="22"
                        Width="195px" Text='<%# Bind("asegurado") %>' BorderColor="#C04000" onclick="this.blur();"
                        onfocus="this.blur();"></asp:TextBox></td>
                    <td style="width: 20px; height: 20px;">
                      &nbsp;
                    </td>
                    <td width="199" style="height: 20px">
                      Teléfono</td>
                    <td width="200" style="height: 20px">
                      <asp:TextBox ID="txtTelefonoContacto" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="23" Text='<%# Bind("telefonoresponsablesiniestro") %>'></asp:TextBox></td>
                    <td width="20" style="height: 20px">
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
                      <table width="200" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="190">
                            <asp:TextBox ID="txtFechaHoraSiniestro" runat="server" CssClass="FormText" Width="160px"
                              TabIndex="24" Text='<%# Bind("fsiniestro") %>'></asp:TextBox></td>
                          <td width="10">
                            <button tabindex="22" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaSiniestro"
                              type="button">
                              <img style="cursor: pointer;" src="img/cal.gif" width="16" height="16" border="0"
                                alt="Escoja una fecha" /></button>

                            <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'FormView1_txtFechaHoraSiniestro',
                                                                        ifFormat       :    '%d/%m/%Y %H:%M',
                                                                        button         :    'btnFechaSiniestro',
                                                                        showsTime      :    true,
                                                                        timeFormat     :    '24',
                                                                        singleClick    :    false
                                                                    }); 
                            </script>

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
                      <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="25" Text='<%# Bind("emailresponsablesiniestro") %>'></asp:TextBox></td>
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
                      <asp:TextBox ID="txtLugarDelSiniestro" runat="server" CssClass="FormText" Width="195px"
                        TabIndex="26" Text='<%# Bind("lugarsiniestro") %>'></asp:TextBox></td>
                    <td style="width: 20px; height: 13px">
                      &nbsp;
                    </td>
                    <td style="height: 13px">
                      Descripci&oacute;n del Siniestro</td>
                    <td style="height: 13px">
                      <asp:TextBox ID="txtTipoSiniestroId" Style="display: none;" runat="server" Text='<%# Eval("tiposiniestroId") %>'
                        Width="27px"></asp:TextBox>&nbsp;
                      <asp:TextBox ID="txtRamoId" Style="display: none;" runat="server" Width="37px" Text='<%# Eval("RamoId") %>'></asp:TextBox></td>
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
                      <Custom:AutoSuggestBox ID="txtDatoUbigeo" runat="server" CssClass="FormText" DataType="Distrito"
                        MaxSuggestChars="18" ResourcesDir="./asb_includes" Width="195px" TabIndex="27"
                        Style="z-index: 300" IncludeMoreMenuItem="False" KeyPressDelay="300" MenuCSSClass="asbMenu"
                        MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NumMenuItems="10" SelectedValue='<%# Bind("ubigeo") %>'
                        SelMenuItemCSSClass="asbSelMenuItem" Text='<%# Eval("distrito") %>' UseIFrame="True"></Custom:AutoSuggestBox></td>
                    <td style="width: 20px; height: 13px">
                    </td>
                    <td colspan="2" rowspan="2">
                      <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Height="40px"
                        TextMode="MultiLine" Width="392px" TabIndex="30" Text='<%# Bind("descripcion") %>'></asp:TextBox>
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
                      <asp:TextBox ID="txtRamoAfectado" runat="server" CssClass="FormText" TabIndex="28"
                        Width="195px" Text='<%# Bind("RamoAfectado") %>' BorderColor="#C04000" onclick="this.blur();"
                        onfocus="this.blur();"></asp:TextBox></td>
                    <td style="width: 20px; height: 13px">
                    </td>
                    <td style="height: 13px">
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 6px">
                    </td>
                    <td style="height: 6px">
                    </td>
                    <td style="height: 6px" colspan="4">
                    </td>
                    <td style="height: 6px">
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 13px">
                    </td>
                    <td style="height: 13px">
                      Tipo de Siniestro</td>
                    <td colspan="4" style="height: 13px">
                      <asp:DropDownList ID="cbxTipoSiniestro" runat="server" CssClass="FormSelect" DataSourceID="sdsTiposDeSiniestroByRamoId"
                        DataTextField="tipoSiniestro" DataValueField="tipoSiniestroId" Width="620px">
                      </asp:DropDownList></td>
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
              <div id="Div4" style="margin-left: 10px; z-index: 1;">
                <table width="855" border="0" cellpadding="0" cellspacing="0" class="DataTable" style="font-family: Verdana">
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
                    <td width="20" height="20">
                      &nbsp;
                    </td>
                    <td>
                        Ajustador</td>
                    <td>
                      <asp:DropDownList CssClass="FormText" ID="cbxAjustador" runat="server" Width="200px"
                        DataSourceID="odsAjustador" DataTextField="persona" DataValueField="personaid"
                        TabIndex="31" SelectedValue='<%# Bind("ajustadorid") %>' AppendDataBoundItems="True">
                        <asp:ListItem Selected="True" Value="-1">[Elija]</asp:ListItem>
                      </asp:DropDownList><asp:ObjectDataSource ID="odsAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetData" TypeName="dsComboTableAdapters.AjustadorComboTableAdapter">
                      </asp:ObjectDataSource>
                    </td>
                    <td width="20">
                      &nbsp;
                    </td>
                    <td width="199">
                      Tipo de Ajuste
                    </td>
                    <td width="200">
                      <asp:DropDownList CssClass="FormText" ID="cbxTipoAjuste" runat="server" Width="200px"
                        DataSourceID="odsTipoAjuste" DataTextField="tajuste" DataValueField="tajusteid"
                        TabIndex="32" SelectedValue='<%# Bind("tajusteid") %>'>
                      </asp:DropDownList><asp:ObjectDataSource ID="odsTipoAjuste" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoAjusteComboTableAdapter">
                      </asp:ObjectDataSource>
                    </td>
                    <td width="20">
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td width="20" style="height: 13px">
                      &nbsp;
                    </td>
                    <td style="height: 13px">
                      Ejecutivo de Siniestro</td>
                    <td style="height: 13px">
                      <span style="height: 20px">
                          <asp:DropDownList ID="cbxEjecutivoSiniestro" runat="server" AppendDataBoundItems="True"
                              CssClass="FormText" DataSourceID="odsEjecutivoSiniestros" DataTextField="persona"
                              DataValueField="personaid" Width="200px" SelectedValue='<%# Bind("ejecutivoSiniestrosid") %>'>
                              <asp:ListItem Value="-1">[-Elija-]</asp:ListItem>
                          </asp:DropDownList><asp:ObjectDataSource ID="odsEjecutivoSiniestros" runat="server"
                              OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsComboTableAdapters.EjecutivoSiniestrosComboTableAdapter">
                          </asp:ObjectDataSource>
                      </span></td>
                    <td width="20" style="height: 13px">
                      &nbsp;
                    </td>
                    <td width="199" style="height: 13px">
                    </td>
                    <td width="200" style="height: 13px">
                    </td>
                    <td width="20" style="height: 13px">
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 31px">
                      &nbsp;
                    </td>
                    <td style="height: 31px">
                      Fecha y Hora en la que se Coordina la Inspección</td>
                    <td style="height: 31px">
                      <table width="200" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td style="width: 190px; height: 18px">
                            <asp:TextBox ID="txtFechaHoraCoordinacion" runat="server" CssClass="FormText" Width="160px"
                              TabIndex="33" Text='<%# Bind("fechahoracoordinacion") %>'></asp:TextBox></td>
                          <td style="width: 10px; height: 18px">
                            <button tabindex="33" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaCoordinacion"
                              type="button">
                              <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                width="16" /></button>

                            <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'FormView1_txtFechaHoraCoordinacion',
                                                                        ifFormat       :    '%d/%m/%Y %H:%M',
                                                                        button         :    'btnFechaCoordinacion',
                                                                        showsTime      :    true,
                                                                        timeFormat     :    '24',
                                                                        singleClick    :    false
                                                                    }); 
                            </script>

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
                        Width="195px" Text='<%# Bind("lugareunion") %>'></asp:TextBox></td>
                    <td style="height: 31px">
                      &nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td height="31">
                    </td>
                    <td height="31">
                      Fecha y Hora para la que se programa la Inspección</td>
                    <td height="31">
                      <table width="200" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="190">
                            <asp:TextBox ID="txtFechaHoraReunion" runat="server" CssClass="FormText" Width="160px"
                              TabIndex="34" Text='<%# Bind("fechahorareunion") %>'></asp:TextBox></td>
                          <td width="10">
                            <button tabindex="34" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaReunion"
                              type="button">
                              <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                width="16" /></button>

                            <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'FormView1_txtFechaHoraReunion',
                                                                        ifFormat       :    '%d/%m/%Y %H:%M',
                                                                        button         :    'btnFechaReunion',
                                                                        showsTime      :    true,
                                                                        timeFormat     :    '24',
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                            </script>

                          </td>
                        </tr>
                      </table>
                    </td>
                    <td height="31">
                    </td>
                    <td height="31">
                      Distrito-Provincia-Departamento</td>
                    <td height="31">
                      <Custom:AutoSuggestBox ID="txtDatoUbigeoInspeccion" runat="server" CssClass="FormText"
                        DataType="Distrito" Height="11px" MaxSuggestChars="18" ResourcesDir="./asb_includes"
                        Width="195px" TabIndex="36" IncludeMoreMenuItem="False" KeyPressDelay="300" MenuCSSClass="asbMenu"
                        MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NumMenuItems="10" SelectedValue='<%# Bind("ubigeoIDinspeccion") %>'
                        SelMenuItemCSSClass="asbSelMenuItem" Text='<%# Bind("distritoInspeccion") %>' UseIFrame="False"></Custom:AutoSuggestBox></td>
                    <td>
                    </td>
                  </tr>
                  <tr>
                    <td height="20">
                    </td>
                    <td>
                      Fecha y Hora de Realización de la Inspección</td>
                    <td>
                      <table width="200" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td style="width: 190px; height: 18px">
                            <asp:TextBox ID="txtFechaHoraProgramacionInspeccion" runat="server" CssClass="FormText"
                              Width="160px" TabIndex="33" Text='<%# Bind("fechahoraprogramacion") %>'></asp:TextBox></td>
                          <td style="width: 10px; height: 18px">
                            <button tabindex="33" style="width: 17px; height: 17px;" class="FormButton" id="btnPtogramacion"
                              type="button">
                              <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                width="16" /></button>

                            <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'FormView1_txtFechaHoraProgramacionInspeccion',
                                                                        ifFormat       :    '%d/%m/%Y %H:%M',
                                                                        button         :    'btnPtogramacion',
                                                                        showsTime      :    true,
                                                                        timeFormat     :    '24',
                                                                        singleClick    :    false
                                                                    }); 
                            </script>

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
                        Width="195px" Text='<%# Bind("referencia") %>'></asp:TextBox></td>
                    <td>
                    </td>
                  </tr>
                  <tr>
                    <td height="20">
                    </td>
                    <td>
                      &nbsp;Persona de Contacto</td>
                    <td>
                      <asp:TextBox ID="txtPersonaContactoInspeccion" runat="server" CssClass="FormText"
                        TabIndex="38" Width="195px" Text='<%# Bind("personacontacto") %>'></asp:TextBox></td>
                    <td>
                    </td>
                    <td>
                      Teléfono de Contacto</td>
                    <td>
                      <asp:TextBox ID="txtTelefonoContactoInspeccion" runat="server" CssClass="FormText"
                        TabIndex="39" Width="195px" Text='<%# Bind("telefonopersonacontacto") %>'></asp:TextBox></td>
                    <td>
                    </td>
                  </tr>
                  <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
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
              <asp:TextBox Style="display: none;" ID="txtAjusteId" runat="server" CssClass="FormText"
                Text='<%# Bind("ajusteId") %>'></asp:TextBox>
              <asp:TextBox ID="txtPolizaId" Style="display: none;" runat="server" CssClass="FormText"
                Text='<%# Bind("polizaid") %>'></asp:TextBox>
            </div>
          </EditItemTemplate>
          <EditRowStyle BorderStyle="None" BorderWidth="0px" CssClass="sinPadding" />
          <RowStyle CssClass="sinPadding" VerticalAlign="Top" />
          <PagerStyle HorizontalAlign="Left" />
        </asp:FormView>
        <asp:Panel ID="pnlMsgError" runat="server" BackColor="Red" BorderColor="Red" Height="69px"
          Style="z-index: 450; left: 225px; position: absolute; top: 357px; text-align: center;"
          Visible="False" Width="408px">
          <div style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px">
            <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="10px" ForeColor="White"
              Text="AVISO DE ERROR <br />Por favor verifique los Errores que pudiesen existir en el formulario en los formatos de fechas"
              Width="380px"></asp:Label>&nbsp;</div>
          <asp:Image onclick="closepnlMsgError();" ID="imgClose" Style="cursor: pointer; position: absolute;
            left: 388px; top: 5px;" runat="server" ImageUrl="~/images/btnClose.jpg" />
        </asp:Panel>
        &nbsp;
        <div style="left: 0px; width: 350px; position: relative; top: -9px; height: 66px"
          id="Div1">
          <div style="left: 15px; position: absolute; top: 3px">
            <asp:ImageButton ID="btnGuardar" TabIndex="26" OnClick="btnGuardar_Click" runat="server"
              ToolTip="Guardar El Registro" ImageUrl="~/imgRGen/btnSave.gif" CommandName="Update"
              OnClientClick="return validaFechas();"></asp:ImageButton></div>
          <div style="left: 89px; position: absolute; top: 3px">
            <img style="cursor: hand" id="ImgbtnEquipo" title="Agregar Personas al Equipo" onclick="asignarEquipoAAjuste();"
              alt="Agregar Personas al Equipo" src="imgRGen/btnEquipo.gif" name="ImgbtnEquipo"
              runat="server" /></div>
          <div style="left: 170px; position: absolute; top: 17px">
          </div>
          <span style="left: 162px; position: absolute; top: 3px">
            <img style="cursor: hand" id="imgBtnAsignarPrimeraPoliza" title="Asignar Póliza Principal"
              onclick="asignaPolizaPrincipal();" alt="Asignar Póliza Principal" src="imgRGen/btnAsignarPrimeraPoliza.jpg"
              runat="server" />
          </span>
          <asp:Panel ID="pnlConfirmacion" runat="server" BackColor="#FF8000" BorderColor="Red"
            Height="36px" Style="z-index: 450; left: 237px; position: absolute; top: 10px;
            text-align: center;" Visible="False" Width="427px">
            <div style="padding-top: 10px;">
              <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="10px" ForeColor="White"
                Text="El Caso de Ajuste ha sido Actualizado" Width="380px"></asp:Label>&nbsp;</div>
            <asp:Image onclick="closepnlConfirmacion();" ID="Image1" Style="cursor: pointer;
              position: absolute; left: 405px; top: 5px;" runat="server" ImageUrl="~/images/btnClose.jpg" />
          </asp:Panel>
        </div>
        <asp:SqlDataSource ID="sdsRegistroInicial" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
          SelectCommand="sp_rgen_Ajuste_Total_Select" SelectCommandType="StoredProcedure"
          UpdateCommand="sp_rgen_Ajuste_Total_Update" UpdateCommandType="StoredProcedure"
          OnUpdating="sdsRegistroInicial_Updating" OnUpdated="sdsRegistroInicial_Updated">
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
            <asp:Parameter Name="numerosiniestroBroker" Type="String" />
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
              <asp:Parameter Name="ejecutivoSiniestrosid" Type="Decimal" />
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
        <div>
        </div>
      </div>
    </form>
  </div>
  <asp:SqlDataSource ID="sdsCambioEstado" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
    InsertCommand="sp_rgen_cambiaEstadoAjuste" InsertCommandType="StoredProcedure"
    SelectCommand="select * from RGN_ESTADOSAJUSTE">
    <InsertParameters>
      <asp:Parameter Name="fechaAux" Type="DateTime" />
      <asp:Parameter Name="AjusteId" Type="Decimal" />
      <asp:Parameter Name="estadoAjusteId" Type="Decimal" />
      <asp:Parameter Name="u_ucrea" Type="String" />
    </InsertParameters>
  </asp:SqlDataSource>
  <br />
</body>
</html>
