<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vListaCoberturas.aspx.cs"
  Inherits="Mantenimientos_vListaCoberturas" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <title>Mantenimiento de Coberturas</title>

  <script type="text/javascript" src="../Scripts/functions.js">
  </script>

  <link href="../Css/layout.css" rel="stylesheet" type="text/css" />

  <script type='text/javascript' src="../Scripts/lib/x_core.js"></script>

  <script type='text/javascript' src='../Scripts/lib/x_dom.js'></script>

  <script type="text/javascript" src="../Scripts/lib/x_event.js"></script>

  <script type="text/javascript" src="../Scripts/lib/CollapsibleDiv.js"></script>

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
    
  </script>

</head>
<body>
  <form id="form1" runat="server">
    <div style="width: 630px; overflow: auto; position: relative; height: 460px;">
      <div style="width: 605px; position: relative;">
        <div class="DataTop">
          <div class="DataTopLeft">
          </div>
          <div class="DataTopRight">
          </div>
        </div>
        <div class="DataContent">
          <div class="DataContentRight" style="padding:1%; left: 0px; top: 0px;">
            <div class="PanelEncabezado">
              <asp:Label ID="lblCobertura" runat="server" Font-Size="18px" Font-Bold="True" ForeColor="White">Cobertura</asp:Label>
              <img id="btnNewItem" alt="Ver Filtros" class="btnCollapse" src="../imgRGen/openCloseCollapse.jpg"
                style="right: 15px; top: 2px" title="Ver Filtros" /><div>
                  <div id="pnlMensajeConfirmacion" style="float: left; width: auto; margin-left: 50px;"
                    runat="server" class="panelMensaje" visible="false">
                    <div class="icoIdea">
                    </div>
                    <asp:Label ID="lblMensaje" runat="server" Text="La Cobertura ha sido registrada satisfactoriamente"></asp:Label>
                  </div>
                </div>
            </div>
            <div class="hr">
            </div>
            <div id="pnlNewItem" style="display: none;" runat="server" class="DataTable">
              <div style="padding: 5px;">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="riesgoId" DataSourceID="odsCoberturaFRM"
                  DefaultMode="Insert" OnItemInserting="FormView1_ItemInserting" Width="540px" CellPadding="0"
                  OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated" OnItemUpdating="FormView1_ItemUpdating"
                  OnDataBound="FormView1_DataBound">
                  <EditItemTemplate>
                    &nbsp;<table border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="width: 150px; padding-top: 2px" valign="top">
                          Cobertura</td>
                        <td>
                          <asp:TextBox ID="txtCobertura" runat="server" CssClass="FormText" Text='<%# Bind("nombre") %>'
                            Width="350px" Height="35px" TextMode="MultiLine"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td style="padding-top: 2px" valign="top">
                          Descripción</td>
                        <td>
                          <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Height="50px"
                            Text='<%# Bind("descripcion") %>' TextMode="MultiLine" Width="350px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          Ramo<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="DropDownList1"
                            ErrorMessage="Elija un Módulo" Operator="NotEqual" ValidationGroup="vldGrpInsert"
                            ValueToCompare="-1">(*)</asp:CompareValidator></td>
                        <td>
                          <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" CssClass="FormText"
                            DataSourceID="sdsRamoCombo" DataTextField="nombre" DataValueField="ramoId" Width="200px"
                            SelectedValue='<%# Bind("ramoid") %>'>
                            <asp:ListItem Value="-1">[ Elija ]</asp:ListItem>
                          </asp:DropDownList><asp:SqlDataSource ID="sdsRamoCombo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                            SelectCommand="sp_rgen_RamoCombo" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          &nbsp;</td>
                        <td>
                        </td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                          <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/IconSave24.gif"
                            CommandName="Update" ValidationGroup="vldGrpInsert" />
                          &nbsp;
                          <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/imgRGen/btnExitForm.jpg"
                            CommandName="Update" ValidationGroup="vldGrpInsert" OnClick="ImageButton3_Click" /></td>
                      </tr>
                    </table>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                    &nbsp;<table border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td style="width: 150px; padding-top: 2px" valign="top">
                          Cobertura</td>
                        <td>
                          <asp:TextBox ID="txtCobertura" runat="server" CssClass="FormText" Height="35px" Text='<%# Bind("nombre") %>'
                            TextMode="MultiLine" Width="350px"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td style="padding-top: 2px" valign="top">
                          Descripción</td>
                        <td>
                          <asp:TextBox ID="txtDescripcion" runat="server" CssClass="FormText" Text='<%# Bind("descripcion") %>'
                            Width="350px" Height="50px" TextMode="MultiLine"></asp:TextBox></td>
                      </tr>
                      <tr>
                        <td>
                          Ramo<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="DropDownList1"
                            ErrorMessage="Elija un Módulo" Operator="NotEqual" ValidationGroup="vldGrpInsert"
                            ValueToCompare="-1">(*)</asp:CompareValidator></td>
                        <td>
                          <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" CssClass="FormText"
                            DataSourceID="sdsRamoCombo" DataTextField="nombre" DataValueField="ramoId" Width="200px"
                            SelectedValue='<%# Bind("ramoid") %>'>
                            <asp:ListItem Value="-1">[ Elija ]</asp:ListItem>
                          </asp:DropDownList>
                          <asp:SqlDataSource ID="sdsRamoCombo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                            SelectCommand="sp_rgen_RamoCombo" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          &nbsp;</td>
                        <td>
                        </td>
                      </tr>
                      <tr>
                        <td>
                        </td>
                        <td>
                          <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/IconSave24.gif"
                            CommandName="Insert" ValidationGroup="vldGrpInsert" />
                        </td>
                      </tr>
                    </table>
                  </InsertItemTemplate>
                </asp:FormView>
              </div>
            </div>
            <br />
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
          <div class="DataContentRight" style="padding:1%; left: 0px; top: 0px;">
            <div class="PanelEncabezado">
              <asp:Label ID="lblListaTitulo" runat="server" Font-Size="18px" Font-Bold="True" ForeColor="White">Lista de Coberturas</asp:Label>
              <img id="btnShowFilters" src="../imgRGen/openCloseCollapse.jpg" alt="Ver Filtros"
                title="Ver Filtros" class="btnCollapse" style="right: 15px; top: 2px" /></div>
            <div class="hr">
            </div>
            <div class="DataTable" runat="server" id="pnlFilters" style="padding: 5px;">
              <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td style="width: 150px; padding-top: 2px" valign="top">
                    Cobertura</td>
                  <td>
                    <asp:TextBox ID="txtCobertura" runat="server" CssClass="FormText" Width="288px"></asp:TextBox></td>
                </tr>
                <tr>
                  <td style="padding-top: 2px" valign="top">
                    Ramo</td>
                  <td>
                    <asp:DropDownList ID="cbxRamo" runat="server" AppendDataBoundItems="True" CssClass="FormText"
                      DataSourceID="sdsRamoCombo" DataTextField="nombre" DataValueField="ramoId" Width="291px">
                      <asp:ListItem Value="-1">[ Todos ]</asp:ListItem>
                    </asp:DropDownList></td>
                </tr>
                <tr>
                  <td>
                    Estado</td>
                  <td>
                    <asp:RadioButtonList ID="rbtnGroupEstado" runat="server" CellPadding="0" CellSpacing="0"
                      RepeatDirection="Horizontal">
                      <asp:ListItem Value="T" Selected="True">Todos</asp:ListItem>
                      <asp:ListItem Value="A">Activo</asp:ListItem>
                      <asp:ListItem Value="I">Inactivo</asp:ListItem>
                    </asp:RadioButtonList></td>
                </tr>
                <tr>
                  <td style="height: 13px">
                    &nbsp;</td>
                  <td style="height: 13px">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/imgRGen/btnBuscar24.jpg"
                      OnClick="ImageButton1_Click" /></td>
                </tr>
                <tr>
                  <td>
                  </td>
                  <td>
                  </td>
                </tr>
              </table>
            </div>
            <br />
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
              CellPadding="0" CssClass="DataTable" DataKeyNames="riesgoId" Width="585px" Style="left: 0px;
              top: 0px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
              <Columns>
                <asp:BoundField DataField="riesgoId" HeaderText="riesgoId" InsertVisible="False"
                  ReadOnly="True" SortExpression="riesgoId">
                  <ItemStyle CssClass="invisible" />
                  <HeaderStyle CssClass="invisible" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Cobertura" SortExpression="nombre">
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="FormText" Text='<%# Bind("funcionalidad") %>'
                      Width="100%"></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("nombre") %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Descripci&#243;n" SortExpression="descripcion">
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" CssClass="FormText" Text='<%# Bind("codigo") %>'
                      Width="100%"></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("descripcion") %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Estado" InsertVisible="False" SortExpression="estado">
                  <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# getEstado((String)Eval("estado")) %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                  <ItemStyle Width="42px" />
                  <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit"
                      OnClientClick='<%# setUrl((decimal) Eval("riesgoId")) %>' ImageUrl="~/images/btnsListas/icon_edit.jpg" />&nbsp;<asp:ImageButton
                        ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Delete"
                        ImageUrl='<%# setImage((String) Eval("estado")) %>' OnClientClick='<%#setClientClick((String) Eval("estado")) %>' />
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <RowStyle CssClass="ItemStyle" />
              <HeaderStyle CssClass="HeaderStyle" />
              <EmptyDataTemplate>
                <div class="EmptyResult">
                  <table id="Table1" border="1" cellpadding="0" cellspacing="0" class="DataTable" style="width: 634px;
                    border-collapse: collapse">
                    <tr class="HeaderStyle">
                      <th class="invisible" scope="col">
                        <a href="">riesgoId</a></th>
                      <th scope="col">
                        <a href="">Cobertura</a></th>
                      <th scope="col">
                        <a href="">Descripción</a></th>
                      <th scope="col">
                        <a href="">Estado</a></th>
                      <th scope="col" style="color: #0000ff; text-decoration: underline">
                        &nbsp;</th>
                    </tr>
                    <tr class="ItemStyle">
                      <td class="invisible">
                        --</td>
                      <td>
                        --
                      </td>
                      <td>
                        --</td>
                      <td>
                        --
                      </td>
                      <td style="width: 42px">
                        &nbsp;</td>
                    </tr>
                  </table>
                </div>
              </EmptyDataTemplate>
            </asp:GridView>
            <br />
          </div>
        </div>
        <div class="DataBottom">
          <div class="DataBottomLeft">
          </div>
          <div class="DataBottomRight">
          </div>
        </div>
      </div>
    </div>
    <asp:ObjectDataSource ID="odsCoberturaLista" runat="server" DeleteMethod="Delete"
      SelectMethod="GetData" TypeName="dsMantenimientosTableAdapters.CoberturaListaTableAdapter"
      OnSelected="odsCoberturaLista_Selected">
      <DeleteParameters>
        <asp:Parameter Name="riesgoId" Type="Decimal" />
      </DeleteParameters>
      <SelectParameters>
        <asp:ControlParameter ControlID="txtCobertura" Name="cobertura" PropertyName="Text"
          Type="String" />
        <asp:ControlParameter ControlID="rbtnGroupEstado" Name="estado" PropertyName="SelectedValue"
          Type="String" />
        <asp:ControlParameter ControlID="cbxRamo" Name="ramoId" PropertyName="SelectedValue"
          Type="Decimal" />
      </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCoberturaFRM" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
      SelectMethod="GetData" TypeName="dsMantenimientosTableAdapters.CoberturaFRMTableAdapter"
      UpdateMethod="Update" OnInserted="odsCoberturaFRM_Inserted">
      <DeleteParameters>
        <asp:Parameter Name="riesgoId" Type="Decimal" />
      </DeleteParameters>
      <UpdateParameters>
        <asp:Parameter Name="riesgoId" Type="Decimal" />
        <asp:Parameter Name="nombre" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
        <asp:Parameter Name="ramoid" Type="Decimal" />
        <asp:Parameter Name="uupdate" Type="String" />
      </UpdateParameters>
      <SelectParameters>
        <asp:QueryStringParameter Name="riesgoId" QueryStringField="RiesgoId" Type="Decimal" />
      </SelectParameters>
      <InsertParameters>
        <asp:Parameter Direction="InputOutput" Name="riesgoId" Type="Object" />
        <asp:Parameter Name="nombre" Type="String" />
        <asp:Parameter Name="descripcion" Type="String" />
        <asp:Parameter Name="ramoId" Type="Decimal" />
        <asp:Parameter Name="ucrea" Type="String" />
      </InsertParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sdsRamoCombo" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
      SelectCommand="sp_rgen_RamoCombo" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
  </form>
</body>
</html>
