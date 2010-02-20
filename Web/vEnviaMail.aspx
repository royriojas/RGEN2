<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeFile="vEnviaMail.aspx.cs"
    Inherits="vEnviaMail" %>

<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Enviar Informe por Correo Electrónico</title>

    <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <style type="text/css"> 
        .grupoOpciones {
            width:400px;
            margin:5px;
            font-size: 11px;
            font-weight:bold;
            float:left;
        }
        .grupoOpciones p {
            clear: left;     
            margin-top:10px;
            margin-bottom:10px;       
        }
        .grupoOpciones p label {
            float: left;    
            width:45%;    
           
        }
        .grupoOpciones span.chk {
            width:5px;
            height:5px;
            float: right;            

        }
        .grupoOpciones input.FormText {
           float: right;
           width: 420px;
           
        }
        legend {
            font-size: 11px;
            font-weight:bold;
            color:white;
            
        }
    </style>

    <script type="text/javascript">
        function validaEnvioInforme() {
            return false;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight" style="padding:1%;">
                    <div class="PanelEncabezado">
                        <asp:Label ID="Label3" runat="server" Font-Size="18px" Font-Bold="True">Envio de Email</asp:Label>
                        <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Producto" title="Agregar Producto"
                            id="trigger_nuevoTipoDiv" />
                    </div>
                    <div class="hr">
                    </div>
                    <div class="DataTable" style="padding: 5px;">
                        <table border="0" cellspacing="0" cellpadding="0" >
                            <tr>
                                <td style="width: 106px">
                                    Para</td>
                                <td >
                                    &nbsp;:
                            <asp:TextBox ID="txtPara" runat="server" CssClass="FormText" Width="450px" /></td>
                                <td style="width: 18px">
                                    &nbsp;</td>
                                <td style="width: 45px">
                <asp:Button Text="volver"  ID="btnVolver"
                    runat="server" CssClass="FormButton" /></td>
                            </tr>
                            <tr>
                                <td style="width: 106px">
                                    Asunto</td>
                                <td>
                                    &nbsp;:
                            <asp:TextBox ID="txtAsunto" runat="server" CssClass="FormText" Width="450px" /></td>
                                <td style="width: 18px">
                                </td>
                                <td style="width: 45px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 106px">
                                    Archivo Adjunto
                                </td>
                                <td>
                                    &nbsp;:
                            <asp:TextBox ID="txtNombreDelInforme" runat="server" CssClass="FormText" Width="450px" /></td>
                                <td style="width: 18px">
                                </td>
                                <td style="width: 45px">
                <asp:Button Text="Enviar" ID="btnEnviar"
                    runat="server" CssClass="FormButton" OnClick="btnEnviar_Click" /></td>
                            </tr>
                        </table>
                    </div>
                    <div class="DataTable" style="padding: 5px;">
                        <FTB:FreeTextBox ID="txtContentArea" runat="server" Height="250px" Width="640px"
                            SupportFolder="./aspnet_client/FreeTextBox/" BackColor="163, 199, 228" GutterBackColor="163, 199, 228">
                        </FTB:FreeTextBox>
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
        <asp:ObjectDataSource ID="odsActualizaEnvios" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsInformesTableAdapters.DatosInformeTableAdapter"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </form>
</body>
</html>
