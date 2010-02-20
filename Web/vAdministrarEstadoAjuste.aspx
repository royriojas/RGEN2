<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAdministrarEstadoAjuste.aspx.cs" Inherits="vAdministrarEstadoAjuste" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
    <title>Administrador Estados Ajuste</title>  
	<script type="text/javascript" language="javascript">
		function valida() {
			var retorno = false;
			var chk = document.getElementById('chkEliminar');
			if (chk.checked) {
				retorno = confirm('¿Desea Eliminar el Ajuste?');
			}
			chk.checked = retorno;
			return retorno;
		}
		
	</script>  
</head>
<body>
    <form id="form2" runat="server">
    <div>
    <div id="ContenidoPagina" style="width:580px;">
        
        <div class="DataTop">
            <div class="DataTopLeft"></div>
            <div class="DataTopRight"></div>
        </div>    
       
        <div class="DataContent">
          <div class="DataContentRight">
		  	<div style="position:relative;"><asp:Label ID="lblAjusteNumero" Font-Bold="true" Font-Size="16px" runat="server" Text='Ajuste Número: '></asp:Label>
		  	</div>
           		<div class="hr"></div>
			<div>
			  <table width="560" border="0" cellspacing="0" cellpadding="0" style="top: 0px">
			  	<tr>
                  <td width="19">&nbsp;</td>
                  <td width="248" valign="top"><asp:Label ID="Label1" Font-Bold="true" Font-Size="12px" runat="server" Text="Estados"></asp:Label>
                      <asp:RadioButtonList ID="rbgrp_Estados" runat="server" DataSourceID="odsEstadosAjuste"
                          DataTextField="estadoajuste" DataValueField="estadoajusteid" Width="300px">                      </asp:RadioButtonList>
                      <asp:ObjectDataSource ID="odsEstadosAjuste" runat="server"
                          OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsComboTableAdapters.EstadoAjusteComboTableAdapter">                      </asp:ObjectDataSource>                  </td>
                  <td width="29">&nbsp;</td>
                  <td width="284" valign="top">&nbsp;
                    <asp:Label ID="Label2" runat="server" Font-Bold="true"  Font-Size="12px" Text="Control de Calidad"></asp:Label>
                      <asp:RadioButtonList ID="rbgrp_ControlCalidad" runat="server">
                          <asp:ListItem>Aprobado</asp:ListItem>
                          <asp:ListItem>Observado</asp:ListItem>
                      </asp:RadioButtonList>
					  <br />
					  <br />
					  <asp:CheckBox ID="chkEliminar" runat="server" Text="Eliminar Ajuste" />
					  <br />
					  <br />
					  <div style="position:absolute; bottom:10px; right: 20px;">
                      <asp:ImageButton OnClientClick="valida();" ID="imgbtnSave" runat="server" ImageUrl="~/imgRGen/btnSave.gif" />
				    </div>
				  </td>
					  
                </tr>
                 
              </table>
			</div>
				<div class="hr"></div>
				<div>
                    &nbsp;<div style="height:20px;">
                        &nbsp;</div>
            </div>
          </div>
		  
        </div>
	
	    <div class="DataBottom">
            <div class="DataBottomLeft"></div>
            <div class="DataBottomRight"></div>
        </div>
        
      </div>
    </div>
       
    </form>
</body>
</html>
