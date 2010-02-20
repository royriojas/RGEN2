<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vNuevoCasoAjuste.aspx.cs"
    Inherits="vNuevoCasoAjuste" %>

<%@ Register TagPrefix="Custom" Namespace="ASB" Assembly="AutoSuggestBox" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Riesgos Generales | Nuevo Caso de Ajuste</title>
    <!-- scripts importados -->

    <script type="text/javascript" src="Scripts/lib/x_core.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_dom.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

    <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

    <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_emptyTextBox.js"></script>

    <script type="text/javascript" src="Scripts/functions.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_textBoxFunctions.js"></script>

    <script type="text/javascript" src="Scripts/lib/xCaseOperations.js">
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

    <script type="text/javascript">
        function CheckIfPossible(msj) {
            if (msj == 0) {
                return confirm('¿Está seguro que desea proceder sin filtrar por RAMO la lista de TIPO DE SINIESTRO?');
            }
            else return confirm('¿Desea filtrar por RAMO la lista de TIPO DE SINIESTRO?');
        }
  
    </script>

    <script type="text/javascript"> 	
    
     function perfomContactoAjaxSearch() {            
            var pId = $('txtContactoCiaSeguros_SelectedValue').value;
            if (pId != "") {
                vNuevoCasoAjuste.getEjecutivoAseguradora(pId,callBackFunction);
            }
           
        }
        function callBackFunction(res) {
            try {
                var contacto = res.value;                
                clearForm();
                $('txtTelefonoContactoCia').value = contacto.Telefono;
                $('txtEmailContactoCia').value = contacto.Email;                        
            }
            catch(e) {
                alert(CCSOL.Utiles.traceError(e));
            }
        }
        function clearForm() {                       
            $('txtTelefonoContactoCia').value = '';
            $('txtEmailContactoCia').value = '';                        
            //OtrosCamposElegidos
            
        }
        function clearASB() {
             $('txtContactoCiaSeguros').value = "";
            $('txtContactoCiaSeguros_SelectedValue').value = "";
        }
        function setAsbFilter(e) { 
              
            if (!e) { 
              asbGetObj('txtContactoCiaSeguros').msFilters = $('cbxCiaSeguros').value; 
              return;
            }
            if ($('txtContactoCiaSeguros').value != '')  {
                if (!confirm('Se Borrarán los datos que ha seleccionado al cambiar la aseguradora, ¿Desea Continuar?')) {
                    return;
                }
            }
            //limpiamos el AutoSuggestBox         
            clearASB();
            clearForm();
            asbGetObj('txtContactoCiaSeguros').msFilters = $('cbxCiaSeguros').value;                                  
        }
    
        function AjaxDataSearchInit(){
            setAsbFilter();
            xAddEventListener($('cbxCiaSeguros'),'change',setAsbFilter,false);
            xAddEventListener($('txtContactoCiaSeguros'),'blur',perfomContactoAjaxSearch,false);
        }
    
    
	    function muestraBusquedaPolizas() {
	        var cias = $('cbxCiaSeguros');	
	        var selectedIndexCia = cias.selectedIndex; 
	        if (cias.value == '-1') {
	            alert('Debe escoger una aseguradora para poder realizar la búsqueda de la póliza')
	        }       
	        else {
    	        showPopWin('vBusquedaPoliza.aspx?AseguradoraId='+cias.value+'&AseguradoraNombre='+(cias.options[cias.selectedIndex].innerHTML), 620, 480, null);
	        }
            
	    }	
	    function validaFechaPosterior() {
	    }
	    function doFill() {
	    try {
	        //alert($('cbxRamo').value);
	        $('txtRamoId').value = $('cbxRamo').value;
	     }
	     catch(e) {
	        alert(e.message);
	     }
	        fillCbxTipoSiniestro();
	    }
	    function fillCbxTipoSiniestro() {
            $('btnFillTiposSiniestro').click();
        }
		function seteaValoresDePoliza(polizaId,polizaNumero,PersonaAseguradaId,NombrePersonaAsegurada,nombreContratante,RamoAfectado,ramoId) {
		        
		       
		        $('txtNumPoliza').value = polizaNumero;		        		        
		        $('txtPolizaId').value = '' + polizaId;		        
		        $('txtPersonaAseguradaId').value = '' + PersonaAseguradaId;		        
		        $('txtPersonaAsegurada').value = NombrePersonaAsegurada;
                $('txtContratante').value = nombreContratante;		    
		        $('txtRamoAfectado').value = RamoAfectado;
		        $('txtRamoId').value = ramoId;
		        //llamada al metodo de la libreria emptyTextBox (la que le pone amarillo a los campos que faltan llenar
		        limpiaCamposLlenados();
		        
		        hidePopWin(true); 
		        
		        $('asbBroker').focus();
		        
	          fillCbxTipoSiniestro();
	          	          	          
	            
	       
		}
		window.onload = function () {
		    
		  // xAddEventListener($('btnGuardar'),'click',validaBrokerElegido,false);
		    
			seteaOcultadoresDeDivs();
			var ele = xGetElementById('form1');
			xAddEventListener(ele,'keypress',deshabilitaEnterKeyFromForms,false);
			
			//seteo el foco al primer elemento del formulario
			var primerItem = xGetElementById('cbxQuienNotifico');
			primerItem.focus();
			
			//hago De Solo lectura el campo de póliza, no por html para poder "recoger el valor del campo" en el envio del formulario
            var txtPol = xGetElementById('txtNumPoliza');            
            txtPol.onfocus = function () {
                if (<%=deboAceptarFoco%>) xGetElementById('btnBuscaPoliza').focus();
            }
            try {
                textboxCopyValue('txtLugarDelSiniestro','txtDireccionReunion');         
            }
            catch(e) {            
            } 
            
           //verificadores de fecha
           
           var x = new xTextBoxCaseOperators();
           seteaValoresCero();
           //alert(x);
           
           AjaxDataSearchInit();
            
		}
		
  		function seteaOcultadoresDeDivs() {
			btn_ocultar = new CollapsibleDiv('img_oculta_cabecera',
						 'cabecera',						 
						 true,
						 null);
		}
		
		function hidepnlMsgError() {
		    $('pnlMsgError').style.display = 'none';
		}
		
		function validaBrokerElegido() {
		    if ($('asbBroker_SelectedValue').value == "") {
		        alert('No ha elegido un broker de la lista, Debe elegir un broker de la lista');
		        return false;
		    }
		    else return true;
		}
		
		
  
	 
    </script>

    <!-- Estilos -->
    <link rel="stylesheet" type="text/css" href="Scripts/calendar/calendar-blue2.css" />
    <link rel="stylesheet" type="text/css" href="scripts/popUpWin/css/style.css" />
    <link rel="stylesheet" type="text/css" href="scripts/popUpWin/css/subModal.css" />
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin-left: auto; margin-right: auto; position: relative; width: 900px;">
        <div id="cabecera">
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="ajuste" />
            <uc2:linksAjustadorAdministrador ID="LinksAjustadorAdministrador1" runat="server" />
        </div>
        <div style="height: 3px;">
        </div>
        <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
        </div>
        <div class="DataContent">
            <div class="DataContentRight">
                <img id="img_oculta_cabecera" src="imgRGen/openCloseCollapse.jpg" alt="Ocultar Cabecera"
                    title="Ocultar Cabecera" style="position: absolute; left: 860px; top: 4px;" />
                <div>
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Nuevo Caso de Ajuste" Font-Bold="True"
                        Font-Size="18px"></asp:Label>
                </div>
                <asp:Panel Style="position: absolute; left: 326px; top: 1px; z-index: 450;" ID="pnlMsgError"
                    runat="server" Height="30px" Width="400px" BackColor="Red" BorderColor="Red"
                    Visible="False" ForeColor="White">
                    <div style="padding-right: 10px; text-align: center; padding-left: 10px; padding-bottom: 4px;
                        padding-top: 4px">
                        <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="White" Text="AVISO DE ERROR <br />Por favor verifique los Errores que pudiesen existir en el formulario en los formatos de fechas"
                            Font-Size="10px"></asp:Label>
                        <img alt="colapsar" src="images/btnClose.jpg" style="cursor: pointer; position: absolute;
                            left: 383px; top: 4px;" onclick="hidepnlMsgError();" />
                    </div>
                </asp:Panel>
                <asp:Button ID="btnFillTiposSiniestro" runat="server" Text="Button" Style="display: none;"
                    OnClick="btnFillTiposSiniestro_Click" />
                <asp:TextBox Style="display: none;" ID="txtRamoId" runat="server" onblur="fillCbxTipoSiniestro();"></asp:TextBox>
                <div class="hr">
                </div>
                <div id="ContenidoPagina" style="background-color: #4C96C9;">
                    <div>
                        <div id="notificacion" style="margin-left: 10px;">
                            <table width="855" border="0" cellpadding="0" cellspacing="0" class="DataTable">
                                <tr>
                                    <td width="20" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="194" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="202" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="20" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="199" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="200" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="20" style="height: 13px">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20" style="height: 29px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 29px">
                                        Quien notific&oacute;
                                    </td>
                                    <td style="height: 29px">
                                        <asp:DropDownList ID="cbxQuienNotifico" runat="server" CssClass="FormText" Width="200px"
                                            TabIndex="1">
                                            <asp:ListItem Value="-1">[Elija Uno]</asp:ListItem>
                                            <asp:ListItem Value="Cia Seguros">Compa&#241;&#236;a Seguros</asp:ListItem>
                                            <asp:ListItem>Broker</asp:ListItem>
                                            <asp:ListItem>Asegurado</asp:ListItem>
                                            <asp:ListItem>Otro</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td width="20" style="height: 29px">
                                        &nbsp;
                                    </td>
                                    <td width="199" style="height: 29px">
                                        Nombre Notificante
                                    </td>
                                    <td width="200" style="height: 29px">
                                        <asp:TextBox ID="txtNotificante" runat="server" CssClass="FormText MAYUSC" Width="195px"
                                            TabIndex="2"></asp:TextBox>
                                    </td>
                                    <td width="20" style="height: 29px">
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
                                            OnDataBound="cbxTipoComunicacion_DataBound">
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
                                                        <asp:TextBox ID="txtFechaHoraAviso" runat="server" CssClass="FormText" Width="160px"
                                                            TabIndex="4"></asp:TextBox>
                                                    </span>
                                                </td>
                                                <td width="10">
                                                    <button tabindex="4" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaAviso">
                                                        <img style="cursor: pointer;" src="img/cal.gif" width="16" height="16" border="0"
                                                            alt="Escoja una fecha" /></button>

                                                    <script type="text/javascript">
                                                        function getFoco(cal) {

                                                            p = cal.params;
                                                            p.inputField.focus();
                                                            p.inputField.select();
                                                            cal.hide();

                                                        }
                                                        Calendar.setup({
                                                            inputField: 'txtFechaHoraAviso',
                                                            ifFormat: '%d/%m/%Y %H:%M',
                                                            button: 'btnFechaAviso',
                                                            showsTime: true,
                                                            timeFormat: '24',
                                                            singleClick: false,
                                                            onClose: getFoco
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
                                    <td width="20" style="height: 20px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 20px">
                                        Quien Confirmó (Aseguradora)
                                    </td>
                                    <td style="height: 20px">
                                        <asp:TextBox ID="txtNombreConfirmante" runat="server" CssClass="FormText MAYUSC"
                                            TabIndex="5" Width="195px"></asp:TextBox>
                                    </td>
                                    <td width="20" style="height: 20px">
                                        &nbsp;
                                    </td>
                                    <td width="199" style="height: 20px">
                                        Cargo Confirmante
                                    </td>
                                    <td width="200" style="height: 20px">
                                        <asp:TextBox ID="txtPuesto" runat="server" CssClass="FormText MAYUSC" TabIndex="6"
                                            Width="195px"></asp:TextBox>
                                    </td>
                                    <td width="20" style="height: 20px">
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
                                                CssClass="FormText" DataSourceID="odsTipoComunicacion" DataTextField="nombre"
                                                DataValueField="tcomunicacionId" Width="200px" OnDataBound="cbxTipoComunicacionConfirmacion_DataBound">
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
                                                        TabIndex="8"></asp:TextBox>
                                                </td>
                                                <td width="10">
                                                    <button tabindex="8" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaConfirmacion">
                                                        <img src="img/cal.gif" width="16" height="16" border="0" alt="Escoja una fecha" /></button>

                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField: 'txtFechaConfirmacion',
                                                            ifFormat: '%d/%m/%Y %H:%M',
                                                            button: 'btnFechaConfirmacion',
                                                            showsTime: true,
                                                            timeFormat: '24',
                                                            singleClick: false,
                                                            onClose: getFoco
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
                        <div style="margin-left: 10px;">
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
                                        Aseguradora<asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="cbxCiaSeguros"
                                            ErrorMessage="Elija una Aseguradora" Operator="NotEqual" ValidationGroup="requeridos"
                                            ValueToCompare="-1">(*)</asp:CompareValidator>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="cbxCiaSeguros" runat="server" CssClass="FormText" Width="200px"
                                            DataSourceID="odsCiaSeguros" DataTextField="persona" DataValueField="personaid"
                                            TabIndex="9" OnDataBound="cbxCiaSeguros_DataBound">
                                        </asp:DropDownList>
                                        &nbsp;
                                    </td>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                    <td width="199">
                                        Broker
                                    </td>
                                    <td width="200">
                                        <Custom:AutoSuggestBox ID="asbBroker" runat="server" CssClass="FormText" IncludeMoreMenuItem="True"
                                            MaxSuggestChars="15" NumMenuItems="15" ResourcesDir="./asb_includes" Width="195px"
                                            DataType="Broker" TabIndex="15" WarnNoValueSelected="false"></Custom:AutoSuggestBox>
                                    </td>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20" style="height: 22px">
                                    </td>
                                    <td style="height: 22px">
                                        Responsable
                                    </td>
                                    <td style="height: 22px">
                                        <Custom:AutoSuggestBox Filters="-1" ID="txtContactoCiaSeguros" runat="server" OnFocusShowAll="True"
                                            Width="195px" DataType="Ejecutivo" WarnNoValueSelected="false" ResourcesDir="./asb_includes"
                                            CssClass="FormText" TabIndex="10"></Custom:AutoSuggestBox>
                                    </td>
                                    <td width="20" style="height: 22px">
                                    </td>
                                    <td width="199" style="height: 22px">
                                        Responsable
                                    </td>
                                    <td width="200" style="height: 22px">
                                        <asp:TextBox ID="txtContactoCorredor" runat="server" CssClass="FormText MAYUSC" Width="195px"
                                            TabIndex="16"></asp:TextBox>
                                    </td>
                                    <td width="20" style="height: 22px">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20" height="20">
                                    </td>
                                    <td>
                                        Teléfono Responsable
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTelefonoContactoCia" runat="server" CssClass="FormText" Width="195px"
                                            TabIndex="11"></asp:TextBox>
                                    </td>
                                    <td width="20">
                                    </td>
                                    <td width="199">
                                        Teléfono Responsable
                                    </td>
                                    <td width="200">
                                        <asp:TextBox ID="txtTelefonoContactoCorredor" runat="server" CssClass="FormText"
                                            Width="195px" TabIndex="17"></asp:TextBox>
                                    </td>
                                    <td width="20">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20" height="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        Correo Electrónico
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmailContactoCia" runat="server" CssClass="FormText" Width="195px"
                                            TabIndex="12"></asp:TextBox>
                                    </td>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                    <td width="199">
                                        Correo Electrónico
                                    </td>
                                    <td width="200">
                                        <asp:TextBox ID="txtEmailContactoCorredor" runat="server" CssClass="FormText" Width="195px"
                                            TabIndex="18"></asp:TextBox>
                                    </td>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        N&ordm; de Siniestro
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtNumeroSiniestro" runat="server" CssClass="FormText" Width="195px"
                                            TabIndex="13"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        N&ordm; de Siniestro Broker
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtNumeroSiniestroBroker" runat="server" CssClass="FormText" TabIndex="19"
                                            Width="195px"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 13px">
                                        Nº de P&oacute;liza
                                    </td>
                                    <td style="height: 13px">
                                        <table width="200" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="190" style="height: 20px">
                                                    <asp:TextBox ID="txtNumPoliza" Width="160px" runat="server" CssClass="FormText" TabIndex="14"
                                                        BorderColor="#EA6F13" BorderStyle="Solid"></asp:TextBox>
                                                </td>
                                                <td width="10" style="height: 20px">
                                                    <button runat="server" id="btnBuscaPoliza" onclick="muestraBusquedaPolizas();return false;"
                                                        style="width: 30px; cursor: pointer; cursor: hand;" title="Buscar Pólizas o Crear Una Nueva"
                                                        class="FormButton" tabindex="13">
                                                        ...</button>
                                                </td>
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
                                    <td style="height: 13px">
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
                        <div id="AseguradoSiniestro" style="margin-left: 10px;">
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
                                    <td width="20" style="height: 20px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 20px">
                                        Contratante
                                    </td>
                                    <td style="height: 20px">
                                        <asp:TextBox ID="txtContratante" runat="server" CssClass="FormText MAYUSC" TabIndex="20"
                                            Width="195px" BorderColor="#EA6F13" BorderStyle="Solid"></asp:TextBox>
                                    </td>
                                    <td style="width: 20px; height: 20px;">
                                        &nbsp;
                                    </td>
                                    <td width="199" style="height: 20px">
                                        Persona de Contacto
                                    </td>
                                    <td width="200" style="height: 20px">
                                        <asp:TextBox ID="txtContactoPersona" runat="server" CssClass="FormText MAYUSC" Width="195px"
                                            TabIndex="24"></asp:TextBox>
                                    </td>
                                    <td width="20" style="height: 20px">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20" style="height: 20px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 20px">
                                        Asegurado<asp:RequiredFieldValidator ID="rqValidatorTxtAsegurado" runat="server"
                                            ControlToValidate="txtPersonaAsegurada" ErrorMessage="Ingrese el nombre del Asegurado"
                                            ValidationGroup="requeridos">(*)</asp:RequiredFieldValidator>
                                    </td>
                                    <td style="height: 20px">
                                        <asp:TextBox ID="txtPersonaAsegurada" runat="server" CssClass="FormText MAYUSC" TabIndex="21"
                                            Width="195px" BorderColor="#EA6F13" BorderStyle="Solid"></asp:TextBox>
                                    </td>
                                    <td style="width: 20px; height: 20px;">
                                        &nbsp;
                                    </td>
                                    <td width="199" style="height: 20px">
                                        Teléfono
                                    </td>
                                    <td width="200" style="height: 20px">
                                        <asp:TextBox ID="txtTelefonoContacto" runat="server" CssClass="FormText" Width="195px"
                                            TabIndex="25"></asp:TextBox>
                                    </td>
                                    <td width="20" style="height: 20px">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        Fecha y Hora del Siniestro<asp:RequiredFieldValidator ID="RequiredFieldValidator8"
                                            runat="server" ControlToValidate="txtFechaHoraSiniestro" ErrorMessage="Ingrese la fecha y hora del siniestro"
                                            ValidationGroup="requeridos">(*)</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <table width="200" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="190">
                                                    <asp:TextBox ID="txtFechaHoraSiniestro" runat="server" CssClass="FormText" Width="160px"
                                                        TabIndex="20"></asp:TextBox>
                                                </td>
                                                <td width="10">
                                                    <button tabindex="22" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaSiniestro">
                                                        <img style="cursor: pointer;" src="img/cal.gif" width="16" height="16" border="0"
                                                            alt="Escoja una fecha" /></button>

                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField: 'txtFechaHoraSiniestro',
                                                            ifFormat: '%d/%m/%Y %H:%M',
                                                            button: 'btnFechaSiniestro',
                                                            showsTime: true,
                                                            timeFormat: '24',
                                                            singleClick: false,
                                                            onClose: getFoco
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
                                        Correo Electrónico
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="FormText" Width="195px"
                                            TabIndex="26"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 12px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 12px">
                                        Lugar del Siniestro<asp:RequiredFieldValidator ID="rqvLugarSiniestro" runat="server"
                                            ControlToValidate="txtLugarDelSiniestro" ErrorMessage="Ingrese El lugar de Ocurrencia"
                                            ValidationGroup="requeridos">(*)</asp:RequiredFieldValidator>
                                    </td>
                                    <td style="height: 12px">
                                        <asp:TextBox ID="txtLugarDelSiniestro" runat="server" CssClass="FormText" Width="195px"
                                            TabIndex="21"></asp:TextBox>
                                    </td>
                                    <td style="width: 20px; height: 12px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 12px">
                                        Descripci&oacute;n del Siniestro
                                    </td>
                                    <td style="height: 12px">
                                        &nbsp;
                                    </td>
                                    <td style="height: 12px">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="20" style="height: 13px">
                                    </td>
                                    <td style="height: 13px">
                                        Distrito - Prov. - Dpto.
                                    </td>
                                    <td style="height: 13px">
                                        <Custom:AutoSuggestBox ID="txtDatoUbigeo" runat="server" CssClass="FormText" DataType="Distrito"
                                            MaxSuggestChars="18" ResourcesDir="./asb_includes" Width="195px" TabIndex="22"
                                            Style="z-index: 300"></Custom:AutoSuggestBox>
                                    </td>
                                    <td style="width: 20px; height: 13px">
                                    </td>
                                    <td colspan="2" rowspan="2">
                                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Height="40px"
                                            TextMode="MultiLine" Width="392px" TabIndex="27"></asp:TextBox>
                                        <asp:ObjectDataSource ID="odsCiaSeguros" runat="server" OldValuesParameterFormatString="original_{0}"
                                            SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter">
                                        </asp:ObjectDataSource>
                                    </td>
                                    <td style="height: 13px">
                                    </td>
                                </tr>
                                <tr>
                                    <td height="20" style="height: 13px">
                                    </td>
                                    <td style="height: 13px">
                                        Ramo Afectado |
                                        <asp:LinkButton ID="lnkSinRamo" runat="server" ForeColor="Navy" OnClientClick="return CheckIfPossible(0);"
                                            OnClick="lnkSinRamo_Click">Sin Ramo</asp:LinkButton>
                                        <asp:CompareValidator ID="CompareValidator8" runat="server" ControlToValidate="cbxRamo"
                                            ErrorMessage="Elija un tipo de Siniestro" Operator="NotEqual" ValidationGroup="requeridos"
                                            ValueToCompare="-1">(*)</asp:CompareValidator>
                                    </td>
                                    <td style="height: 13px">
                                        <asp:TextBox ID="txtRamoAfectado" BorderColor="#EA6F13" runat="server" CssClass="FormText"
                                            Width="195px" TabIndex="23"></asp:TextBox>
                                        <asp:DropDownList onchange="doFill();" ID="cbxRamo" runat="server" CssClass="FormSelect"
                                            DataSourceID="odsRamo" DataTextField="nombre" DataValueField="ramoId" Width="200px"
                                            TabIndex="23" OnDataBound="cbxTipoSiniestro_DataBound">
                                        </asp:DropDownList>
                                        <asp:ObjectDataSource ID="odsRamo" runat="server" OldValuesParameterFormatString="original_{0}"
                                            SelectMethod="GetData" TypeName="dsComboTableAdapters.RamoComboTableAdapter">
                                        </asp:ObjectDataSource>
                                    </td>
                                    <td style="width: 20px; height: 13px">
                                    </td>
                                    <td style="height: 13px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 4px">
                                    </td>
                                    <td style="height: 4px">
                                    </td>
                                    <td style="height: 4px" colspan="4">
                                    </td>
                                    <td style="height: 4px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 13px">
                                    </td>
                                    <td style="height: 13px">
                                        Tipo de Siniestro<asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="cbxTipoSiniestro"
                                            ErrorMessage="Elija un tipo de Siniestro" Operator="NotEqual" ValidationGroup="requeridos"
                                            ValueToCompare="-1">(*)</asp:CompareValidator>
                                    </td>
                                    <td style="height: 13px" colspan="5">
                                        <asp:DropDownList ID="cbxTipoSiniestro" runat="server" CssClass="FormSelect" DataSourceID="sdsTiposDeSiniestroByRamoId"
                                            DataTextField="tipoSiniestro" DataValueField="tipoSiniestroId" Width="616px"
                                            TabIndex="28" OnDataBound="cbxTipoSiniestro_DataBound">
                                        </asp:DropDownList>
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
                        <div id="AjustadorInspeccion" style="margin-left: 10px;" runat="server">
                            <table width="855" border="0" cellpadding="0" cellspacing="0" class="DataTable" style="left: 0px;
                                top: 0px">
                                <tr>
                                    <td width="20" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="194" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="202" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td style="width: 20px; height: 13px;">
                                        &nbsp;
                                    </td>
                                    <td style="width: 199px; height: 13px;">
                                        &nbsp;
                                    </td>
                                    <td width="200" style="height: 13px">
                                        &nbsp;
                                    </td>
                                    <td width="20" style="height: 13px">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20" height="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        Ajustador<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cbxAjustador"
                                            ErrorMessage="Elija Ajustador" Operator="NotEqual" ValidationGroup="requeridos"
                                            ValueToCompare="-1">(*)</asp:CompareValidator>
                                    </td>
                                    <td>
                                        <asp:DropDownList CssClass="FormText" ID="cbxAjustador" runat="server" Width="200px"
                                            DataSourceID="odsAjustador" DataTextField="persona" DataValueField="personaid"
                                            TabIndex="29" OnDataBound="cbxAjustador_DataBound">
                                        </asp:DropDownList>
                                        <asp:ObjectDataSource ID="odsAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
                                            SelectMethod="GetData" TypeName="dsComboTableAdapters.AjustadorComboTableAdapter">
                                        </asp:ObjectDataSource>
                                    </td>
                                    <td style="width: 20px">
                                        &nbsp;
                                    </td>
                                    <td style="width: 199px">
                                        Tipo de Ajuste
                                        <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="cbxTipoAjuste"
                                            ErrorMessage="Elija un tipo de Ajuste" Operator="NotEqual" ValidationGroup="requeridos"
                                            ValueToCompare="-1">(*)</asp:CompareValidator>
                                    </td>
                                    <td width="200">
                                        <asp:DropDownList CssClass="FormText" ID="cbxTipoAjuste" runat="server" Width="200px"
                                            DataSourceID="odsTipoAjuste" DataTextField="tajuste" DataValueField="tajusteid"
                                            TabIndex="30" OnDataBound="cbxTipoAjuste_DataBound">
                                        </asp:DropDownList>
                                        <asp:ObjectDataSource ID="odsTipoAjuste" runat="server" OldValuesParameterFormatString="original_{0}"
                                            SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoAjusteComboTableAdapter">
                                        </asp:ObjectDataSource>
                                    </td>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                    <td>
                                        Ejecutivo de Siniestros
                                    </td>
                                    <td>
                                        <span style="height: 20px">
                                            <asp:DropDownList ID="cbxEjecutivoSiniestros" runat="server" AppendDataBoundItems="True"
                                                CssClass="FormText" DataSourceID="odsEjecutivo" DataTextField="persona" DataValueField="personaid"
                                                Width="200px">
                                                <asp:ListItem Value="-1">[Elija uno]</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:ObjectDataSource ID="odsEjecutivo" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetData" TypeName="dsComboTableAdapters.EjecutivoSiniestrosComboTableAdapter">
                                            </asp:ObjectDataSource>
                                        </span>
                                    </td>
                                    <td style="width: 20px">
                                        &nbsp;
                                    </td>
                                    <td style="width: 199px">
                                    </td>
                                    <td width="200">
                                    </td>
                                    <td width="20">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="20">
                                        &nbsp;
                                    </td>
                                    <td height="20">
                                        Fecha y Hora en la que se Coordina la Inspección
                                    </td>
                                    <td height="20">
                                        <table width="200" border="0" cellspacing="0" cellpadding="0" id="TABLE1">
                                            <tr>
                                                <td width="190">
                                                    <asp:TextBox ID="txtFechaHoraCoordinacion" runat="server" CssClass="FormText" Width="160px"
                                                        TabIndex="31"></asp:TextBox>
                                                </td>
                                                <td style="width: 10px">
                                                    <button tabindex="33" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaCoordinacion">
                                                        <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                                            width="16" /></button>

                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField: 'txtFechaHoraCoordinacion',
                                                            ifFormat: '%d/%m/%Y %H:%M',
                                                            button: 'btnFechaCoordinacion',
                                                            showsTime: true,
                                                            timeFormat: '24',
                                                            singleClick: false,
                                                            onClose: getFoco
                                                        }); 
                                                                                                                                                            
                                                                    
                                                    </script>

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td height="20" style="width: 20px">
                                        &nbsp;
                                    </td>
                                    <td height="20" style="width: 199px">
                                        Direccion de Inspecci&oacute;n
                                    </td>
                                    <td height="20">
                                        <asp:TextBox ID="txtDireccionReunion" runat="server" CssClass="FormText" TabIndex="35"
                                            Width="195px"></asp:TextBox>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 33px">
                                    </td>
                                    <td style="height: 33px">
                                        Fecha y Hora para la que se programa la Inspección
                                    </td>
                                    <td style="height: 33px">
                                        <table width="200" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="190" style="height: 20px">
                                                    <asp:TextBox ID="txtFechaHoraReunion" runat="server" CssClass="FormText" Width="160px"
                                                        TabIndex="32"></asp:TextBox>
                                                </td>
                                                <td width="10" style="height: 20px">
                                                    <button tabindex="34" style="width: 17px; height: 17px;" class="FormButton" id="btnFechaReunion">
                                                        <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                                            width="16" /></button>

                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField: 'txtFechaHoraReunion',
                                                            ifFormat: '%d/%m/%Y %H:%M',
                                                            button: 'btnFechaReunion',
                                                            showsTime: true,
                                                            timeFormat: '24',
                                                            singleClick: false,
                                                            onClose: getFoco
                                                        }); 
                                                                                                                                                            
                                                                    
                                                    </script>

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 20px; height: 33px;">
                                    </td>
                                    <td style="width: 199px; height: 33px;">
                                        Distrito-Provincia-Departamento
                                    </td>
                                    <td style="height: 33px">
                                        <Custom:AutoSuggestBox ID="txtDatoUbigeoInspeccion" runat="server" CssClass="FormText"
                                            DataType="Distrito" Height="11px" MaxSuggestChars="18" ResourcesDir="./asb_includes"
                                            Width="195px" TabIndex="36"></Custom:AutoSuggestBox>
                                    </td>
                                    <td style="height: 33px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 20px">
                                    </td>
                                    <td style="height: 20px">
                                        Fecha y Hora de Realización de la Inspección
                                    </td>
                                    <td style="height: 20px">
                                        <table border="0" cellpadding="0" cellspacing="0" width="200">
                                            <tr>
                                                <td style="width: 190px; height: 18px">
                                                    <asp:TextBox ID="txtFechaHoraProgramacionInspeccion" runat="server" CssClass="FormText"
                                                        TabIndex="33" Text='<%# Bind("fechahoraprogramacion") %>' Width="160px"></asp:TextBox>
                                                </td>
                                                <td style="width: 10px; height: 18px">
                                                    <button id="btnPtogramacion" class="FormButton" style="width: 17px; height: 17px"
                                                        tabindex="33" type="button">
                                                        <img alt="Escoja una fecha" border="0" height="16" src="img/cal.gif" style="cursor: pointer"
                                                            width="16" /></button>

                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField: 'txtFechaHoraProgramacionInspeccion',
                                                            ifFormat: '%d/%m/%Y %H:%M',
                                                            button: 'btnPtogramacion',
                                                            showsTime: true,
                                                            timeFormat: '24',
                                                            singleClick: false,
                                                            onClose: getFoco
                                                        }); 
                                                    </script>

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="height: 20px; width: 20px;">
                                    </td>
                                    <td style="height: 20px; width: 199px;">
                                        Referencia de la Dirección
                                    </td>
                                    <td style="height: 20px">
                                        <asp:TextBox ID="txtReferenciaReunion" runat="server" CssClass="FormText" TabIndex="37"
                                            Width="195px"></asp:TextBox>
                                    </td>
                                    <td style="height: 20px">
                                    </td>
                                </tr>
                                <tr>
                                    <td height="20">
                                    </td>
                                    <td>
                                        Persona de Contacto
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPersonaContactoInspeccion" runat="server" CssClass="FormText MAYUSC"
                                            TabIndex="34" Width="195px"></asp:TextBox>
                                    </td>
                                    <td style="width: 20px">
                                    </td>
                                    <td style="width: 199px">
                                        Teléfono de Contacto
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTelefonoContactoInspeccion" runat="server" CssClass="FormText"
                                            TabIndex="38" Width="195px"></asp:TextBox>
                                    </td>
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
                                    <td style="width: 20px">
                                    </td>
                                    <td style="width: 199px">
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            &nbsp;&nbsp;&nbsp;&nbsp;<span id="Span1"> </span>
                            <div>
                            </div>
                            <div class="hr">
                            </div>
                        </div>
                        <div>
                            <br />
                        </div>
                        <div style="width: 300px; height: 80px; position: relative; left: 0px; top: 0px;"
                            id="Div1">
                            <div style="position: absolute; left: 15px; top: 17px;" id="DIV2">
                                <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/imgRGen/btnSave.gif"
                                    ToolTip="Guardar El Registro" TabIndex="50" OnClick="btnGuardar_Click" ValidationGroup="requeridos" />
                            </div>
                        </div>
                        <asp:TextBox Style="display: none;" ID="txtPersonaAseguradaId" runat="server" CssClass="FormText"></asp:TextBox>
                        <asp:TextBox ID="txtPolizaId" Style="display: none;" runat="server" CssClass="FormText"></asp:TextBox>&nbsp;&nbsp;
                        &nbsp;&nbsp;
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="requeridos" />
                    </div>
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
    </form>
    <asp:SqlDataSource ID="sqlNuevoAjuste" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
        InsertCommand="sp_rgen_Ajuste_Total_Insert" InsertCommandType="StoredProcedure"
        SelectCommand="sp_rgen_Ajuste_Total_Select" SelectCommandType="StoredProcedure"
        OnInserting="sqlNuevoAjuste_Inserting" 
        OnInserted="sqlNuevoAjuste_Inserted" OldValuesParameterFormatString="">
        <SelectParameters>
            <asp:Parameter Name="ajusteid" Type="Decimal" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter DefaultValue="1" Direction="InputOutput" Name="numeroAjuste" Size="30"
                Type="String" />
            <asp:Parameter Direction="InputOutput" Name="ajusteId" Type="Decimal" 
                DefaultValue="" />
            <asp:ControlParameter ControlID="cbxQuienNotifico" Name="quienNotifico" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="txtNotificante" Name="NombreDelNotificante" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtFechaHoraAviso" Name="faviso" PropertyName="Text"
                Type="DateTime" />
            <asp:ControlParameter ControlID="cbxTipoComunicacion" Name="medioDeNotificacionId"
                PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="txtNombreConfirmante" Name="NombreQuienConfirma"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtFechaConfirmacion" Name="FechayHoraConfirmacion"
                PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="cbxTipoComunicacion" Name="medioConfirmacionId"
                PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="txtPuesto" Name="cargoconfirmante" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="cbxCiaSeguros" Name="aseguradoraid" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtContactoCiaSeguros" Name="nombreresponsable"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTelefonoContactoCia" Name="telefonoresponsable"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmailContactoCia" Name="emailresponsable" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="asbBroker" Name="brokerId" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtContactoCorredor" Name="nombreresponsableBroker"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTelefonoContactoCorredor" Name="telefonoresponsableBroker"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmailContactoCorredor" Name="emailresponsableBroker"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtNumeroSiniestro" Name="numeroSiniestroCia" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtNumeroSiniestroBroker" DefaultValue="" Name="numeroSiniestroBroker"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtFechaHoraSiniestro" Name="fsiniestro" PropertyName="Text"
                Type="DateTime" />
            <asp:ControlParameter ControlID="txtLugarDelSiniestro" Name="lugarsiniestro" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtDatoUbigeo" Name="ubigeoid" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="cbxTipoSiniestro" Name="tiposiniestro_id" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtContactoPersona" Name="nombreresponsableSiniestro"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTelefonoContacto" Name="telefonoresponsableSiniestro"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmailContacto" Name="emailresponsableSiniestro"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDescripcion" Name="descripcion" PropertyName="Text"
                Type="String" />
            <asp:SessionParameter Name="usuario" SessionField="NombreUsuario" Type="String" />
            <asp:ControlParameter ControlID="txtPolizaId" Name="polizaid" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="cbxAjustador" Name="ajustadorid" PropertyName="SelectedValue"
                Type="Decimal" />           
            <asp:ControlParameter ControlID="cbxEjecutivoSiniestros" DefaultValue="" 
                Name="ejecutivosiniestrosid" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="txtFechaHoraCoordinacion" Name="FechaHoraCoordinacion"
                PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="txtFechaHoraProgramacionInspeccion" DefaultValue=""
                Name="FechaHoraCoordinacionInspeccion" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="txtFechaHoraReunion" Name="FechaHoraReunion" PropertyName="Text"
                Type="DateTime" />
            <asp:ControlParameter ControlID="txtDatoUbigeoInspeccion" Name="ubigeoidInspeccion"
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtPersonaContactoInspeccion" Name="personacontacto"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="cbxTipoAjuste" Name="tajusteid" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtDireccionReunion" Name="lugarDeReunion" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtReferenciaReunion" Name="referencia" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtTelefonoContactoInspeccion" Name="telefonoPersonaContacto"
                PropertyName="Text" Type="String" />
            <asp:Parameter DefaultValue="" Direction="ReturnValue" Name="RETURN_VALUE" 
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="odsNuevoAjusteAseguradora1" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
        InsertCommand="sp_rgen_Ajuste_Parcial_Insert" InsertCommandType="StoredProcedure"
        SelectCommand="sp_rgen_Ajuste_Parcial_Select" SelectCommandType="StoredProcedure"
        OnInserted="odsNuevoAjusteAseguradora1_Inserted">
        <SelectParameters>
            <asp:Parameter Name="ajusteid" Type="Decimal" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Direction="InputOutput" Name="numeroAjuste" Type="String" DefaultValue="&quot;1&quot;"
                Size="30" />
            <asp:ControlParameter ControlID="cbxQuienNotifico" Name="quienNotifico" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="txtNotificante" DefaultValue="" Name="NombreDelNotificante"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtFechaHoraAviso" Name="faviso" PropertyName="Text"
                Type="DateTime" />
            <asp:ControlParameter ControlID="cbxTipoComunicacion" Name="medioDeNotificacionId"
                PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="txtNombreConfirmante" Name="NombreQuienConfirma"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtFechaConfirmacion" Name="FechayHoraConfirmacion"
                PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="cbxTipoComunicacionConfirmacion" Name="medioConfirmacionId"
                PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="txtPuesto" Name="cargoconfirmante" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="cbxCiaSeguros" Name="aseguradoraid" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtContactoCiaSeguros" Name="nombreresponsable"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTelefonoContactoCia" Name="telefonoresponsable"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmailContactoCia" Name="emailresponsable" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="asbBroker" Name="brokerId" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtContactoCorredor" Name="nombreresponsableBroker"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTelefonoContactoCorredor" Name="telefonoresponsableBroker"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmailContactoCorredor" Name="emailresponsableBroker"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtNumeroSiniestro" Name="numeroSiniestroCia" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtNumeroSiniestroBroker" DefaultValue="" Name="numeroSiniestroBroker"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtFechaHoraSiniestro" Name="fsiniestro" PropertyName="Text"
                Type="DateTime" />
            <asp:ControlParameter ControlID="txtLugarDelSiniestro" Name="lugarsiniestro" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtDatoUbigeo" DefaultValue="" Name="ubigeoid" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="cbxTipoSiniestro" Name="tiposiniestro_id" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtContactoPersona" Name="nombreresponsableSiniestro"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTelefonoContacto" Name="telefonoresponsableSiniestro"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtEmailContacto" Name="emailresponsableSiniestro"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDescripcion" Name="descripcion" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtPolizaId" Name="polizaid" PropertyName="Text"
                Type="Decimal" />
            <asp:Parameter DefaultValue="" Direction="InputOutput" Name="ajuId" Size="10" Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsTiposDeSiniestroByRamoId" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
        SelectCommand="sp_rgnx_selectTipoSiniestroByRamoId" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtRamoId" Name="ramoId" PropertyName="Text" Type="Decimal"
                DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script type="text/javascript">
        creaPopUpDivs();
    </script>

</body>
</html>
