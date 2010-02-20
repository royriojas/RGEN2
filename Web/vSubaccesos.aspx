<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vSubaccesos.aspx.cs" Inherits="vSubaccesos" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
  TagPrefix="uc2" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>Asignación de SubAccesos</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/subModal.css' />
  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/style.css' />

  <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script language="javascript" type="text/javascript">
// <!CDATA[

function btnRequisitos_onclick() {
     //showPopWin("vRiesgosXRequisito.aspx", 640, 340, null);		    
     //muestraVentanaPopUrl("vRiesgosXRequisito.aspx");
     showPopWin("vRiesgosXRequisito.aspx", 550, 465, null);
     return false;
}

function btnTipoSiniestro_onclick() {
    showPopWin("vTipoSiniestro.aspx", 710, 480, null);
    return false;
}

function btnRamo_onclick() {
    showPopWin("vListaRamo.aspx", 545, 475, null);
    return false;
}
function btnCobertura_onclick() {
   showPopWin("Mantenimientos/vListaCoberturas.aspx", 635, 470, null);
    return false;
}

function btnProducto_onclick() {
   showPopWin("vListaProducto.aspx", 630, 480, null);
    return false;
}

function btnAseguradora_onclick() {
    showPopWin("vNuevoAseguradora.aspx",710,480,null);
    return false;
}

function btnBroker_onclick() {
    showPopWin("vNuevoBroker.aspx",710,480,null);
    return false;
}

function btnAsegurado_onclick() {
    showPopWin("vNuevoAsegurado.aspx",710,480,null);
    return false;
}

