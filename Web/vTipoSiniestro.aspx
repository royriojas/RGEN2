<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vTipoSiniestro.aspx.cs" Inherits="vTipoSiniestro" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Tipo de Siniestro</title>
  <link href="css/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="Scripts/functions.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_core.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_dom.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/x_event.js"></script>

  <script language="javascript" type="text/javascript" src="Scripts/lib/CollapsibleDiv.js"></script>

  <script type="text/javascript">
     var collapse_newItem;
    var collapse_filters;
    function doCollapse_filters() {
        collapse_newItem.displayDiv(!collapse_filters.getElementVisible());        
    }
    function redirectUrl(url,action,fId) {
        document.location.href = url + '?action='+action+'&RiesgoId='+fId;
        return false;
    }
    window.onload = function () {
        try {
            collapse_newItem = new CollapsibleDiv ('btnNewItem',
						 'pnlNewItem',
						 null,
						 null
						);
			collapse_filters = new CollapsibleDiv('btnShowFilters',
			            'pnlFilters',
			            null,
			            null
			            );
			
			
			xAddEventListener($('btnShowFilters'),'click',doCollapse_filters,false);
			
        }
        catch(e)
        {
            alert(e.message);
        }
    }
    
    function closepnlConfirmacion() {
         $('pnlMensajeConfirmacion').style.display = 'none';
    }
    
   
  </script>

