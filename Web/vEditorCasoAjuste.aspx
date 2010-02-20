<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vEditorCasoAjuste.aspx.cs"
    Inherits="vEditorCasoAjuste" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>    
    <link rel='stylesheet' type='text/css' href='css/layout.css' />
    <link rel='stylesheet' type='text/css' href='Scripts/tabCSS/v3.css' />
    <!--<link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_def.css' />-->
    <link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_dyn.css' />
    <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/subModal.css' />
    <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/style.css' />
    <title>Riesgos Generales | Editor Caso de Ajuste </title>

    <script type='text/javascript' src="Scripts/lib/x_core.js"></script>

    <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>

    <script type='text/javascript' src="Scripts/lib/xtabpanelgroup.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

    <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

    <script type='text/javascript'>
    
    
    window.onload = function()
    {
        if (window.winOnLoad) window.winOnLoad();
    	
    }
    window.onunload = function()
    {
        if (window.winOnUnload) window.winOnUnload();
    }
    </script>

    <script type='text/javascript'>
    //document.write("<link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_dyn.css'>");

    //cargamos los datos del estado del ajuste para controlar el avance a traves de los tabs...
    var estadoActualAjuste;
    var NumeroAjuste = "";
    function cargaDatosAjuste() {
		var elemento = xGetElementById('lblNumAjuste');
        var NumeroAjuste = utiles.ajax.gestorAjax.getNumeroAjuste('<%=qStringAjusteId%>').value;
		//alert(estadoActualAjuste + " " + NumeroAjuste);        
		estadoActualAjuste = utiles.ajax.gestorAjax.getEstadoActual('<%=qStringAjusteId%>').value;
        if (estadoActualAjuste >= 3) estadoActualAjuste = estadoActualAjuste - 1;		
		elemento.innerHTML = NumeroAjuste;
		
		
    }
    
    function imprimeCaratula() {
        ShowReport('vViewPdf.aspx?AjusteId=<%=qStringAjusteId %>&TI=HR');
        return false;
    }
    

    function recargaDatos() 
    {
        pageToLoad = 0;
        tpg1.select(1);
        cargaDatosAjuste();
        cargaIframes();
    }
	function muestraPopUp(elemento,ancho,alto) {		
	    tpg1.select(1);
	    if ((ancho) && (alto)) {
	        showPopWin(elemento.href, ancho, alto, null);		
	    }
	    else {
		    showPopWin(elemento.href, 758, 570, null);		
		}
		return false;
	}    
	
    
    var tpg1;
    function gotoPage1() 
    {       
        tpg1.select(2);
        recargaPaginaInterna(1);
        return false;
    }
        
function validaTabPage() {
    var actualIndex = tpg1.getSelectedIndex();
    var anteriorIndex = tpg1.getLastSelectedIndex();
    var estadoActual = estadoActualAjuste;	    
    if (estadoActual = 5) estadoActual = 6;
    if (actualIndex > estadoActual) {
        tpg1.select(anteriorIndex+1);
        return false;
    }
    
    //return true
}


function recargaPaginaInterna(myPage) {
      var ifrm;
      var thisDate = new Date();
	  switch (myPage) {
	    case 0 :
	    
	      if (estadoActualAjuste >= 0) {
		      ifrm = xGetElementById('iframeFlujoGrafico');
		      ifrm.src = 'vFlujoGrafico_.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;;
          }
		  
	      break;
	    case 1 : 
	     if (estadoActualAjuste >= 1) {
	      ifrm = xGetElementById('ifrmRegistroInicial');
	      ifrm.src = 'vEditorRegistroInicialAjuste.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
         }
	      
    	  break;
        case 2 :
        if (estadoActualAjuste >= 2) {
	              ifrm = xGetElementById('ifrmRegistroBasico');
	              ifrm.src = 'vEditorRegistroBasico.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
        }      

        break;
        case 3:

        if (estadoActualAjuste >= 3) {
	          ifrm = xGetElementById('ifrmRegistroPreliminar');
	          ifrm.src = 'vRegistroPreliminar.aspx?AjusteId=<%=qStringAjusteId %>&tInforme=P&tmstamp='+thisDate;
	    }
    	break;
        case 4:  
	      if (estadoActualAjuste >= 4) {
	          ifrm = xGetElementById('ifrmRegistroComplementario');
	          ifrm.src = 'vRegistroPreliminar.aspx?AjusteId=<%=qStringAjusteId %>&tInforme=C&tmstamp='+thisDate;
	      }    


    	  break;
    	case 5:
	          if (estadoActualAjuste >= 3) {
	              ifrm = xGetElementById('ifrmConvenioAjuste');
	              ifrm.src = 'vConvenioAjuste.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
              }

	      break;
	    case 6: 
              if (estadoActualAjuste >= 3) {
	              ifrm = xGetElementById('ifrmInformeFinal');	      
	              ifrm.src = 'vRegistroFinal.aspx?AjusteId=<%=qStringAjusteId %>&tInforme=F&tmstamp='+thisDate;
	          }    
	      break;  		
	  }
}