// ]]>
  </script>

  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
  <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <table id="Data" cellspacing="0" cellpadding="0" border="0" align="center">
      <tr>
        <td>
          <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="opciones" />
          <br />
          <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
          </div>
          <div class="DataContent">
            <div class="DataContentRight">
              <asp:Panel ID="aseguradoraPanel" runat="server" Height="20px" Width="600px">
                <asp:Label ID="aseguradoraLabel" runat="server" Text="Aseguradora" Font-Bold="True"
                  Font-Size="14px" Width="110px"></asp:Label>&nbsp;<asp:DropDownList ID="aseguradoraIdCombo"
                    runat="server" CssClass="FormText" DataSourceID="odsAseguradora" DataTextField="persona"
                    DataValueField="personaId" Width="250px" AppendDataBoundItems="True" AutoPostBack="True">
                    <asp:ListItem Value="" Text="Seleccione una aseguradora"></asp:ListItem>
                  </asp:DropDownList>
              </asp:Panel>
              <asp:Button Style="position: absolute; left: 424px; top: 1px;" ID="btnMantenimientoUsuarios"
                runat="server" CssClass="FormButton" PostBackUrl="~/vListaUsuario.aspx" Text="Mantenimiento de Usuarios"
                Width="168px" />
              <asp:Panel ID="brokerPanel" runat="server" Height="20px" Width="600px">
                <asp:Label ID="brokerLabel" runat="server" Font-Bold="True" Font-Size="14px" Text="Broker"
                  Width="110px"></asp:Label>
                <asp:DropDownList ID="brokerIdCombo" runat="server" CssClass="FormText" DataSourceID="odsBroker"
                  DataTextField="persona" DataValueField="personaId" Width="250px" AppendDataBoundItems="True"
                  AutoPostBack="True" OnSelectedIndexChanged="brokerIdCombo_SelectedIndexChanged">
                  <asp:ListItem Value="" Text="Seleccione un broker"></asp:ListItem>
                </asp:DropDownList>
              </asp:Panel>
              &nbsp;&nbsp;
            </div>
          </div>
          <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
          </div>
          <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
          </div>
          <div class="DataContent">
            <div class="DataContentRight">
              <table>
                <tr>
                  <td valign="top" width="460" style="height: 499px">
                    <asp:GridView ID="subaccesoGridView" runat="server" AutoGenerateColumns="False" BorderStyle="Solid"
                      DataSourceID="odsSubaccesoAseguradora" Width="450px" Style="top: 1px">
                      <Columns>
                        <asp:BoundField DataField="funcionalidadId" HeaderText="funcionalidadId" SortExpression="funcionalidadId">
                          <ItemStyle CssClass="HiddenStyle" />
                          <HeaderStyle CssClass="HiddenStyle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="funcionalidad" HeaderText="Funcionalidad" SortExpression="funcionalidad" />
                        <asp:TemplateField HeaderText="Acceso" SortExpression="acceso">
                          <ItemStyle HorizontalAlign="Center" />
                          <HeaderStyle HorizontalAlign="Center" Width="50px" />
                          <ItemTemplate>
                            <asp:CheckBox ID="accesoCheckBox" runat="server" Checked='<%# Eval("acceso") %>' />
                          </ItemTemplate>
                        </asp:TemplateField>
                      </Columns>
                      <RowStyle CssClass="ItemStyle" />
                      <HeaderStyle CssClass="HeaderStyle" />
                    </asp:GridView>
                    <asp:Label ID="mensajeLabel" runat="server" Font-Bold="True" Font-Size="14px" Text="Seleccione un elemento de la lista"
                      Width="381px"></asp:Label><br />
                    <br />
                    <asp:ImageButton ID="guardarImageButton" runat="server" ImageUrl="~/imgRGen/btnSave.gif"
                      OnClick="guardarImageButton_Click" />
                    <asp:HiddenField ID="hdfAseguradoraId" runat="server" />
                  </td>
                  <td valign="top" style="width: 412px; height: 499px;">
                       <table style="width: 455px; height: 14px; left: 0px; top: 0px;">
                        <tr>
                          <td style="height: 14px" valign="top" colspan="2">
                            &nbsp;<asp:FormView ID="frmConfiguracion" runat="server" DataKeyNames="aseguradoraId"
                              DataSourceID="odsConfiguracion" DefaultMode="Edit" Height="84px">
                              <EditItemTemplate>
                                <table style="width: 455px; height: 14px;">
                                  <tr>
                                    <td style="width: 263px" valign="top">
                                      <asp:Label ID="DLIBLabel" runat="server" Width="258px" Height="15px">Días límite para informe básico</asp:Label></td>
                                    <td style="width: 206px" valign="top">
                                      <asp:TextBox ID="DLIB" runat="server" CssClass="FormText" Width="50px" Text='<%# Bind("diasIB") %>'></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="DLIB" ErrorMessage="Ingrese los días límite para el informe básico"
                                        Font-Bold="True" Display="Dynamic">(*)</asp:RequiredFieldValidator><asp:RangeValidator
                                          ID="RangeValidator1" runat="server" ControlToValidate="DLIB" Display="Dynamic"
                                          ErrorMessage="Ingrese un número válido" Font-Bold="True" MaximumValue="999" MinimumValue="0"
                                          Type="Integer">Número inválido</asp:RangeValidator></td>
                                  </tr>
                                  <tr>
                                    <td style="width: 263px" valign="top">
                                      <asp:Label ID="DLIPLabel" runat="server" Width="259px" Height="2px">Días límite para informe preliminar</asp:Label></td>
                                    <td style="width: 206px" valign="top">
                                      <asp:TextBox ID="DLIP" runat="server" CssClass="FormText" Width="50px" Text='<%# Bind("diasIP") %>'></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator2" runat="server" ControlToValidate="DLIP" Display="Dynamic"
                                        ErrorMessage="Ingrese los días límite para el informe preliminar" Font-Bold="True">(*)</asp:RequiredFieldValidator><asp:RangeValidator
                                          ID="RangeValidator2" runat="server" ControlToValidate="DLIP" Display="Dynamic"
                                          ErrorMessage="Ingrese un número válido" Font-Bold="True" MaximumValue="999" MinimumValue="0"
                                          Type="Integer">Número inválido</asp:RangeValidator></td>
                                  </tr>
                                  <tr>
                                    <td style="width: 263px" valign="top">
                                      <asp:Label ID="DL1CLabel" runat="server" Width="256px">Días límite para primer complementario</asp:Label></td>
                                    <td style="width: 206px" valign="top">
                                      <asp:TextBox ID="DL1C" runat="server" CssClass="FormText" Width="50px" Text='<%# Bind("diasIC") %>'></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator3" runat="server" ControlToValidate="DL1C" ErrorMessage="Ingrese los días límite para el primer informe complementario"
                                        Font-Bold="True" Display="Dynamic">(*)</asp:RequiredFieldValidator><asp:RangeValidator
                                          ID="RangeValidator3" runat="server" ControlToValidate="DL1C" Display="Dynamic"
                                          ErrorMessage="Ingrese un número válido" Font-Bold="True" MaximumValue="999" MinimumValue="0"
                                          Type="Integer">Número inválido</asp:RangeValidator></td>
                                  </tr>
                                  <tr>
                                    <td style="width: 263px" valign="top">
                                      <asp:Label ID="DLIFRLabel" runat="server" Width="256px">Días límite para informe rápido final</asp:Label></td>
                                    <td style="width: 206px" valign="top">
                                      <asp:TextBox ID="DLIFR" runat="server" CssClass="FormText" Width="50px" Text='<%# Bind("diasIFR") %>'></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator4" runat="server" ControlToValidate="DLIFR" ErrorMessage="Ingrese los días límite para el informe final rápido"
                                        Font-Bold="True" Display="Dynamic">(*)</asp:RequiredFieldValidator>
                                      <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="DLIFR"
                                        Display="Dynamic" ErrorMessage="Ingrese un número válido" Font-Bold="True" MaximumValue="999"
                                        MinimumValue="0" Type="Integer">Número inválido</asp:RangeValidator></td>
                                  </tr>
                                </table>
                              </EditItemTemplate>
                            </asp:FormView>
                            <asp:Panel ID="subaccesoPanel" runat="server" Height="50px" Width="125px">
                              <table style="width: 455px; height: 14px; left: 0px; top: 0px;">
                                <tr>
                          <td style="width: 263px" valign="top">
                            <asp:Label ID="DLERSLabel" runat="server" Width="254px">Días límite para recordatorios solicitudes</asp:Label></td>
                          <td style="width: 206px" valign="top">
                            <asp:TextBox ID="DLERS" runat="server" CssClass="FormText" Width="50px"></asp:TextBox><asp:RequiredFieldValidator
                              ID="RequiredFieldValidator5" runat="server" ControlToValidate="DLERS" ErrorMessage="Ingrese los días límite para emisión de recordatorios"
                              Font-Bold="True" Display="Dynamic">(*)</asp:RequiredFieldValidator><asp:RangeValidator
                                ID="RangeValidator5" runat="server" ControlToValidate="DLERS" Display="Dynamic"
                                ErrorMessage="Ingrese un número válido" Font-Bold="True" MaximumValue="999" MinimumValue="0"
                                Type="Integer">Número inválido</asp:RangeValidator></td>
                                </tr>
                                <tr>
                          <td style="width: 263px" valign="top">
                            <asp:Label ID="lblNumInicial" runat="server" Width="243px">Numero Secuencial actual del Ajuste</asp:Label></td>
                          <td style="width: 206px" valign="top">
                            <asp:TextBox ID="txtNumInicial" runat="server" CssClass="FormText" Width="50px"></asp:TextBox><asp:RequiredFieldValidator
                              ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtNumInicial" Display="Dynamic"
                              ErrorMessage="Ingrese los días límite para emisión de recordatorios" Font-Bold="True">(*)</asp:RequiredFieldValidator><asp:RangeValidator
                                ID="RangeValidator6" runat="server" ControlToValidate="txtNumInicial" Display="Dynamic"
                                ErrorMessage="Ingrese un número válido" Font-Bold="True" MaximumValue="9999" MinimumValue="0"
                                Type="Integer">Número inválido</asp:RangeValidator></td>
                                </tr>
                                <tr>
                          <td style="width: 263px; height: 48px;" valign="top">
                            <asp:Label ID="Label1" runat="server" Width="244px">Número Actual de Carta</asp:Label></td>
                          <td style="width: 206px; height: 48px;" valign="top">
                            <asp:FormView ID="frmUpdateNumCarta" runat="server" DataSourceID="odsNumCarta" DefaultMode="Edit"
                              Style="left: 0px" CellPadding="0">
                              <EditItemTemplate>
                                <asp:TextBox ID="valorParametroTextBox" runat="server" CssClass="FormText" Text='<%# Bind("valorParametro") %>'
                                  Width="50px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="valorParametroTextBox"
                                  Display="Dynamic" ErrorMessage="Ingrese los días límite para emisión de recordatorios"
                                  Font-Bold="True">(*)</asp:RequiredFieldValidator><asp:RangeValidator ID="RangeValidator7"
                                    runat="server" ControlToValidate="valorParametroTextBox" Display="Dynamic" ErrorMessage="Ingrese un número válido"
                                    Font-Bold="True" MaximumValue="9999" MinimumValue="0" Type="Integer">número inválido</asp:RangeValidator><br />
                                &nbsp;
                              </EditItemTemplate>
                            </asp:FormView>
                          </td>
                                </tr>
                                <tr>
                          <td style="width: 263px; height: 48px" valign="top">
                            <button id="btnRequisitos" class="FormButton" onclick="return btnRequisitos_onclick()"
                              style="width: 170px">
                              Cartas Por Riesgo</button>
                            <br />
                            <br />
                            <button id="btnProducto" class="FormButton" onclick="return btnProducto_onclick()"
                              style="width: 170px">
                              Productos</button><br />
                            <br />
                            <button id="btnRamo" class="FormButton" onclick="return btnRamo_onclick()" style="width: 170px">
                              Ramos</button><br />
                            <br />
                            <button id="btnCobertura" class="FormButton" onclick="return btnCobertura_onclick()"
                              style="width: 170px">
                              Cobertura</button><br />
                            <br />
                            <button id="btnTipoSiniestro" class="FormButton" onclick="return btnTipoSiniestro_onclick() "
                              style="width: 170px">
                              Tipo de Siniestro</button>
                            <br />
                            <br />
                            <button id="btnAseguradora" class="FormButton" onclick="return btnAseguradora_onclick() "
                              style="width: 170px">
                              Aseguradoras</button>
                            <br />
                            <br />
                            <button id="btnBroker" class="FormButton" onclick="return btnBroker_onclick() " style="width: 170px">
                              Brokers</button>
                            <br />
                            <br />
                            <button id="Button1" class="FormButton" onclick="return btnAsegurado_onclick() "
                              style="width: 170px">
                              Asegurados</button>
                          </td>
                          <td style="width: 206px; height: 48px" valign="top">
                          </td>
                                </tr>
                              </table>
                            </asp:Panel>
                          </td>
                        </tr>
                      </table>
                      &nbsp;
                    
                    <br />
                  </td>
                </tr>
                <tr>
                  <td colspan="2">
                  </td>
                </tr>
              </table>
            </div>
          </div>
          <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
          </div>
        </td>
      </tr>
    </table>
    <asp:ObjectDataSource ID="odsAseguradora" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsBroker" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.BrokerComboTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsNumCarta" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsCartasTableAdapters.numeroComunicacionActualTableAdapter"
      UpdateMethod="Update">
      <UpdateParameters>
        <asp:Parameter Name="valorParametro" Type="String" />
      </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsSubaccesoAseguradora" runat="server" SelectMethod="GetData"
      TypeName="dsUsuariosTableAdapters.SubAccesoTableAdapter" OnSelected="odsSubaccesoAseguradora_Selected"
      InsertMethod="SubAccesoInsert">
      <SelectParameters>
        <asp:ControlParameter ControlID="aseguradoraIdCombo" Name="aseguradoraId" PropertyName="SelectedValue"
          Type="Decimal" />
        <asp:ControlParameter ControlID="brokerIdCombo" Name="brokerId" PropertyName="SelectedValue"
          Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:ControlParameter ControlID="aseguradoraIdCombo" Name="aseguradoraId" PropertyName="SelectedValue"
          Type="Decimal" />
        <asp:ControlParameter ControlID="brokerIdCombo" Name="brokerId" PropertyName="SelectedValue"
          Type="Decimal" />
        <asp:SessionParameter Name="uupdate" SessionField="usuario" Type="String" />
      </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsConfiguracion" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsUsuariosTableAdapters.CONFIGURACIONXASEGURADORATableAdapter"
      UpdateMethod="Update">
      <UpdateParameters>
        <asp:Parameter Name="diasIB" Type="Decimal" />
        <asp:Parameter Name="diasIP" Type="Decimal" />
        <asp:Parameter Name="diasIC" Type="Decimal" />
        <asp:Parameter Name="diasIFR" Type="Decimal" />
        <asp:Parameter Name="Original_aseguradoraId" Type="Decimal" />
      </UpdateParameters>
      <SelectParameters>
        <asp:ControlParameter ControlID="hdfAseguradoraId" Name="aseguradoraId"
          PropertyName="Value" Type="Decimal" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
      ShowSummary="False" />
  </form>

  <script type="text/javascript">
        creaPopUpDivs();
  </script>

</body>
</html>
