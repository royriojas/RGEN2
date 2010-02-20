<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vDocumentos.aspx.cs" Inherits="vDocumentos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel='stylesheet' type='text/css' href='css/layout.css' />
    <title>Riesgos Generales | Documentos </title>

    <script type='text/javascript' src="Scripts/lib/x_core.js"></script>
    <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>    
    <script type="text/javascript" src="Scripts/lib/x_event.js"></script>
    <script type='text/javascript' src="Scripts/functions.js"></script>
    
    <script type="text/javascript">
    
        function validarEliminacion(numero) {
            return confirm("Desea Eliminar la Solicitud numero " + numero);
        }
        
    </script>

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    
</head>
<body>
    <form id="form1" runat="server">
    <div id="contenedor" style="width: 731px;position:relative;" runat="server">
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight" style="padding :1%; ">                       
                    <div class="PanelEncabezado"style="height:30px;">
                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="18px">Lista de Solicitud de Documentos</asp:Label>
						 <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="#"
                                onclick="return separar();" Width="22px" CssClass="BtnSeparar"></asp:HyperLink>
                        <asp:Button  style="position:absolute; right:15px; top: 3px;" ID="btnNuevaSolicitud" runat="server" CssClass="FormButton" Text="Nueva Solicitud" OnClick="btnNuevaSolicitud_Click" /></div>
                    <div class="hr">
                    </div>
                     <div id="cont">        
            
                 <div style="position:relative; ">               
                <asp:GridView ID="gViewDocumentos" runat="server" AutoGenerateColumns="False" DataKeyNames="solicitudDocumentosId,ajusteId" DataSourceID="sdsNuevaCarta" Width="700px" AllowPaging="True" AllowSorting="True" OnRowCommand="gViewDocumentos_RowCommand" PageSize="15">
                    <Columns>
                        <asp:TemplateField HeaderText="N&#186;">
                            <ItemStyle Width="25px" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text="<%# num++ %>"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="solicitudDocumentosId" HeaderText="solicitudDocumentosId"
                            InsertVisible="False" ReadOnly="True" SortExpression="solicitudDocumentosId"
                            Visible="False" />
                        <asp:BoundField DataField="numeroSolicitud" HeaderText="N&#250;mero" SortExpression="numeroSolicitud">
                            <ItemStyle HorizontalAlign="Center" Width="165px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Fecha" DataFormatString="{0:MM-dd-yyyy}" HeaderText="Fecha"
                            HtmlEncode="False" SortExpression="Fecha" >
                            <ItemStyle HorizontalAlign="Center" Width="110px" />
                        </asp:BoundField >
                        <asp:BoundField DataField="enreferencia" HeaderText="En Referencia a" SortExpression="enreferencia" >
                            <ItemStyle HorizontalAlign="Center" Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tipo" HeaderText="Tipo" SortExpression="tipo" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemStyle Width="120px" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CssClass="FormButton" PostBackUrl='<%# "vSolicitudDatos.aspx?SolicitudDocumentosId="+Eval("solicitudDocumentosId")+"&TipoAccion=Editar&AjusteId="+Eval("AjusteId") %>'
                                    Text="Editar" /><asp:Button ID="Button2" runat="server" CommandArgument='<%# Eval("solicitudDocumentosId") %>'
                                    CommandName="ELIMINAR" CssClass="FormButton" Text="Eliminar" OnClientClick='<%# "return validarEliminacion("+num+");" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="ItemStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <EmptyDataTemplate>
                        Aún no se han definido Cartas de Solicitud de Datos para este ajuste
                    </EmptyDataTemplate>
                    <PagerStyle CssClass="DataTable" />
                </asp:GridView>
             
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
            <asp:Panel style="margin-left: auto; margin-right: auto; position: relative;text-align:center; background-color:Red;padding:5px; left: 0px; top: 0px;" ID="pnlError" runat="server" Height="29px" HorizontalAlign="Center" Width="334px" Visible="False">
        <asp:Image ID="Image1" runat="server" style="float:left;" ImageUrl="~/imgRGen/important.jpg" />
    
        <asp:Label ID="lblError"  runat="server" Font-Bold="True" Text='Sólo Se Puede Emitir Cartas Después de Realizar la Inspección' Height="14px" Visible="False" Width="281px"></asp:Label>
     
        <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" OnClientClick="window.parent.hidePopWin(true);return false;">Cerrar Ventana</asp:LinkButton></asp:Panel>
            <asp:SqlDataSource ID="sdsNuevaCarta" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                    SelectCommand="SELECT solicitudDocumentosId, numeroSolicitud, Fecha, estado, enreferencia, tipo, ajusteId FROM RGN_SOLICITUDDOCUMENTOS WHERE (ajusteId = @ajusteId) and (estado <> 'I')" UpdateCommand="sp_rgen_solicitudDocumentosDelete" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="165" Name="ajusteId" QueryStringField="AjusteId" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="solicitudDocumentosId" Type="Decimal" />
                    </UpdateParameters>
      </asp:SqlDataSource>
     
    </form>
</body>
</html>
