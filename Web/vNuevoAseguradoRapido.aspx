<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vNuevoAseguradoRapido.aspx.cs"
  Inherits="vNuevoAseguradoRapido" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Nuevo Asegurado</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/xCaseOperations.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript">
    
    var urlArgs;
    var action;
     
    function evaluateAction() {
        
        /*EVALUA LOS PARAMETROS VIA URL*/
       
        doNewActions();
        
    }
    
    
    function doNewActions() {
        try {
            
            deshabilitaCamposPersonaNatural('true');
        }
        catch(e) {
            alert(e.message);
        }
    }
    
    window.onload = function () {
       evaluateAction();
    }
    
    function deshabilitaCamposPersonaNatural(key) {
        //alert(key == 'true');
        var habilitado = (key=='true');
	    var clase = (habilitado)? 'deshabilitado FormText MAYUSC': 'FormText MAYUSC';
	    var prefix = 'FormView1_'; //prefijo en el caso nuevo	    	    
	    
	    $(prefix+'ApellidoPaternoTextBox').className = clase;
	    $(prefix+'ApellidoPaternoTextBox').disabled = habilitado;
	    
	    $(prefix+'ApellidoMaternoTextBox').className = clase;	
	    $(prefix+'ApellidoMaternoTextBox').disabled = habilitado;
	    
	    $(prefix+'SegundoNombreTextBox').className = clase;
	    $(prefix+'SegundoNombreTextBox').disabled = habilitado;
	    
	    
		$('lblnombreRazonSocial').innerHTML = (habilitado)?"Razón Social":"Nombre";
		
	}
	
  function muestraOcultaPersonaJuridica(elemento) {				
		deshabilitaCamposPersonaNatural(elemento.value); 						
	}
	
	function copyValues() {
	  window.parent.SetAseguradoValues($('hdfAseguradoId').value,$('hdfAsegurado').value);
	}
	
    
  </script>

  <!-- por alguna extraña razon cuando necesito tener una clase CSS de manera dinámica no puedo sacarla del archivo css
        vinculado. Debo ponerla en la pagina -->
  <style type="text/css">
    
        .deshabilitado {                       
	        color: #CCCCCC;
	        background-color: #CCCCCC;	
	        font-family:Verdana;	
	        border-top:1px solid #41778B;
	        border-right:1px solid #D6D3CE;
	        border-bottom:1px solid #D6D3CE;
	        border-left:1px solid #42758C;
	        font-size:10px;
	        background-image:url(../imgRGen/fondo_FormText.gif);
	        background-repeat:repeat-x;	
        }

    </style>
  <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
    <link href="./asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <form id="form1" runat="server">
    <div class="DataTop">
      <div class="DataTopLeft">
      </div>
      <div class="DataTopRight">
      </div>
    </div>
    <div class="DataContent">
      <div class="DataContentRight" style="padding: 1%;">
        <div class="PanelEncabezado">
          <asp:Label ID="lblTitulo" runat="server" Font-Size="18px" Font-Bold="True">Nuevo Asegurado</asp:Label>&nbsp;
        </div>
        <div class="hr">
        </div>
        <div id="nuevoRegDiv" runat="server">
          <asp:FormView ID="FormView1" runat="server" DataKeyNames="personaId" DataSourceID="sdsAseguradoFRM"
            DefaultMode="Insert" Width="551px" OnItemInserting="FormView1_ItemInserting" AllowPaging="True"
            Style="left: 0px">
            <InsertItemTemplate>
              <div style="padding: 5px;" class="DataTable">
                <table class="DataTable" width="630" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="130">
                      Tipo Persona</td>
                    <td style="width: 203px">
                      <asp:RadioButtonList ID="rbgrpNaturalJuridica" runat="server" Font-Bold="False" ForeColor="White"
                        RepeatDirection="Horizontal" TabIndex="13" SelectedValue='<%# Bind("chkPersonaJuridica") %>'>
                        <asp:ListItem onclick="muestraOcultaPersonaJuridica(this);" Value="false">Natural</asp:ListItem>
                        <asp:ListItem onclick="muestraOcultaPersonaJuridica(this);" Selected="True" Value="true">Jur&#237;dica</asp:ListItem>
                      </asp:RadioButtonList></td>
                    <td width="130">
                    </td>
                    <td width="194">
                    </td>
                  </tr>
                  <tr>
                    <td width="130">
                      <span id="lblnombreRazonSocial">Nombre</span></td>
                    <td style="width: 203px">
                      <asp:TextBox ID="PrimerNombreTextBox" runat="server" CssClass="FormText MAYUSC" Text='<%# Bind("PrimerNombre") %>'
                        Width="160px"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="PrimerNombreTextBox"
                        ErrorMessage="El Nombre es obligatorio" ValidationGroup="NuevoItem">(*)</asp:RequiredFieldValidator></td>
                    <td width="130">
                      Apellido Paterno</td>
                    <td width="194">
                      <asp:TextBox ID="ApellidoPaternoTextBox" runat="server" CssClass="FormText MAYUSC"
                        Text='<%# Bind("ApellidoPaterno") %>' Width="160px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td style="height: 16px">
                      Segundo Nombre</td>
                    <td style="height: 16px; width: 203px;">
                      <asp:TextBox ID="SegundoNombreTextBox" runat="server" CssClass="FormText MAYUSC"
                        Text='<%# Bind("SegundoNombre") %>' Width="160px"></asp:TextBox></td>
                    <td style="height: 16px">
                      Apellido Materno</td>
                    <td style="height: 16px">
                      <asp:TextBox ID="ApellidoMaternoTextBox" runat="server" CssClass="FormText MAYUSC"
                        Text='<%# Bind("ApellidoMaterno") %>' Width="160px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td>
                      Dirección</td>
                    <td style="width: 203px">
                      <asp:TextBox ID="TextBox3" runat="server" CssClass="FormText" Text='<%# Bind("direccion") %>'
                        Width="160px"></asp:TextBox></td>
                    <td width="130">
                      Tipo Documento
                    </td>
                    <td width="194">
                      <asp:DropDownList ID="DropDownList1" runat="server" CssClass="FormText" DataSourceID="odsTipoDocumento"
                        DataTextField="tdocid" DataValueField="tdocidId" SelectedValue='<%# Bind("tdocidId") %>'
                        Width="165px" AppendDataBoundItems="True">
                        <asp:ListItem Selected="True" Value="-1">[ Elija ]</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Distrito</td>
                    <td style="width: 203px">
                      <cc1:AutoSuggestBox ID="AutoSuggestBox1" runat="server" BorderWidth="0px" CssClass="FormText"
                        DataType="Distrito" IncludeMoreMenuItem="False" KeyPressDelay="300" MaxSuggestChars="15"
                        MenuCSSClass="asbMenu" MenuItemCSSClass="asbMenuItem" MoreMenuItemLabel="..." NumMenuItems="12"
                        ResourcesDir="./asb_includes" SelectedValue='<%# Bind("ubigeoId") %>' SelMenuItemCSSClass="asbSelMenuItem"
                        UseIFrame="True" Width="160px" WarnNoValueSelected="false"></cc1:AutoSuggestBox>
                    </td>
                    <td style="height: 16px">
                      N° Documento
                    </td>
                    <td style="height: 16px">
                      <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Text='<%# Bind("docid") %>'
                        Width="160px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td>
                    </td>
                    <td style="width: 203px">
                    </td>
                    <td>
                      Telefono Fijo
                    </td>
                    <td>
                      <asp:TextBox ID="TextBox4" runat="server" CssClass="FormText" Text='<%# Bind("TFIJO") %>'
                        Width="160px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td>
                    </td>
                    <td style="width: 203px">
                    </td>
                    <td>
                      Fax</td>
                    <td>
                      <asp:TextBox ID="TextBox5" runat="server" CssClass="FormText" Text='<%# Bind("TFAX") %>'
                        Width="160px"></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td>
                    </td>
                    <td style="width: 203px">
                      <asp:ImageButton ID="btnGuardar" runat="server" CommandName="Insert" ImageUrl="~/images/IconSave24.gif"
                        ValidationGroup="NuevoItem" /></td>
                    <td>
                    </td>
                    <td>
                    </td>
                  </tr>
                  <tr>
                    <td>
                    </td>
                    <td style="width: 203px">
                    </td>
                    <td>
                    </td>
                    <td >
                        
                    </td>
                  </tr>
                </table>
              </div>
              <asp:ObjectDataSource ID="odsTipoDocumento" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoDocumentoIdentidadComboTableAdapter">
              </asp:ObjectDataSource>
              <asp:HiddenField ID="hfNombre" runat="server" />
              <asp:HiddenField ID="hfAseguradoId" runat="server" />
              <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="NuevoItem" />
            </InsertItemTemplate>
            <EditItemTemplate>
              <div style="padding: 5px;" class="DataTable">
                &nbsp;</div>
            </EditItemTemplate>
          </asp:FormView>
        </div>
      </div>
    </div>
    <div class="DataBottom">
      <div class="DataBottomLeft">
      </div>
      <div class="DataBottomRight">
      </div>
    </div>
    <asp:SqlDataSource ID="sdsAseguradoFRM" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      InsertCommand="sp_rgen_AseguradoInsert" InsertCommandType="StoredProcedure" SelectCommand="sp_rgen_AseguradoSelectById"
      SelectCommandType="StoredProcedure" UpdateCommand="sp_rgen_aseguradoUpdate" UpdateCommandType="StoredProcedure"
      OnInserted="sdsAseguradoFRM_Inserted">
      <UpdateParameters>
        <asp:Parameter Name="PrimerNombre" Type="String" />
        <asp:Parameter Name="SegundoNombre" Type="String" />
        <asp:Parameter Name="ApellidoPaterno" Type="String" />
        <asp:Parameter Name="ApellidoMaterno" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
        <asp:Parameter Name="TFIJO" Type="String" />
        <asp:Parameter Name="TFAX" Type="String" />
        <asp:Parameter Name="direccion" Type="String" />
        <asp:Parameter Name="ubigeoId" Type="String" />
        <asp:Parameter Name="tdocidId" Type="Decimal" />
        <asp:Parameter Name="docid" Type="String" />
        <asp:Parameter Name="personaId" Type="Decimal" />
        <asp:Parameter Name="chkPersonaJuridica" Type="Boolean" />
      </UpdateParameters>
      <SelectParameters>
        <asp:QueryStringParameter Name="personaId" QueryStringField="AseguradoId" Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:Parameter Name="PrimerNombre" Type="String" />
        <asp:Parameter Name="SegundoNombre" Type="String" />
        <asp:Parameter Name="ApellidoPaterno" Type="String" />
        <asp:Parameter Name="ApellidoMaterno" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
        <asp:Parameter Name="TFIJO" Type="String" />
        <asp:Parameter Name="TFAX" Type="String" />
        <asp:Parameter Name="direccion" Type="String" />
        <asp:Parameter Name="ubigeoId" Type="String" />
        <asp:Parameter Name="tdocidId" Type="Decimal" />
        <asp:Parameter Name="docid" Type="String" />
        <asp:Parameter Direction="InputOutput" Name="personaId" Type="Decimal" />
        <asp:Parameter Name="chkPersonaJuridica" Type="Boolean" />
      </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hdfAseguradoId" runat="server" />
    <asp:HiddenField ID="hdfAsegurado" runat="server" />
  </form>
</body>
</html>
