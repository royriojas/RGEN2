<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vElegirAjustador.aspx.cs"
  Inherits="vElegirAjustador" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Asignar Ajustador</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script type="text/ecmascript" src="Scripts/lib/x_CheckHabilitador.js"></script>

  <script language="javascript" type="text/javascript"> 
	
	function cierraVentana() 
	{                     
        window.top.hidePopWin(true);
        window.top.refrescate();            
    }
    window.onload = function () {        
        cargaEmailAjustador();
        
         try {
               
                var chk1 = new xCheckHabilitador('chkNotificar','txtCorreo','deshabilitado');
                                
            }
            catch (e) {
               // alert(e.message);
            }
            
        
        if (<%=huboPostBack%>) {
            cierraVentana();
        }
    }
    
    function cargaEmailAjustador() {        
        var correo = vElegirAjustador.obtenCorreoPersona($('DropDownList1').value).value;
        //alert (correo);
        $('txtCorreo').value = correo;
    }
    
  </script>

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
</head>
<body style="background-image: none; background-color: #4C96C9;margin:10px;">
  <div>
    <form id="formAsignarAjustador" runat="server">
      <div style="position: relative">
        <div style="height: 30px; margin-top: 10px; margin-bottom: 5px; position: relative;
          background-color: #2c84bd;">
          &nbsp;
          <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px">Seleccionar Ajustador</asp:Label>
          &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;
        </div>
        <div id="Contenido">
          <table border="0" cellpadding="0" cellspacing="0" class="DataTable">
            <tr>
              <td style="width: 28px; height: 12px">
                &nbsp;</td>
              <td style="width: 492px; height: 12px">
                &nbsp;</td>
              <td style="height: 12px; width: 237px;">
                &nbsp;</td>
              <td style="height: 12px; width: 169px;">
                &nbsp;</td>
              <td width="10" style="height: 12px">
                &nbsp;</td>
            </tr>
            <tr>
              <td style="width: 28px; height: 8px;">
                &nbsp;</td>
              <td style="width: 492px; height: 8px;">
                Nombre Ajustador</td>
              <td style="height: 8px; width: 237px;">
                <span style="width: 314px">
                  <asp:DropDownList onchange="cargaEmailAjustador();" ID="DropDownList1" runat="server"
                    CssClass="FormText" DataSourceID="odsAjustador" DataTextField="persona" DataValueField="personaid"
                    Width="205px">
                  </asp:DropDownList>
                </span>
              </td>
              <td style="height: 8px; width: 169px;">
                &nbsp;</td>
              <td width="10" style="height: 8px">
                &nbsp;</td>
            </tr>
              <tr>
                  <td style="width: 28px; height: 17px">
                  </td>
                  <td style="width: 492px; height: 17px">
                      Nombre Ejecutivo de Siniestros</td>
                  <td style="width: 237px; height: 17px">
                      <asp:DropDownList ID="DropDownList2" runat="server" CssClass="FormText" DataSourceID="odsEjecutivoSiniestros"
                          DataTextField="persona" DataValueField="personaid" Width="205px">
                      </asp:DropDownList>
                  </td>
                  <td style="width: 169px; height: 17px">
                  </td>
                  <td style="height: 17px" width="10">
                  </td>
              </tr>
            <tr>
              <td style="width: 28px; height: 17px">
              </td>
              <td style="width: 492px; height: 17px">
              </td>
              <td style="width: 237px; height: 17px">
                <asp:CheckBox ID="chkNotificar" runat="server" Text="Notificar" Checked="True" /></td>
              <td style="width: 169px; height: 17px">
              </td>
              <td style="height: 17px" width="10">
              </td>
            </tr>
            <tr>
              <td style="width: 28px; height: 17px">
              </td>
              <td style="width: 492px; height: 17px">
                Correo Electrónico</td>
              <td style="height: 17px; width: 237px;">
                <asp:TextBox ID="txtCorreo" runat="server" CssClass="FormText" Width="200px"></asp:TextBox></td>
              <td style="height: 17px; width: 169px;">
              </td>
              <td style="height: 17px" width="10">
              </td>
            </tr>
            <tr>
              <td style="height: 17px; width: 28px;">
                &nbsp;</td>
              <td style="height: 17px; width: 492px;">
                &nbsp;</td>
              <td style="height: 17px; width: 237px;">
                <span style="width: 605px; height: 18px;">&nbsp;</span></td>
              <td style="height: 17px; width: 169px;">
              </td>
              <td style="height: 17px">
              </td>
            </tr>
            <tr>
              <td style="width: 28px">
                &nbsp;</td>
              <td style="width: 492px">
                &nbsp;</td>
              <td style="width: 237px">
                <asp:Button ID="btnAceptar" runat="server" CssClass="FormButton" Text="Aceptar" OnClick="btnRegistrar_Click" />&nbsp;
              </td>
              <td style="width: 169px">
              </td>
              <td>
              </td>
            </tr>
            <tr>
              <td style="width: 28px; height: 15px">
              </td>
              <td style="width: 492px; height: 15px">
              </td>
              <td style="width: 237px; height: 15px">
              </td>
              <td style="width: 169px; height: 15px">
              </td>
              <td style="height: 15px">
              </td>
            </tr>
          </table>
        </div>
      </div>
    </form>
  </div>
    &nbsp;
  <asp:ObjectDataSource ID="odsAsignarAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsAjusteTableAdapters.AsignarAjustadorTableAdapter"
    UpdateMethod="Update">
    <UpdateParameters>
      <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
      <asp:ControlParameter ControlID="DropDownList1" Name="ajustadorId" PropertyName="SelectedValue"
        Type="Decimal" />
        <asp:ControlParameter ControlID="DropDownList2" Name="ejecutivoSiniestrosId" PropertyName="SelectedValue"
            Type="Decimal" />
    </UpdateParameters>
    <SelectParameters>
        <asp:QueryStringParameter Name="ajusteId" QueryStringField="AjusteId" Type="Decimal" />
    </SelectParameters>
  </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsEjecutivoSiniestros" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsComboTableAdapters.EjecutivoSiniestrosComboTableAdapter">
    </asp:ObjectDataSource>
  <asp:ObjectDataSource ID="odsAjustador" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="dsComboTableAdapters.AjustadorComboTableAdapter">
  </asp:ObjectDataSource>
</body>
</html>
