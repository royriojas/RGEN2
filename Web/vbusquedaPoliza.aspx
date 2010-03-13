<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vbusquedaPoliza.aspx.cs"
    Inherits="vbusquedaPoliza" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
 <title>B&uacute;squeda de P&oacute;lizas</title>

    <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

    <script language="javascript" type="text/javascript"> 
    
   
    /*
    function verificaVacio(elemento) {
        if (elemento.value == '') {
            elemento.value = '--vacío--';
        }
    }
    */
	function nuevaPoliza() {
		var ciaseguros = $('txtAseguradoraId');		
		var nombreAseguradora = $('txtAseguradoraNombre');
		window.location.href = 'vRegistroPolizaRapido.aspx?AseguradoraId='+ciaseguros.value+'&indicador=creacionrapida&AseguradoraNombre='+nombreAseguradora.value+'&AjusteId=<%=qStringAjusteId%>';
		
	}
	function sayHello() {
	    //alert($('txtPolizaIdTemp').value);
	}
	function grabaPolizaPrincipal(polizaid,numpoliza) {
	    var btn = $('btnGrabarPolizaAjuste');
	    var txtpid = $('txtPolizaIdTemp');
	    txtpid.value = polizaid;
	    if (confirm("¿Desea realmente asociar la póliza N° "+numpoliza + '?')) btn.click();
	}
    function cierraVentana(polizaid,polizanumero,personaId,personaNombre,contratante,ramo,ramoId) {
        
        if (typeof(window.top.ifrmRegistroInicial) != 'undefined'){
            window.top.ifrmRegistroInicial.seteaValoresDePoliza(polizaid,polizanumero,personaId,personaNombre,contratante,ramo,ramoId);        
            //window.top.ifrmRegistroInicial.hidePopWin(true); esto se hara en la ventana padre
        }
        else {
            window.top.seteaValoresDePoliza(polizaid,polizanumero,personaId,personaNombre,contratante,ramo,ramoId);          
            //window.top.hidePopWin(true); esto se hará en la ventana padre
            
        }
        
        
    }    
    
    function cierrate() {
        if (<%=cerrar %>) {
            if (typeof(window.top.ifrmRegistroInicial) != 'undefined'){
                //window.top.ifrmRegistroInicial.seteaValoresDePoliza(polizaid,polizanumero,personaId,personaNombre,contratante,ramo);        
                window.top.ifrmRegistroInicial.reload();
                window.top.ifrmRegistroInicial.hidePopWin(true); 
                
            }
            else {
                //window.top.seteaValoresDePoliza(polizaid,polizanumero,personaId,personaNombre,contratante,ramo);          
                window.top.reload();
                window.top.hidePopWin(true); 
                
            
            }
        }        
    }
    window.onload = function () {
        cierrate();
    }
    

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="ContenidoPagina" style="width: 600px;">
                <div class="DataTop">
                    <div class="DataTopLeft">
                    </div>
                    <div class="DataTopRight">
                    </div>
                </div>
                <div class="DataContent">
                    <div class="DataContentRight">
                        <div>
                            Buscar P&oacute;lizas</div>
                        <div class="hr">
                        </div>
                        <div>
                            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="DataTable">
                                <tr>
                                    <td width="9">
                                        &nbsp;</td>
                                    <td width="131" height="20">
                                        Aseguradora</td>
                                    <td width="204" height="20">
                                        <asp:TextBox ID="txtAseguradoraNombre" runat="server" CssClass="FormText" Width="218px"
                                            ReadOnly="True"></asp:TextBox></td>
                                    <td height="20" colspan="2">
                                        <asp:TextBox Style="display: none;" ID="txtAseguradoraId" runat="server" CssClass="FormText"
                                            Width="20px"></asp:TextBox>
                                        <asp:Button Style="display: none;" OnClientClick="sayHello();" ID="btnGrabarPolizaAjuste"
                                            runat="server" Text="grabar" OnClick="btnGrabarPolizaAjuste_Click" /></td>
                                    <td width="17" height="20">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="9">
                                        &nbsp;</td>
                                    <td height="20">
                                        N&uacute;mero de P&oacute;liza
                                    </td>
                                    <td height="20">
                                        <asp:TextBox ID="txtNumPoliza" runat="server" CssClass="FormText" Width="218px"></asp:TextBox></td>
                                    <td height="20">
                                        &nbsp;</td>
                                    <td height="20">
                                        <button class="FormButton" onclick="nuevaPoliza();return false;">
                                            Nueva P&oacute;liza</button></td>
                                    <td width="17" height="20">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="9" style="height: 20px">
                                        &nbsp;</td>
                                    <td style="height: 20px">
                                        Asegurado</td>
                                    <td style="height: 20px">
                                        <cc1:AutoSuggestBox ID="asbAsegurado" runat="server" CssClass="FormText" DataType="Asegurado"
                                            IncludeMoreMenuItem="True" MaxSuggestChars="6" NumMenuItems="15" Width="218px"
                                            ResourcesDir="./asb_includes"></cc1:AutoSuggestBox></td>
                                    <td width="90" style="height: 20px">
                                    </td>
                                    <td width="105" style="height: 20px">
                                        <asp:Button ID="btnBuscar" runat="server" CssClass="FormButton" OnClick="Button1_Click"
                                            Text="Buscar" /></td>
                                    <td width="17" style="height: 20px">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="9">
                                        &nbsp;</td>
                                    <td>
                                        &nbsp;</td>
                                    <td colspan="3">
                                        &nbsp;</td>
                                    <td width="17">
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </div>
                        <div class="hr">
                        </div>
                        <div>
                            <asp:GridView ID="DataTable" runat="server" Width="577px" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" DataSourceID="odsPolizasList" OnRowDataBound="DataTable_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="numeroPoliza" HeaderText="N&#176; P&#243;liza" SortExpression="numeroPoliza">
                                        <ItemStyle Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Asegurado" HeaderText="Asegurado" SortExpression="Asegurado">
                                        <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="contratante" HeaderText="Contratante" SortExpression="contratante">
                                        <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ramoafectado" HeaderText="Ramo" SortExpression="ramoafectado">
                                        <ItemStyle Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField  DataField="finicio" HeaderText="Inicio" SortExpression="finicio" DataFormatString="{0:dd-MM-yyyy}" HtmlEncode="False" >
                                        <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ffin" HeaderText="Fin" SortExpression="ffin" DataFormatString="{0:dd-MM-yyyy}" HtmlEncode="False" >
                                        <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                </Columns>
                                <RowStyle CssClass="ItemStyle" Wrap="True" />
                                <HeaderStyle CssClass="HeaderStyle" />
                                <EmptyDataTemplate>
                                    <div style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; vertical-align: middle;
                                        padding-top: 10px; height: 100px; background-color: #0099cc; text-align: center">
                                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="14px" Text="No se ha Encontrado Pólizas con los criterios especificados"></asp:Label></div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <div style="height: 20px;">
                                <asp:TextBox Style="display: none;" ID="txtPolizaIdTemp" runat="server" Width="71px"></asp:TextBox></div>
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
        <asp:ObjectDataSource ID="odsPolizasList" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaBusquedaTableAdapter">
            <SelectParameters>
                <asp:ControlParameter ControlID="asbAsegurado" ConvertEmptyStringToNull="False" Name="asegurado"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtNumPoliza" ConvertEmptyStringToNull="False" Name="numeroPoliza"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtAseguradoraId" Name="aseguradoraId" PropertyName="Text"
                    Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:SqlDataSource ID="sdsInsertaPoliza" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
            InsertCommand="sp_rgn_asignaPolizaPrincipal" InsertCommandType="StoredProcedure"
            SelectCommand="select * from RGN_POLIZA_AJUSTE" OnInserting="sdsInsertaPoliza_Inserting"
            OnInserted="sdsInsertaPoliza_Inserted">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtPolizaIdTemp" DefaultValue="" Name="polizaId"
                    PropertyName="Text" Type="Decimal" />
                <asp:QueryStringParameter Name="aseguradoraId" QueryStringField="AseguradoraId" Type="Decimal" />
                <asp:QueryStringParameter DefaultValue="" Name="ajusteId" QueryStringField="AjusteId"
                    Type="Decimal" />
                <asp:QueryStringParameter DefaultValue="" Name="NumSiniestro" QueryStringField="NumeroSiniestro"
                    Type="Decimal" />
                <asp:SessionParameter Name="uupdate" SessionField="NombreUsuario" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
    </form>
   
</body>
</html>
