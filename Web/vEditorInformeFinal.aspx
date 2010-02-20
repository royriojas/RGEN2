<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vEditorInformeFinal.aspx.cs" Inherits="vEditorInformeFinal" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel='stylesheet' type='text/css' href='css/layout.css' />
    <link rel='stylesheet' type='text/css' href='Scripts/tabCSS/v3.css' />
    <!--<link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_def.css' />-->
    <link rel='stylesheet' type='text/css' href='Scripts/tabCSS/tpg_dyn.css'/>
	
	<link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/subModal.css'/>
	<link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/style.css'/>
	
    <title>Riesgos Generales | Editor Informe Final </title>

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
       
var tpg1;
function winOnLoad()
{
	try {

	  tpg1 = new xTabPanelGroup('tpg1', 880, 780, 40, 'tabPanel', 'tabGroup', 'tabDefault', 'tabSelected');

	  var ifrm = xGetElementById('ifrmSecciones');
	  ifrm.src = 'vSeccionesInformeFinal.aspx?AjusteId=<%=qStringAjusteId %>';
	  
	  ifrm = xGetElementById('ifrmListaSecciones');
	  ifrm.src = 'vListaSecciones.aspx?AjusteId=<%=qStringAjusteId %>';
	  
	  
	    
	}
	catch(e) {
		alert(e);
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
		imagen.src = (!cabeceraVisible)?"imgRGen/close.gif":"imgRGen/open.gif";
		cabeceraVisible = !cabeceraVisible;
	}
</script>

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    
    
    
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; position: relative; width: 900px;">
        
            <div id="contenedorSuperior">
              <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="ajuste" />
              <uc2:linksAjustadorAdministrador ID="LinksAjustadorAdministrador1" runat="server" />
          </div>
			
            <!-- opciones de Ajuste -->
            <div>
                <div class="DataTop" >
                    <div class="DataTopLeft">
                    </div>
                    <div class="DataTopRight">
                    </div>
                </div>
                <div class="DataContent">
                    <div class="DataContentRight">
                        <div style="width: 880px; height:65px; position: relative;">
						<div id="OtrasOpciones">
							<a id='lnkSolicitudDocumentos' href='vDocumentos.aspx?AjusteId=<%=qStringAjusteId %>' onclick="return muestraPopUp(this);" class='tabOtrasOpciones' style="width:100px;float:left;" >
                                <span class='TextoLinkTab'>
                                	Solicitud<br />
                                    Documentos								</span>
                          </a>
						  <a id='lnkBitacoras' href='vBitacoras.aspx?AjusteId=<%=qStringAjusteId %>' onclick="return muestraPopUp(this);" class='tabOtrasOpciones' style="width:100px;float:left;">
                                <span class='TextoLinkTab'>
                                	Bitácoras
								</span>
                          </a>
						  <a id='lnkInformes' href='vInformes.aspx?AjusteId=<%=qStringAjusteId %>' class='tabOtrasOpciones' style="width:100px;float:left;" >
                                <span class='TextoLinkTab'>
                                	Informes
								</span>
                          </a>
						  <a id='lnkInformacionRelevante' href='vInformacionRelevante.aspx?AjusteId=<%=qStringAjusteId %>' onclick="return muestraPopUp(this);"  class='tabOtrasOpciones' style="width:100px;float:left;">
                                <span class='TextoLinkTab'>
                                	Información<br />Relevante
								</span>
                          </a>
						  <div id="btnLayerHide">
						  <img src="imgRGen/close.gif"  title="cerrar / mostrar cabecera"  alt="cerrar / mostrar cabecera" width="16" height="10" style="cursor:hand;cursor:pointer;" onclick="MuestraOculta(this);" /></div>
							<div id="Seccionbusqueda">
							  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="17" valign="middle" ><label></label></td>
                                  <td width="236" valign="middle" ><input name="textfield" type="text" class="FormText" style="width: 223px" /></td>
                                  <td width="73" valign="middle" ><button class="FormButton" id="btn">Buscar</button></td>
                                </tr>
                              </table>
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
         
            <!-- paneles de RGen-->
            <div style="width: 900px;position: relative;">
                <div class="DataTop">
                    <div class="DataTopLeft">
                    </div>
                    <div class="DataTopRight">
                    </div>
                </div>
                <div class="DataContent">
                    <div class="DataContentRight" style="width:880px;">
					<div id="cabecera" style="height:30px;">
                        <asp:Label ID="lblNumAjuste" runat="server" Font-Bold="True" Font-Size="18px" Text="Ajuste Nº PA-2006-2"></asp:Label>
                        </div>
                        <div>
                            <div id='tpg1' class='tabPanelGroup'>
                                <div class='tabGroup' style="position: relative;">
                                    <a id='lnkSecciones' href='#Secciones' class='tabDefault'>                                        
                                        <br />
                                        Secciones
                                        <br />
                                        
                                    </a><span class='linkDelim'>&nbsp;|&nbsp;</span> <a id='lnkListaSecciones' href='#lnkListaSecciones'
                                        class='tabDefault'>
                                        <br />
                                            Lista<br />
                                            Secciones
                                    </a>
                                </div>
                                
                                <div id='Secciones' class='tabPanel'>
                                    <iframe id="ifrmSecciones" scrolling="no" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%" ></iframe>
                                </div>
                                <div id='ListaSecciones' class='tabPanel'>
                                    <iframe id="ifrmListaSecciones" scrolling="no" frameborder="0" style="border-width: 0px;
                                        width: 100%; height: 100%" ></iframe>
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
</body>
</html>
