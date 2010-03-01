<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vConvenioAjuste.aspx.cs"
   Inherits="vConvenioAjuste" %>

<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
  <title>Riesgos Generales | Convenio de Ajuste</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script language="javascript" type="text/javascript" src="Scripts/calendar/datetimepicker.js"></script>

  <script type="text/javascript" src="Scripts/functions.js" language="javascript"></script>

  <script type="text/javascript" src="Scripts/lib/x_core.js" language="javascript"></script>

  <script type="text/javascript" src="Scripts/lib/x_dom.js" language="javascript"></script>

  <script type="text/javascript" src="Scripts/lib/x_event.js" language="javascript"></script>

  <script type="text/javascript" src="Scripts/lib/xCaseOperations.js" language="javascript"></script>

  <script type="text/javascript" language="javascript">

	window.onload = OnLoad;
  	
	function OnLoad() {			
			xAddEventListener($('convenioAjusteFormView_txtTotalIndemnizacion'),'blur',updateValueOfIndemnization,false);
			xAddEventListener($('convenioAjusteFormView_txtTotalPerdida'),'blur',updateValueOfIndemnization,false);
			xAddEventListener($('convenioAjusteFormView_txtDeducible'),'blur',updateValueOfIndemnization,false);			
	}
		

    
    function VerConvenio()
    {
      ShowReport('vViewPdf.aspx?AjusteId=<%=qStringAjusteId%>&TI=CA');
    }
    
    function closepnlConfirmacion() {
            $('pnlConfirmacion').style.display = 'none';
    }
    
  
    function updateValueOfIndemnization() {
        try 
        {            
            var result = $('convenioAjusteFormView_txtTotalPerdida').value - $('convenioAjusteFormView_txtDeducible').value;            
            $('convenioAjusteFormView_txtTotalIndemnizacion').value = result;
            $('convenioAjusteFormView_txtTotalIndemnizacion').value = ($('convenioAjusteFormView_txtTotalIndemnizacion').value == 'NaN')?'Ingrese aquí solo números':formatNumber(result,2,'','.','','','-','');
        }
        catch(e) {
            alert(e.message);
        }
        
    }
    
    /*this is function is called when the AjaxCall has finished*/
    function ReApplyJavascripts() 
    {
       OnLoad();
       OnLoadFunctionCaseOperations(); /* this is the call to the function that enables the xCaseOperations */
   }


   function tryDateFirst(sender, args) {

       args.IsValid = args.Value != '';
   }
  
     
  </script>

