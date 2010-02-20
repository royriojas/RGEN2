<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vCreaSolicitudDocumentos.aspx.cs"
    Inherits="vCreaSolicitudDocumentos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Imprimir Solicitud</title>

    <script type="text/javascript" src="Scripts/functions.js"></script>
    
    <script type="text/javascript" src="Scripts/lib/x_core.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_dom.js"></script>

    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>
    <script type="text/ecmascript" src="Scripts/lib/x_CheckHabilitador.js"></script>
    

    <script type="text/javascript">
        
        function closePopUpWindow() {
            window.parent.hidePopWin(true); 
        }
        function muestraProcesando() {
            var ele = $('DivResultado');
            ele.style.display ='block';
            ocultarPanel();
        }
       
        function ocultarPanel() {
            try {
                var ele = $('ImprimirSolicitudDatos');
                ele.style.display = 'none';
            }
            catch(e) {
            }
        }
        
      
        
        window.onload = function () {
            try {
               
                var chk1 = new xCheckHabilitador('chkDestinatarioOtros','txtCorreoOtros','deshabilitado');
                var chk2 = new xCheckHabilitador('chkDestinatarioBroker','txtCorreoBroker','deshabilitado');
                var chk3 = new xCheckHabilitador('chkDestinatarioAseguradora','txtCorreoAseguradora','deshabilitado');                
                
            }
            catch (e) {
               // alert(e.message);
            }
        }
    </script>

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <style type ="text/css">
        
        .deshabilitado {                       
	            color: #CCCCCC;
	            background-color: #CCCCCC;	
	            font-family:Verdana;	
	            border-top:1px solid #41778B;
	            border-right:1px solid #D6D3CE;
	            border-bottom:1px solid #D6D3CE;
	            border-left:1px solid #42758C;
	            font-size:10px;
	            background-image:url(../imgRGen/fondo_FormText.gif);
	            background-repeat:repeat-x;	
        }
        
    </style>
    
</head>
<body>
    <form id="frmImprimirSolicitud" runat="server">
        <div runat="server" id="ImprimirSolicitudDatos" style="margin-left: auto; margin-right: auto;
            margin-top: 10px; margin-bottom: 10px; width: 400px; background-color: #3399CC;
            padding: 10px;">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="2" style="height: 25px">
                        <strong>Nombre del Destinatario :</strong>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 18px">
                        <asp:TextBox CssClass="FormText" ID="txtDestinatario" runat="server" TextMode="SingleLine"
                            Width="380px" /></td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 18px">
                        <strong>Cargo :</strong>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 18px">
                                    <asp:TextBox ID="txtCargo" runat="server" CssClass="FormText" Width="380px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                       <strong>Descripción :</strong>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Height="76px"
                                        TextMode="MultiLine" Width="380px"></asp:TextBox></td>
                            </tr>
                <tr>
                    <td colspan="2" style="height: 18px">
                        <table id="myTable" width="100%" border="0" cellpadding="0" cellspacing="0" runat="server">
                           
                            <tr>
                                <td colspan="2" >
                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 228px" >
                                    <strong>N° de Recordatorios :&nbsp; </strong>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNumRecordatorio" runat="server" CssClass="FormText" Width="151px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 228px">
                                   <strong>N° de Carta del Asegurado :</strong> </td>
                                   <td>
                                    <strong>
                                        <asp:TextBox ID="txtNumCartaAsegurado" runat="server" CssClass="FormText" Width="151px"></asp:TextBox></strong></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 31px">
                        <strong>Enviar Automaticamente la Solicitud por correo a</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="padding: 5px;">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="27%">
                                        <asp:CheckBox ID="chkDestinatarioAseguradora" runat="server" Text='Aseguradora' /></td>
                                    <td width="73%">
                                        <asp:TextBox CssClass="FormText" ID="txtCorreoAseguradora" runat="server" Width="270px" /></td>
                                </tr>
                                <tr>
                                    <td style="height: 20px">
                                        <asp:CheckBox ID="chkDestinatarioBroker" runat="server" Text='Broker' /></td>
                                    <td style="height: 20px">
                                        <asp:TextBox CssClass="FormText" ID="txtCorreoBroker" runat="server" Width="270px" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkDestinatarioOtros" runat="server" Text='Otros' /></td>
                                    <td>
                                        <asp:TextBox CssClass="FormText" ID="txtCorreoOtros" runat="server" Width="270px" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 16px">
                        <div align="right">
                            <asp:Button CommandName="CrearSolicitud" OnClientClick="muestraProcesando();" ID="btnCrear"
                                runat="server" CssClass="FormButton" Text="Crear" Width="96px" OnClick="btnCrear_Click" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div runat="server" id="DivResultado" style="display: none; margin-left: auto; margin-right: auto;
            margin-top: 10px; margin-bottom: 10px; width: 400px; background-color: #117ecc;
            padding: 10px;">
            <div align="center">
                <table width="80%" border="0" cellpadding="5" cellspacing="0">
                    <tr>
                        <td width="8%">
                            <img id="imgLoading" runat="server" src="img/loading.gif" alt="" /></td>
                        <td width="92%">
                            <p id="lblResutado" runat="server" align="center">
                                <strong>Procesando su Solicitud</strong></p>
                            <button runat="server" style="width: 80px;" id="verSolicitud" class="FormButton">
                                Ver Solicitud</button></td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
</html>