var pageToLoad = 0;
function cargaIframes() {
      var ifrm;
      var thisDate = new Date();
	  
	  if (estadoActualAjuste >= 0) {
		  ifrm = xGetElementById('iframeFlujoGrafico');
		  ifrm.src = 'vFlujoGrafico_.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;;
      }/*
      if (estadoActualAjuste >= 1) {
	      ifrm = xGetElementById('ifrmRegistroInicial');
	      ifrm.src = 'vEditorRegistroInicialAjuste.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
      }
      if (estadoActualAjuste >= 2) {
	      ifrm = xGetElementById('ifrmRegistroBasico');
	      ifrm.src = 'vEditorRegistroBasico.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
      }
      
      if (estadoActualAjuste >= 3) {
	      ifrm = xGetElementById('ifrmRegistroPreliminar');
	      ifrm.src = 'vRegistroPreliminar.aspx?AjusteId=<%=qStringAjusteId %>&tInforme=P&tmstamp='+thisDate;
	  }
	  if (estadoActualAjuste >= 4) {
	      ifrm = xGetElementById('ifrmRegistroComplementario');
	      ifrm.src = 'vRegistroPreliminar.aspx?AjusteId=<%=qStringAjusteId %>&tInforme=C&tmstamp='+thisDate;
	  }    
	  if (estadoActualAjuste >= 5) {
	      ifrm = xGetElementById('ifrmConvenioAjuste');
	      ifrm.src = 'vConvenioAjuste.aspx?AjusteId=<%=qStringAjusteId %>&tmstamp='+thisDate;
      }
      if (estadoActualAjuste >= 5) {
	      ifrm = xGetElementById('ifrmInformeFinal');	      
	      ifrm.src = 'vRegistroFinal.aspx?AjusteId=<%=qStringAjusteId %>&tInforme=F&tmstamp='+thisDate;
	  }    
	  */
}
function salDelAjuste() {
    document.location.href = 'vListaAjuste.aspx';
}

function recargaPagina(evt) {
    try {
        var myEv = new xEvent(evt);
        
        recargaPaginaInterna(myEv.target.mypage);
    }
    catch (e) {
        
    }
}


function winOnLoad()
{
	try {   
	      cargaDatosAjuste();	          	  
	      var lnk = xGetElementById('lnkGraficoFlujo');	  	  
	      lnk.mypage = 0;
	      xAddEventListener(lnk,'click',recargaPagina,true);
	      /*xAddEventListener(lnk,'click',validaTabPage,true);	      
	      xAddEventListener(lnk,'mouseout',validaTabPage,true);*/
    	  
	      lnk = xGetElementById('lnkRegistroInicial');	  
	      /*xAddEventListener(lnk,'click',validaTabPage,true);*/
	      lnk.mypage = 1;
   	      xAddEventListener(lnk,'click',recargaPagina,true);	  
	      /*xAddEventListener(lnk,'mouseout',validaTabPage,true);*/
    	  
	      lnk = xGetElementById('lnkRegistroBasico');	 	
	      lnk.mypage = 2;  
	      /*xAddEventListener(lnk,'click',validaTabPage,true);*/
   	      xAddEventListener(lnk,'click',recargaPagina,true);	  
	      /*xAddEventListener(lnk,'mouseout',validaTabPage,true);*/
    	  
    	  
	      lnk = xGetElementById('lnkRegistroPreliminar');	  	  
	      lnk.mypage = 3;
	      //xAddEventListener(lnk,'click',validaTabPage,true);
   	      xAddEventListener(lnk,'click',recargaPagina,true);	  
	      //xAddEventListener(lnk,'mouseout',validaTabPage,true);	  
    	  
	      lnk = xGetElementById('lnkRegistroComplementario');	  	  
	      
	      lnk.mypage = 4;
	      //xAddEventListener(lnk,'click',validaTabPage,true);	  
   	      xAddEventListener(lnk,'click',recargaPagina,true);	  	      
          //xAddEventListener(lnk,'mouseout',validaTabPage,true);
    	  
	      lnk = xGetElementById('lnkConvenioAjuste');	  	  
	      lnk.mypage = 5;
	      //xAddEventListener(lnk,'click',validaTabPage,true);	  
   	      xAddEventListener(lnk,'click',recargaPagina,true);	  	     
	      //xAddEventListener(lnk,'mouseout',validaTabPage,true);
    	  
	      lnk = xGetElementById('lnkInformeFinal');	  	  
	      //xAddEventListener(lnk,'click',validaTabPage,true);	  
	      lnk.mypage = 6;
   	      xAddEventListener(lnk,'click',recargaPagina,true);	  	      
	      //xAddEventListener(lnk,'mouseout',validaTabPage,true);
    	     
	    setTimeout ('cargaIframes()', 1000); 
		 
	    
	}
	catch(e) {
		alert('Error en =' + e.message);
	}
}


