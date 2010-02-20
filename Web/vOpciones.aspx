<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vOpciones.aspx.cs" Inherits="vOpciones" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Estadísticas y Reportes</title>
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .grupoOpciones {
            width:300px;
            margin:10px 60px 50px 10px;
            font-size: 11px;
            font-weight:bold;
            float:left;
        }
        .grupoOpciones p {
            clear: left;
            margin-top: 3px;         
            margin-bottom:1px;
            padding-top: 1px;
            padding-bottom: 1px;
            
        }
        .grupoOpciones p label {
            float: left;    
            width:45%;    
            margin-top: 1px;
            
            
        }
        .grupoOpciones span.chk {
            width:5px;
            height:5px;
            float: right;
            
        }
        .grupoOpciones input.FormText {
           float: right;
           width: 150px;
           margin-top: 0px;
           margin-bottom:0px;
        }
        legend {
            font-size: 11px;
            font-weight:bold;
            color:white;
        }
    </style>
 
     <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; width: 900px; position: relative;">
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="opciones"/>
            <br />
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight">
                    <div>
                        <div>
                            &nbsp;<br />
                            <div style="position: relative;">
                                &nbsp;</div>
                        </div>
                        <asp:Panel ID="Panel1" runat="server" Height="50px" Width="872px">
                                <asp:Label ID="lblM" runat="server" Text="Mantenimientos" Font-Size="18px"></asp:Label>
                            <br />
                            <br />
                            <asp:Button ID="btnMantenimientoUsuarios" runat="server" Text="Mantenimiento de Usuarios" CssClass="FormButton" Width="225px" /><br />
                            <br />
                            <asp:Button ID="Button1" runat="server" Text="Mantenimiento de Brokers" CssClass="FormButton" OnClick="Button1_Click" Width="225px" /><br />
                            <br />
                            <asp:Button ID="Button2" runat="server" Text="Mantenimiento de Aseguradoras" CssClass="FormButton" OnClick="Button2_Click" Width="225px" /><br />
                            <br />
                            <asp:Button ID="Button3" runat="server" Text="Mantenimiento de Ramos" CssClass="FormButton" Width="225px" /><br />
                            <br />
                            <asp:Button ID="Button4" runat="server" Text="Mantenimiento de Productos" CssClass="FormButton" Width="225px" /><br />
                            <br />
                            <asp:Button ID="Button5" runat="server" Text="Tipos de Siniestro" CssClass="FormButton" Width="225px" /><br />
                            <br />
                            <asp:Button ID="Button6" runat="server" Text="Tipos de Comunicación" CssClass="FormButton" Width="225px" /><br />
                        </asp:Panel>
                        <br />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