</head>
<body>
  <form id="form1" runat="server">
    <div style="position: relative; width: 703px; overflow: auto; left: 0px; top: 0px;
      height: 480px;">
      <div id="cont" style="width: 680px; position: relative;">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding: 1%; left: 0px; top: 0px;">
            <div class="PanelEncabezado">
              <asp:Label ID="lblCobertura" runat="server" Text="Nuevo Tipo de Siniestro" Font-Bold="True"
                Font-Size="18px"></asp:Label>
              <img id="btnNewItem" src="./imgRGen/openCloseCollapse.jpg" alt="Agregar" title="Agregar"
                class="btnCollapse" style="right: 15px; top: 1px" /></div>
            <div class="hr">
            </div>
            <div id="pnlNewItem" style="display: none;" runat="server">
              <div style="padding: 10px; position: relative;" class="DataTable">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="tipoSiniestroId" DataSourceID="sdsTipoSiniestro"
                  DefaultMode="Insert" OnItemInserting="FormView1_ItemInserting" OnItemInserted="FormView1_ItemInserted">
                  <InsertItemTemplate>
                    <table id="tbl" style="width: 626px" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="width: 105px; height: 40px" valign="top">
                          Tipo Siniestro</td>
                        <td style="height: 40px; width: 521px;" valign="top">
                          <asp:TextBox ID="tipoSiniestroTextBox" runat="server" Text='<%# Bind("tipoSiniestro") %>'
                            CssClass="FormText" Width="370px" Height="30px" TextMode="MultiLine"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td style="width: 105px; height: 39px" valign="top">
                          Descripción</td>
                        <td style="height: 39px; width: 521px;" valign="top">
                          <asp:TextBox ID="descripcionTextBox" runat="server" Text='<%# Bind("descripcion") %>'
                            CssClass="FormText" Height="30px" TextMode="MultiLine" Width="370px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td style="height: 22px; width: 105px;" valign="top">
                          Ramo
                          <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="DropDownList1"
                            ErrorMessage="Debe elegir un valor para el ramo" Operator="NotEqual" ValidationGroup="newFormValidator"
                            ValueToCompare="-1">(*)</asp:CompareValidator></td>
                        <td style="height: 22px; width: 521px;" valign="top">
                          <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" CssClass="FormText"
                            DataSourceID="sdsComboRamo" DataTextField="nombre" DataValueField="ramoId" SelectedValue='<%# Bind("ramoId") %>'
                            Width="209px">
                            <asp:ListItem Value="-1">[ Elija ]</asp:ListItem>
                          </asp:DropDownList>
                        </td>
                      </tr>
                      <tr>
                        <td style="width: 105px; height: 4px" valign="top">
                        </td>
                        <td style="height: 4px; width: 521px;" valign="top">
                          &nbsp;</td>
                      </tr>
                      <tr>
                        <td style="width: 105px; height: 22px" valign="top">
                        </td>
                        <td style="height: 22px; width: 521px;" valign="top">
                          <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Insert" ImageUrl="~/images/IconSave24.gif"
                            ValidationGroup="newFormValidator" /><asp:SqlDataSource ID="sdsComboRamo" runat="server"
                              ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>" SelectCommand="sp_rgen_RamoCombo"
                              SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </td>
                      </tr>
                    </table>
                  </InsertItemTemplate>
                </asp:FormView>
              </div>
              <div id="pnlMensajeConfirmacion" runat="server" class="panelMensaje" style="left: 161px;
                vertical-align: middle; width: 375px; position: absolute; top: 158px; height: 20px;
                text-align: center" visible="false">
                <div class="icoIdea">
                </div>
                <asp:Label ID="lblMensaje" runat="server" Text="El Tipo de Siniestro ha sido creado satisfactoriamente"></asp:Label>
                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/btnClose.jpg" onclick="closepnlConfirmacion();"
                  Style="left: 354px; cursor: pointer; position: absolute; top: 3px" />
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
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding: 1%;">
            <div class="PanelEncabezado">
              <asp:Label ID="lblListaTitulo" runat="server" Text="Lista de Tipos de Siniestro"
                Font-Bold="True" Font-Size="18px"></asp:Label>
              <img id="btnShowFilters" src="./imgRGen/openCloseCollapse.jpg" alt="Agregar" title="Agregar"
                class="btnCollapse" style="right: 15px; top: 1px" />
              <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
                onclick="return separar();" CssClass="BtnSeparar" Width="22px"></asp:HyperLink>
            </div>
            <div class="hr">
            </div>
            <div id="pnlFilters" style="display: none;" class="DataTable" runat="server">
              <div style="padding: 5px;">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="left: 0px;
                  top: 0px">
                  <tr>
                    <td style="height: 12px" width="18%">
                      &nbsp;Tipo Siniestro</td>
                    <td style="height: 12px" width="55%">
                      <asp:TextBox ID="txtTipoSiniestro" runat="server" CssClass="FormText" Width="285px"></asp:TextBox></td>
                    <td style="height: 12px" width="27%">
                      &nbsp;</td>
                  </tr>
                  <tr>
                    <td style="height: 12px" width="18%">
                      &nbsp;Ramo</td>
                    <td style="height: 12px" width="55%">
                      <asp:DropDownList ID="cbxRamo" runat="server" AppendDataBoundItems="True" CssClass="FormText"
                        DataSourceID="sdsRamoCombo" DataTextField="nombre" DataValueField="ramoId" Width="290px">
                        <asp:ListItem Value="-1">[ Todos ]</asp:ListItem>
                      </asp:DropDownList>
                    </td>
                    <td style="height: 12px" width="27%">
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 12px" width="18%">
                      &nbsp;Estado</td>
                    <td style="height: 12px" width="55%">
                      <asp:RadioButtonList ID="rbtnGroupEstado" runat="server" CellPadding="0" CellSpacing="0"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="T">Todos</asp:ListItem>
                        <asp:ListItem Value="A">Activo</asp:ListItem>
                        <asp:ListItem Value="I">Inactivo</asp:ListItem>
                      </asp:RadioButtonList></td>
                    <td style="height: 12px" width="27%">
                      &nbsp;<asp:SqlDataSource ID="sdsRamoCombo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                        SelectCommand="sp_rgen_RamoCombo" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </td>
                  </tr>
                  <tr>
                    <td style="height: 12px" width="18%">
                    </td>
                    <td style="height: 12px" width="55%">
                      <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/imgRGen/btnBuscar24.jpg"
                        OnClick="ImageButton1_Click" />&nbsp;</td>
                    <td style="height: 12px" width="27%">
                    </td>
                  </tr>
                </table>
              </div>
            </div>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="tipoSiniestroId"
              DataSourceID="sdsTipoSiniestro" Width="652px" AllowPaging="True" AllowSorting="True"
              OnRowUpdating="GridView1_RowUpdating" OnRowUpdated="GridView1_RowUpdated">
              <Columns>
                <asp:BoundField DataField="tipoSiniestroId" HeaderText="tipoSiniestroId" InsertVisible="False"
                  ReadOnly="True" SortExpression="tipoSiniestroId">
                  <ItemStyle CssClass="invisible" />
                  <HeaderStyle CssClass="invisible" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Tipo Siniestro" SortExpression="tipoSiniestro">
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="FormText" Text='<%# Bind("tipoSiniestro") %>'
                      TextMode="MultiLine" Width="180px" Rows="4"></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("tipoSiniestro") %>'></asp:Label>
                  </ItemTemplate>
                  <ItemStyle Width="150px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Descripci&#243;n" SortExpression="descripcion">
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Text='<%# Bind("descripcion") %>'
                      TextMode="MultiLine" Width="180px" Rows="4"></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("descripcion") %>'></asp:Label>
                  </ItemTemplate>
                  <ItemStyle Width="150px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ramo" SortExpression="nombre">
                  <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="FormText" DataSourceID="sdsComboRamo"
                      DataTextField="nombre" DataValueField="ramoId" SelectedValue='<%# Bind("ramoId") %>'
                      Width="185px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsComboRamo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                      SelectCommand="sp_rgen_RamoCombo" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                  </EditItemTemplate>
                  <ItemStyle Width="150px" />
                  <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("nombre") %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                  <EditItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update"
                      ImageUrl="~/imgRGen/button_ok.gif" Text="Update" />&nbsp;<asp:ImageButton ID="ImageButton2"
                        runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/imgRGen/iconCancel.gif"
                        Text="Cancel" />
                  </EditItemTemplate>
                  <ItemStyle Width="40px" HorizontalAlign="Center" />
                  <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
                      ImageUrl="~/imgRGen/button_edit.gif" />&nbsp;<asp:ImageButton ID="ImageButton2" runat="server"
                        CausesValidation="False" CommandName="Delete" ImageUrl="~/imgRGen/deleteItem.gif"
                        OnClientClick="return confirm('¿Confirma la Eliminación de este tipo de Siniestro?');" />
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <RowStyle CssClass="ItemStyle" />
              <HeaderStyle CssClass="HeaderStyle" />
              <EmptyDataTemplate>
                <div class="DataTable" style="padding: 5px; width: 640px; color: #541c01;">
                  <h4 style="margin-bottom: 3px;">
                    No se han encontrado resultados
                  </h4>
                  <p style="margin: 2px;">
                    No ha sido posible encontrar resultados para mostrar con los criterios proporcionados,
                    intente cambiando los criterios empleados.
                  </p>
                </div>
              </EmptyDataTemplate>
            </asp:GridView>
            &nbsp;
          </div>
        </div>
        <div class="DataBottom">
          <div class="DataBottomLeft">
          </div>
          <div class="DataBottomRight">
          </div>
        </div>
        <div id="nuevoTipoDiv">
          &nbsp;</div>
      </div>
    </div>
    <asp:SqlDataSource ID="sdsTipoSiniestro" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      DeleteCommand="sp_rgen_TipoSiniestroDelete" DeleteCommandType="StoredProcedure"
      InsertCommand="sp_rgen_TipoSiniestroInsert" InsertCommandType="StoredProcedure"
      SelectCommand="sp_rgen_TipoSiniestroSelectAllByFilters" SelectCommandType="StoredProcedure"
      UpdateCommand="sp_rgen_TipoSiniestroUpdate" UpdateCommandType="StoredProcedure"
      OnInserted="sdsTipoSiniestro_Inserted">
      <DeleteParameters>
        <asp:Parameter Name="tipoSiniestroId" Type="Decimal" />
      </DeleteParameters>
      <UpdateParameters>
        <asp:Parameter Name="tipoSiniestroId" Type="Decimal" />
        <asp:Parameter Name="tipoSiniestro" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
        <asp:Parameter Name="ramoId" Type="Decimal" />
        <asp:Parameter Name="uupdate" Type="String" />
      </UpdateParameters>
      <InsertParameters>
        <asp:Parameter Name="tipoSiniestro" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
        <asp:Parameter Name="ucrea" Type="String" />
        <asp:Parameter Name="ramoid" Type="Decimal" />
      </InsertParameters>
      <SelectParameters>
        <asp:ControlParameter ControlID="txtTipoSiniestro" Name="tiposiniestro" PropertyName="Text"
          Type="String" DefaultValue="(mark:empty)" />
        <asp:ControlParameter ControlID="rbtnGroupEstado" Name="estado" PropertyName="SelectedValue"
          Type="String" />
        <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
          Type="Decimal" />
      </SelectParameters>
    </asp:SqlDataSource>
  </form>
</body>
</html>
