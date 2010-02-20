<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vBusquedaDocumentos.aspx.cs" Inherits="vBusquedaDocumentos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Búsqueda de Documentos</title>
    <link href="css/layout.css" rel="stylesheet" type="text/css" />
	
    <link href="css/RGenStyles.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	.invisible {
	    display:none;
	    
	}
	</style>
	
</head>
<body style="background-image:none;background-color:#4C96C9; color: #ffffff;">
<div style="margin-left: auto; margin-right: auto; position: relative; width: 700px; left: 0px; top: 0px;">
    <form id="formDocumentosSolicitados" runat="server">    
    <div style="position:relative">
    
   
        <div style="height:30px; margin-top:5px;margin-bottom:5px;position:relative;">	&nbsp;<br />
		      <div style="position:relative">
                <div style="height:30px; margin-top:5px;margin-bottom:5px;position:relative;">	
	                       <asp:Label ID="lblListaDocumentos" runat="server" Font-Bold="True" Font-Size="18px">Búsqueda de Documentos</asp:Label>
                    <br />
            <table>
                <tr>
                    <td style="width: 100px">
                        Tipo de Siniestro</td>
                    <td style="width: 100px">
                        <asp:DropDownList ID="cbxTipoSiniestro" runat="server" DataSourceID="odsTipoSiniestro" DataTextField="tipoSiniestro"
                            DataValueField="tipoSiniestroId" AutoPostBack="True" OnSelectedIndexChanged="cbxTipoSiniestro_SelectedIndexChanged" CssClass="FormText" OnDataBound="cbxTipoSiniestro_DataBound" Width="195px">
                        </asp:DropDownList><asp:ObjectDataSource ID="odsTipoSiniestro" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="dsComboTableAdapters.TipoSiniestroComboTableAdapter"></asp:ObjectDataSource>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="width: 100px">
                        </td>
                </tr>
            </table>
	                <br />
	                <br />
                    <div id="ListaDocumentos" style="margin-left:auto;margin-right:auto;position:relative">
                      <div>
                          <asp:GridView ID="gridListaDocumentos" runat="server" CssClass="DataTable" AutoGenerateColumns="False" DataKeyNames="requisitoId" DataSourceID="odsDocumentosTipoSiniestro">
                              <HeaderStyle CssClass="HeaderStyle" />
                              <Columns>
                                  <asp:TemplateField HeaderText="N&#186;">
                                      <ItemStyle HorizontalAlign="Center" Width="20px" />
                                      <ItemTemplate>
                                          <asp:Label ID="Label1" runat="server" Text="<%# num++ %>"></asp:Label>
                                      </ItemTemplate>
                                  </asp:TemplateField>
                                  <asp:BoundField DataField="requisitoId" HeaderText="requisitoId" InsertVisible="False"
                                      ReadOnly="True" SortExpression="requisitoId" >
                                      <ItemStyle CssClass="invisible" />
                                      <HeaderStyle CssClass="invisible" />
                                      <FooterStyle CssClass="invisible" />
                                  </asp:BoundField>
                                  <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre">
                                      <ItemStyle HorizontalAlign="Left" Width="255px" />
                                  </asp:BoundField>
                                  <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" SortExpression="descripcion">
                                      <ItemStyle HorizontalAlign="Left" Width="270px" />
                                  </asp:BoundField>
                                  <asp:TemplateField>
                                      <ItemStyle HorizontalAlign="Center" Width="20px" />
                                      <ItemTemplate>
                                         <div align="center"> <asp:CheckBox ID="chkDocumentos" runat="server" />
                                         </div>
                                      </ItemTemplate>
                                  </asp:TemplateField>
                              </Columns>
                          </asp:GridView>
                          </div>
                    </div>
                    <div>
                        <asp:ObjectDataSource ID="odsDocumentosTipoSiniestro" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsDocumentosTableAdapters.DocumentosTipoSiniestroIdListaTableAdapter">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="cbxTipoSiniestro" Name="tiposiniestroId" PropertyName="SelectedValue"
                                    Type="Decimal" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsCarta" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
                            OnInserted="odsCarta_Inserted" OnInserting="odsCarta_Inserting" SelectMethod="GetData"
                            TypeName="dsDocumentosTableAdapters.SolicitudDocumentosListaTableAdapter">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="57" Name="AjusteId" QueryStringField="AjusteId"
                                    Type="Decimal" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:Parameter Name="AjusteId" Type="Decimal" />
                                <asp:Parameter Direction="InputOutput" Name="solDocId" Type="Object" />
                                <asp:Parameter Name="ucrea" Type="String" />
                                <asp:Parameter Name="uupdate" Type="String" />
                            </InsertParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="odsInsertaRequisito" runat="server" InsertMethod="Insert"
                            OldValuesParameterFormatString="original_{0}" OnInserting="odsInsertaRequisito_Inserting"
                            SelectMethod="GetData" TypeName="dsDocumentosTableAdapters.RequisitosDeDocumentoTableAdapter">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="57" Name="ajusteId" QueryStringField="AjusteId"
                                    Type="Decimal" />
                                <asp:Parameter Name="SolDocId" Type="Decimal" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <br />
                    </div>
                    <div style="width: 300px; height: 80px; position: relative; left: 0px; top: 0px;"
                        id="Div1">
                        <div style="position: absolute; left: 15px; top: 17px;">
                            <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/imgRGen/save.gif" ToolTip="Guardar El Registro"
                                TabIndex="26" OnClick="btnGuardar_Click" /></div>
                    </div>
                    
                </div>
   
        
        
             </div>
   
    
       
    </form>
 </div>
</body>
</html>
