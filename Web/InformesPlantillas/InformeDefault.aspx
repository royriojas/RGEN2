<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformeDefault.aspx.cs" Inherits="InformesPlantillas_InformeDefault" %>

<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<html xmlns="http//www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>
    <%=this.titulos %>
  </title>
  <link href="inf.css?nc=<%= DateTime.Now.ToString() %>" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div id="divDatosGenerales" runat="server">
      <h2>
        DATOS GENERALES</h2>
      <asp:FormView ID="frmDatosGenerales" runat="server" DataSourceID="odsDatosGenerales">
        <ItemTemplate>
          <table border="0" class="ReportCell" cellspacing="0" cellpadding="0" width="100%">
            <tr>
              <td valign="top" class="Negrita" style="width: 251px;">
                CONTRATANTE
              </td>
              <td width="10" valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td colspan="5" valign="top">
                <asp:Label ID="contratanteLabel" runat="server" Text='<%# Eval("contratante") %>'></asp:Label></td>
            </tr>
            <tr>
              <td valign="top" class="Negrita" style="width: 251px">
                ASEGURADO</td>
              <td valign="top" class="Negrita">
                :</td>
              <td colspan="5" valign="top">
                <asp:Label ID="aseguradoLabel" runat="server" Text='<%# Eval("asegurado") %>'></asp:Label></td>
            </tr>
            <tr>
              <td valign="top" class="Negrita" style="width: 251px">
                GIRO DEL NEGOCIO</td>
              <td valign="top" class="Negrita">
                :</td>
              <td colspan="5" valign="top">
                <asp:Label ID="gironegocioLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("gironegocio")) %>'></asp:Label></td>
            </tr>
            <tr>
              <td valign="top" class="Negrita" style="width: 251px">
                GRUPO ECONÓMICO</td>
              <td valign="top" class="Negrita">
                :</td>
              <td colspan="5" valign="top">
                <asp:Label ID="grupoeconomicoLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("grupoeconomico")) %>'></asp:Label></td>
            </tr>
            <tr>
              <td valign="top" class="Negrita" style="width: 251px">
                ASEGURADORA</td>
              <td valign="top" class="Negrita">
                :</td>
              <td width="627" valign="top">
                <asp:Label ID="aseguradoraLabel" runat="server" Text='<%# Eval("aseguradora") %>'></asp:Label></td>
              <td width="8" valign="top">
                &nbsp;</td>
              <td valign="top" class="Negrita" style="width: 135px;">
                RESPONSABLE</td>
              <td width="10" valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td width="288" valign="top">
                <asp:Label ID="responsableaseguradoraLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("responsableaseguradora")) %>'></asp:Label></td>
            </tr>
            <tr>
              <td valign="top" class="Negrita" style="width: 251px">
                BROKER</td>
              <td valign="top" class="Negrita">
                :</td>
              <td valign="top" style="text-align: left;">
                <asp:Label ID="brokerLabel" runat="server" Text='<%# Eval("broker") %>'></asp:Label></td>
              <td valign="top">
                &nbsp;</td>
              <td valign="top" class="Negrita" style="width: 135px">
                RESPONSABLE</td>
              <td valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="responsablebrokerLabel" runat="server" Text='<%# Eval("responsablebroker") %>'></asp:Label></td>
            </tr>
          </table>
          <br />
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsDatosGenerales" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoGeneralesTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divFechaAvisoCoordinacion" runat="server">
      <h2>
        FECHA - HORA DE AVISO & COORDINACIÓN</h2>
      <asp:FormView ID="frmFechaHoraAviso" runat="server" DataSourceID="odsFechaHoraAviso">
        <ItemTemplate>
          <table class="ReportCellNotJustify" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="Negrita" style="width: 217px;" valign="top">
                AVISÓ</td>
              <td width="10" class="Negrita" style="width: 10px;" valign="top">
                :</td>
              <td valign="top" style="width: 171px">
                <asp:Label ID="fechaavisoLabel" runat="server" Text='<%# Eval("fechaaviso","{0:dd/MM/yyyy HH:mm}") %>'></asp:Label></td>
              <td width="10" style="width: 10px;" valign="top">
                &nbsp;</td>
              <td class="Negrita" style="width: 60px;" valign="top">
                QUIÉN</td>
              <td width="10" class="Negrita" style="width: 10px;" valign="top">
                :</td>
              <td width="276" valign="top">
                <asp:Label ID="quienLabel" runat="server" Text='<%# Eval("quien") %>'></asp:Label></td>
              <td width="10" style="width: 10px;" valign="top">
                &nbsp;</td>
              <td class="Negrita" style="width: 34px;" valign="top">
                VÍA</td>
              <td width="10" class="Negrita" style="width: 10px;" valign="top">
                :</td>
              <td width="221" valign="top">
                <asp:Label ID="viaLabel" runat="server" Text='<%# Eval("via") %>'></asp:Label></td>
            </tr>
            <tr>
              <td class="Negrita" style="width: 217px" valign="top">
                COORDINACIÓN</td>
              <td class="Negrita" valign="top">
                :</td>
              <td valign="top" style="width: 171px">
                <asp:Label ID="fechacoordinacionLabel" runat="server" Text='<%# Eval("fechacoordinacion","{0:dd/MM/yyyy HH:mm}") %>'></asp:Label></td>
              <td valign="top">
                &nbsp;</td>
              <td class="Negrita" style="width: 60px" valign="top">
                CON</td>
              <td class="Negrita" valign="top">
                :</td>
              <td valign="top">
                <asp:Label ID="con1Label" runat="server" Text='<%# Eval("con1") %>'></asp:Label></td>
              <td valign="top">
                &nbsp;</td>
              <td class="Negrita" style="<%# CCSOL.Utiles.Utilidades.IsNull(Eval("es1")) %>; width: 34px;"
                valign="top">
                ES</td>
              <td style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("es1")) %>' class="Negrita" valign="top">
                :</td>
              <td style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("es1")) %>' valign="top">
                <asp:Label ID="es1Label" runat="server" Text='<%# Eval("es1") %>'></asp:Label>
              </td>
            </tr>
            <tr>
              <td class="Negrita" style="width: 217px" valign="top">
                INSPECCIÓN
              </td>
              <td class="Negrita" valign="top">
                :</td>
              <td valign="top" style="width: 171px">
                <asp:Label ID="fechainspeccionLabel" runat="server" Text='<%# Eval("fechainspeccion", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label></td>
              <td valign="top">
                &nbsp;</td>
              <td class="Negrita" style="width: 60px" valign="top">
                CON</td>
              <td class="Negrita" valign="top">
                :</td>
              <td valign="top">
                <asp:Label ID="con2Label" runat="server" Text='<%# Eval("con2") %>'></asp:Label></td>
              <td valign="top">
                &nbsp;</td>
              <td class="Negrita" style="<%# CCSOL.Utiles.Utilidades.IsNull(Eval("es2")) %>; width: 34px;"
                valign="top">
                ES</td>
              <td style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("es2")) %>' class="Negrita" valign="top">
                :</td>
              <td style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("es2")) %>' valign="top">
                <asp:Label ID="es2Label" runat="server" Text='<%# Eval("es2") %>'></asp:Label>
              </td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsFechaHoraAviso" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoFechaAvisoCoordinacionTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divOcurrencia" runat="server">
      <h2>
        DE LA OCURRENCIA</h2>
      <asp:FormView ID="frmOcurrencia" runat="server" DataSourceID="odsOcurrencia">
        <ItemTemplate>
          <table class="ReportCell" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td valign="top" class="Negrita" style="width: 217px;">
                Tipo de Siniestro</td>
              <td width="10" valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <asp:Label ID="tipoSiniestroLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("tipoSiniestro")) %>'></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 217px;" valign="top" class="Negrita">
                Fecha Siniestro</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="fechasiniestroLabel" runat="server" Text='<%# Eval("fechasiniestro") %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("lugarSiniestro")) %>'>
              <td style="width: 217px;" valign="top" class="Negrita">
                Lugar del Siniestro</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="lugarSiniestroLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("lugarSiniestro")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("detalleocurrencia")) %>'>
              <td style="width: 217px;" valign="top" class="Negrita">
                Detalle Ocurrencia</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="detalleocurrenciaLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("detalleocurrencia")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("causasiniestro")) %>'>
              <td style="width: 217px;" valign="top" class="Negrita">
                Causa del Siniestro</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="causasiniestroLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("causasiniestro")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("investigaciones")) %>'>
              <td style="width: 217px;" valign="top" class="Negrita">
                Investigaciones</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="investigacionesLabel" runat="server" Text='<%# Eval("investigaciones") %>'></asp:Label></td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsOcurrencia" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoOcurrenciaCabeceraTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divInspeccion" runat="server">
      <h2>
        DE LA INSPECCIÓN</h2>
      <asp:FormView ID="frmInspeccion" runat="server" DataSourceID="odsInspeccion">
        <ItemTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="ReportCell">
            <tr>
              <td style="width: 217px;" valign="top" class="Negrita">
                Lugar de Inspección</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="lugarDeReunionLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("lugarDeReunion")) %>'></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 217px;" valign="top" class="Negrita">
                &nbsp;</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                &nbsp;</td>
              <td valign="top">
                <asp:Label ID="DistritoLabel" runat="server" Text='<%# Eval("Distrito") %>'></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 217px;" valign="top" class="Negrita">
                Persona Entrevistada</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="PersonaEntrevistadaLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("PersonaEntrevistada")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("descripcionRiesgo")) %>'>
              <td style="width: 217px;" valign="top" class="Negrita">
                Descripción del Riesgo</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="descripcionRiesgoLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("descripcionRiesgo")) %>'></asp:Label></td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsInspeccion" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoInspeccionTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divDanos" runat="server">
      <h3>
        DETALLE DE DAÑOS Y/O PERDIDAS
      </h3>
      <cc1:Repeater ID="Repeater1" runat="server" DataSourceID="odsOcurrenciaDetalle" OnItemDataBound="Repeater1_ItemDataBound">
        <HeaderTemplate>
          <table class="GridViewNotJustify" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr class="header">
              <th width="4%">
                Nº</th>
              <th width="28%">
                BIENES Y/O PERSONAS AFECTADAS</th>
              <th width="24%">
                DESCRIPCIÓN DE LOS DAÑOS, PERDIDAS Y/O HERIDAS</th>
              <th width="26%">
                LOCAL</th>
              <th width="18%">
                ESTIMACIÓN DE DAÑO Y/O PERDIDA</th>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td valign="top">
              <div align="center">
                <asp:Label ID="itemLabel" runat="server" Text='<%# this.Num++ %>'></asp:Label>
              </div>
            </td>
            <td valign="top">
              <%#R3M.Common.Util.ReplaceASBR(Eval("Bienes"))%>
            </td>
            <td valign="top">
              <%#R3M.Common.Util.ReplaceASBR(Eval("descripcion"))%>
            </td>
            <td valign="top">
              <%#(Eval("LocalDelBien"))%>
            </td>
            <td valign="top">
              <div style="text-align: right;">
                <%#Eval("estimacion", "{0:#,##0.00}")%>
              </div>
            </td>
          </tr>
        </ItemTemplate>
        <FooterTemplate>
          <tr>
            <td colspan="4" valign="top">
              <div class="Negrita" align="right">
                TOTAL PÉRDIDAS ESTIMADAS US$
              </div>
            </td>
            <td valign="top">
              <div style="text-align: right;">
                <%#  SumaDetalleOcurrencia.ToString("#,##0.00")%>
              </div>
            </td>
          </tr>
          </table>
        </FooterTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsOcurrenciaDetalle" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoOcurrenciaDetalleTableAdapter"
        OnSelecting="odsOcurrenciaDetalle_Selecting" OnSelected="odsOcurrenciaDetalle_Selected">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divPoliza" runat="server">
      <h2>
        DE LA PÓLIZA</h2>
      <asp:FormView ID="FormView1" runat="server" DataSourceID="odsPoliza">
        <ItemTemplate>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ReportCell">
            <tr>
              <td valign="top" class="Negrita" style="width: 112px;">
                Producto</td>
              <td width="11" valign="top" class="Negrita">
                :</td>
              <td width="535" valign="top">
                <asp:Label ID="PRODUCTOLabel" runat="server" Text='<%# Eval("PRODUCTO") %>'></asp:Label></td>
              <td width="7" valign="top">
                &nbsp;</td>
              <td valign="top" class="Negrita" style="width: 69px;">
                Número</td>
              <td width="10" valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td width="263" valign="top">
                <asp:Label ID="numeroLabel" runat="server" Text='<%# Eval("numero") %>'></asp:Label></td>
            </tr>
            <tr>
              <td valign="top" class="Negrita" style="width: 112px">
                Ramo</td>
              <td valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="RAMOLabel" runat="server" Text='<%# Eval("RAMO") %>'></asp:Label></td>
              <td valign="top">
                &nbsp;</td>
              <td valign="top" class="Negrita" style="width: 69px">
                Vigencia</td>
              <td valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="vigenciaLabel" runat="server" Text='<%# Eval("vigencia") %>'></asp:Label></td>
            </tr>
            <tr>
              <td valign="top" class="Negrita" style="width: 112px">
                Cobertura</td>
              <td valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="coberturaLabel" runat="server" Text='<%# Eval("cobertura") %>'></asp:Label></td>
              <td valign="top">
                &nbsp;</td>
              <td valign="top" class="Negrita" style="width: 69px">
                &nbsp;</td>
              <td valign="top" class="Negrita">
                &nbsp;</td>
              <td valign="top">
                &nbsp;</td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsPoliza" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoPolizaTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divSublimitesAfectados" runat="server">
      <h3>
        DETALLE DE LOS SUBLÍMITES AFECTADOS</h3>
      <cc1:Repeater ID="repeaterSublimites" runat="server" DataSourceID="odsPolizaDetalle"
        OnItemCreated="repeaterSublimites_ItemCreated1" OnItemDataBound="repeaterSublimites_ItemDataBound">
        <EmptyDataTemplate>
        </EmptyDataTemplate>
        <HeaderTemplate>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="GridViewNotJustify">
            <tr class="header">
              <th width="4%">
                Nº</th>
              <th width="28%">
                DETALLE</th>
              <th width="24%">
                LOCAL</th>
              <th width="22%">
                <asp:Label ID="concepto1Label" runat="server" Text=''></asp:Label></th>
              <th width="22%">
                <asp:Label ID="concepto2Label" runat="server" Text=''></asp:Label></th>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td valign="top">
              <div align="center">
                <asp:Label ID="itemLabel" runat="server" Text='<%# this.Num++ %>'></asp:Label>
              </div>
            </td>
            <td valign="top">
              <asp:Label ID="detalleLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("detalle"))%>'></asp:Label></td>
            <td valign="top">
              <asp:Label ID="localLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("localItem"))%>'></asp:Label></td>
            <td valign="top">
              <div style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("monto")) %>; text-align: right;'>
                <asp:Label ID="simboloLabel" runat="server" Text='<%#Eval("simbolo")%>'></asp:Label>
                <asp:Label ID="montoLabel" runat="server" Text='<%#Eval("monto", "{0:#,##0.00}")%>'></asp:Label>
              </div>
            </td>
            <td valign="top">
              <div style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("montoAsegurado2")) %> text-align: right;'>
                <asp:Label ID="simbolo2Label" runat="server" Text='<%#Eval("simbolo")%>'></asp:Label>
                <asp:Label ID="montoAsegurado2" runat="server" Text='<%#Eval("montoAsegurado2", "{0:#,##0.00}")%>'></asp:Label>
              </div>
            </td>
          </tr>
        </ItemTemplate>
        <FooterTemplate>
          </table>
        </FooterTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsPolizaDetalle" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoPolizaDetalleTableAdapter"
        OnSelecting="odsPolizaDetalle_Selecting" OnSelected="odsPolizaDetalle_Selected">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divDeducibles" runat="server">
      <table border="0" cellpadding="0" cellspacing="0" class="ReportCell">
        <tr>
          <td style="width: 229px;" valign="top" class="Negrita">
            Deducibles</td>
          <td style="width: 10px;" valign="top" class="Negrita">
            :</td>
          <td valign="top">
            &nbsp;
          </td>
        </tr>
        <tr>
          <td class="Negrita" style="width: 229px" valign="top">
          </td>
          <td class="Negrita" style="width: 10px" valign="top">
          </td>
          <td valign="top">
            <cc1:Repeater ID="repeaterDeducibles" runat="server" DataSourceID="odsDeducibles">
              <ItemTemplate>
                <ul>
                  <li>
                    <asp:Label ID="deducibleLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("condiciones"))%>'></asp:Label></li>
                </ul>
              </ItemTemplate>
            </cc1:Repeater>
            <asp:ObjectDataSource ID="odsDeducibles" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoDeduciblesTableAdapter"
              OnSelected="odsDeducibles_Selected">
              <SelectParameters>
                <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
              </SelectParameters>
            </asp:ObjectDataSource>
          </td>
        </tr>
      </table>
    </div>
    <br />
    <div id="divClausulas" runat="server">
      <table border="0" cellpadding="0" cellspacing="0" class="ReportCell">
        <tr>
          <td style="width: 229px;" valign="top" class="Negrita">
            Cláusulas Aplicables</td>
          <td style="width: 10px;" valign="top" class="Negrita">
            :</td>
          <td valign="top">
            &nbsp;
          </td>
        </tr>
        <tr>
          <td class="Negrita" style="width: 229px" valign="top">
          </td>
          <td class="Negrita" style="width: 10px" valign="top">
          </td>
          <td valign="top">
            <cc1:Repeater ID="repeaterClausulas" runat="server" DataSourceID="odsClausulas">
              <ItemTemplate>
                <ul>
                  <li>
                    <asp:Label ID="clausulaLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("nombre"))%>'></asp:Label></li>
                </ul>
              </ItemTemplate>
            </cc1:Repeater>
            <asp:ObjectDataSource ID="odsClausulas" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoClausulasTableAdapter"
              OnSelected="odsClausulas_Selected">
              <SelectParameters>
                <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
              </SelectParameters>
            </asp:ObjectDataSource>
          </td>
        </tr>
      </table>
    </div>
    <div id="divReclamoAsegurado" runat="server">
      <h2>
        DEL RECLAMO</h2>
      <asp:FormView ID="FormView2" runat="server" DataSourceID="odsReclamo" Width="455px">
        <ItemTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="ReportCell">
            <tr>
              <td style="width: 229px;" valign="top" class="Negrita">
                Reclamo del Asegurado</td>
              <td valign="top" class="Negrita">
                :</td>
              <td valign="top" style="width: 40px;">
                <asp:Label ID="monedaReclamoLabel" runat="server" Text='<%# Eval("monedaReclamo") %>'></asp:Label>
              </td>
              <td valign="top">
                <asp:Label ID="reclamoaseguradoLabel" runat="server" Text='<%# Eval("reclamoAsegurado", "{0:#,##0.00}") %>'></asp:Label></td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsReclamo" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoReclamoTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divInformacionComplementaria" runat="server">
      <h2>
        INFORMACIÓN COMPLEMENTARIA</h2>
      <asp:FormView ID="FormView3" runat="server" DataSourceID="odsInformacionComplementaria">
        <ItemTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="ReportCell">
            <tr style="<%# IsFinal?"display:none": "" %>; isfinal: '' %>;">
              <td style="width: 247px;" valign="top" class="Negrita">
                Reserva Estimada (neta)</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td valign="top">
                <asp:Label ID="monedaReservaLabel" runat="server" Text='<%# Eval("monedaReserva") %>'></asp:Label>
                <asp:Label ID="reservaestimadaLabel" runat="server" Text='<%#Eval("reservaestimada", "{0:#,##0.00}") %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("situacionajuste")) %>'>
              <td style="width: 247px;" valign="top" class="Negrita">
                Situación de Ajuste</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                <span class="Negrita" style="width: 10px;">:</span></td>
              <td valign="top">
                <asp:Label ID="situacionajusteLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("situacionajuste")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("verificaciongarantias")) %>'>
              <td style="width: 247px;" valign="top" class="Negrita">
                Verificación Garantias</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                <span class="Negrita" style="width: 10px;">:</span></td>
              <td valign="top">
                <asp:Label ID="verificaciongarantiasLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("verificaciongarantias")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("siniestrosanteriores")) %>'>
              <td style="width: 247px;" valign="top" class="Negrita">
                Siniestros Anteriores</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                <span class="Negrita" style="width: 10px;">:</span></td>
              <td valign="top">
                <asp:Label ID="siniestrosanterioresLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("siniestrosanteriores")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("salvamentoyrecupero")) %>'>
              <td style="width: 247px;" valign="top" class="Negrita">
                Salvamento y/o Recupero</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                <span class="Negrita" style="width: 10px;">:</span></td>
              <td valign="top">
                <asp:Label ID="salvamentoyrecuperoLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("salvamentoyrecupero")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("opinionAjustador")) %>'>
              <td style="width: 247px; height: 21px;" valign="top" class="Negrita">
                Opinión del Ajustador</td>
              <td style="width: 10px; height: 21px;" valign="top" class="Negrita">
                <span class="Negrita" style="width: 10px;">:</span></td>
              <td valign="top" style="height: 21px">
                <asp:Label ID="opinionAjustadorLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("opinionAjustador")) %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("recomendaciones")) %>'>
              <td class="Negrita" style="width: 247px; height: 21px" valign="top">
                Recomendaciones</td>
              <td class="Negrita" style="width: 10px; height: 21px" valign="top">
                :</td>
              <td style="height: 21px" valign="top">
                <asp:Label ID="recomendacionesLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("recomendaciones")) %>'></asp:Label></td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsInformacionComplementaria" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoReclamoTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divSubtitulosAdicionales" runat="server">
      <cc1:Repeater ID="repeaterSubtitulosAdicionales" runat="server" DataSourceID="odsSeccionesAdicionales">
        <ItemTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="ReportCell">
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(Eval("ContenidoSeccion")) %>'>
              <td class="Negrita" style="width: 247px;" valign="top">
                <asp:Label ID="SubtituloSeccionLabel" runat="server" Text='<%# Eval("TituloSeccion") %>'></asp:Label></td>
              <td class="Negrita" style="width: 10px;" valign="top">
                :</td>
              <td style="" valign="top">
                <asp:Label ID="ContenidoSeccionLabel" runat="server" Text='<%# Eval("ContenidoSeccion") %>'></asp:Label></td>
            </tr>
          </table>
        </ItemTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsSeccionesAdicionales" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.SeccionesAdicionalesAjusteTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divTitulosAdionales" runat="server">
      <cc1:Repeater ID="repeaterTitulos" runat="server" DataSourceID="odsTitulosAdicionales">
        <ItemTemplate>
          <h2>
            <asp:Literal ID="SubtituloSeccionLabel" runat="server" Text='<%# Eval("tituloPadre") %>'></asp:Literal>
          </h2>
          <asp:Literal ID="ContenidoSeccionLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("contenidoPadre")) %>'></asp:Literal></td>
        </ItemTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsTitulosAdicionales" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.SeccionesTotalTableAdapter"
        OnSelected="odsTitulosAdicionales_Selected">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Decimal" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divLiquidacion" runat="server">
      <h2>
        DE LA LIQUIDACIÓN</h2>
      <asp:FormView ID="FormView4" runat="server" DataKeyNames="ajusteId" DataSourceID="odsLiquidacion">
        <ItemTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="ReportCell">
            <tr>
              <td style="width: 247px;" valign="top" class="Negrita">
                Total Pérdida</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                :</td>
              <td style="width: 40px" valign="top">
                <asp:Label ID="simboloLabel" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label></td>
              <td valign="top" style="text-align: right; width: 200px;">
                <asp:Label ID="totalPerdidaLabel" runat="server" Text='<%# Eval("totalperdida", "{0:#,##0.00}")%>'></asp:Label>
              </td>
              <td style="text-align: right; width: 420px;" valign="top">
              </td>
            </tr>
            <tr>
              <td style="width: 247px;" valign="top" class="Negrita">
                Deducible</td>
              <td style="width: 10px;" valign="top" class="Negrita">
                <span class="Negrita" style="width: 10px;">:</span></td>
              <td style="width: 40px" valign="top">
                <asp:Label ID="simboloDeducibleLabel" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label></td>
              <td valign="top" style="border-bottom: black 1px solid; text-align: right; width: 200px;">
                <asp:Label ID="totalDeducibleLabel" runat="server" Text='<%# Eval("totaldeducible", "{0:#,##0.00}") %>'></asp:Label></td>
              <td valign="top" style="width: 420px">
              </td>
            </tr>
            <tr>
              <td valign="top" class="Negrita">
                Total Indemnización</td>
              <td valign="top" class="Negrita">
                <span class="Negrita" style="width: 10px;">:</span></td>
              <td class="Negrita" style="width: 40px" valign="top">
                <asp:Label ID="simboloIndemnizacionLabel" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label></td>
              <td valign="top" class="Negrita" style="border-bottom: black 6px double; text-align: right;
                width: 200px;">
                <asp:Label ID="totalIndemnizacionLabel" runat="server" Text='<%# Eval("totalIndemnizacion", "{0:#,##0.00}") %>'></asp:Label></td>
              <td class="Negrita" valign="top" style="width: 420px;">
              </td>
            </tr>
            <tr>
              <td class="Negrita" valign="top" style="height: 6px">
              </td>
              <td class="Negrita" valign="top" style="height: 6px">
              </td>
              <td class="Negrita" valign="top" style="height: 6px">
              </td>
              <td class="Negrita" valign="top" style="height: 6px">
              </td>
              <td class="Negrita" style="width: 420px; height: 6px;" valign="top">
              </td>
            </tr>
            <tr>
              <td valign="top" colspan="5">
                <span class="Negrita">Son</span> <span class="Negrita" style="width: 10px;">:</span>
                <span style="text-transform: uppercase;">
                  <%# GetNumeroEnTexto(Eval("totalIndemnizacion"), Eval("monedaId")) %>
                </span>
              </td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsLiquidacion" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsAjusteTableAdapters.ConvenioAjusteTableAdapter"
        UpdateMethod="Update" OnSelected="odsLiquidacion_Selected">
        <UpdateParameters>
          <asp:Parameter Name="ajusteId" Type="Decimal" />
          <asp:Parameter Name="totalDeducible" Type="Decimal" />
          <asp:Parameter Name="totalIndemnizacion" Type="Decimal" />
          <asp:Parameter Name="totalPerdida" Type="Decimal" />
          <asp:Parameter Name="montoIndemnizacion" Type="String" />
          <asp:Parameter Name="representante" Type="String" />
          <asp:Parameter Name="usuario" Type="String" />
          <asp:Parameter Name="monedaId" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
        </SelectParameters>
        <InsertParameters>
          <asp:Parameter Name="ajusteId" Type="Decimal" />
          <asp:Parameter Name="totalDeducible" Type="Decimal" />
          <asp:Parameter Name="totalIndemnizacion" Type="Decimal" />
          <asp:Parameter Name="totalPerdida" Type="Decimal" />
          <asp:Parameter Name="montoIndemnizacion" Type="String" />
          <asp:Parameter Name="representante" Type="String" />
          <asp:Parameter Name="usuario" Type="String" />
          <asp:Parameter Name="monedaId" Type="Decimal" />
        </InsertParameters>
      </asp:ObjectDataSource>
    </div>
    <div id="divDocumentacionSolicitada" runat="server">
      <h2>
        DOCUMENTACIÓN SOLICITADA</h2>
      <cc1:Repeater ID="repeaterDocumentosSolicitados" runat="server" DataSourceID="odsDocumentosSolicitados">
        <ItemTemplate>
          <ul>
            <li>
              <asp:Label ID="documentoLabel" runat="server" Text='<%# R3M.Common.Util.ReplaceASBR(Eval("nombre")) %>'></asp:Label></li>
          </ul>
        </ItemTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsDocumentosSolicitados" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoDocumentacionSolicitadaTableAdapter"
        OnSelected="odsDocumentosSolicitados_Selected">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
    <br />
    <br />
    <h3>
      Preventores Asociados</h3>
    <p>
      Ajustadores y Peritos de Seguros S.A.A.</p>
    <p>
      &nbsp;</p>
    <p>
      &nbsp;</p>
    <p>
      <span class="Negrita" style="font-size: 27px;">Ing. Rafael Romero</span><br />
      Gerente de Riesgos Generales<br />
      A.P.J: 012 / A.P.N: 044</p>
    <div id="divImagenes" runat="server">
      <h2 style="page-break-before: always">
        IMAGENES DEL SINIESTRO</h2>
      <cc1:Repeater ID="Repeater2" runat="server" DataSourceID="odsImagenes" OnDataBinding="Repeater2_DataBinding"
        OnItemDataBound="Repeater2_ItemDataBound">
        <HeaderTemplate>
          <table>
            <tr>
        </HeaderTemplate>
        <ItemTemplate>
          <td valign="top" style="width: 460px; text-align: right;">
            <div class="ImgHolder">
              <img alt="" src='<%# R3M.Common.Util.ResolveURL("vGetImageGrande.aspx?AjusteId="+ Request.QueryString["ajusteId"] + "&ArchivoId=" + Eval("archivoId").ToString() + "&imagen=grande")  %>' />
            </div>
            <div class="txtInfo">
              <%# Eval("descripcion") %>
            </div>
          </td>
          <asp:Literal ID="separator" runat="server" Visible="false">
            </tr><tr>
          </asp:Literal>
          <asp:Literal ID="TableEnd" runat="server" Visible="false">
          </tr>
          </table>
            <div style="page-break-before: always; clear: both">
            </div>
            <table>
            <tr>
          </asp:Literal>
        </ItemTemplate>
        <FooterTemplate>
          </tr></table>
        </FooterTemplate>
      </cc1:Repeater>
      <asp:ObjectDataSource ID="odsImagenes" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoImagenesTableAdapter"
        OnSelected="odsImagenes_Selected">
        <SelectParameters>
          <asp:QueryStringParameter Name="ajusteid" QueryStringField="AjusteId" Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
  </form>
</body>
</html>
