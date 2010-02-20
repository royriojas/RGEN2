<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InformePacificoBasico.aspx.cs"
  Inherits="InformesPlantillas_InformePacificoBasico" %>

<%@ Register Assembly="CustomControls" Namespace="CustomControls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Informe Básico</title>
  <link href="inf.css?nc=<%= DateTime.Now.ToString() %>" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div id="divDatosGenerales" runat="server">
      <asp:FormView ID="frmDatosGenerales" runat="server" DataSourceID="odsDatosGenerales">
        <ItemTemplate>
          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td colspan="3" valign="top" class="Negrita">
                <h2>
                  SEÑORES PACÍFICO SEGUROS</h2>
              </td>
            </tr>
            <tr>
              <td style="width: 210px;" valign="top" class="Negrita">
                ATENCIÓN</td>
              <td width="10" valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <asp:Label ID="responsableaseguradoraLabel" runat="server" Text='<%# Bind("responsableaseguradora") %>'></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 210px;" valign="top" class="Negrita">
                CONTRATANTE</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <asp:Label ID="contratanteLabel" runat="server" Text='<%# Bind("contratante") %>'></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 210px;" valign="top" class="Negrita">
                ASEGURADO</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <asp:Label ID="aseguradoLabel" runat="server" Text='<%# Bind("asegurado") %>'></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 210px;" valign="top" class="Negrita">
                GIRO DEL NEGOCIO</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <asp:Label ID="gironegocioLabel" runat="server" Text='<%# Bind("gironegocio") %>'></asp:Label></td>
            </tr>
          </table>
          <asp:HiddenField ID="hdfEjectivoBroker" runat="server" Value='<%# Eval("responsablebroker") %>' />
          <asp:HiddenField ID="hdfBroker" runat="server" Value='<%# Eval("broker") %>' />
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsDatosGenerales" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoGeneralesTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
      <br />
    </div>
    <div id="divDatosPoliza" runat="server">
      <asp:FormView ID="frmPoliza" runat="server" DataSourceID="odsDatosPóliza" OnDataBound="frmPoliza_DataBound">
        <ItemTemplate>
          <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td style="width: 210px;" valign="top" class="Negrita">
                PÓLIZA Nº</td>
              <td width="10" valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <asp:Label ID="polizaNumeroLabel" runat="server" Text='<%# Eval("numero") %>'></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 210px;" valign="top" class="Negrita">
                VIGENCIA</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <asp:Label ID="vigenciaLabel" runat="server" Text='<%# Eval("vigencia") %>'></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 210px;" valign="top" class="Negrita">
                COBERTURA AFECTADA</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <asp:Label ID="coberturaLabel" runat="server" Text='<%# Eval("cobertura") %>'></asp:Label></td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("SUMA_ASEGURADA",this.AjusteId)) %>'>
              <td style="width: 210px;" valign="top" class="Negrita">
                SUMA ASEGURADA</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <%# GestorInforme.getSubtitle("SUMA_ASEGURADA",this.AjusteId) %>
              </td>
            </tr>
            <tr style='<%# CCSOL.Utiles.Utilidades.IsNull(GestorInforme.getSubtitle("BIEN_AFECTADO",this.AjusteId)) %>'>
              <td style="width: 210px;" valign="top" class="Negrita">
                SUBLIMITE ASEG.</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <%#GestorInforme.getSubtitle("BIEN_AFECTADO",AjusteId) %>
              </td>
            </tr>
            <tr id="trDeducibles" runat="server">
              <td style="width: 210px;" valign="top" class="Negrita">
                DEDUCIBLES</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <cc1:Repeater ID="repeaterDeducibles" runat="server" DataSourceID="odsDeducibles">
                  <ItemTemplate>
                    <ul>
                      <li>
                        <asp:Label ID="deducibleLabel" runat="server" Text='<%#Eval("condiciones")%>'></asp:Label></li>
                    </ul>
                  </ItemTemplate>
                </cc1:Repeater>
                <asp:ObjectDataSource ID="odsDeducibles" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoDeduciblesTableAdapter"
                  OnSelected="odsDeducibles_Selected">
                  <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
                      Type="Int32" />
                  </SelectParameters>
                </asp:ObjectDataSource>
              </td>
            </tr>
            <tr id='trClausulas' runat="server">
              <td style="width: 210px;" valign="top" class="Negrita">
                CLÁUSULAS APLICABLES</td>
              <td valign="top" class="Negrita" style="width: 10px;">
                :</td>
              <td valign="top">
                <cc1:Repeater ID="repeaterClausulas" runat="server" DataSourceID="odsClausulas">
                  <ItemTemplate>
                    <ul>
                      <li>
                        <asp:Label ID="clausulaLabel" runat="server" Text='<%#Eval("nombre")%>'></asp:Label></li>
                    </ul>
                  </ItemTemplate>
                </cc1:Repeater>
                <asp:ObjectDataSource ID="odsClausulas" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoClausulasTableAdapter"
                  OnSelected="odsClausulas_Selected">
                  <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
                      Type="Int32" />
                  </SelectParameters>
                </asp:ObjectDataSource>
              </td>
            </tr>
            <tr>
              <td style="width: 210px; height: 18px;" valign="top" class="Negrita">
                BROKER</td>
              <td valign="top" class="Negrita" style="width: 10px; height: 18px;">
                :</td>
              <td valign="top" style="height: 18px">
                <asp:Label ID="brokerLabel" runat="server" Text="Broker"></asp:Label></td>
            </tr>
            <tr>
              <td style="width: 210px; height: 18px;" valign="top" class="Negrita">
                BROKER/EJECUTIVO</td>
              <td valign="top" class="Negrita" style="width: 10px; height: 18px;">
                :</td>
              <td valign="top" style="height: 18px">
                <asp:Label ID="ejecutivoBrokerLabel" runat="server" Text="Ejec Broker"></asp:Label></td>
            </tr>
          </table>
        </ItemTemplate>
      </asp:FormView>
      <asp:ObjectDataSource ID="odsDatosPóliza" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoPolizaTableAdapter">
        <SelectParameters>
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
      <br />
    </div>
    <asp:FormView ID="frmDatosAjuste" runat="server" DataSourceID="odsDatosAjuste">
      <ItemTemplate>
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              PACÍFICO REF. Nº</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="numeroSiniestroCiaLabel" runat="server" Text='<%# Bind("numeroSiniestroCia") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              FECHA/LUGAR DE OCURRENCIA</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="fsiniestroLabel" runat="server" Text='<%# Bind("fsiniestro") %>'></asp:Label><br />
              <asp:Label ID="lugarSiniestroLabel" runat="server" Text='<%# Bind("lugarSiniestro") %>'></asp:Label><br />
              <asp:Label ID="distritoSiniestroLabel" runat="server" Text='<%# Bind("distritoSiniestro") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              FECHA/HORA DE INSPECCIÓN</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="fechaReunion" runat="server" Text='<%# Bind("FechaHoraReunion") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              LUGAR DE INSPECCIÓN</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="lugarDeReunionLabel" runat="server" Text='<%# Bind("lugarDeReunion") %>'></asp:Label><br />
              <asp:Label ID="distritoReunionLabel" runat="server" Text='<%# Bind("distritoReunion") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              PERSONA ENTREVISTADA</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="personaEntrevistadaLabel" runat="server" Text='<%# Bind("PersonaEntrevistada") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              CIRCUNSTANCIAS</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="detalleocurrenciaLabel" runat="server" Text='<%# Bind("detalleocurrencia") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              &nbsp;</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              &nbsp;</td>
            <td valign="top">
            </td>
          </tr>
        </table>
        <div id="divBienes" runat="server">
          <h3>
            BIEN AFECTADO</h3>
          <cc1:Repeater ID="repeaterSublimites" runat="server" DataSourceID="odsPolizaDetalle"
            OnItemCreated="repeaterSublimites_ItemCreated1" OnItemDataBound="repeaterSublimites_ItemDataBound">
            <EmptyDataTemplate>
            </EmptyDataTemplate>
            <HeaderTemplate>
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="GridView">
                <tr class="header">
                  <th width="4%">
                    ÍTEM</th>
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
                  <asp:Label ID="detalleLabel" runat="server" Text='<%#Eval("detalle")%>'></asp:Label></td>
                <td valign="top">
                  <asp:Label ID="localLabel" runat="server" Text='<%#Eval("localItem")%>'></asp:Label></td>
                <td valign="top">
                  <div align="right" style="text-align: right;">
                    <asp:Label ID="simboloLabel" runat="server" Text='<%#Eval("simbolo")%>'></asp:Label>
                    <asp:Label ID="montoLabel" runat="server" Text='<%#Eval("monto", "{0:#,###.00}")%>'></asp:Label>
                  </div>
                </td>
                <td valign="top">
                  <div div align="right" style="text-align: right;">
                    <asp:Label ID="simbolo2Label" runat="server" Text='<%#Eval("simbolo")%>'></asp:Label>
                    <asp:Label ID="montoAsegurado2" runat="server" Text='<%#Eval("montoAsegurado2", "{0:#,###.00}")%>'></asp:Label>
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
              <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="ajusteId"
                Type="Int32" />
            </SelectParameters>
          </asp:ObjectDataSource>
        </div>
        <div id="divDanos" runat="server">
          <h3>
            DAÑOS Y/O PÉRDIDAS</h3>
          <cc1:Repeater ID="Repeater1" runat="server" DataSourceID="odsOcurrenciaDetalle" OnItemDataBound="Repeater1_ItemDataBound">
            <HeaderTemplate>
              <table class="GridView" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr class="header">
                  <th width="4%">
                    ÍTEM</th>
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
                    <asp:Label ID="Label7" runat="server" Text='<%# this.Num++ %>'></asp:Label>
                  </div>
                </td>
                <td valign="top">
                  <asp:Label ID="bienesLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("Bienes"))%>'></asp:Label></td>
                <td valign="top">
                  <asp:Label ID="descripcionLabel" runat="server" Text='<%#R3M.Common.Util.ReplaceASBR(Eval("descripcion"))%>'></asp:Label></td>
                <td valign="top">
                  <asp:Label ID="Label9" runat="server" Text='<%#(Eval("LocalDelBien"))%>'></asp:Label></td>
                <td valign="top">
                  <div align="right" style="text-align: right;">
                    <asp:Label ID="Label10" runat="server" Text='<%#Eval("estimacion", "{0:#,###.00}")%>'></asp:Label>
                  </div>
                </td>
              </tr>
            </ItemTemplate>
            <FooterTemplate>
              <tr>
                <td colspan="4" valign="top">
                  <div class="Negrita" align="right">
                    TOTAL PERDIDAS ESTIMADAS US$
                  </div>
                </td>
                <td valign="top">
                  <div align="right" style="text-align: right;">
                    <%#  this.SumaDetalleOcurrencia.ToString("#,###.00")%>
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
              <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
                Type="Int32" />
            </SelectParameters>
          </asp:ObjectDataSource>
        </div>
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              RECLAMO</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="monedareclamoLabel" runat="server" Text='<%# Bind("monedaReclamo") %>'></asp:Label>
              <asp:Label ID="reclamoLabel" runat="server" Text='<%# Bind("reclamo") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              RESERVA</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="monedareservaLabel" runat="server" Text='<%# Bind("monedaReserva") %>'></asp:Label>
              <asp:Label ID="reservaLabel" runat="server" Text='<%# Bind("reserva") %>'></asp:Label></td>
          </tr>
          <tr>
            <td style="width: 207px;" valign="top" class="Negrita">
              SITUACIÓN ACTUAL</td>
            <td valign="top" class="Negrita" style="width: 6px;">
              :</td>
            <td valign="top">
              <asp:Label ID="situacionAjusteLabel" runat="server" Text='<%# Bind("situacionAjuste") %>'></asp:Label></td>
          </tr>
        </table>
      </ItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="odsDatosAjuste" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsReportePacificoTableAdapters.InformeBasicoPacificoDatosAjusteTableAdapter">
      <SelectParameters>
        <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
          Type="Int32" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <br />
    <br />
    <div id="divDocumentacionSolicitadoa" runat="server">
      <table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td style="width: 210px;" valign="top" class="Negrita">
            DETALLE DE INFORMACIÓN REQUERIDA</td>
          <td valign="top" class="Negrita" style="width: 10px;">
            :</td>
          <td valign="top">
            <cc1:Repeater ID="repeaterDocumentosSolicitados" runat="server" DataSourceID="odsDocumentosSolicitados">
              <ItemTemplate>
                <ul>
                  <li>
                    <asp:Label ID="documentoLabel" runat="server" Text='<%# Bind("nombre") %>'></asp:Label></li>
                </ul>
              </ItemTemplate>
            </cc1:Repeater>
            <asp:ObjectDataSource ID="odsDocumentosSolicitados" runat="server" OldValuesParameterFormatString="original_{0}"
              SelectMethod="GetData" TypeName="dsReporteTableAdapters.InformeBasicoDocumentacionSolicitadaTableAdapter"
              OnSelected="odsDocumentosSolicitados_Selected">
              <SelectParameters>
                <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="ajusteId"
                  Type="Int32" />
              </SelectParameters>
            </asp:ObjectDataSource>
          </td>
        </tr>
      </table>
    </div>
    <h3>
      Preventores Asociados</h3>
    <p>
      Ajustadores y Peritos de Seguros S.A.A.</p>
    <h3>
      &nbsp;</h3>
    <h3>
      &nbsp;</h3>
    <h3>
      Ing. Rafael Romero</h3>
    <p>
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
          <asp:QueryStringParameter DefaultValue="240" Name="ajusteid" QueryStringField="AjusteId"
            Type="Int32" />
        </SelectParameters>
      </asp:ObjectDataSource>
    </div>
  </form>
</body>
</html>