window.onunload = function()
{
  if (tpg1) tpg1.onUnload(); 
}
    </script>

    <script type="text/javascript">
	var cabeceraVisible = true;
	//oculta o muestra la cabecera segun el estado de la misma 
	function MuestraOculta(imagen) {
		var seccion = document.getElementById('contenedorSuperior');		
		seccion.style.display = (cabeceraVisible)?"none":"block";
		imagen.src = (!cabeceraVisible)?"imgRGen/openCloseCollapse.jpg":"imgRGen/openCloseCollapse.jpg";
		cabeceraVisible = !cabeceraVisible;
	}
    </script>

    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; position: relative; width: 900px;">
            <div id="contenedorSuperior">
                <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="ajuste"/>
                <uc2:linksAjustadorAdministrador ID="LinksAjustadorAdministrador1" runat="server" />
            </div>
            <!-- opciones de Ajuste -->
            <div>
                <div class="DataTop">
                    <div class="DataTopLeft">
                    </div>
                    <div class="DataTopRight">
                    </div>
                </div>
                <div class="DataContent">
                    <div class="DataContentRight">
                        <div style="width: 880px; height: 65px; position: relative;">
                            <div id="OtrasOpciones" style="left: 7px; width: 820px; top: 11px">
							  <a id='lnkImprimirCaratula' href='#'
                                    onclick="return imprimeCaratula();" class='tabOtrasOpciones' runat="server" style="width: 100px;
                                    float: left;"><span style="position: absolute; left: 24px; top: 3px;" class='TextoLinkTab'>
                                        Imprimir<br />
                                        Carátula </span></a>
							
							
							
                            <a id='lnkFinalizar' href=''
                                    onclick="return muestraPopUp(this,660,300);" class='tabOtrasOpciones' runat="server" style="width: 100px;
                                    float: left;"><span style="position: absolute; left: 126px; top: 3px;" class='TextoLinkTab'>
                                        Finalizar<br />
                                        Ajuste </span></a>
                                        <a id='lnkEliminarAjuste' runat="server" href='vEliminarCasoAjuste.aspx?AjusteId=<%=qStringAjusteId %>'
                                    onclick="return muestraPopUp(this,660,240);" class='tabOtrasOpciones' style="width: 100px;
                                    float: left;"><span style="position: absolute; left: 228px; top: 4px;" class='TextoLinkTab'>
                                        Eliminar<br />
                                        Ajuste </span></a>
                                <a id='lnkSolicitudDocumentos' href='vDocumentos.aspx?AjusteId=<%=qStringAjusteId %>'
                                    onclick="return muestraPopUp(this,745,470)" class='tabOtrasOpciones' style="width: 100px;
                                    float: left;"><span style="position: absolute; left: 316px; top: 3px;" class='TextoLinkTab'>
                                        Solicitud<br />
                                        Documentos </span></a><a id='lnkBitacoras' href='vBitacoras.aspx?AjusteId=<%=qStringAjusteId %>'
                                            onclick="return muestraPopUp(this,810,600);" class='tabOtrasOpciones' style="width: 100px;
                                            float: left;"><span style="position: absolute; left: 430px; top: 10px;" class='TextoLinkTab'>
                                                Bitácoras </span></a><a id='lnkInformes' href='vListaInforme.aspx?AjusteId=<%=qStringAjusteId %>'
                                                    onclick="return muestraPopUp(this,700,480);" class='tabOtrasOpciones' style="width: 100px;
                                                    float: left;"><span style="position: absolute; left: 533px; top: 10px;" class='TextoLinkTab'>
                                                        Informes </span></a><a id='lnkInformacionRelevante' href='vInformacionRelevante.aspx?AjusteId=<%=qStringAjusteId %>'
                                                            onclick="return muestraPopUp(this);" class='tabOtrasOpciones' style="width: 100px;
                                                            float: left;"><span style="position: absolute; left: 624px; top: 3px;" class='TextoLinkTab'>
                                                                Información<br />
                                                                Relevante </span></a><a id='lnkObvservacion' href='vRegistroObservacion.aspx?AjusteId=<%=qStringAjusteId %>'
                                                                    onclick="return muestraPopUp(this,660,190);" class='tabOtrasOpciones' style="width: 100px;
                                                                    float: left;"><span style="position: absolute; left: 724px; top: 4px;" class='TextoLinkTab'>
                                                                        Registrar<br />
                                                                        Observación</span></a>
                                <div id="btnLayerHide" style="left: 855px; top: -9px; width: 21px; height: 25px;">
                                    <img src="imgRGen/openCloseCollapse.jpg" title="cerrar / mostrar cabecera" alt="cerrar / mostrar cabecera"
                                        width="16" height="16" style="cursor: hand; cursor: pointer;" onclick="MuestraOculta(this);" /></div>
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
            <!-- paneles de RGen-->
            <div style="width: 900px; position: relative;">
                <div class="DataTop">
                    <div class="DataTopLeft">
                    </div>
                    <div class="DataTopRight">
                    </div>
                </div>
                <div class="DataContent">
                    <div class="DataContentRight" style="width: 880px;">
                        <div id="cabecera" style="height: 30px;">
                            <asp:Label ID="lblNumAjuste" runat="server" Font-Bold="True" Font-Size="18px" Text="Ajuste Nº PA-2006-2"></asp:Label>
                            <asp:HyperLink onclick="alert(estadoActualAjuste);" ID="HyperLink1" runat="server" Visible="False">HyperLink</asp:HyperLink>
                            <asp:HyperLink runat="server" style="position:absolute; left: 738px; top: 7px;" ID="lnkAdminEstados"  onclick="return muestraPopUp(this,560,340);" Font-Bold="True" Width="148px">Administrar Estados</asp:HyperLink>
                            
                            </div>
                        <div>
                            <div id='tpg1' class='tabPanelGroup'>
                                <div class='tabGroup' style="position: relative;">
                                    <a id='lnkGraficoFlujo' href='#GraficoFlujo' class='tabDefault'>
                                        <br />
                                        Flujo<br />
                                        Grafico </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkRegistroInicial'
                                            href='#RegistroInicial' class='tabDefault'>
                                            <br />
                                            Registro<br />
                                            Inicial </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkRegistroBasico'
                                                href='#RegistroBasico' class='tabDefault'>
                                                <br />
                                                Registro<br />
                                                B&aacute;sico </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkRegistroPreliminar'
                                                    href='#RegistroPreliminar' class='tabDefault'>
                                                    <br />
                                                    Registro<br />
                                                    Preliminar </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkRegistroComplementario'
                                                        href='#RegistroComplementario' class='tabDefault'>
                                                        <br />
                                                        Registro<br />
                                                        Complementario </a><span class='linkDelim'>&nbsp;|&nbsp;</span>
                                    <a id='lnkConvenioAjuste' href='#ConvenioAjuste' class='tabDefault'>
                                        <br />
                                        Convenio<br />
                                        de Ajuste </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkInformeFinal'
                                            href='#InformeFinal' class='tabDefault'>
                                            <br />
                                            Informe<br />
                                            Final </a>
                                </div>
                                <div id='GraficoFlujo' class='tabPanel'>
                                    <iframe id="iframeFlujoGrafico"  scrolling="no" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%"></iframe>
                                </div>
                                <div id='RegistroInicial' class='tabPanel'>
                                    <iframe id="ifrmRegistroInicial" src="blankPage.aspx?AjusteId=<%=qStringAjusteId%>"  scrolling="no" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%"></iframe>
                                </div>
                                <div id='RegistroBasico' class='tabPanel'>
                                    <iframe id="ifrmRegistroBasico" src="blankPage.aspx?AjusteId=<%=qStringAjusteId%>"  scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%"></iframe>
                                </div>
                                <div id='RegistroPreliminar' class='tabPanel'>
                                    <iframe id="ifrmRegistroPreliminar" src="blankPage.aspx?AjusteId=<%=qStringAjusteId%>"  scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%"></iframe>
                                </div>
                                <div id='RegistroComplementario' class='tabPanel' style="margin: 0px;">
                                    <iframe id="ifrmRegistroComplementario" src="blankPage.aspx?AjusteId=<%=qStringAjusteId%>"  scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%"></iframe>
                                </div>
                                <div id='ConvenioAjuste' class='tabPanel' style="margin: 0px;">
                                    <iframe id="ifrmConvenioAjuste" src="blankPage.aspx?AjusteId=<%=qStringAjusteId%>"  scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%"></iframe>
                                </div>
                                <div id='InformeFinal' class='tabPanel' style="margin: 0px;">
                                    <iframe id="ifrmInformeFinal" src="blankPage.aspx?AjusteId=<%=qStringAjusteId%>"  scrolling="auto" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%"></iframe>
                                </div>
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
        </div>

        <script type="text/javascript" language="javascript">
		    	creaPopUpDivs();
        </script>

    </form>
	<script type="text/javascript">
		tpg1 = new xTabPanelGroup('tpg1', 880, 790, 40, 'tabPanel', 'tabGroup', 'tabDefault', 'tabSelected');
	</script>
</body>
</html>
