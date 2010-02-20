<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VRegistroDeduciblesPoliza.aspx.cs" Inherits="VRegistroDeduciblesPoliza" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Deducibles</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>
	<script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>
	<script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>
	<script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>
	<script language="javascript" type="text/javascript" src="Scripts/functions.js"></script>
    <script language="javascript" type="text/javascript" src="Scripts/calendar/datetimepicker.js"></script>
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" language="javascript">
		function seteaOcultadoresDeDivs() {
			btn_ocultar = new CollapsibleDiv('nuevoDeducible',
						 'ContenidoDeducible',						 
						 false,
						 null);
		}
		window.onload = function () {
			seteaOcultadoresDeDivs();
		}
	</script>
</head>
<body style="background-image:none;background-color:#4C96C9;">
<div style="margin-left: auto; margin-right: auto; position: relative; width: 700px; left: 0px; top: 0px;">
    <form id="formRegistroDeducibles" runat="server">    
    <div style="position:relative">
    
   <div id="ContenidoDeducible">
	<table border="0" cellpadding="0" cellspacing="0" class="DataTable" style="width: 700px">
      <tr>
        <td width="10">&nbsp;</td>
        <td width="120">&nbsp;</td>
        <td width="200">&nbsp;</td>
        <td width="50">&nbsp;</td>
        <td width="150">&nbsp;</td>
        <td style="width: 222px">&nbsp;</td>
        <td style="width: 10px">&nbsp;</td>
      </tr>
      <tr>
        <td style="height: 76px">&nbsp;</td>
        <td width="120" style="height: 76px">
            Deducibles</td>
        <td colspan="4" style="height: 76px"><span style="width: 314px">
          <asp:TextBox ID="txtDeducible" runat="server" CssClass="FormText" TextMode="MultiLine"
                                    Width="525px" Height="70px"></asp:TextBox>
        </span></td>
        <td style="width: 10px; height: 76px">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td width="120">&nbsp;</td>
        <td>&nbsp;</td>
        <td width="50">&nbsp;</td>
        <td>&nbsp;</td>
        <td style="width: 222px"></td>
        <td style="width: 10px"></td>
      </tr>
      <tr>
        <td style="height: 17px">&nbsp;</td>
        <td style="height: 17px">&nbsp;</td>
        <td style="height: 17px"><span style="width: 605px; height: 18px;">
          <asp:Button ID="btnRegistrarDeducible" runat="server" CssClass="FormButton" Text="Agregar" OnClick="btnRegistrarDeducible_Click"  />          
        </span></td>
        <td style="height: 17px">&nbsp;</td>
        <td style="height: 17px">&nbsp;</td>
        <td style="height: 17px; width: 222px;"></td>
        <td style="height: 17px; width: 10px;"></td>
      </tr>
      <tr>
        <td style="height: 13px">&nbsp;</td>
        <td style="height: 13px">&nbsp;</td>
        <td style="height: 13px">&nbsp;</td>
        <td style="height: 13px">&nbsp;</td>
        <td style="height: 13px">&nbsp;</td>
        <td style="width: 222px; height: 13px"></td>
        <td style="width: 10px; height: 13px"></td>
      </tr>
    </table>
    
   </div>
    <div style="height:30px; margin-top:5px;margin-bottom:5px;position:relative; left: 0px; width: 700px; top: 0px; background-color: #4582bb;">	&nbsp;
		   <asp:Label ID="lblListaDeducibles" runat="server" Font-Bold="True" Font-Size="18px">Lista de Deducibles </asp:Label>
		   <img src="imgRGen/openCloseCollapse.jpg" alt="Agregar Deducible" title="Agregar Deducible" style="position:absolute; left: 676px; top: 6px;" id="nuevoDeducible" />   
       
        <script language="javascript" src="Scripts/lib/CollapsibleDiv.js" type="text/javascript"></script>

    </div>
   
   <div id="ListaDeducibles" style="margin-left:auto;margin-right:auto;position:relative">
      <div>
        <asp:GridView ID="gridDeducibles" runat="server" AutoGenerateColumns="False" DataSourceID="odsDeducibles" Width="700px"  
            CssClass="DataTable" OnRowCommand="gridDeducibles_RowCommand" AllowPaging="True" >
                    <Columns>
                        <asp:TemplateField HeaderText="N&#176;">
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="condiciones" HeaderText="Deducible" SortExpression="condiciones" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton2" runat="server" CommandArgument='<%# Bind("atributoId") %>'
                                    CommandName="Eliminar" ImageUrl="~/imgRGen/deleteItem.gif" CausesValidation="False" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20px" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="HeaderStyle" />
          <EmptyDataTemplate>
            No hay deducibles registrados
          </EmptyDataTemplate>
                </asp:GridView>
          &nbsp;<br/>
         </div>
    </div>
    
    
     
    </div>
   
    </form>
 </div>
    <asp:TextBox ID="txtatributoId" runat="server" Visible="False" Width="64px"></asp:TextBox>
    <asp:ObjectDataSource ID="odsDeducibles" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPolizaTableAdapters.AtributoPolizaSelectByIdTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="atributoId" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
            <asp:Parameter Name="ajusteId" Type="Decimal" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtatributoId" Direction="InputOutput" Name="atributoId"
                PropertyName="Text" Type="Object" />
            <asp:QueryStringParameter Name="polizaId" QueryStringField="PolizaId" Type="Decimal" />
            <asp:ControlParameter ControlID="txtDeducible" Name="condiciones" PropertyName="Text"
                Type="String" />
            <asp:SessionParameter Name="usuario" SessionField="NombreUsuario" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
    &nbsp;
</body>
</html>
