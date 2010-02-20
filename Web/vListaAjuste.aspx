<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaAjuste.aspx.cs" Inherits="vListaAjuste" %>

<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc1" %>
<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
  TagPrefix="uc2" %>
<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Riesgos Generales | Lista de Ajustes</title>
  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/subModal.css' />
  <link rel='stylesheet' type='text/css' href='Scripts/popUpWin/css/style.css' />

  <script type='text/javascript' src="Scripts/lib/x_core.js"></script>

  <script type='text/javascript' src='Scripts/lib/x_dom.js'></script>

  <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <script type='text/javascript'>
        function muestraPopUp(elemento) {	
    		
	        showPopWin(elemento.href, 758, 570, null);		
		    return false;
	    }
  </script>

  <script type="text/javascript" language="javascript">
	    window.onload = function () {
    	
	    btn_mostrar_Ocultar = new CollapsibleDiv('img_hide_cabecera',
						     'cabecera_collapsible',						 
						     true,
						     null);
	    btn_agregarNuevoArchivo = new CollapsibleDiv('img_hide_grpBusqueda',
						     'grupoBusqueda',						 
						     true,
						     null);
    	
    }

    window.onunload= function () {
	    if (btn_mostrar_Ocultar) btn_mostrar_Ocultar.UnLoad();
    }
  </script>


    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <link href="./Scripts/wcc_includes/calendar-blue.css" rel="stylesheet" type="text/css" />
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
    <link href="./Scripts/wcc_includes/calendar-blue.css" rel="stylesheet" type="text/css" />
    <link href="./Scripts/wcc_includes/calendar-blue.css" rel="stylesheet" type="text/css" />
    <link href="./Scripts/wcc_includes/calendar-blue.css" rel="stylesheet" type="text/css" />
    <link href="./Scripts/wcc_includes/calendar-blue.css" rel="stylesheet" type="text/css" />
    <link href="./Scripts/wcc_includes/calendar-blue.css" rel="stylesheet" type="text/css" />

