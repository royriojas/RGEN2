<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vAsociaProductos.aspx.cs"
    Inherits="Mantenimientos_vAsociaProductos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Asociación de Productos y Ramos</title>

    <script type="text/javascript" src="../Scripts/functions.js">
    </script>
    
    
    
    <link href="../Css/layout.css" rel="stylesheet" type="text/css" />

    <script type='text/javascript' src="../Scripts/lib/x_core.js"></script>

    <script type='text/javascript' src='../Scripts/lib/x_dom.js'></script>

    <script type="text/javascript" src="../Scripts/lib/x_event.js"></script>
        
    <script type="text/javascript" src="../Scripts/functions.js"></script>
    

    <script type="text/javascript" src="../Scripts/lib/CollapsibleDiv.js"></script>
    
    <script type="text/javascript">
    var checks = new Array();
    function noAllChecksUnchecked() {
        var alMenosUno = false;
        for (i = 0; i < checks.length; i++) {
            if (checks[i].checked == true) {
                 alMenosUno = true;                  
                 break;
            }
        }
        if (alMenosUno) {
            return true;
        }
        else {
            alert('No ha marcado ningun ramo, debe por lo menos marcar un ramo');
            return false;
        }
    }
    function onLoadFunction() {
        var allChecks = xGetElementsByTagName('INPUT',$('pnlGrilla'));
        var indice = 0;
        for (i = 0; i < allChecks.length; i++) {
            if (allChecks[i].type == 'checkbox') {
                checks[indice++] = allChecks[i];
            }
        }
    }
    window.onload = function() {
        onLoadFunction();
    }
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight" style="padding:1%;">
                    <div class="PanelEncabezado">
                        <asp:Label ID="lblProductoSeleccionado" runat="server" Font-Bold="True" Font-Size="18px">Productos</asp:Label>
                        <asp:HyperLink ID="lnkSeparar" runat="server" ImageUrl="~/imgRGen/separar.gif" NavigateUrl="~/vBitacoras.aspx"
                            onclick="return separar();" Width="22px" CssClass="BtnSeparar"></asp:HyperLink>
                        <img runat="server" src="../imgRGen/openCloseCollapse.jpg" alt="Agregar Producto" title="Agregar Producto"
                            id="trigger_nuevoTipoDiv" />
                    </div>
                    <div class="hr">
                    </div>
                    <div class="DataTable" id="pnlGrilla">
                        <asp:GridView ID="grdRamos" runat="server" AutoGenerateColumns="False" CellPadding="2"
                            DataSourceID="sdsRamosChecks" BorderWidth="0px" GridLines="Horizontal" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="ramoId" HeaderText="ramoId" InsertVisible="False" ReadOnly="True"
                                    SortExpression="ramoId">
                                    <ItemStyle CssClass="invisible" />
                                    <HeaderStyle CssClass="invisible" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="chk" SortExpression="chk">
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chk" runat="server" Checked='<%# Bind("chk") %>' />
                                    </EditItemTemplate>
                                    <ItemStyle Width="20px" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chk" runat="server" Checked='<%# Bind("chk") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="nombre" SortExpression="nombre">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("nombre") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle Width="200px" Font-Size="11px" />
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("nombre") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="ItemStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                        </asp:GridView>
                    </div>
                    <br />
                    <asp:ImageButton ID="imgBtnSave" runat="server" ImageUrl="~/images/IconSave32.gif"
                        OnClick="imgBtnSave_Click" OnClientClick="return noAllChecksUnchecked();" /><br />
                </div>
            </div>
            <div class="DataBottom">
                <div class="DataBottomLeft">
                </div>
                <div class="DataBottomRight">
                </div>
            </div>                     
        </div>
        <asp:SqlDataSource ID="sdsRamosChecks" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
            SelectCommand="sp_rgen_ramosByProductoIdToChk" SelectCommandType="StoredProcedure"
            DeleteCommand="sp_rgen_ramoxPRoductoDelete" DeleteCommandType="StoredProcedure"
            InsertCommand="sp_rgen_ramoxProductoInsert" InsertCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="productoId" QueryStringField="ProductoId" Type="Decimal" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="productoId" Type="Decimal" />
                <asp:Parameter Name="ramoId" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="productoId" Type="Decimal" />
                <asp:Parameter Name="ramoId" Type="Decimal" />
            </InsertParameters>
        </asp:SqlDataSource>
        &nbsp;&nbsp;
    </form>
</body>
</html>
