<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vRiesgosXRequisito.aspx.cs"
  Inherits="vRiesgosXRequisito" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Riesgos Generales | Mantenimiento de Requisitos</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_core.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_event.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_dom.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/x_checkAll.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript" language="javascript" src="Scripts/functions.js"></script>

  <script type="text/javascript" language="javascript">
        var Checks;
       
        function verificaChecks() {
            if (Checks.allEmptyChecks()) {
                alert('Debe elegir por lo menos un riesgo al cual asociar este Requisito!');
                return false;
            }
        }
      
        function doinit()
        {
            Checks = new xCheckAllN('GridView2_ctl01_chkAll','regionChecks'); //no funca roy
        }
      
        window.onload = function () {
            try {                
                 
                 btn_ocultar = new CollapsibleDiv('trigger_nuevoTipoDiv',
						     'divNuevoItem',						 
						     null,
						     null);
                doinit();						     
						     
            }
            catch (ex) {
                //alert(ex.message);
            }
           
        }
  </script>

</head>
<body>
  <div style="width: 545px; overflow: auto; height: 460px; position: relative;">
    <div style="width: 525px; position: relative;">
      <form id="form1" runat="server">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding: 1%">
            <div class="PanelEncabezado" style="padding: 1%;">
              <asp:Label ID="lblTitulo" runat="server" Font-Bold="True" ForeColor="White" Font-Size="18px">Nuevo Requisito </asp:Label>
              <img runat="server" src="imgRGen/openCloseCollapse.jpg" alt="Agregar Riesgo por Requisito"
                title="Agregar Riesgo por Requisito" id="trigger_nuevoTipoDiv" />
            </div>
            <div class="hr">
            </div>
            <div id="divNuevoItem" style="display: none; padding: 1%;" runat="server">
              <div id="Panel1" runat="server">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="requisitoId" DataSourceID="sdsRequisito"
                  DefaultMode="Insert" Width="493px" OnItemUpdated="FormView1_ItemUpdated" OnItemInserting="FormView1_ItemInserting">
                  <EditItemTemplate>
                    <div style="padding: 5px;" class="DataTable">
                      <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td style="padding-top: 2px; width: 78px;" valign="top">
                            Nombre</td>
                          <td>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="FormText" Text='<%# Bind("nombre") %>'
                              Width="300px" MaxLength="500" TextMode="MultiLine" Rows="3"></asp:TextBox></td>
                          <td style="width: 9px">
                          </td>
                          <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNombre"
                              ErrorMessage="Ingrese un nombre" ValidationGroup="InsertVG"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                          <td style="padding-top: 2px; width: 78px;" valign="top">
                            Descripci&oacute;n</td>
                          <td>
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Text='<%# Bind("descripcion") %>'
                              TextMode="MultiLine" Width="300px" MaxLength="1000" Rows="3"></asp:TextBox></td>
                          <td style="width: 9px">
                          </td>
                          <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescripcion"
                              ErrorMessage="Ingrese una Descripción" ValidationGroup="InsertVG"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                          <td style="width: 78px">
                            &nbsp;</td>
                          <td>
                            &nbsp;</td>
                          <td style="width: 9px">
                          </td>
                          <td>
                          </td>
                        </tr>
                        <tr>
                          <td style="width: 78px">
                            &nbsp;<asp:HyperLink ID="lnkVolver" runat="server" CssClass="FormButton" ForeColor="#000040"
                              NavigateUrl="~/vRiesgosXRequisito.aspx" Width="50px">&nbsp;&nbsp;Volver</asp:HyperLink></td>
                          <td>
                            &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" CommandName="Update" ImageUrl="~/images/IconSave24.gif"
                              OnClientClick="return verificaChecks();" ValidationGroup="InsertVG" />
                          </td>
                          <td style="width: 9px">
                          </td>
                          <td>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                    <div class="DataTable" style="padding: 5px;">
                      <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td valign="top" style="padding-top: 2px; width: 79px;">
                            Nombre</td>
                          <td>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" Text='<%# Bind("nombre") %>'
                              Width="300px" TextMode="MultiLine" Rows="3"></asp:TextBox></td>
                          <td style="width: 9px">
                          </td>
                          <td valign="top">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                              ErrorMessage="Ingrese un nombre" ValidationGroup="InsertVG"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                          <td valign="top" style="padding-top: 2px; width: 79px;">
                            Descripci&oacute;n</td>
                          <td>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Text='<%# Bind("descripcion") %>'
                              TextMode="MultiLine" Width="300px" Rows="3"></asp:TextBox></td>
                          <td style="width: 9px">
                          </td>
                          <td valign="top">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                              ErrorMessage="Ingrese una Descripción" ValidationGroup="InsertVG"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                          <td style="width: 79px">
                            &nbsp;</td>
                          <td>
                            &nbsp;</td>
                          <td style="width: 9px">
                          </td>
                          <td>
                          </td>
                        </tr>
                        <tr>
                          <td style="width: 79px">
                            &nbsp;</td>
                          <td>
                            &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" CommandName="Insert" ImageUrl="~/images/IconSave24.gif"
                              ValidationGroup="InsertVG" /></td>
                          <td style="width: 9px">
                          </td>
                          <td>
                          </td>
                        </tr>
                      </table>
                    </div>
                  </InsertItemTemplate>
                </asp:FormView>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="DataTable"
                  DataKeyNames="ramoId" DataSourceID="sdsRiesgoDelRequisito" Width="495px" CellPadding="1"
                  Style="left: 0px; top: -5px">
                  <Columns>
                    <asp:TemplateField>
                      <AlternatingItemTemplate>
                        <asp:CheckBox ID="chk" runat="server" Checked='<%# Bind("chk") %>' />
                      </AlternatingItemTemplate>
                      <ItemStyle Width="30px" HorizontalAlign="Center" VerticalAlign="Top" />
                      <ItemTemplate>
                        <asp:CheckBox ID="chk" runat="server" Checked='<%# Bind("chk") %>' />
                      </ItemTemplate>
                      <HeaderTemplate>
                        <asp:CheckBox ID="chkAll" runat="server" Width="27px" TextAlign="Left" EnableTheming="False" />
                      </HeaderTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ramoId" HeaderText="ramoId" InsertVisible="False" ReadOnly="True"
                      SortExpression="ramoId">
                      <ItemStyle CssClass="invisible" />
                      <HeaderStyle CssClass="invisible" />
                      <FooterStyle CssClass="invisible" />
                    </asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Ramo" SortExpression="nombre" />
                  </Columns>
                  <RowStyle CssClass="ItemStyle" />
                  <HeaderStyle CssClass="HeaderStyle" ForeColor="White" />
                  <AlternatingRowStyle BorderStyle="None" />
                </asp:GridView>
              </div>
            </div>
            <div style="clear: both">
            </div>
          </div>
        </div>
        <div class="DataBottom">
          <div class="DataBottomLeft">
          </div>
          <div class="DataBottomRight">
          </div>
        </div>
        <div id="pnlGrilla" runat="server">
          <div class="DataTop">
            <div class="DataTopLeft">
            </div>
            <div class="DataTopRight">
            </div>
          </div>
          <div class="DataContent">
            <div class="DataContentRight">
              <div class="PanelEncabezado">
                <asp:Label ID="lblListaGastos" runat="server" Font-Bold="True" Font-Size="18px">Requisitos a Solicitar por Ramo</asp:Label>
                <asp:HyperLink ID="lnkSeparar" runat="server" CssClass="BtnSeparar" ImageUrl="~/imgRGen/separar.gif"
                  NavigateUrl="~/vBitacoras.aspx" onclick="return separar();" Width="22px"></asp:HyperLink></div>
              <div style="padding: 1px;">
                <div class="hr">
                </div>
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>
                      Nombre</td>
                    <td style="width: 11px">
                      &nbsp;</td>
                    <td style="width: 11px">
                      <asp:TextBox ID="txtDocumento" CssClass="FormText" runat="server" Width="220px"></asp:TextBox></td>
                    <td style="width: 148px">
                      &nbsp;<asp:Button ID="Button1" runat="server" CssClass="FormButton" OnClick="Button1_Click"
                        Text="Buscar" /></td>
                  </tr>
                   <tr>
                    <td>
                      Ramo</td>
                    <td style="width: 11px">
                    </td>
                     <td style="width: 11px">
                   <asp:DropDownList ID="cbxRiesgo" runat="server" AutoPostBack="True" CssClass="FormText"
                        DataSourceID="odsRamosCombo" DataTextField="nombre" DataValueField="ramoId" Width="224px"
                        OnDataBound="cbxRiesgo_DataBound">
                      </asp:DropDownList></td>
                    <td style="width: 148px">
                      &nbsp;</td>
                  </tr>
                </table><div class="hr">
                </div>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="sdsDocumentosRelacionadosAlRiesgo"
                  AutoGenerateColumns="False" CssClass="DataTable" Width="500px" CellPadding="1"
                  AllowPaging="True" AllowSorting="True" DataKeyNames="requisitoId" OnRowDeleting="GridView1_RowDeleting">
                  <Columns>
                    <asp:BoundField DataField="requisitoId" HeaderText="requisitoId" InsertVisible="False"
                      ReadOnly="True" SortExpression="requisitoId">
                      <ItemStyle CssClass="invisible" />
                      <HeaderStyle CssClass="invisible" />
                    </asp:BoundField>
                    <asp:BoundField DataField="documento" HeaderText="Requisito" SortExpression="documento" />
                    <asp:TemplateField>
                      <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="False" ForeColor="Navy"
                          NavigateUrl='<%# "vRiesgosXRequisito.aspx?action=editar&requisitoId="+Eval("requisitoId") %>'
                          Width="8px" ImageUrl="~/imgRGen/button_edit.gif">Editar</asp:HyperLink>
                        &nbsp;&nbsp;
                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Delete"
                          ImageUrl="~/imgRGen/deleteItem.gif" OnClientClick="return confirm('¿Confirma la Eliminación de este Requisito?');"
                          Text="Delete" />
                      </ItemTemplate>
                      <ItemStyle HorizontalAlign="Center" Width="70px" VerticalAlign="Top" />
                    </asp:TemplateField>
                  </Columns>
                  <RowStyle CssClass="ItemStyle" />
                  <HeaderStyle CssClass="HeaderStyle" Height="20px" />
                  <EmptyDataTemplate>
                    <div style="padding: 10px; text-align: center;">
                      No hay Requisitos Asociados a este riesgo
                    </div>
                  </EmptyDataTemplate>
                </asp:GridView>
                <br />
                <asp:SqlDataSource ID="sdsRiesgoDelRequisito" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                  SelectCommand="sp_rgn_riesgosdelRequisito" SelectCommandType="StoredProcedure"
                  DeleteCommand="sp_rgen_DesasociaRequisitoaRiesgo" DeleteCommandType="StoredProcedure"
                  InsertCommand="sp_rgen_AsociaRequisitoaRiesgo" InsertCommandType="StoredProcedure">
                  <SelectParameters>
                    <asp:QueryStringParameter Name="requisitoid" QueryStringField="requisitoId" Type="Decimal" />
                  </SelectParameters>
                  <DeleteParameters>
                    <asp:Parameter Name="requisitoId" Type="Decimal" />
                    <asp:Parameter Name="ramoId" Type="Decimal" />
                  </DeleteParameters>
                  <InsertParameters>
                    <asp:Parameter Name="requisitoId" Type="Decimal" />
                    <asp:Parameter Name="ramoId" Type="Decimal" />
                  </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsRequisito" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                  DeleteCommand="UPDATE RGN_REQUISITOS SET estado = 'I' WHERE (requisitoId = @requisitoId)"
                  InsertCommand="sp_rgen_insertaRequisito" SelectCommand="SELECT nombre, requisitoId, descripcion, fcrea, fupdate, estado, ucrea, uupdate FROM RGN_REQUISITOS WHERE (requisitoId = @RequisitoId)"
                  UpdateCommand="UPDATE RGN_REQUISITOS SET nombre = @nombre, descripcion = @descripcion, fupdate = @fupdate, uupdate = @uupdate WHERE (requisitoId = @requisitoId)"
                  InsertCommandType="StoredProcedure" OnInserted="sdsRequisito_Inserted" OnInserting="sdsRequisito_Inserting">
                  <DeleteParameters>
                    <asp:Parameter Name="requisitoId" />
                  </DeleteParameters>
                  <UpdateParameters>
                    <asp:Parameter Name="nombre" />
                    <asp:Parameter Name="descripcion" />
                    <asp:Parameter Name="fupdate" />
                    <asp:Parameter Name="uupdate" />
                    <asp:Parameter Name="requisitoId" />
                  </UpdateParameters>
                  <SelectParameters>
                    <asp:QueryStringParameter Name="RequisitoId" QueryStringField="requisitoId" />
                  </SelectParameters>
                  <InsertParameters>
                    <asp:Parameter DefaultValue="" Direction="InputOutput" Name="requisitoId" Size="8"
                      Type="Decimal" />
                    <asp:Parameter Name="nombre" Size="500" />
                    <asp:Parameter Name="descripcion" DefaultValue="" Size="500" />
                  </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsDocumentosRelacionadosAlRiesgo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                  SelectCommand="sp_rgen_documentosXRiesgoListaFiltro" SelectCommandType="StoredProcedure"
                  DeleteCommand="sp_rgen_documentosDelete" DeleteCommandType="StoredProcedure">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="cbxRiesgo" Name="ramoId" PropertyName="SelectedValue"
                      Type="Decimal" />
                    <asp:ControlParameter ControlID="txtDocumento" ConvertEmptyStringToNull="False" Name="nombre"
                      PropertyName="Text" Type="String" />
                  </SelectParameters>
                  <DeleteParameters>
                    <asp:Parameter Name="requisitoId" Type="Decimal" />
                    <asp:Parameter Name="uupdate" Type="String" />
                  </DeleteParameters>
                </asp:SqlDataSource>
                <asp:ObjectDataSource ID="odsRamosCombo" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="GetData" TypeName="dsComboTableAdapters.RamoComboTableAdapter"></asp:ObjectDataSource>
                <br />
              </div>
            </div>
          </div>
          <div class="DataBottom">
            <div class="DataBottomLeft">
            </div>
            <div class="DataBottomRight">
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
