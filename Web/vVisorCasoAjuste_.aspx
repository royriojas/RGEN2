<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vVisorCasoAjuste_.aspx.cs"
    Inherits="vVisorCasoAjuste_" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="RgenControl_.ascx" TagName="RgenControl" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Flujo Gr&aacute;fico</title>
    <style type="text/css">
	body {
		background:#4C96C9;
	}
	.tipGrp4s {
		position:absolute;
		visibility:hidden;
		overflow:hidden;
		color:#330;
		background:#ffc;
		border:1px solid #330;
		margin:0;
		padding:2px;
		width:auto;
		height:auto;
		z-index:10;	
		font-family: Verdana, Arial, Helvetica, sans-serif;
		font-size: 10px;
		line-height: 11px;
	}
	.tipGrp4s p {
		margin:3px;
	}
	
	</style>

     <script type="text/javascript" src="Scripts/functions.js"></script>

    <script type="text/javascript" src="Scripts/lib/xtooltipgroup.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_core.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_dom.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>
    
    <script type="text/javascript" src="Scripts/lib/x__imagencambiante.js"></script>

    <script type="text/javascript">
 	
 	
    var msg = new Array();
    msg[0]  = "Loading Registro Inicial...";
    msg[1]  = "Loading Registro Avanzado...";
    msg[2]  = "Loading Coordinacion...";
    msg[3]  = "Loading Inspección...";
    msg[4]  = "Loading Informe Básico...";
    msg[5]  = "Loading Informe Preliminar...";
    msg[6]  = "Loading InformeComplementarios...";
    msg[7]  = "Loading Convenio...";
    msg[8]  = "Loading Informe Final...";
    msg[9]  = "Loading Datos...";
    msg[10] = "Loading Solicitud Documentos...";    
    msg[11] = "Loading Comunicaciones...";
    msg[12] = "Loading Anexos...";
    msg[13] = "Loading Actividades...";
    msg[14] = "Loading Gastos";

    var estadoActualAjuste = 1;
    var arregloEstados = new Array();
    var documentosfaltantes = 0;
	var tipoAjuste;

    // esta función hace la llamada al gestor de Ajax, para obtener la data del ajuste
    // de manera asíncrona.
      function cargaDatosAjuste() {
		
        var elemento = xGetElementById('lblNumAjuste');
        elemento.innerHTML = utiles.ajax.gestorAjax.getNumeroAjuste('<%=qStringAjusteId%>').value;
        
        msg = utiles.ajax.gestorAjax.getDatosAjuste('<%=qStringAjusteId%>').value;        
	           
		
		estadoActualAjuste = utiles.ajax.gestorAjax.getEstadoActual('<%=qStringAjusteId%>').value;
		documentosfaltantes = utiles.ajax.gestorAjax.getEstadoDocumentos('<%=qStringAjusteId%>').value;
		
		//alert(estadoActualAjuste); 
		recorreArreglo();
	
    }
	function cargaDiasDelAjuste() {
		var dias= new Array();
		dias= utiles.ajax.gestorAjax.getDiasEnLosEstados('<%=qStringAjusteId%>',estadoActualAjuste).value;
	
		for (i = 0; i <= estadoActualAjuste; i++) {
		    try {			
			    arregloEstados[i].setDiasEstado(''+dias[i]);
			}
			catch(e) {
			    //alert(e.message);
			}
		}
	}

    function recorreArreglo() {
	        for (i = 0; i < estadoActualAjuste + 1; i++) {
	            try {
	                arregloEstados[i].imgActiva();
	            }
	            catch(e) {
	                //alert(e.message);
	            }
	        }	    
	        if (documentosfaltantes > 0) {
	            try {
	                arregloEstados[9].imgActiva();
	            }
	            catch(e) {
	                //alert(e.message);
	            }
	        }
	        tipoAjuste = utiles.ajax.gestorAjax.getTipoAjuste('<%=qStringAjusteId%>').value;    
	        if (tipoAjuste == 2) {
	            //arregloEstados[0].imgInactiva();
	            //arregloEstados[1].imgInactiva();
                //arregloEstados[2].imgInactiva();
                //arregloEstados[3].imgInactiva();
                arregloEstados[4].imgInactiva();
                arregloEstados[5].imgInactiva();
                arregloEstados[6].imgInactiva();
                //arregloEstados[7].imgInactiva();
                //arregloEstados[8].imgInactiva();
                arregloEstados[9].imgInactiva();               	            
	        }
		}
	window.onload = function()
	{
	    try {
	    arregloEstados = new Array();
		arregloEstados[0] = new xImagenCambiante('RgenControl1_registroinicial','ctrlImg/registroinicial_over.jpg',false);							
		arregloEstados[1] =	new xImagenCambiante('RgenControl1_registroAvanzado','ctrlImg/registroAvanzado_over.jpg',false);    
		arregloEstados[2] =	new xImagenCambiante('RgenControl1_coordinacioninspeccion','ctrlImg/coordinacioninspeccion_over.jpg',false);
		arregloEstados[3] =	new xImagenCambiante('RgenControl1_inspeccion','ctrlImg/inspeccion_over.jpg',false);
		arregloEstados[4] =	new xImagenCambiante('RgenControl1_informebasico','ctrlImg/informebasico_over.jpg',false);
		arregloEstados[5] =	new xImagenCambiante('RgenControl1_informepreliminar','ctrlImg/informepreliminar_over.jpg',false);
		arregloEstados[6] =	new xImagenCambiante('RgenControl1_informescomplementarios','ctrlImg/informescomplementarios_over.jpg',false);
		arregloEstados[7] =	new xImagenCambiante('RgenControl1_conveniodeajuste','ctrlImg/conveniodeajuste_over.jpg',false);
		arregloEstados[8] =	new xImagenCambiante('RgenControl1_informefinal','ctrlImg/informefinal_over.jpg',false);
		
		arregloEstados[9] = new xImagenCambiante('RgenControl1_solicituddocumentos','ctrlImg/solicituddocumentos_over.jpg',false);
    	 
        cargaDatosAjuste();
	  new xTooltipGroup(['RgenControl1_registroinicial',
						 'RgenControl1_registroAvanzado',
						 'RgenControl1_coordinacioninspeccion', 
						 'RgenControl1_inspeccion',
						 'RgenControl1_informebasico',
						 'RgenControl1_informepreliminar',
						 'RgenControl1_informescomplementarios',
						 'RgenControl1_conveniodeajuste',
						 'RgenControl1_informefinal',
						 'RgenControl1_datos',
						 'RgenControl1_solicituddocumentos'						 
						 ],
						'tipGrp4s',
						'mouse', 
						10, 
						10,
						[(arregloEstados[0].isActive())? "<p>"+msg[0]+"</p>" : "",
						 (arregloEstados[1].isActive())? "<p>"+msg[1]+"</p>" : "",
						 (arregloEstados[2].isActive())? "<p>"+msg[2]+"</p>" : "",

						(arregloEstados[3].isActive())? "<p>"+msg[3]+"</p>" : "",

						 (arregloEstados[4].isActive())? "<p>"+msg[4]+"</p>" : "",

						(arregloEstados[5].isActive())? "<p>"+msg[5]+"</p>" : "",

						 (arregloEstados[6].isActive())? "<p>"+msg[6]+"</p>" : "",

						(arregloEstados[7].isActive())? "<p>"+msg[7]+"</p>" : "",

						 (arregloEstados[8].isActive())? "<p>"+msg[8]+"</p>" : "",

						 "<div>"+msg[9]+"</div>", 
						 (arregloEstados[9].isActive())? "<p>"+msg[10]+"</p>" : ""

						
						]);
						
		if (tipoAjuste != 2) cargaDiasDelAjuste();
		arregloEstados[9].setCursorTo('default');
		
		
		xAddEventListener($('RgenControl1_registroinicial'),'click',gotoRegistroInicial,false);
		xAddEventListener($('RgenControl1_registroAvanzado'),'click',gotoRegistroInicial,false);
		xAddEventListener($('RgenControl1_coordinacioninspeccion'),'click',gotoRegistroInicial,false);
		xAddEventListener($('RgenControl1_inspeccion'),'click',gotoRegistroInicial,false);
		
		}
		catch(e) {
		    alert(e.message);
		}		
	}    
	function gotoRegistroInicial() {
	    WinPopUpMax('vViewRegistroInicial.aspx?AjusteId=<%=qStringAjusteId%>');
	}    
    </script>

    <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/subModal.css' />
    <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/style.css' />

    <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

    <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

    <script type="text/javascript">

	function muestraPopUp(elemento) {		
		showPopWin(elemento.href, 735, 480, null);
		return false;
	}    
		
    </script>

    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; width: 880px; position: relative;">
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="ajuste"/>
            <br />
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight">
                    <div style="height: 30px;">
                        <p id="lblNumAjuste" style="margin: 0px; font-family: verdana arial; font-size: 18px;
                            font-weight: bold;">
                            Ajuste N°
                        </p>
                        <div style="left: 700px; width: 311px; position: absolute; top: 6px; height: 22px">
                            <a onclick="muestraPopUp(this);" href="vListaInforme.aspx?AjusteId=<%=qStringAjusteId%>">
                               <button class="FormButton" id="btnInformacionRelevante" runat="server"> Lista de Informes </button>
                            </a>
                        </div>
                    </div>
                    <div>
                        <uc2:RgenControl ID="RgenControl1" runat="server" />
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
 		<script type="text/javascript" language="javascript">
			creaPopUpDivs();
		</script>
    </form>
</body>
</html>
