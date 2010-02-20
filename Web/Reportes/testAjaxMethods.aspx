<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testAjaxMethods.aspx.cs" Inherits="Reportes_testAjaxMethods" %>

<%@ Register Assembly="AutoSuggestBox" Namespace="ASB" TagPrefix="Custom" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
     <script type="text/javascript" src="../Scripts/lib/x.js"></script>
    <script type="text/javascript" src="../Scripts/functions.js"></script>
   
    <script type="text/javascript">
        
        
        
        
        function perfomContactoAjaxSearch() {            
            var pId = $('txtContactoCiaSeguros_SelectedValue').value;
            if (pId != "") {
                Reportes_testAjaxMethods.getEjecutivoAseguradora(pId,callBackFunction);
            }
           
        }
        function callBackFunction(res) {
            try {
                var contacto = res.value;                
                $('TestArea').value = CCSOL.Utiles.StringFormat('Nombre del Ejecutivo = {0},\nTelefono : {1},\nEmail : {2}',contacto.Nombre,contacto.Telefono, contacto.Email);
            }
            catch(e) {
                alert(CCSOL.Utiles.traceError(e));
            }
        }
        function clearForm() {
            $('txtContactoCiaSeguros').value = "";
            $('txtContactoCiaSeguros_SelectedValue').value = "";
            //OtrosCamposElegidos
            
        }
        function setAsbFilter(e) {   
            if ($('txtContactoCiaSeguros').value != '')  {
                if (!confirm('Se Borrarán los datos que ha seleccionado al cambiar la aseguradora, ¿Desea Continuar?')) {
                    return;
                }
            }
            //limpiamos el AutoSuggestBox         
            clearForm();
            asbGetObj('txtContactoCiaSeguros').msFilters = $('cbxCiaSeguros').value;                                  
        }
        
        window.onload = function () {
            xAddEventListener($('cbxCiaSeguros'),'change',setAsbFilter,false);
            xAddEventListener($('txtContactoCiaSeguros'),'blur',perfomContactoAjaxSearch,false);
        }
    </script>


    <link href="../asb_includes/AutoSuggestBox.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="TestArea" runat="server" Height="73px" TextMode="MultiLine" Width="544px"></asp:TextBox>
        
        <button id='btnTriggerAjax' onclick='perfomContactoAjaxSearch();return false;' >Do Ajax Call</button><br />
        <br />
        <Custom:AutoSuggestBox Filters="-1" ID="txtContactoCiaSeguros" runat="server" OnFocusShowAll="True"
            Width="347px" DataType="Ejecutivo" WarnNoValueSelected="true" ResourcesDir="../asb_includes"></Custom:AutoSuggestBox><br />
        <br />
        <asp:DropDownList ID="cbxCiaSeguros" runat="server" CssClass="FormText" DataSourceID="odsCiaSeguros"
            DataTextField="persona" DataValueField="personaid" 
            TabIndex="9" Width="200px" AppendDataBoundItems="True">
            <asp:ListItem Selected="True" Value="-1">[Elija una]</asp:ListItem>
        </asp:DropDownList><asp:ObjectDataSource ID="odsCiaSeguros" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData" TypeName="dsComboTableAdapters.CiaComboTableAdapter"></asp:ObjectDataSource>
    </div>
        
    </form>
</body>
</html>