</head>
<body>
  <table id="Data" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td>
        <form id="form1" runat="server">
          <div id="cabecera_collapsible" style="position: relative;">
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="ajuste" />
            <uc2:linksAjustadorAdministrador ID="LinksAjustadorAdministrador1" runat="server" />
          </div>
          <div style="height: 1px; margin: 0px;">
          </div>
          <!-- aqui -->
          <div id="grupoBusqueda">
            <div class="DataTop">
              <div class="DataTopLeft">
              </div>
              <div class="DataTopRight">
              </div>
            </div>
            <div class="DataContent">
              <div class="DataContentRight">
                <div style="height: 16px">
                  <asp:Label ID="lblNotificar" runat="server" Font-Bold="True" Font-Size="18px" Style="float: left">Búsqueda</asp:Label>
                  <img alt="" src="imgRGen/openCloseCollapse.jpg" id="img_hide_cabecera" title="Ocultar/Mostrar Cabecera"
                    style="float: right; margin-top: 3px" />
                </div>
                <div class="hr">
                </div>
                <table border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Asegurado</td>
                    <td style="width: 266px;">
                      <asp:TextBox ID="txtAsegurado" runat="server" CssClass="FormText" Width="233px" TabIndex="5"></asp:TextBox></td>
                    <td style="width: 150px">
                      Ramo</td>
                    <td style="width: 235px">
                      <span>
                        <asp:DropDownList ID="cbxRamo" runat="server" CssClass="FormSelect" Width="207px"
                          TabIndex="5" AppendDataBoundItems="True" DataSourceID="odsRamo" DataTextField="nombre"
                          DataValueField="ramoId">
                        </asp:DropDownList>
                      </span>
                    </td>
                    <td style="width: 223px;" rowspan="3">
                      &nbsp; &nbsp;<asp:ImageButton ID="ibtnBuscar" runat="server" ImageUrl="~/imgRGen/btnBuscar.gif"
                        TabIndex="17" OnClick="ibtnBuscar_Click" ValidationGroup="ValidDates" /></td>
                  </tr>
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Aseguradora</td>
                    <td style="width: 266px">
                      <asp:DropDownList ID="cbxCia" runat="server" CssClass="FormSelect" Width="237px"
                        TabIndex="5" AppendDataBoundItems="True" DataSourceID="odsCia" DataTextField="persona"
                        DataValueField="personaid" OnDataBound="cbxCia_DataBound">
                      </asp:DropDownList></td>
                    <td style="width: 150px">
                      Tipo de Ajuste
                    </td>
                    <td style="width: 235px">
                      <span>
                        <asp:DropDownList ID="cbxLiquidacion" runat="server" CssClass="FormSelect" Width="207px"
                          TabIndex="5" AppendDataBoundItems="True" DataSourceID="odsTipoLiquidacion" DataTextField="tajuste"
                          DataValueField="tajusteid">
                        </asp:DropDownList>
                      </span>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Broker</td>
                    <td style="width: 266px">
                      <asp:DropDownList ID="cbxBroker" runat="server" AppendDataBoundItems="True" CssClass="FormSelect"
                        DataSourceID="odsBroker" DataTextField="persona" DataValueField="personaId" Width="237px"
                        TabIndex="5" OnDataBound="cbxBroker_DataBound">
                      </asp:DropDownList></td>
                    <td style="width: 150px">
                      Tipo de Siniestro
                    </td>
                    <td style="width: 235px">
                      <asp:TextBox ID="txtSiniestro" runat="server" CssClass="FormText" Width="202px" TabIndex="5"></asp:TextBox>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Encargado Aseguradora
                    </td>
                    <td style="width: 266px">
                      <asp:TextBox ID="txtEjecutivo" runat="server" CssClass="FormText" Width="233px" TabIndex="5"></asp:TextBox></td>
                    <td style="width: 150px">
                      Status</td>
                    <td style="width: 235px">
                      <span>
                        <asp:DropDownList ID="cbxEstatus" runat="server" CssClass="FormSelect" Width="207px"
                          TabIndex="5" AppendDataBoundItems="True" DataSourceID="odsEstatus" DataTextField="estadoajuste"
                          DataValueField="estadoajusteid">
                        </asp:DropDownList>
                      </span>
                    </td>
                    <td style="width: 223px" rowspan="6" valign="top">
                      <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtFechaInicio"
                        ErrorMessage="La fecha de Inicio no es una fecha válida" Font-Bold="False" ForeColor="Linen"
                        OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="ValidDates"
                        Width="260px">La fecha de Inicio no es una fecha válida</asp:CustomValidator><br />
                      <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtFechaFin"
                        ErrorMessage="La fecha Final no es una fecha válida" Font-Bold="False" ForeColor="Snow"
                        OnServerValidate="CustomValidator2_ServerValidate" ValidationGroup="ValidDates"
                        Width="240px">La fecha Final no es una fecha válida</asp:CustomValidator><br />
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEntre"
                        ErrorMessage="Los días deben ser números" Font-Bold="False" ForeColor="White" ValidationExpression="[0-9]*"
                        ValidationGroup="ValidDates" Width="225px">Los días deben ser números</asp:RegularExpressionValidator><br />
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtFin"
                        ErrorMessage="Los días deben ser números" Font-Bold="False" ForeColor="White" ValidationExpression="[0-9]*"
                        ValidationGroup="ValidDates" Width="225px"></asp:RegularExpressionValidator><asp:RegularExpressionValidator
                          ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtReservaEntre"
                          ErrorMessage="Los montos de reserva deben ser números" Font-Bold="False" ForeColor="White"
                          ValidationExpression="[0-9]*" ValidationGroup="ValidDates" Width="256px">Los montos de reserva deben ser números</asp:RegularExpressionValidator><br />
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtReservaHasta"
                        ErrorMessage="Los montos de reserva deben ser números" Font-Bold="False" ForeColor="White"
                        ValidationExpression="[0-9]*" ValidationGroup="ValidDates" Width="256px">Los montos de reserva deben ser números</asp:RegularExpressionValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtDiasEntre"
                        ErrorMessage="Los días deben ser números" Font-Bold="False" ForeColor="White" ValidationExpression="[0-9]*"
                        ValidationGroup="ValidDates" Width="186px">Los días deben ser números</asp:RegularExpressionValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtDiasHasta"
                        ErrorMessage="Los días deben ser números" Font-Bold="False" ForeColor="White" ValidationExpression="[0-9]*"
                        ValidationGroup="ValidDates" Width="186px">Los días deben ser números</asp:RegularExpressionValidator></td>
                  </tr>
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Encargado Broker
                    </td>
                    <td style="width: 266px">
                      <asp:TextBox ID="txtEjecutivoBroker" runat="server" CssClass="FormText" Width="233px"
                        TabIndex="5"></asp:TextBox></td>
                    <td style="width: 150px">
                      N&deg; Siniestro
                    </td>
                    <td style="width: 235px">
                      <span>
                        <asp:TextBox ID="txtNroSiniestroCia" runat="server" CssClass="FormText" Width="203px"
                          TabIndex="5"></asp:TextBox>
                      </span>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Encargado Ajustador
                    </td>
                    <td style="width: 266px; height: 20px;">
                      <asp:DropDownList ID="cbxAjustador" runat="server" CssClass="FormSelect" Width="237px"
                        TabIndex="5" AppendDataBoundItems="True" DataSourceID="odsAjustador" DataTextField="persona"
                        DataValueField="personaid" OnDataBound="cbxAjustador_DataBound">
                      </asp:DropDownList></td>
                    <td style="width: 150px; height: 20px;">
                      N&deg; Broker
                    </td>
                    <td style="width: 235px; height: 20px;">
                      <span>
                        <asp:TextBox ID="txtNroSiniestroBroker" runat="server" CssClass="FormText" Width="203px"
                          TabIndex="5"></asp:TextBox>
                      </span>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Ejecutivo Siniestros</td>
                    <td style="width: 266px">
                        <asp:DropDownList ID="cbxEjecutivoSiniestros" runat="server" AppendDataBoundItems="True"
                            CssClass="FormSelect" DataSourceID="odsEjecutivoSiniestros" DataTextField="persona"
                            DataValueField="personaid" Width="237px" OnDataBound="cbxEjecutivoSiniestros_DataBound">
                        </asp:DropDownList></td>
                    <td style="width: 150px">
                      N&deg; Ajuste
                    </td>
                    <td style="width: 235px">
                      <span>
                        <asp:TextBox ID="txtNroAjuste" runat="server" CssClass="FormText" Width="203px" TabIndex="5"></asp:TextBox>
                      </span>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Nro. Poliza</td>
                    <td style="width: 266px">
                      <asp:TextBox ID="txtPoliza" runat="server" CssClass="FormText" Width="233px" TabIndex="5"></asp:TextBox></td>
                    <td style="width: 150px">
                      Reserva Neta</td>
                    <td style="width: 235px">
                      <table width="250" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="24">
                            de</td>
                          <td width="19">
                            <span style="width: 207px; height: 12px">
                              <img alt="Escoja una fecha" border="0" height="16" style="visibility: hidden;" src="img/cal.gif"
                                width="16" /></span></td>
                          <td width="67">
                            <asp:TextBox ID="txtReservaEntre" runat="server" CssClass="FormText" TabIndex="5"
                              Width="50px"></asp:TextBox></td>
                          <td width="22">
                            <div align="center">
                              a</div>
                          </td>
                          <td width="21">
                            <span style="height: 12px">
                              <img style="visibility: hidden;" alt="Escoja una fecha" border="0" height="16" src="img/cal.gif"
                                width="16" /></span></td>
                          <td>
                            <asp:TextBox ID="txtReservaHasta" runat="server" CssClass="FormText" TabIndex="5"
                              Width="50px"></asp:TextBox></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 20px; width: 164px;">
                      &nbsp;Fecha de Siniestro</td>
                    <td style="width: 266px">
                      <table border="0" cellspacing="0" cellpadding="0" style="left: 0px; top: 0px">
                        <tr>
                          <td colspan="2" style="width: 20px">
                            del&nbsp;</td>
                          <td style="width: 96px">
                            <cc1:WebCalendar ID="txtFechaInicio" runat="server" BtnCalendarImage="img/cal.gif"
                              GenerateBtn="True" CssClass="FormText" WcResourcesDir="./Scripts/wcc_includes"
                              Width="70px" TabIndex="5"></cc1:WebCalendar><%--       <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'txtFechaInicio',
                                                                        ifFormat       :    '%d/%m/%Y',
                                                                        button         :    'btnFechaInicio',
                                                                        showsTime      :    false,                                                                        
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                                  </script>--%></td>
                          <td colspan="2" style="width: 28px">
                            <div align="center">
                              al</div>
                          </td>
                          <td style="width: 87px">
                            <cc1:WebCalendar CssClass="FormText" ID="txtFechaFin" runat="server" BtnCalendarImage="img/cal.gif"
                              GenerateBtn="True" SingleClick="true" DaFormat="%d/%m/%Y" WcResourcesDir="./Scripts/wcc_includes"
                              Width="70px" TabIndex="5"></cc1:WebCalendar><%-- <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'txtFechaFin',
                                                                        ifFormat       :    '%d/%m/%Y' ,
                                                                        button         :    'btnFechaFin',
                                                                        showsTime      :    false,                                                                        
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                                  </script>--%></td>
                        </tr>
                      </table>
                    </td>
                    <td style="width: 150px">
                      D&iacute;as desde el último cambio de Estado</td>
                    <td style="width: 235px">
                      <table width="250" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="24">
                            de</td>
                          <td width="19">
                            <span style="width: 207px; height: 12px">
                              <img alt="Escoja una fecha" border="0" height="16" onclick="NewCal('txtFechaInicio','ddmmyyyy',true,24)"
                                style="visibility: hidden;" src="img/cal.gif" width="16" /></span></td>
                          <td width="67">
                            <asp:TextBox ID="txtEntre" runat="server" CssClass="FormText" TabIndex="5" Width="50px"></asp:TextBox></td>
                          <td width="22">
                            <div align="center">
                              a</div>
                          </td>
                          <td width="21">
                            <span style="height: 12px">
                              <img style="visibility: hidden;" alt="Escoja una fecha" border="0" height="16" onclick="NewCal('txtFechaFin','ddmmyyyy',true,12)"
                                src="img/cal.gif" width="16" /></span></td>
                          <td>
                            <asp:TextBox ID="txtFin" runat="server" CssClass="FormText" TabIndex="5" Width="50px"></asp:TextBox></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <tr>
                    <td style="width: 164px; height: 13px;">
                      &nbsp;D&iacute;as de asignado
                    </td>
                    <td style="width: 266px; height: 13px;">
                      <table border="0" cellspacing="0" cellpadding="0" style="left: 0px">
                        <tr>
                          <td colspan="2" style="width: 22px">
                            de&nbsp;</td>
                          <td style="width: 95px">
                            <%--       <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'txtFechaInicio',
                                                                        ifFormat       :    '%d/%m/%Y',
                                                                        button         :    'btnFechaInicio',
                                                                        showsTime      :    false,                                                                        
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                                  </script>--%>
                            <asp:TextBox ID="txtDiasEntre" runat="server" CssClass="FormText" TabIndex="5" Width="45px"></asp:TextBox></td>
                          <td colspan="2" style="width: 28px">
                            <div align="center">
                              a</div>
                          </td>
                          <td style="width: 87px">
                            <%-- <script type="text/javascript">
                                                                  Calendar.setup({
                                                                        inputField     :    'txtFechaFin',
                                                                        ifFormat       :    '%d/%m/%Y' ,
                                                                        button         :    'btnFechaFin',
                                                                        showsTime      :    false,                                                                        
                                                                        singleClick    :    false
                                                                    }); 
                                                                                                                                                            
                                                                    
                                  </script>--%>
                            <asp:TextBox ID="txtDiasHasta" runat="server" CssClass="FormText" TabIndex="5" Width="45px"></asp:TextBox></td>
                        </tr>
                      </table>
                    </td>
                    <td style="width: 150px; height: 13px;">
                      &nbsp;</td>
                    <td style="width: 235px; height: 13px;">
                      &nbsp;
                    </td>
                    <td style="width: 223px; height: 13px;">
                      &nbsp;</td>
                  </tr>
                    <tr>
                        <td style="width: 164px; height: 13px">
                        </td>
                        <td style="width: 266px; height: 13px">
                        </td>
                        <td style="width: 150px; height: 13px">
                        </td>
                        <td style="width: 235px; height: 13px">
                        </td>
                        <td style="width: 223px; height: 13px">
                        </td>
                    </tr>
                </table>
              </div>
              <div style="clear: both;">
              </div>
            </div>
          </div>
          <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
          </div>
          <!-- tabControl for Sytled -->
          <div id="grilla">
            <div class="DataTop">
              <div class="DataTopLeft">
              </div>
              <div class="DataTopRight">
              </div>
            </div>
            <div class="DataContent">
              <div class="DataContentRight">
                <div style="height: 16px">
                  <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="18px" Style="float: left">Lista de Ajustes</asp:Label>
                  <img alt="" src="imgRGen/openCloseCollapse.jpg" id="img_hide_grpBusqueda" title="Ocultar/Mostrar filtros de Búsqueda"
                    style="float: right; margin-top: 3px" />
                </div>
                <div class="hr">
                </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                  OnRowDataBound="GridView1_RowDataBound" AllowPaging="True" CellPadding="0" PageSize="30" OnPageIndexChanging="GridView1_PageIndexChanging">
                  <Columns>
                    <asp:BoundField DataField="Aseguradora" HeaderText="Aseguradora" SortExpression="Aseguradora" />
                    <asp:BoundField DataField="Broker" HeaderText="Broker" SortExpression="Broker" />
                    <asp:BoundField DataField="Asegurado" HeaderText="Asegurado" SortExpression="Asegurado" />
                    <asp:BoundField DataField="numeroPoliza" HeaderText="N&#186; P&#243;liza" SortExpression="numeroPoliza" />
                    <asp:BoundField DataField="Ramo" HeaderText="Ramo" SortExpression="Ramo" />
                    <asp:BoundField DataField="fsiniestro" DataFormatString="{0:dd-MM-yyyy}" HeaderText="Fecha Siniestro"
                      HtmlEncode="False" SortExpression="fsiniestro">
                      <ItemStyle Width="75px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NroDias" HeaderText="D&#237;as" SortExpression="NroDias">
                      <ItemStyle Width="25px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="siniestro" HeaderText="Tipo Siniestro" SortExpression="siniestro" />
                    <asp:BoundField DataField="numAjustePASA" HeaderText="N&#186; Ajuste" SortExpression="numAjustePASA" />
                    <asp:BoundField DataField="Ajustador" HeaderText="Ajustador" SortExpression="Ajustador" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="Dias" HeaderText="Dias" SortExpression="Dias">
                      <ItemStyle Width="25px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Reserva Neta" SortExpression="EstimadoReserva">
                      <ItemStyle Width="90px" Font-Bold="True" />
                      <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# muestraSimbolo((Eval("aseguradoraId")),(Eval("brokerId")),Eval("simbolo"),Eval("EstimadoReserva")) %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# muestraReserva((Eval("aseguradoraId")),(Eval("brokerId")),Eval("EstimadoReserva", "{0:#,###.00}")) %>'></asp:Label>
                      </ItemTemplate>
                      <HeaderStyle Width="90px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="observaciones" HeaderText="Observaciones" SortExpression="observaciones" />
                    <asp:BoundField DataField="aseguradoraId" HeaderText="aseguradoraId" SortExpression="aseguradoraId"
                      Visible="False" />
                    <asp:BoundField DataField="brokerId" HeaderText="brokerId" SortExpression="brokerId"
                      Visible="False" />
                  </Columns>
                  <RowStyle CssClass="ItemStyle" HorizontalAlign="Center" />
                  <HeaderStyle CssClass="HeaderStyle" Height="30px" />
                  <EmptyDataTemplate>
                    No hay Ajustes para mostrar que cumplan con esos criterios de búsqueda
                  </EmptyDataTemplate>
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetDataByFiltros" TypeName="dsAjusteTableAdapters.ListaAjusteTableAdapter"
                  OnSelected="ObjectDataSource1_Selected" OnSelecting="ObjectDataSource1_Selecting">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="txtAsegurado" Name="asegurado" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtFechaInicio" Name="fInicio" PropertyName="Text"
                      Type="DateTime" />
                    <asp:ControlParameter ControlID="txtFechaFin" Name="fFin" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="cbxCia" Name="Idcia" PropertyName="SelectedValue"
                      Type="Decimal" />
                    <asp:ControlParameter ControlID="cbxLiquidacion" Name="Idliquidacion" PropertyName="SelectedValue"
                      Type="Decimal" />
                    <asp:ControlParameter ControlID="txtSiniestro" Name="siniestro" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="cbxAjustador" Name="Idajustador" PropertyName="SelectedValue"
                      Type="Decimal" />
                      <asp:ControlParameter ControlID="cbxEjecutivoSiniestros" Name="IdejecutivoSiniestros"
                          PropertyName="SelectedValue" Type="Decimal" />
                    <asp:ControlParameter ControlID="cbxRamo" Name="Idramo" PropertyName="SelectedValue"
                      Type="Decimal" />
                    <asp:ControlParameter ControlID="cbxEstatus" Name="Idestado" PropertyName="SelectedValue"
                      Type="Decimal" />
                    <asp:ControlParameter ControlID="cbxBroker" Name="Idbroker" PropertyName="SelectedValue"
                      Type="Decimal" />
                    <asp:ControlParameter ControlID="txtNroSiniestroCia" Name="numsiniestroCia" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtNroSiniestroBroker" Name="numsiniestroBroker"
                      PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtNroAjuste" Name="numAjuste" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtPoliza" Name="numpoliza" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtEjecutivo" Name="ejecutivo" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtReservaEntre" Name="minreserva" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtReservaHasta" Name="maxreserva" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtDiasEntre" Name="mindia" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtDiasHasta" Name="maxdia" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtEjecutivoBroker" Name="ejecutivoBroker" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtEntre" Name="mindiaCambioEstado" PropertyName="Text"
                      Type="String" />
                    <asp:ControlParameter ControlID="txtFin" Name="maxdiaCambioEstado" PropertyName="Text"
                      Type="String" />
                  </SelectParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="odsAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsComboTableAdapters.AjustadorComboTableAdapter">
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="odsBroker" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsComboTableAdapters.BrokerComboTableAdapter"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="odsCia" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="odsTipoLiquidacion" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoAjusteComboTableAdapter">
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="odsEstatus" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsComboTableAdapters.EstadoAjusteComboTableAdapter">
                </asp:ObjectDataSource>
                  <asp:ObjectDataSource ID="odsEjecutivoSiniestros" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="dsComboTableAdapters.EjecutivoSiniestrosComboTableAdapter">
                  </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="odsRamo" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsComboTableAdapters.RamoComboTableAdapter"></asp:ObjectDataSource>
                &nbsp;<br />
              </div>
            </div>
            <div class="DataBottom">
              <div class="DataBottomLeft">
              </div>
              <div class="DataBottomRight">
              </div>
            </div>
          </div>
          <%-- <script type="text/javascript" language="javascript">
			        creaPopUpDivs();
            </script>--%>
        </form>
      </td>
    </tr>
  </table>
</body>
</html>
