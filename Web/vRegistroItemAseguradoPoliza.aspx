<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRegistroItemAseguradoPoliza.aspx.cs"
    Inherits="vRegistroItemAseguradoPoliza" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Items Asegurados</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript" src="Scripts/calendar/datetimepicker.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

    <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
  
    function cargaTipoDeCambio(selector) {
        //declaramos una variable del tipo HTMLOBJECT que reciba el valor de la busqueda del nuevo tipo cambio
        var montoTipoCambio = $('txtTipoCambio');        
        //le asignamos el tipo de cambio
        // este sale del metodo de AJAX 
        //para utilizar un metodo ajax, la pagina debe tener en el onload registrado el tipo de la libreria
        // donde se define el metodo a utilizar 
        montoTipoCambio.value = utiles.ajax.gestorAjax.getTipoDeCambio(selector.value).value;
        
        //llamamos al monto en soles
        calculaMontoSoles();
    }
    
    function calculaMontoSoles() {
        var tipoCambio = $('txtTipoCambio');
        var cantidadMonedaOrigen = $('txtMontoAsegurado');
        var cantidadSoles = $('txtMontoSoles');
        var cantidadMonedaOrigen2 = $('txtMontoAsegurado2');
        var cantidadSoles2 = $('txtMontoSoles2');
        var cadena = tipoCambio.value;
        var posicion = cadena.indexOf(',') 
        if (posicion != -1) {
        
            cadena.charAt(posicion) = '.';
            
        }
        cantidadSoles.value = cantidadMonedaOrigen.value * cadena;
        cantidadSoles2.value = cantidadMonedaOrigen2.value * cadena;

    }
    </script>

    <script type="text/javascript" language="javascript">
		function seteaOcultadoresDeDivs() {
			btn_ocultar = new CollapsibleDiv('nuevoItemAsegurado',
						 'ContenidoItemAsegurado',						 
						 false,
						 null);
		}
		window.onload = function () {
			seteaOcultadoresDeDivs();
		}
    </script>

