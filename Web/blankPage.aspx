<%@ Page Language="C#" AutoEventWireup="true" CodeFile="blankPage.aspx.cs" Inherits="blankPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ajuste</title>

    <script type="text/javascript" src="Scripts/lib/x_core.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_dom.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

    <style type="text/css">
<!--
.panelComments {
	font-family: Arial, Helvetica, sans-serif;
	background-color: #FFFFCC;
	padding: 10px;
	
	margin-bottom:10px;
}
p {
	margin: 0px;
}
table {
	font-size:12px;
	border-top:1px #3399CC solid;
	border-right:1px #3399CC solid;
}
table span {
	
}
table td {
	border-left:1px #3399CC solid;
	border-bottom:1px #3399CC solid;
	padding:5px;
}
.Titulo {
	font-size:20px;
	font-weight:bold;
	margin-top:5px;
	margin-bottom:5px;	
}
.texto {
	font-size:12px;
	margin-bottom:5px;
	
}
.Estilo1 {font-size: 20px; font-weight: bold;  margin-bottom: 5px; color: #003366; }
.Estilo6 {font-size: 12px; margin-bottom: 5px; font-weight: bold; color: #FFFFFF; }
-->
</style>

    <script type="text/javascript">
       window.onload = function () {
        var x = new CollapsibleDiv('trg_gridContainer','gridContainer',null,null);
        var y = new CollapsibleDiv('trg_gridContainerRapido','gridContainerRapido',null,null);
       }

    
    </script>
    
</head>
<body>
    <form id="myform" runat="server">
        <div class="panelComments" style="position: relative;">
            <p class="Estilo1">
                ESTA P�GINA NO EST� DISPONIBLE</p>
            <p class="texto">
                Esta p&aacute;gina no se encuentra disponible, las posibles causas son: que el <strong>
                    estado actual del ajuste</strong> no le permite visualizar esta secci&oacute;n
                o el ajuste posiblemente se encuentra en <strong>Control de Calidad,</strong> complete
                los pasos anteriores para poder entrar en esta secci&oacute;n.</p>
            <p class="texto">
                Puede revisar la tabla siguiente para verificar que el ajuste se encuentra en el
                estado necesario para tener acceso a la funcionalidad requerida.
            </p>
            <p class="texto">
                &nbsp;</p>
            <p class="texto">
                <table width="497" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="211" height="25" bgcolor="#FFFFFF">
                            <span class="texto">El estado actual del Ajuste es :</span></td>
                        <td height="25" bgcolor="#FFFFFF" style="width: 286px">
                            <p class="resaltado">
                                <strong>
                                    <asp:Label ID="lblEstadoActual" runat="server" Text="Label"></asp:Label></strong>&nbsp;</p>
                        </td>
                    </tr>
                    <tr>
                        <td height="25" bgcolor="#FFFFFF">
                            <span class="texto">El Tipo de Ajuste es : </span>
                        </td>
                        <td height="25" bgcolor="#FFFFFF" style="width: 286px">
                            <p class="resaltado">
                                <strong>
                                    <asp:Label ID="lblTipoAjuste" runat="server" Text="Label"></asp:Label></strong>&nbsp;</p>
                        </td>
                    </tr>
                </table>
            </p>
        </div>
        <div class="panelComments" style="position: relative;">
            <p id='trg_gridContainer' class="texto">
                <strong>Haga Clic aqu� para revisar las reglas de acceso definidas para un ajuste Normal.</strong></p>
            <div id='gridContainer' style="display:none;">
                <table width="761" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="168" height="25" background="images/BgGradBlue.jpg">
                            <span class="Estilo6">Estado</span></td>
                        <td width="325" height="25" background="images/BgGradBlue.jpg">
                            <span class="Estilo6">Descripci&oacute;n</span></td>
                        <td width="267" background="images/BgGradBlue.jpg">
                            <span class="Estilo6">Puede accesar a:</span></td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Solicitado</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Estado Inicial cuando el Caso de Ajuste aun no tiene ajustador asignado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            Flujo Gr&aacute;fico
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Iniciado</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            El Caso de Ajuste tiene asignado un Ajustador</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Inspecci&#243;n Coordinada</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Apenas se coordina la inspecci&#243;n con el asegurado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Inspecci&#243;n</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha realizado la inspecci&#243;n</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial</p>
                            <p>
                                Registro B&aacute;sico
                            </p>
                            <p>
                                Solicitud de Documentos
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Informe B&#225;sico</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha generado ya el informe b&#225;sico y este ha sido validado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial</p>
                            <p>
                                Registro B&aacute;sico</p>
                            <p>
                                Registro Preliminar
                            </p>
                            <p>
                                Solicitud de Documentos</p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Informe Preliminar</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha generado ya el informe preliminar y este ha sido validado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial</p>
                            <p>
                                Registro B&aacute;sico</p>
                            <p>
                                Registro Preliminar</p>
                            <p>
                                Registro Complementario
                            </p>
                            <p>
                                Solicitud de Documentos</p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Informe Complementario</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha generado por lo menos un complementario validado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial</p>
                            <p>
                                Registro B&aacute;sico</p>
                            <p>
                                Registro Preliminar</p>
                            <p>
                                Registro Complementario
                            </p>
                            <p>
                                Convenio de Ajuste
                            </p>
                            <p>
                                Solicitud de Documentos</p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Convenio</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se tiene ya registrado el texto del convenio de ajuste</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial</p>
                            <p>
                                Registro B&aacute;sico</p>
                            <p>
                                Registro Preliminar</p>
                            <p>
                                Registro Complementario
                            </p>
                            <p>
                                Convenio de Ajuste
                            </p>
                            <p>
                                Informe Final
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Informe Final</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha elaborado el informe final</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial</p>
                            <p>
                                Registro B&aacute;sico</p>
                            <p>
                                Registro Preliminar</p>
                            <p>
                                Registro Complementario
                            </p>
                            <p>
                                Convenio de Ajuste
                            </p>
                            <p>
                                Informe Final</p>
                            <p>
                                Finalizar Caso
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Finalizado</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha devuelto el informe final y se da por cerrado el caso de Ajuste</td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            TODO
                        </td>
                    </tr>
                </table>
            </div>
            <p class="texto">
                &nbsp;</p>
            <p id='trg_gridContainerRapido' class="texto">
                <strong>Haga Clic aqu� para revisar las reglas de acceso definidas para un ajuste R�pido.</strong></p>
                <div id="gridContainerRapido" style="display:none;">
                
                <table width="761" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="168" height="25" background="images/BgGradBlue.jpg">
                            <span class="Estilo6">Estado</span></td>
                        <td width="325" height="25" background="images/BgGradBlue.jpg">
                            <span class="Estilo6">Descripci&oacute;n</span></td>
                        <td width="267" background="images/BgGradBlue.jpg">
                            <span class="Estilo6">Puede accesar a:</span></td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Solicitado</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Estado Inicial cuando el Caso de Ajuste aun no tiene ajustador asignado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            Flujo Gr&aacute;fico
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Iniciado</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            El Caso de Ajuste tiene asignado un Ajustador</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p><p>
                                    Registro Inicial</p>
                            <p>
                                Convenio de Ajuste
                            </p>
                            <p>
                                Informe Final
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Inspecci&#243;n Coordinada</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Apenas se coordina la inspecci&#243;n con el asegurado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            --</td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Inspecci&#243;n</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha realizado la inspecci&#243;n</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                --</p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Informe B&#225;sico</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha generado ya el informe b&#225;sico y este ha sido validado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                --</p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Informe Preliminar</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha generado ya el informe preliminar y este ha sido validado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                --</p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Informe Complementario</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha generado por lo menos un complementario validado</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                --</p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Convenio</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se tiene ya registrado el texto del convenio de ajuste</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p>
                            <p>
                                Registro Inicial</p>
                            <p>
                                Convenio de Ajuste
                            </p>
                            <p>
                                Informe Final
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Con Informe Final</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha elaborado el informe final</td>
                        <td width="267" height="40" valign="top" bgcolor="#FFFFFF">
                            <p>
                                Flujo Gr&aacute;fico</p><p>
                                    Registro Inicial</p>
                            <p>
                                Convenio de Ajuste
                            </p>
                            <p>
                                Informe Final
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            <strong>Finalizado</strong></td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Cuando se ha devuelto el informe final y se da por cerrado el caso de Ajuste</td>
                        <td height="40" valign="top" bgcolor="#FFFFFF">
                            Flujo Gr�fico<p>
                                Registro Inicial</p>
                            <p>
                                Convenio de Ajuste
                            </p>
                            <p>
                                Informe Final
                            </p>
                        </td>
                    </tr>
                </table>
                </div>
        </div>
    </form>
</body>
</html>
