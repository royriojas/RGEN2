<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vBusquedaPolizasAsociadas.aspx.cs"
    Inherits="vBusquedaPolizasAsociadas" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <title>B&uacute;squeda de P&oacute;lizas a Asociar</title>

    <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

    <script language="javascript" type="text/javascript"> 
    
   
   
	function nuevaPoliza() {
		var ciaseguros = document.getElementById('txtAseguradoraId');				
		document.location.href = 'vRegistroPolizaRapido.aspx?AseguradoraId='+ciaseguros.value+'&AjusteId=<%=ajusteId%>';
	}
	
    function cierraVentana(polizaid,polizanumero,personaId,personaNombre,contratante,ramo) {
        
        if (typeof(window.top.ifrmRegistroInicial) != 'undefined'){
            window.parent.ifrmRegistroInicial.seteaValoresDePoliza(polizaid,polizanumero,personaId,personaNombre,contratante,ramo);        
            window.parent.ifrmRegistroInicial.hidePopWin(true);
        }
        else {
            window.parent.seteaValoresDePoliza(polizaid,polizanumero,personaId,personaNombre,contratante,ramo);          
            window.parent.hidePopWin(true);
            
        }
        
        
    }    
    function copiaACampoOcultoPolizaId(param){
         document.getElementById('txtPolizaIdTemp').value = param;
         __doPostBack('Button1','');
         /*window.parent.doReload();*/
         //window.parent.hidePopWin(true);
    }
    

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="ContenidoPagina" style="width: 800px;">
                <div class="DataTop">
                    <div class="DataTopLeft">
                    </div>
                    <div class="DataTopRight">
                    </div>
                </div>
                <div class="DataContent">
                    <div class="DataContentRight">
                        <div>
                            <asp:Label ID="Label1" Text="Búsqueda de Polizas" Font-Bold="true" Font-Size="16px"
                                runat="server"></asp:Label></div>
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
                                        <asp:TextBox ID="txtAseguradoraNombre" runat="server" CssClass="FormText" Width="218px"></asp:TextBox></td>
                                    <td height="20" colspan="2">
                                        <asp:TextBox Style="display: none;" ID="txtAseguradoraId" runat="server" CssClass="FormText"
                                            Width="20px"></asp:TextBox></td>
                                    <td width="17" height="20">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="9">
                                        &nbsp;</td>
                                    <td height="20">
                                        Asegurado</td>
                                    <td height="20">
                                        <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" Width="218px" ReadOnly="True"></asp:TextBox></td>
                                    <td height="20">
                                        <asp:TextBox ID="txtAseguradoId" runat="server" CssClass="FormText" Style="display: none"
                                            Width="20px"></asp:TextBox></td>
                                    <td height="20" style="width: 110px">
                                        <button class="FormButton" onclick="nuevaPoliza();">
                                            Nueva P&oacute;liza</button></td>
                                    <td width="17" height="20">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="9" style="height: 20px">
                                        &nbsp;</td>
                                    <td style="height: 20px">
                                        N&uacute;mero de P&oacute;liza
                                    </td>
                                    <td style="height: 20px">
                                        <asp:TextBox ID="txtNumPoliza" runat="server" CssClass="FormText" Width="218px"></asp:TextBox></td>
                                    <td width="90" style="height: 20px">
                                    </td>
                                    <td style="height: 20px; width: 110px;">
                                        <asp:Button ID="btnBuscar" runat="server" CssClass="FormButton" Text="Buscar" OnClick="btnBuscar_Click" /></td>
                                    <td width="17" style="height: 20px">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="9" style="height: 17px">
                                        &nbsp;</td>
                                    <td style="height: 17px">
                                    </td>
                                    <td colspan="3" style="height: 17px">
                                        <asp:TextBox style="display:none;" ID="txtPolizaIdTemp" runat="server" CssClass="FormText" Width="103px"></asp:TextBox>
                                        
                                    <asp:LinkButton ID="Button1" style="display:none;" runat="server" OnClick="Button1_Click">btnInsertaPolizaAsociada</asp:LinkButton>
                                        
                                        
                                        </td>
                                    <td width="17" style="height: 17px; display: none;">
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </div>
                        <div class="hr">
                        </div>
                        <div>
                            <asp:GridView ID="gridPolizas" runat="server" Width="762px" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" DataSourceID="odsPolizasList" OnRowDataBound="gridPolizas_RowDataBound">
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
                                    <asp:BoundField DataField="producto" HeaderText="Producto" SortExpression="producto">
                                        <ItemStyle Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ramoafectado" HeaderText="Ramo" SortExpression="ramoafectado">
                                        <ItemStyle Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="cobertura" HeaderText="Cobertura" SortExpression="cobertura">
                                        <ItemStyle Width="40px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ffin" DataFormatString="{0:dd-MM-yyyy}" HeaderText="Vigencia"
                                        SortExpression="ffin">
                                        <ItemStyle Width="70px" />
                                    </asp:BoundField>
                                </Columns>
                                <RowStyle CssClass="ItemStyle" Wrap="True" />
                                <HeaderStyle CssClass="HeaderStyle" />
                            </asp:GridView>
                            <div style="height: 20px;">
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
        <asp:ObjectDataSource ID="odsPolizasList" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsPolizaTableAdapters.PolizaBusquedaAseguradoTableAdapter">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtAseguradoId" Name="aseguradoid" PropertyName="Text"
                    Type="Decimal" />
                <asp:ControlParameter ControlID="txtNumPoliza" ConvertEmptyStringToNull="False" Name="numeroPoliza"
                    PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtAseguradoraId" Name="aseguradoraId" PropertyName="Text"
                    Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:SqlDataSource ID="sqlAsociaPoliza" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
            SelectCommand="sp_rgen_PolizasAsociadasSelect" InsertCommand="sp_rgen_PolizaAsociadaInsert"
            InsertCommandType="StoredProcedure" OnInserting="sqlAsociaPoliza_Inserting" SelectCommandType="StoredProcedure">
            <InsertParameters>
                <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
                <asp:ControlParameter ControlID="txtPolizaIdTemp" Name="polizaId" PropertyName="Text"
                    Type="Decimal" />
                <asp:ControlParameter ControlID="txtAseguradoraId" Name="aseguradoraId" PropertyName="Text"
                    Type="Decimal" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