</head>
<body style="background-image: none; background-color: #4C96C9;">
    <div style="margin-left: auto; margin-right: auto; position: relative; width: 700px;
        left: 0px; top: 0px;">
        <form id="formRegistroItemsAsegurados" runat="server">
            <div style="position: relative">
                <div class="DataTable" id="ContenidoItemAsegurado" style="padding: 10px; display: none;">
                    <table width="608" border="0" cellspacing="0" cellpadding="0">
                        <!--DWLayoutTable-->
                        <tr>
                            <td style="height: 20px">
                                <span style="height: 24px">Materia a Asegurar</span></td>
                            <td colspan="3" style="height: 20px">
                                <asp:TextBox ID="txtItemAsegurado" runat="server" CssClass="FormText" TextMode="MultiLine"
                                    Width="430px" Height="70px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="height: 20px">
                                <span style="height: 20px">Local</span></td>
                            <td colspan="3" style="height: 20px">
                                <asp:TextBox ID="txtLocal" runat="server" CssClass="FormText" Width="432px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td height="19" style="height: 20px">
                                <span style="height: 16px">Concepto</span></td>
                            <td width="202" valign="top" style="height: 20px">
                                <!--DWLayoutEmptyCell-->
                                <asp:DropDownList ID="cbxConcepto1" runat="server" CssClass="FormSelect" Width="190px">
                                    <asp:ListItem Value="Valor Declarado">Valor Declarado</asp:ListItem>
                                    <asp:ListItem Value="Suma Asegurada">Suma Asegurada</asp:ListItem>
                                    <asp:ListItem Value="L&#237;mite &#218;nico Combinado">L&#237;mite &#218;nico Combinado</asp:ListItem>
                                    <asp:ListItem Value="Valor a Primer Riesgo">Valor a Primer Riesgo</asp:ListItem>
                                    <asp:ListItem>Ninguno</asp:ListItem>
                                </asp:DropDownList></td>
                            <td width="77" valign="top" style="height: 20px">
                                <!--DWLayoutEmptyCell-->
                                <asp:DropDownList ID="cbxMoneda" runat="server" CssClass="FormSelect" DataSourceID="odsMoneda"
                                    DataTextField="simbolo" onChange="cargaTipoDeCambio(this);" DataValueField="monedaId"
                                    Width="66px">
                                    <asp:ListItem>US$</asp:ListItem>
                                </asp:DropDownList></td>
                            <td width="205" valign="top" style="height: 20px">
                                <!--DWLayoutEmptyCell-->
                                <asp:TextBox ID="txtMontoAsegurado" runat="server" CssClass="FormText" Width="152px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="height: 20px">
                                &nbsp;
                            </td>
                            <td style="height: 20px">
                                <asp:DropDownList ID="cbxConcepto2" runat="server" CssClass="FormSelect" Width="190px">
                                    <asp:ListItem Value="Valor Declarado">Valor Declarado</asp:ListItem>
                                    <asp:ListItem Value="Suma Asegurada">Suma Asegurada</asp:ListItem>
                                    <asp:ListItem Value="L&#237;mite &#218;nico combinado">L&#237;mite &#218;nico combinado</asp:ListItem>
                                    <asp:ListItem Value="Valor a Primer Riesgo">Valor a Primer Riesgo</asp:ListItem>
                                    <asp:ListItem Value="Ninguno">Ninguno</asp:ListItem>
                                </asp:DropDownList></td>
                            <td style="height: 20px">
                                &nbsp;
                            </td>
                            <td style="height: 20px">
                                <asp:TextBox ID="txtMontoAsegurado2" runat="server" CssClass="FormText" Width="152px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="height: 20px">
                            </td>
                            <td style="height: 20px">
                            </td>
                            <td style="height: 20px">
                            </td>
                            <td style="height: 20px">
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px">
                            </td>
                            <td style="height: 20px">
                                <asp:Button ID="btnAgregar" runat="server" CssClass="FormButton" Text="Agregar" OnClick="btnAgregar_Click" /></td>
                            <td style="height: 20px">
                                <asp:TextBox ID="txtMontoSoles" runat="server" BorderStyle="None" CssClass="FormText invisible" Width="51px" Height="15px"></asp:TextBox></td>
                            <td style="height: 20px">
                                <asp:TextBox ID="txtMontoSoles2" runat="server" BorderStyle="None" CssClass="FormText invisible" Width="51px" Height="15px"></asp:TextBox>
                                <asp:TextBox ID="txtTipoCambio" runat="server" CssClass="FormText invisible" Width="46px"></asp:TextBox></td>
                        </tr>
                    </table>
                </div>
                <div style="height: 30px; margin-top: 5px; margin-bottom: 5px; position: relative;
                    left: 0px; width: 699px; top: 0px; background-color: #467eb7;">
                    &nbsp;
                    <asp:Label ID="lblListaItemsAsegurados" runat="server" Font-Bold="True" Font-Size="18px">Lista Items Asegurados</asp:Label>
                    <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Item Asegurado" title="Agregar Item Asegurado"
                        style="position: absolute; left: 674px; top: 5px;" id="nuevoItemAsegurado" />
                </div>
                <div id="ListaItemsAsegurados" style="margin-left: auto; margin-right: auto; position: relative">
                    <div>
                        <asp:GridView ID="gridItemsAsegurados" runat="server" AutoGenerateColumns="False"
                            DataSourceID="odsItemsAsegurados" Width="700px" DataKeyNames="itemAseguradosId"
                            CssClass="DataTable" AllowPaging="True" OnRowCommand="GridView1_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="localItem" HeaderText="Local" SortExpression="localItem">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="itemAseguradosId" HeaderText="itemAseguradosId" InsertVisible="False"
                                    ReadOnly="True" SortExpression="itemAseguradosId" Visible="False" />
                                <asp:BoundField DataField="polizaId" HeaderText="polizaId" ReadOnly="True" SortExpression="polizaId"
                                    Visible="False" />
                                <asp:BoundField DataField="aseguradoraId" HeaderText="aseguradoraId" ReadOnly="True"
                                    SortExpression="aseguradoraId" Visible="False" />
                                <asp:BoundField DataField="nombreItem" HeaderText="Materia Asegurada" SortExpression="nombreItem">
                                    <ItemStyle Width="250px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="concepto" HeaderText="Concepto" SortExpression="concepto">
                                    <ItemStyle Width="50px" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Monto">
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 38px">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label></td>
                                                <td style="width: 57px">
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("montoAsegurado") %>'></asp:Label></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="concepto2" HeaderText="Concepto" SortExpression="concepto2">
                                    <ItemStyle Width="50px" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Monto">
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 38px; height: 18px">
                                                    <asp:Label ID="LblSimbolo" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label></td>
                                                <td style="width: 57px; height: 18px">
                                                    <asp:Label ID="lblMontoAsegurado2" runat="server" Text='<%# Eval("montoAsegurado2") %>'></asp:Label></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" ImageUrl="~/imgRGen/deleteItem.gif"
                                            CommandName="Eliminar" CommandArgument='<%# Bind("itemAseguradosId") %>' />&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="monedaId" HeaderText="monedaId" SortExpression="monedaId"
                                    Visible="False" />
                                <asp:BoundField DataField="montosoles" HeaderText="montosoles" SortExpression="montosoles"
                                    Visible="False" />
                                <asp:BoundField DataField="tipoCambio" HeaderText="tipoCambio" SortExpression="tipoCambio"
                                    Visible="False" />
                                <asp:BoundField DataField="montosoles2" HeaderText="montosoles2" SortExpression="montosoles2"
                                    Visible="False" />
                                <asp:BoundField DataField="simbolo" HeaderText="simbolo" SortExpression="simbolo"
                                    Visible="False" />
                            </Columns>
                            <HeaderStyle CssClass="HeaderStyle" />
                          <EmptyDataTemplate>
                            No hay Items asegurados registrados
                          </EmptyDataTemplate>
                        </asp:GridView>
                        <br />
                    </div>
                </div>
            </div>
        </form>
    </div>
  
    <asp:TextBox ID="txtItemAseguradoId" runat="server" Visible="False" Width="64px"></asp:TextBox>
    <asp:ObjectDataSource ID="odsItemsAsegurados" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" SelectMethod="GetData" TypeName="dsPolizaTableAdapters.ItemAseguradoSelectByIdTableAdapter" OldValuesParameterFormatString="">
        <DeleteParameters>
            <asp:ControlParameter ControlID="txtItemAseguradoId" Name="itemAseguradosId" PropertyName="Text"
                Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
            <asp:ControlParameter ControlID="txtItemAsegurado" Name="nombreItem" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="cbxConcepto1" Name="concepto" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="txtMontoAsegurado" Name="montoAsegurado" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtMontoSoles" Name="montosoles" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="cbxConcepto2" Name="concepto2" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="txtMontoAsegurado2" Name="montoAsegurado2" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtMontoSoles2" Name="montosoles2" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="cbxMoneda" Name="monedaId" PropertyName="SelectedValue"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtTipoCambio" Name="tipoCambio" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtLocal" Name="localItem" PropertyName="Text" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsComboTableAdapters.MonedaComboTableAdapter"></asp:ObjectDataSource>  
</body>
</html>
