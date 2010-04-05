<%@ Page Language="C#" MasterPageFile="~/RimacInforme/RimacFormsMaster.master" AutoEventWireup="true"
  CodeFile="Coberturas.aspx.cs" Inherits="RimacInforme_Coberturas" Title="Coberturas Aplicables" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <style type="text/css">
    .Coberturas .FormText
    {
      width: 400px;
    }
    .Coberturas .FormText.SumaAsegurada
    {
      width: 240px;
    }
    .Coberturas .FormSelect.Moneda
    {
      width: 56px;
    }
    .List
    {
      padding: 5px;
    }
    .List table td, .List table th
    {
      border-collapse: collapse;
      padding: 4px;
    }
    .List table
    {
      width: 100%;
    }
    .List table .header td, .List table .header th
    {
      background: #1b598a;
      color: #fff;
      font-weight: bold;
      border: 1px solid #1b598a;
    }
    .List table .row td
    {
      background: #fff;
      color: #000;
    }
    .List table .alternateRow td
    {
      background: #eee;
      color: #000;
    }
    .CurrencyColumn
    {
      text-align: right;
    }
    .ActionsColumn
    {
      text-align: center;
    }
    .ActionsColumn a.LinkButton
    {
      float: none;
      display: inline-block;
      width: 100px;
      margin: 0 auto;
    }
    .ActionsColumn a.LinkButton span
    {
    }
    a.LinkButton.Volver
    {
      position: absolute;
      right: 2px;
      top: 7px;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  <script type="text/javascript">
    $(function() {
        $(document).initValidation();
        
        $('a.LinkButton.Delete').click(function(){
            if (confirm('¿Realmente quiere borrar esta cobertura?')) {
              return true;
            }
            return false;
        });   
    });
    
  </script>

  <div class="ListEditor">
    <div class="Editor">
      <div class="FormCSS Coberturas">
        <div class="Legend">
          <h2>
            Coberturas y Sumas Aseguradas</h2>
          <%--<a id="volverLink" href="#" runat="server" class="LinkButton Right Volver"><span>Volver</span></a>--%>
          <asp:HyperLink ID="volverLink" CssClass="LinkButton Right Volver" runat="server"><span>Volver</span></asp:HyperLink>
        </div>
        <asp:FormView ID="FormViewCoberturasAplicables" Width="100%" DataKeyNames="IdRamo"
          runat="server" DataSourceID="odsCoberturasAplicablesFormView" DefaultMode="Insert"
          OnItemDeleted="FormViewCoberturasAplicables_Delete" OnDataBound="FormViewCoberturasAplicables_DataBound"
          OnItemInserting="FormViewCoberturasAplicables_ItemInserting" OnItemInserted="FormViewCoberturasAplicables_ItemInserted"
          OnItemUpdating="FormViewCoberturasAplicables_ItemUpdating" OnItemUpdated="FormViewCoberturasAplicables_ItemUpdated">
          <EditItemTemplate>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  Cobertura Aplicable (Ramo)</label>
                <asp:TextBox ID="TextBox1" CssClass="FormText CoberturaRamo" TextMode="MultiLine"
                  Rows="3" runat="server" Text='<%# Bind("RamoCobertura") %>'></asp:TextBox>
                <p class="Validator Required CoberturasSave" field=".CoberturaRamo">
                  Requerido</p>
                <div class="clear">
                </div>
              </div>
              <div class="Field">
                <label>
                  Suma Asegurada</label>
                <div class="FieldWrapper">
                  <asp:HiddenField ID="ddlMonedaHdn" Value='<%# Eval("MonedaSumaAsegurada") %>' runat="server" />
                  <asp:DropDownList ID="ddlMoneda" CssClass="FormSelect Moneda" runat="server">
                    <asp:ListItem Text="Elija" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="S/." Value="S/."></asp:ListItem>
                    <asp:ListItem Text="US$" Value="US$"></asp:ListItem>
                  </asp:DropDownList>
                  <asp:TextBox ID="TextBox2" CssClass="FormText SumaAsegurada" Text='<%# Bind("SumaAsegurada") %>'
                    runat="server"></asp:TextBox>
                  <p class="Validator RegularExpression CoberturasSave" field=".SumaAsegurada" regex="^\d+(\.\d{1,2})?$">
                    Solo números de la forma ##.##</p>
                  <p class="Validator Compare CoberturasSave" field=".Moneda" compare_value="-1" comparison_type="NotEqual">
                    Elija una moneda por favor</p>
                </div>
                <div class="clear">
                </div>
              </div>
              <div class="Toolbar">
                <asp:LinkButton CommandName="Update" CssClass="LinkButton Save ValidatorTrigger"
                  validation_group=".CoberturasSave" ID="LinkButtonSave" runat="server"> <span>Guardar</span></asp:LinkButton>
                <asp:LinkButton CommandName="Cancel" CssClass="LinkButton Cancel" ID="LinkButtonCancel"
                  runat="server"> <span>Cancelar</span></asp:LinkButton>
                <asp:LinkButton CommandName="Delete" CssClass="LinkButton Delete" ID="LinkButtonDelete"
                  runat="server"> <span>Borrar</span></asp:LinkButton>
                <div class="doClear">
                </div>
              </div>
            </div>
          </EditItemTemplate>
          <InsertItemTemplate>
            <div class="Group-Content">
              <div class="Field First">
                <label>
                  Cobertura Aplicable (Ramo)</label>
                <asp:TextBox ID="TextBox1" CssClass="FormText CoberturaRamo" TextMode="MultiLine"
                  Rows="3" runat="server" Text='<%# Bind("RamoCobertura") %>'></asp:TextBox>
                <p class="Validator Required CoberturasSave" field=".CoberturaRamo">
                  Requerido</p>
                <div class="clear">
                </div>
              </div>
              <div class="Field">
                <label>
                  Suma Asegurada</label>
                <div class="FieldWrapper">
                  <asp:DropDownList ID="ddlMoneda" CssClass="FormSelect Moneda" runat="server">
                    <asp:ListItem Text="Elija" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="S/." Value="S/."></asp:ListItem>
                    <asp:ListItem Text="US$" Value="US$"></asp:ListItem>
                  </asp:DropDownList>
                  <asp:TextBox ID="TextBox2" CssClass="FormText SumaAsegurada" Text='<%# Bind("SumaAsegurada") %>'
                    runat="server"></asp:TextBox>
                  <p class="Validator RegularExpression CoberturasSave" field=".SumaAsegurada" regex="^\d+(\.\d{1,2})?$">
                    Solo números de la forma ##.##</p>
                  <p class="Validator Compare CoberturasSave" field=".Moneda" compare_value="-1" comparison_type="NotEqual">
                    Elija una moneda por favor</p>
                </div>
                <div class="clear">
                </div>
              </div>
              <div class="Toolbar">
                <asp:LinkButton CommandName="Insert" CssClass="LinkButton Save ValidatorTrigger"
                  validation_group=".CoberturasSave" ID="LinkButtonSave" runat="server"> <span>Guardar</span></asp:LinkButton>
                <div class="doClear">
                </div>
              </div>
            </div>
          </InsertItemTemplate>
        </asp:FormView>
      </div>
    </div>
    <div id="message" visible="false" runat="server" class="Message">
    </div>
    <div class="List">
      <asp:GridView RowStyle-CssClass="row" ID="GridViewCoberturas" runat="server" AutoGenerateColumns="False"
        DataSourceID="odsCoberturasAplicablesGridview">
        <RowStyle CssClass="row"></RowStyle>
        <Columns>
          <asp:TemplateField HeaderText="Cobertura / Ramo" SortExpression="RamoCobertura">
            <ItemTemplate>
              <asp:Label ID="Label1" runat="server" Text='<%# Bind("RamoCobertura") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField ItemStyle-Width="240px" SortExpression="SumaAsegurada">
            <HeaderTemplate>
              <div class="CurrencyColumn">
                <span>Suma Asegurada</span></div>
            </HeaderTemplate>
            <ItemTemplate>
              <div class="CurrencyColumn">
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("MonedaSumaAsegurada") %>'></asp:Label>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("SumaAsegurada") %>'></asp:Label>
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField ItemStyle-Width="140px">
            <HeaderTemplate>
              <div class="ActionsColumn">
                <span>Acciones</span></div>
            </HeaderTemplate>
            <ItemTemplate>
              <div class="ActionsColumn">
                <a class="LinkButton" href='?action=Editar&IdAjuste=<%= Request.QueryString["IdAjuste"] %>&IdRamo=<%# Eval("IdRamo") %>'>
                  <span>Editar</span></a>
              </div>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="header"></HeaderStyle>
        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
      </asp:GridView>
    </div>
  </div>
  <asp:ObjectDataSource ID="odsCoberturasAplicablesGridview" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="DataSet1TableAdapters.RGN_COBERTURASAPLICABLESTableAdapter">
    <SelectParameters>
      <asp:QueryStringParameter Name="IdAjuste" QueryStringField="IdAjuste" Type="Decimal" />
    </SelectParameters>
  </asp:ObjectDataSource>
  <asp:ObjectDataSource ID="odsCoberturasAplicablesFormView" runat="server" DeleteMethod="Delete"
    InsertMethod="Insert" OldValuesParameterFormatString="{0}" SelectMethod="GetDataBySingle"
    TypeName="DataSet1TableAdapters.RGN_COBERTURASAPLICABLESTableAdapter" UpdateMethod="Update">
    <DeleteParameters>
      <asp:Parameter Name="IdRamo" Type="Decimal" />
    </DeleteParameters>
    <UpdateParameters>
      <asp:Parameter Name="RamoCobertura" Type="String" />
      <asp:Parameter Name="Estado" Type="Boolean" />
      <asp:Parameter Name="SumaAsegurada" Type="Decimal" />
      <asp:Parameter Name="MonedaSumaAsegurada" Type="String" />
      <asp:Parameter Name="IdAjuste" Type="Decimal" />
      <asp:Parameter Name="IdRamo" Type="Decimal" />
    </UpdateParameters>
    <SelectParameters>
      <asp:QueryStringParameter Name="IdRamo" QueryStringField="IdRamo" Type="Decimal" />
    </SelectParameters>
    <InsertParameters>
      <asp:Parameter Name="RamoCobertura" Type="String" />
      <asp:Parameter Name="Estado" Type="Boolean" />
      <asp:Parameter Name="SumaAsegurada" Type="Decimal" />
      <asp:Parameter Name="MonedaSumaAsegurada" Type="String" />
      <asp:Parameter Name="IdAjuste" Type="Decimal" />
    </InsertParameters>
  </asp:ObjectDataSource>
</asp:Content>
