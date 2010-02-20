<%@ Page Language="C#" MasterPageFile="~/RGenMasterPage.master" AutoEventWireup="true"
  CodeFile="vNuevoCaso.aspx.cs" Inherits="vNuevoCaso" Title="Nuevo Caso (Requisitos Mínimos)" %>

<%@ Register Assembly="WebCalendarControl" Namespace="WebCalendarControl" TagPrefix="cc1" %>
<%@ Register TagPrefix="Custom" Namespace="ASB" Assembly="AutoSuggestBox" %>
<%@ Register Src="ucLoadCss.ascx" TagName="ucLoadCss" TagPrefix="uc2" %>
<%@ Register Src="linksAjustadorAdministrador.ascx" TagName="linksAjustadorAdministrador"
  TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <!--<link rel="stylesheet" type="text/css" href="" /-->
  <!--link rel="stylesheet" type="text/css" href="" /*-->

  <script type="text/javascript" src="Scripts/popUpWin/common.js"></script>

  <script type="text/javascript" src="Scripts/popUpWin/subModal.js"></script>

  <script type="text/javascript">
  function asbAsegurado_CustomValidate(sender, args) {
    //var asbAsegurado = asbGetObj('ctl00_ContentPlaceHolder1_FormView1_asbAsegurado');
    args.IsValid = $('ctl00_ContentPlaceHolder1_FormView1_asbAsegurado_SelectedValue').value != "";
  }
  
  function doShowPopWin(e) {
    showPopWin('vNuevoAseguradoRapido.aspx',680,240);
    xPreventDefault(e);
  }
  
  window.onload = function () {
    xAddEventListener($('ctl00_ContentPlaceHolder1_FormView1_btnSearchAsegurado'),'click',doShowPopWin,false);
  }
  
  function SetAseguradoValues(aseguradoId,asegurado) {
    try {
      $('ctl00_ContentPlaceHolder1_FormView1_asbAsegurado').value = asegurado;
      $('ctl00_ContentPlaceHolder1_FormView1_asbAsegurado_SelectedValue').value = aseguradoId;
      hidePopWin(true);
      //ValidatorValidate($('ctl00_ContentPlaceHolder1_FormView1_CustomValidator1'));
    }
    catch(e) {
      alert(e.message);
    }
  }
  
  function tryDateFirst(sender,args){
    
    args.IsValid = args.Value != '';
  }
  
  </script>

  <div>
    <uc1:linksAjustadorAdministrador ID="LinksAjustadorAdministrador1" runat="server" />
    <div class="dt">
      <div class="dtl">
      </div>
      <div class="dtr">
      </div>
    </div>
    <div class="dc">
      <div class="dcr">
        <h2>
          Nuevo Caso de Ajuste (Requisitos Mínimos)
        </h2>
        <div class="hr">
        </div>
        <div class="tableForm">
          <asp:FormView ID="FormView1" runat="server" DataKeyNames="ajusteId" DataSourceID="odsAjusteNew"
            DefaultMode="Insert" OnItemInserting="FormView1_ItemInserting" OnItemInserted="FormView1_ItemInserted">
            <InsertItemTemplate>
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                  <td style="width: 150px">
                    Asegurado</td>
                  <td style="width: 317px">
                    <Custom:AutoSuggestBox TabIndex="10" ID="asbAsegurado" runat="server" CssClass="FormText"
                      IncludeMoreMenuItem="True" MaxSuggestChars="15" NumMenuItems="15" ResourcesDir="./asb_includes"
                      Width="300px" DataType="Asegurado" WarnNoValueSelected="false" Text='<%#Bind("Asegurado") %>'
                      SelectedValue='<%# Bind("AseguradoId") %>'></Custom:AutoSuggestBox>
                  </td>
                  <td style="width: 73px">
                    <asp:Button TabIndex="20" ID="btnSearchAsegurado" runat="server" Text="..." CssClass="FormButton" />
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="asbAsegurado_CustomValidate"
                      ControlToValidate="asbAsegurado" ErrorMessage="Debe elegir un asegurado" ValidationGroup="NuevoCasoMinimo"
                      ValidateEmptyText="True">(*)</asp:CustomValidator></td>
                  <td>
                    &nbsp;</td>
                </tr>
                <tr>
                  <td>
                    Aseguradora</td>
                  <td style="width: 317px">
                    <asp:DropDownList TabIndex="30" ID="DropDownList1" runat="server" DataSourceID="odsCia"
                      DataTextField="persona" DataValueField="personaId" Width="305px" SelectedValue='<%# Bind("AseguradoraId") %>'
                      AppendDataBoundItems="True" CssClass="FormText" OnDataBound="DropDownList1_DataBound">
                      <asp:ListItem Selected="True" Value="-1">[Elija]</asp:ListItem>
                    </asp:DropDownList>
                  </td>
                  <td style="width: 73px">
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Debe elegir un asegurado"
                      ControlToValidate="DropDownList1" ValidationGroup="NuevoCasoMinimo" ValueToCompare="-1"
                      Operator="NotEqual">(*)</asp:CompareValidator></td>
                  <td>
                    &nbsp;</td>
                </tr>
              </table>
              <ajax:AjaxPanel ID="AjaxPanel1" runat="server" OnAjaxCallEnd="AjaxPanel1_AjaxCallEnd">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                  <tr style="width: 150px">
                    <td style="width: 150px; height: 17px;">
                      Producto</td>
                    <td style="width: 317px; height: 17px;">
                      <asp:DropDownList TabIndex="40" ID="cbxProducto" runat="server" Width="305px" AutoPostBack="True"
                        AppendDataBoundItems="True" CssClass="FormText" DataSourceID="odsProducto" DataTextField="descripcion"
                        DataValueField="productoid">
                        <asp:ListItem Value="-1">[Elija]</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                    <td style="width: 73px; height: 17px;">
                      <asp:CompareValidator ID="CompareValidator4" runat="server" ErrorMessage="Debe elegir el Producto"
                        ControlToValidate="cbxProducto" ValidationGroup="NuevoCasoMinimo" ValueToCompare="-1"
                        Operator="NotEqual">(*)</asp:CompareValidator></td>
                    <td style="height: 17px; width: 5px;">
                    </td>
                  </tr>
                  <tr style="width: 150px">
                    <td style="width: 150px; height: 18px;">
                      Ramo</td>
                    <td style="width: 317px; height: 18px;">
                      <asp:DropDownList TabIndex="40" ID="cbxRamo" runat="server" DataSourceID="sdsRamos"
                        DataTextField="ramo" DataValueField="ramoId" Width="305px" AutoPostBack="True"
                        CssClass="FormText" OnDataBound="cbxRamo_DataBound">
                        <asp:ListItem Value="-1">[Elija]</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                    <td style="width: 73px; height: 18px;">
                      <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Debe elegir el Ramo"
                        ControlToValidate="cbxRamo" ValidationGroup="NuevoCasoMinimo" ValueToCompare="-1"
                        Operator="NotEqual">(*)</asp:CompareValidator></td>
                    <td style="height: 18px; width: 5px;">
                      &nbsp;</td>
                  </tr>
                  <tr style="width: 150px">
                    <td style="width: 150px; height: 18px;">
                      Cobertura</td>
                    <td style="width: 317px; height: 18px;">
                      <asp:DropDownList TabIndex="40" ID="cbxCobertura" runat="server" DataSourceID="Cobertura"
                        DataTextField="nombre" DataValueField="riesgoId" Width="305px" AutoPostBack="True"
                        CssClass="FormText" OnDataBound="cbxCobertura_DataBound">
                        <asp:ListItem Value="-1">[Elija]</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                    <td style="width: 73px; height: 18px;">
                      <asp:CompareValidator ID="CompareValidator5" runat="server" ErrorMessage="Debe elegir la Cobertura"
                        ControlToValidate="cbxCobertura" ValidationGroup="NuevoCasoMinimo" ValueToCompare="-1"
                        Operator="NotEqual">(*)</asp:CompareValidator></td>
                    <td style="height: 18px; width: 5px;">
                      &nbsp;</td>
                  </tr>
                  <tr>
                    <td style="width: 150px">
                      Tipo de Siniestro</td>
                    <td style="width: 317px">
                      <asp:DropDownList TabIndex="50" ID="DropDownList3" runat="server" DataSourceID="sdsTipoSiniestroByRamo"
                        DataTextField="tipoSiniestro" DataValueField="tipoSiniestroId" Width="305px" CssClass="FormText"
                        OnDataBound="DropDownList3_DataBound">
                        <asp:ListItem Value="-1">[Elija]</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                    <td style="width: 73px">
                      <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="Debe elegir el tipo de siniestro"
                        ControlToValidate="DropDownList3" Operator="NotEqual" ValidationGroup="NuevoCasoMinimo"
                        ValueToCompare="-1">(*)</asp:CompareValidator></td>
                    <td style="display: none; width: 5px;">
                      <asp:DropDownList ID="ddlAjustador" runat="server" DataSourceID="odsAjustador" DataTextField="persona"
                        DataValueField="personaid" OnDataBound="ddlAjustador_DataBound" SelectedValue='<%# Bind("AjustadorId") %>'>
                      </asp:DropDownList><asp:ObjectDataSource ID="odsAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetData" TypeName="dsComboTableAdapters.AjustadorComboTableAdapter">
                      </asp:ObjectDataSource>
                    </td>
                  </tr>
                </table>
              </ajax:AjaxPanel>
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr style="width: 150px">
                  <td style="width: 150px">
                    Fecha</td>
                  <td style="width: 317px">
                    <cc1:WebCalendar TabIndex="60" ID="WebCalendar1" runat="server" BtnCalendarImage="img/cal.gif"
                      Text='<%# Bind("FechaSiniestro") %>' CssClass="FormText" GenerateBtn="false" WcResourcesDir="./scripts/wcc_includes"></cc1:WebCalendar></td>
                  <td style="width: 73px">
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="WebCalendar1"
                      ErrorMessage="Debe  Ingresar la fecha" OnServerValidate="CustomValidator2_ServerValidate"
                      ValidateEmptyText="True" ValidationGroup="NuevoCasoMinimo" ClientValidationFunction="tryDateFirst">(*)</asp:CustomValidator></td>
                  <td>
                    &nbsp;</td>
                </tr>
                <tr>
                  <td style="width: 150px">
                    Lugar de Siniestro</td>
                  <td style="width: 317px">
                    <asp:TextBox TabIndex="70" ID="TextBox1" Text='<%# Bind("lugarsiniestro") %>' runat="server"
                      CssClass="FormText" Width="300px"></asp:TextBox></td>
                  <td style="width: 73px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Debe elegir el lugar de siniestro"
                      ControlToValidate="TextBox1" ValidationGroup="NuevoCasoMinimo">(*)</asp:RequiredFieldValidator></td>
                  <td>
                    &nbsp;</td>
                </tr>
                <tr>
                  <td style="padding-top: 2px; width: 150px;" valign="top">
                    Descripción</td>
                  <td style="width: 317px">
                    <asp:TextBox TabIndex="80" ID="TextBox2" runat="server" Text='<%# Bind("descripcion") %>'
                      CssClass="FormText" Rows="5" TextMode="MultiLine" Width="300px"></asp:TextBox></td>
                  <td valign="top" style="width: 73px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Debe ingresar la descripción"
                      ControlToValidate="TextBox2" ValidationGroup="NuevoCasoMinimo">(*)</asp:RequiredFieldValidator></td>
                  <td>
                    &nbsp;</td>
                </tr>
              </table>
              <asp:SqlDataSource ID="sdsTipoSiniestroByRamo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                SelectCommand="sp_rgnx_selectTipoSiniestroByRamoId" SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
                    Type="Decimal" />
                </SelectParameters>
              </asp:SqlDataSource>
              <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
              <asp:SqlDataSource ID="Cobertura" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                SelectCommand="sp_rgenx_CoberturasByRamoId" SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
                    Type="Decimal" />
                </SelectParameters>
              </asp:SqlDataSource>
              <asp:SqlDataSource ID="sdsRamos" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                SelectCommand="sp_rgenx_RamosSelectByProductoId" SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="cbxProducto" Name="productoId" PropertyName="SelectedValue"
                    Type="Decimal" />
                </SelectParameters>
              </asp:SqlDataSource>
            </InsertItemTemplate>
          </asp:FormView>
          <asp:ObjectDataSource ID="odsAjusteNew" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsAjusteNewTableAdapters.sp_rgen_Ajuste_Total_SelectTableAdapter"
            OnInserted="odsAjusteNew_Inserted">
            <SelectParameters>
              <asp:Parameter Name="ajusteid" Type="Decimal" />
            </SelectParameters>
            <InsertParameters>
              <asp:Parameter Direction="InputOutput" Name="numeroAjuste" Type="String" />
              <asp:Parameter Direction="InputOutput" Name="ajusteId" Type="Object" />
              <asp:Parameter Name="AseguradoId" Type="Decimal" />
              <asp:Parameter Name="Asegurado" Type="String" />
              <asp:Parameter Name="AseguradoraId" Type="Decimal" />
              <asp:Parameter Name="TipoSiniestroId" Type="Decimal" />
              <asp:Parameter Name="FechaSiniestro" Type="DateTime" />
              <asp:Parameter Name="lugarsiniestro" Type="String" />
              <asp:Parameter Name="ucrea" Type="String" />
              <asp:Parameter Name="ramoId" Type="Decimal" />
              <asp:Parameter Name="productoId" Type="Decimal" />
              <asp:Parameter Name="riesgoId" Type="Decimal" />
              <asp:Parameter Name="descripcion" Type="String" />
              <asp:Parameter Name="AjustadorId" Type="Decimal" />
            </InsertParameters>
          </asp:ObjectDataSource>
        </div>
        <div class="hr">
        </div>
        <div class="Ctrls">
          <asp:LinkButton TabIndex="100" ID="LinkButton1" runat="server" OnClick="LinkButton1_Click1"
            ValidationGroup="NuevoCasoMinimo"><img style="border:none;" alt="" src="imgRGen/btnSave.gif" /></asp:LinkButton>
        </div>
        <div runat="server" id="pnlMesage" visible="true">
        </div>
      </div>
    </div>
    <div class="db">
      <div class="dbl">
      </div>
      <div class="dbr">
      </div>
    </div>
    <uc2:ucLoadCss ID="UcLoadCss1" runat="server" PathToFileToLoad="scripts/popUpWin/css/style.css" />
    <asp:ObjectDataSource ID="odsCia" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter"></asp:ObjectDataSource>
    &nbsp;
    <asp:ObjectDataSource ID="odsProducto" runat="server" OldValuesParameterFormatString="original_{0}"
      SelectMethod="GetData" TypeName="dsComboTableAdapters.ProductoComboTableAdapter">
    </asp:ObjectDataSource>
    <uc2:ucLoadCss ID="UcLoadCss2" runat="server" PathToFileToLoad="scripts/popUpWin/css/subModal.css" />    
  </div>

  <script type="text/javascript">
  
    xAddEventListener(window,'load',replaceValidatorOnChange);
    
    function replaceValidatorOnChange() {
      if (typeof(ValidatorOnChange) == 'function') {
        var OldValidatorOnChange = ValidatorOnChange;
        ValidatorOnChange = function (event) {
          try {
            OldValidatorOnChange(event);
          }
          catch(e) {
          }
        }
                  
      }
    }
   
  
    function rewire() {
    
		
		
     //Page_Validators =  new Array(document.getElementById("ctl00_ContentPlaceHolder1_FormView1_CustomValidator1"), document.getElementById("ctl00_ContentPlaceHolder1_FormView1_CompareValidator1"), document.getElementById("ctl00_ContentPlaceHolder1_FormView1_CompareValidator2"), document.getElementById("ctl00_ContentPlaceHolder1_FormView1_CompareValidator3"), document.getElementById("ctl00_ContentPlaceHolder1_FormView1_RequiredFieldValidator1"), document.getElementById("ctl00_ContentPlaceHolder1_FormView1_RequiredFieldValidator2"), document.getElementById("ctl00_ContentPlaceHolder1_FormView1_RequiredFieldValidator3"));
    }
  </script>

  <script type="text/javascript">
        creaPopUpDivs();
  </script>

</asp:Content>
