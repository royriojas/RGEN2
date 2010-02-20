<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vViewPdf.aspx.cs" Inherits="vViewPdf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
  <title>Riesgos Generales / Visualización de PDF</title>
  <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
  <meta name="CODE_LANGUAGE" content="C#">
  <meta name="vs_defaultClientScript" content="JavaScript">
  <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
  <link href="css/layout.css" type="text/css" rel="stylesheet">
</head>
<body>
  <form id="Form1" method="post" runat="server">
    <table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
      <tr>
        <td height="6">
          <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
          </div>
          <strong><span style="font-size: 14pt">INFORME BASICO</span></strong></td>
      </tr>
      <tr>
        <td align="center">
          <div class="DataContent" style="height: 100%">
            <div class="DataContentRight" style="vertical-align: middle; height: 100%; text-align: center">
              El archivo no se encuentra disponible</div>
          </div>
        </td>
      </tr>
      <tr>
        <td height="6">
          <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
          </div>
          <asp:ObjectDataSource ID="odsInformeBasico" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsReporteTableAdapters.TieneInformeBasicoTableAdapter">
            <SelectParameters>
              <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
            </SelectParameters>
          </asp:ObjectDataSource>
          &nbsp; &nbsp;
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