</head>
<body style="background-image: none; background-color: #4C96C9;">
  <form id="form1" runat="server">
  <div style="background-color: #3785B9; padding: 10px;">
    <ajax:AjaxPanel ID="AjaxPanel1" runat="server" OnAjaxCallEnd="AjaxPanel1_AjaxCallEnd">
      <asp:FormView ID="convenioAjusteFormView" runat="server" DataKeyNames="ajusteId"
        DataSourceID="odsConvenioAjuste" DefaultMode="Edit" OnItemUpdating="convenioAjusteFormView_ItemUpdating"
        OnItemUpdated="convenioAjusteFormView_ItemUpdated">
        <EditItemTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="DataTable" width="700">
            <tr>
              <td height="19" width="23">
                &nbsp;
              </td>
              <td width="157" height="19" style="width: 149px">
                &nbsp;
              </td>
              <td height="19" style="width: 51px">
                &nbsp;
              </td>
              <td height="19" width="192">
                &nbsp;
              </td>
              <td height="19" width="233">
                &nbsp;
              </td>
              <td height="19" width="33">
                &nbsp;
              </td>
            </tr>
            <tr>
              <td width="23" style="height: 20px">
              </td>
              <td style="height: 20px; width: 149px;">
                Representante<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                  ControlToValidate="txtRepresentante" ErrorMessage="Ingrese el nombre del Representante"
                  ValidationGroup="actualizar">(*)</asp:RequiredFieldValidator>
              </td>
              <td colspan="3" style="height: 20px">
                <asp:TextBox ID="txtRepresentante" runat="server" CssClass="FormText CAMELCASE" Width="462px"
                  Text='<%# Bind("representante") %>'></asp:TextBox>
              </td>
              <td width="33" style="height: 20px">
              </td>
            </tr>
            <tr>
              <td style="height: 20px" width="23">
              </td>
              <td style="height: 20px; width: 149px;">
                Total Perdida
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTotalPerdida"
                  ErrorMessage="Ingrese el Total de Pérdida" ValidationGroup="actualizar">(*)</asp:RequiredFieldValidator>
              </td>
              <td style="height: 20px; width: 51px;">
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label>
              </td>
              <td style="height: 20px" width="192">
                <asp:TextBox ID="txtTotalPerdida" runat="server" CssClass="FormText NUMBERS" Width="182px"
                  Text='<%# Bind("totalPerdida") %>'></asp:TextBox>
              </td>
              <td style="height: 20px" width="233">
              </td>
              <td style="height: 20px" width="33">
              </td>
            </tr>
            <tr>
              <td style="height: 20px" width="23">
                &nbsp;
              </td>
              <td style="height: 20px; width: 149px;">
                Deducible
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDeducible"
                  ErrorMessage="Ingrese el Deducible" ValidationGroup="actualizar">(*)</asp:RequiredFieldValidator>
              </td>
              <td style="height: 20px; width: 51px;">
                <asp:Label ID="Label1" runat="server" Text='<%# muestraSimbolo(Eval("simbolo")) %>'></asp:Label>
              </td>
              <td style="height: 20px" width="192">
                <asp:TextBox ID="txtDeducible" runat="server" CssClass="FormText NUMBERS" Width="182px"
                  Text='<%# Bind("totalDeducible") %>'></asp:TextBox>
              </td>
              <td style="height: 20px">
              </td>
              <td style="height: 20px" width="33">
                &nbsp;
              </td>
            </tr>
            <tr>
              <td style="height: 20px" width="23">
                &nbsp;
              </td>
              <td style="height: 20px; width: 149px;">
                Cifra a Indemnizar
              </td>
              <td style="color: #541c01; height: 20px; width: 51px;">
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("simbolo") %>'></asp:Label>
              </td>
              <td style="height: 20px" width="192">
                <asp:TextBox ID="txtTotalIndemnizacion" runat="server" CssClass="FormText NUMBERS"
                  Width="182px" Text='<%# Bind("totalIndemnizacion") %>'></asp:TextBox>
              </td>
              <td style="height: 20px">
              </td>
              <td style="height: 20px" width="33">
                &nbsp;
              </td>
            </tr>
            <tr>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="width: 149px; height: 20px;">
                &nbsp;
              </td>
              <td style="height: 20px; width: 51px;">
                &nbsp;
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
            </tr>
            <tr>
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="width: 149px; height: 20px;">
                Fecha Recepcion Convenio Firmado
              </td>
              <td style="height: 20px; width: 51px;">
                &nbsp;
              </td>
              <td style="height: 20px">
                <cc1:WebCalendar ID="txtFechaRecepcionConvenioFirmado" runat="server" BtnCalendarImage="img/cal.gif"
                  CssClass="FormText" GenerateBtn="false" TabIndex="60" Text='<%# Bind("fRecepcionConvenioFirmado") %>'
                  WcResourcesDir="./scripts/wcc_includes"></cc1:WebCalendar>
              </td>
              <td style="height: 20px">
                <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="tryDateFirst"
                  ControlToValidate="txtFechaRecepcionConvenioFirmado" ErrorMessage="Debe  Ingresar la fecha"
                  OnServerValidate="CustomValidator2_ServerValidate" ValidateEmptyText="True">(*)</asp:CustomValidator>
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
            </tr>
            <tr>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="width: 149px; height: 20px;">
                &nbsp;
              </td>
              <td style="height: 20px; width: 51px;">
                &nbsp;
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
            </tr>
            <tr>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="width: 149px; height: 20px;">
                &nbsp;<asp:Button ID="btnRegistrar" runat="server" CssClass="FormButton" Text="Actualizar"
                  CommandName="Update" ValidationGroup="actualizar" />
              </td>
              <td style="width: 51px; height: 20px;">
              </td>
              <td style="height: 20px">
                &nbsp;
                <input id="verPdfButton" class="FormButton" type="button" value="Ver PDF" onclick="VerConvenio();" />
                <asp:Button ID="Button1" runat="server" CssClass="FormButton" Text="Notificar" CommandName="Update"
                  ValidationGroup="actualizar" OnClick="Button1_Click" />
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
              <td style="height: 20px">
                &nbsp;
              </td>
            </tr>
            <tr>
              <td height="20">
              </td>
              <td height="20" style="width: 149px">
              </td>
              <td height="20" style="width: 51px">
                &nbsp;
              </td>
              <td height="20">
              </td>
              <td height="20">
              </td>
              <td height="20">
              </td>
            </tr>
          </table>
        </EditItemTemplate>
      </asp:FormView>
      <div>
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td style="height: 20px">
            </td>
            <td style="width: 149px; height: 20px;">
              <asp:CheckBox ID="chkRechazo" runat="server" Text="Rechazar Ajuste" AutoPostBack="True" />
            </td>
            <td style="width: 51px; height: 20px;">
              &nbsp;
            </td>
            <td style="height: 20px">
            </td>
            <td style="height: 20px">
            </td>
            <td style="height: 20px">
            </td>
          </tr>
        </table>
      </div>
      <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" />
      <asp:Panel ID="pnlConfirmacion" runat="server" BackColor="#FF8000" BorderColor="Red"
        Height="36px" Style="z-index: 450; left: 226px; position: absolute; top: 128px;
        text-align: center" Visible="False" Width="296px">
        <div style="padding-top: 5px">
          <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="10px" ForeColor="White"
            Text="El Caso de Ajuste ha sido Actualizado" Width="258px"></asp:Label>&nbsp;</div>
        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/btnClose.jpg" onclick="closepnlConfirmacion();"
          Style="left: 277px; cursor: pointer; position: absolute; top: 2px" />
      </asp:Panel>
    </ajax:AjaxPanel>
  </div>
  <asp:ObjectDataSource ID="odsConvenioAjuste" runat="server" SelectMethod="GetData"
    TypeName="dsAjusteTableAdapters.ConvenioAjusteTableAdapter" InsertMethod="Insert"
    UpdateMethod="Update" OldValuesParameterFormatString="{0}">
    <InsertParameters>
      <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
      <asp:ControlParameter ControlID="txtDeducible" Name="totalDeducible" PropertyName="Text"
        Type="Decimal" />
      <asp:ControlParameter ControlID="txtTotalIndemnizacion" Name="totalIndemnizacion"
        PropertyName="Text" Type="Decimal" />
      <asp:ControlParameter ControlID="txtTotalPerdida" Name="totalPerdida" PropertyName="Text"
        Type="Decimal" />
      <asp:ControlParameter ControlID="txtMontoString" Name="montoIndemnizacion" PropertyName="Text"
        Type="String" />
      <asp:ControlParameter ControlID="txtRepresentante" Name="representante" PropertyName="Text"
        Type="String" />
      <asp:Parameter Name="usuario" Type="String" />
      <asp:ControlParameter ControlID="txtFechaRecepcionConvenioFirmado" Name="fRecepcionConvenioFirmado"
        PropertyName="SelectedValue" Type="DateTime" />
    </InsertParameters>
    <UpdateParameters>
      <asp:Parameter Name="ajusteId" Type="Decimal" />
      <asp:Parameter Name="totalDeducible" Type="Decimal" Size="18" />
      <asp:Parameter Name="totalIndemnizacion" Type="Decimal" Size="18" />
      <asp:Parameter Name="totalPerdida" Type="Decimal" Size="18" />
      <asp:Parameter Name="montoIndemnizacion" Type="String"/>
      <asp:Parameter Name="representante" Type="String" />
      <asp:SessionParameter Name="usuario" SessionField="NombreUsuario" Type="String" />
      <asp:Parameter Name="frecepcionConvenioFirmado" Type="DateTime" />
    </UpdateParameters>
    <SelectParameters>
      <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
    </SelectParameters>
  </asp:ObjectDataSource>
  <asp:ObjectDataSource ID="odsMoneda" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsComboTableAdapters.MonedaComboTableAdapter">
  </asp:ObjectDataSource>
  </form>
</body>
</html>
