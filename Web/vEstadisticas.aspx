<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vEstadisticas.aspx.cs" Inherits="vEstadisticas" %>

<%@ Register Src="ucHeader.ascx" TagName="ucHeader" TagPrefix="uc1" %>
<%@ Register Assembly="dotnetCHARTING" Namespace="dotnetCHARTING" TagPrefix="dotnetCHARTING" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Estadísticas y Reportes</title>

    <link href="css/layout.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; width: 880px; position: relative;">
            <uc1:ucHeader ID="UcHeader1" runat="server" TabActual="estadisticas" />
            <br />
            <div class="DataTop">
                <div class="DataTopLeft">
                </div>
                <div class="DataTopRight">
                </div>
            </div>
            <div class="DataContent">
                <div class="DataContentRight" style="position:relative;" runat="server" id="contenedorPrincipal">
                    <div style="height: 84px; position:relative;">
                        <p id="lblNumAjuste" style="margin: 0px; font-family: verdana arial; font-size: 18px;
                            font-weight: bold;">
                            Estadísticas
                            <asp:ImageButton ID="ibtnExportar" runat="server" ImageUrl="~/imgRGen/btnExportar.jpg"
                                OnClick="lnkExport_Click" Style="z-index: 103; left: 741px; position: absolute;
                                top: 32px" TabIndex="17" />
                        </p>
                         <div class="hr">
                    </div>
                        <div style="left: 533px; width: 319px; position: absolute; top: 6px; height: 25px;
                            text-align: right; z-index: 101;">
                            &nbsp;</div>
                        <div style="position: relative; width: 856px; height: 26px; left: 3px; top: 3px; z-index: 102;">
                            <table border="0" cellpadding="0" cellspacing="0" style="width: 853px; left: 0px;
                                top: 0px;">
                                <tr>
                                    <td style="width: 6px; height: 13px;">                                    </td>
                                    <td style="width: 54px; height: 13px;">                                    </td>
                                    <td style="width: 171px; height: 13px">                                    </td>
                                    <td style="width: 9px; height: 13px">                                    </td>
                                    <td style="width: 66px; height: 13px">                                    </td>
                                    <td style="width: 108px; height: 13px">                                    </td>
                                    <td style="width: 4px; height: 13px">                                    </td>
                                    <td style="width: 38px; height: 13px">                                    </td>
                                    <td style="width: 251px; height: 13px">                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 6px; height: 18px;">                                    </td>
                                    <td style="width: 54px; height: 18px; color: #ffffff;">
                                        <strong>Criterio</strong></td>
                                    <td style="width: 171px; height: 18px; color: #ffffff;">
                                        <asp:DropDownList ID="cbxCriterio" runat="server" CssClass="FormText" Width="200px"
                                            AutoPostBack="True" OnSelectedIndexChanged="CbxChangedIndex">
                                            <asp:ListItem Value="SINIESTRO">Por Tipo de Siniestro</asp:ListItem>
                                            <asp:ListItem Value="RAMO" Selected="True">Por Ramo</asp:ListItem>
                                            <asp:ListItem Value="COBERTURA">Por Cobertura</asp:ListItem>
                                            <asp:ListItem Value="PRODUCTO">Por Producto</asp:ListItem>
                                            <asp:ListItem Value="BROKER">Por Broker</asp:ListItem>
                                            <asp:ListItem Value="AJUSTADOR">Por Ajustador</asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td style="width: 9px; height: 18px; color: #ffffff;">                                    </td>
                                    <td style="width: 66px; color: #ffffff; height: 18px">
                                        <strong>Operación</strong></td>
                                    <td style="width: 108px; height: 18px; color: #ffffff;">
                                        <asp:DropDownList ID="cbxOperacion" runat="server" CssClass="FormText" OnSelectedIndexChanged="CbxChangedIndex"
                                            Width="136px" AutoPostBack="True">
                                            <asp:ListItem Value="SUM">Suma</asp:ListItem>
                                            <asp:ListItem Value="AVG">Promedio</asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td style="width: 4px; color: #ffffff; height: 18px; text-align: center">                                    </td>
                                    <td style="width: 38px; height: 18px; color: #ffffff; text-align: left;">
                                        <strong>Año</strong></td>
                                  <td style="width: 251px; height: 18px; color: #ffffff;"><asp:DropDownList ID="cbxAnho" runat="server" CssClass="FormText" Width="104px" AutoPostBack="True"
                                            OnSelectedIndexChanged="CbxChangedIndex">
                                    <asp:ListItem Value="1981">1981</asp:ListItem>
                                    <asp:ListItem Value="1982">1982</asp:ListItem>
                                    <asp:ListItem Value="1983">1983</asp:ListItem>
                                    <asp:ListItem Value="1984">1984</asp:ListItem>
                                    <asp:ListItem Value="1985">1985</asp:ListItem>
                                    <asp:ListItem Value="1986">1986</asp:ListItem>
                                    <asp:ListItem Value="1987">1987</asp:ListItem>
                                    <asp:ListItem Value="1988">1988</asp:ListItem>
                                    <asp:ListItem Value="1989">1989</asp:ListItem>
                                    <asp:ListItem Value="1990">1990</asp:ListItem>
                                    <asp:ListItem Value="1991">1991</asp:ListItem>
                                    <asp:ListItem Value="1992">1992</asp:ListItem>
                                    <asp:ListItem Value="1993">1993</asp:ListItem>
                                    <asp:ListItem Value="1994">1994</asp:ListItem>
                                    <asp:ListItem Value="1995">1995</asp:ListItem>
                                    <asp:ListItem Value="1996">1996</asp:ListItem>
                                    <asp:ListItem Value="1997">1997</asp:ListItem>
                                    <asp:ListItem Value="1998">1998</asp:ListItem>
                                    <asp:ListItem Value="1999">1999</asp:ListItem>
                                    <asp:ListItem Value="2000">2000</asp:ListItem>
                                    <asp:ListItem Value="2001">2001</asp:ListItem>
                                    <asp:ListItem Value="2002">2002</asp:ListItem>
                                    <asp:ListItem Value="2003">2003</asp:ListItem>
                                    <asp:ListItem Value="2004">2004</asp:ListItem>
                                    <asp:ListItem Selected="True" Value="2005">2005</asp:ListItem>
                                    <asp:ListItem Value="2006">2006</asp:ListItem>
                                    <asp:ListItem Value="2007">2007</asp:ListItem>
                                    <asp:ListItem Value="2008">2008</asp:ListItem>
                                    <asp:ListItem Value="2009">2009</asp:ListItem>
                                    <asp:ListItem Value="2010">2010</asp:ListItem>
                                    <asp:ListItem Value="2011">2011</asp:ListItem>
                                    <asp:ListItem Value="2012">2012</asp:ListItem>
                                    <asp:ListItem Value="2013">2013</asp:ListItem>
                                    <asp:ListItem Value="2014">2014</asp:ListItem>
                                    <asp:ListItem Value="2015">2015</asp:ListItem>
                                    <asp:ListItem Value="2016">2016</asp:ListItem>
                                    <asp:ListItem Value="2017">2017</asp:ListItem>
                                    <asp:ListItem Value="2018">2018</asp:ListItem>
                                    <asp:ListItem Value="2019">2019</asp:ListItem>
                                    <asp:ListItem Value="2020">2020</asp:ListItem>
                                  </asp:DropDownList>
                                      &nbsp;
                                  </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                   
                    <div style="left: 8px; height:505px; width:99%;  background-color:#d6dae1;position:relative; top: 0px;">
                        <dotnetCHARTING:Chart ID="Chart1" runat="server" Height="500px" Width="580px"  style="position:relative; left:5px;top:5px;" MarginTop="0" PrinterOptimizedText="True" OnPreRender="Chart1_PreRender">
                            <TitleBox Position="Left">
                                <Label Color="Black">
                                </Label>
                            </TitleBox>
                            <DefaultLegendBox CornerBottomRight="Round" Padding="4" Visible="true" CornerTopRight="Round"
                                DefaultCorner="Round" CornerTopLeft="Round" CornerBottomLeft="Round" Template="%YValue %Icon %Name">
                                <HeaderEntry Value="Value" Visible="False" Name="Name" SortOrder="-1">
                                    <LabelStyle Font="Arial, 8pt, style=Bold"></LabelStyle>
                                    <DividerLine Color="Gray"></DividerLine>
                                </HeaderEntry>
                            </DefaultLegendBox>                                                                                                                                                                              
                        </dotnetCHARTING:Chart>                       
                    </div>
                </div>
                <div style="position: absolute; left: 605px; top: 203px; padding-right: 3px; padding-left: 3px; padding-bottom: 3px; overflow: scroll; width: 252px; padding-top: 3px; height: 492px; background-color: lightgrey; text-align: center;">
                    <div>                      
                        <asp:Label ID="lblEstadisticas" runat="server" Font-Bold="True" Font-Names="Arial"
                            Font-Size="15px" ForeColor="#506A9A"></asp:Label><br />
                        <asp:GridView ID="gvDatos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                            Width="233px" AllowPaging="True" PageSize="8" BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px" CellPadding="0" CssClass="DataTableEstadisticas">
                            <Columns>
                                <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" SortExpression="descripcion">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="cantidad" HeaderText="Cantidad" SortExpression="cantidad" DataFormatString="{0:#,###.##}">
                                    <ItemStyle HorizontalAlign="Right" Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="porcentajecant" HeaderText="%" SortExpression="porcentajecant">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle Font-Bold="True" />
                                </asp:BoundField>
                            </Columns>
                            <RowStyle CssClass="ItemStyle_white" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <EmptyDataTemplate>
                                no hay datos
                            </EmptyDataTemplate>
                        </asp:GridView>
                        &nbsp;
                        <asp:GridView ID="gvReserva" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                            Width="234px" AllowPaging="True" PageSize="8" CssClass="DataTableEstadisticas">
                            <Columns>
                                <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" SortExpression="descripcion">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="reserva" HeaderText="Reserva Neta" SortExpression="reserva" DataFormatString="{0:#,###.##}" HtmlEncode="False">
                                    <ItemStyle HorizontalAlign="Right" Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="porcentajereserva" HeaderText="%" SortExpression="porcentajereserva">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                            </Columns>
                            <RowStyle CssClass="ItemStyle_white" />
                            <HeaderStyle CssClass="HeaderStyle" />
                        </asp:GridView>
                    </div>
                    &nbsp;
                </div>				
            </div>
            <div class="DataBottom">
                <div class="DataBottomLeft">
                </div>
                <div class="DataBottomRight">
                </div>
            </div>         
            <asp:Repeater ID="rpt_cantidad" runat="server" DataSourceID="SqlDataSource1" DataMember="DefaultView" Visible="false">
            <HeaderTemplate>   
                   
                 <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                    <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                    <TD class=3Dxl6515243>Por Cantidad</TD>
                    <TD class=3Dxl6815243></TD>
                    <TD class=3Dxl1515243></TD>
                    <TD class=3Dxl1515243></TD>
                    <TD class=3Dxl1515243></TD>
                    <TD class=3Dxl1515243></TD>
                 </TR>
                  <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                    <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                    <TD class=3Dxl7115243 style=3D"BORDER-RIGHT: black 0.5pt solid; =
                WIDTH: 154pt"=20
                    width=3D204 colSpan=3D2>Descripci=F3n</TD>
                    <TD class=3Dxl7115243=20
                    style=3D"BORDER-RIGHT: black 0.5pt solid; BORDER-LEFT: medium none; =
                WIDTH: 154pt"=20
                    width=3D204 colSpan=3D2>Cantidad</TD>
                    <TD class=3Dxl7115243=20
                    style=3D"BORDER-RIGHT: black 0.5pt solid; BORDER-LEFT: medium none; =
                WIDTH: 154pt"=20
                    width=3D204 colSpan=3D2>%</TD></TR>
                    
            </HeaderTemplate>
            <ItemTemplate>
              <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                <TD class=3Dxl7615243 style=3D"WIDTH: 154pt" width=3D204=20
                colSpan=3D2><%# DataBinder.Eval(Container.DataItem, "descripcion")%></TD>
                <TD class=3Dxl7615243 style=3D"BORDER-LEFT: medium none; WIDTH: =
            154pt" width=3D204=20 
            colSpan=3D2><%# DataBinder.Eval(Container.DataItem, "cantidad") %></TD>
                <TD class=3Dxl7615243 style=3D"BORDER-LEFT: medium none; WIDTH: =
            154pt" width=3D204=20
                colSpan=3D2><%# DataBinder.Eval(Container.DataItem, "porcentajecant") %></TD></TR>            
            </ItemTemplate>
            <FooterTemplate>
                  <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                    <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD></TR>
            </FooterTemplate>
            </asp:Repeater>
            <asp:Repeater ID="rpt_reserva" runat="server" DataSourceID="SqlDataSource1" DataMember="DefaultView" Visible="false">
            <HeaderTemplate>
            <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                    <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                    <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD></TR>
                  <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                    <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                    <TD class=3Dxl6515243>Por Reserva</TD>
                    <TD class=3Dxl1515243></TD>
                    <TD class=3Dxl1515243></TD>
                    <TD class=3Dxl1515243></TD>
                    <TD class=3Dxl1515243></TD>
                    <TD class=3Dxl1515243></TD></TR>
                  <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                    <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                    <TD class=3Dxl7115243 style=3D"BORDER-RIGHT: black 0.5pt solid; =
                WIDTH: 154pt"=20
                    width=3D204 colSpan=3D2>Descripci=F3n</TD>
                    <TD class=3Dxl7115243=20
                    style=3D"BORDER-RIGHT: black 0.5pt solid; BORDER-LEFT: medium none; =
                WIDTH: 154pt"=20
                    width=3D204 colSpan=3D2>Reserva Neta</TD>
                    <TD class=3Dxl7115243=20
                    style=3D"BORDER-RIGHT: black 0.5pt solid; BORDER-LEFT: medium none; =
                WIDTH: 154pt"=20
                    width=3D204 colSpan=3D2>%</TD></TR>
            </HeaderTemplate>
                  
            <ItemTemplate>
                 <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                    <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                    <TD class=3Dxl7615243 style=3D"WIDTH: 154pt" width=3D204=20
                    colSpan=3D2><%# DataBinder.Eval(Container.DataItem, "descripcion")%></TD>
                    <TD class=3Dxl7615243 style=3D"BORDER-LEFT: medium none; WIDTH: =
                154pt" width=3D204=20
                    colSpan=3D2><%# DataBinder.Eval(Container.DataItem, "reserva")%></TD>
                    <TD class=3Dxl7615243 style=3D"BORDER-LEFT: medium none; WIDTH: =
                154pt" width=3D204=20
                    colSpan=3D2><%# DataBinder.Eval(Container.DataItem, "porcentajereserva")%></TD></TR>            </ItemTemplate>
            <FooterTemplate>
                <TR style=3D"HEIGHT: 12.75pt" height=3D17>
                <TD class=3Dxl1515243 style=3D"HEIGHT: 12.75pt" height=3D17></TD>
                <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD>
                <TD class=3Dxl6915243 style=3D"WIDTH: 77pt" width=3D102></TD></TR>
            </FooterTemplate>
            </asp:Repeater>
        </div>
        <asp:TextBox Style="display: none;" ID="TextBox2" runat="server"></asp:TextBox>
        <asp:TextBox Style="display: none;" ID="TextBox1" runat="server"></asp:TextBox>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:rgen2ConnectionString %>"
                            SelectCommand="sp_rgen_estadistica_general" SelectCommandType="StoredProcedure"
                            OnSelecting="SqlDataSource1_Selecting" OnSelected="SqlDataSource1_Selected" ProviderName="<%$ ConnectionStrings:rgen2ConnectionString.ProviderName %>">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="cbxOperacion" Name="criterio1" PropertyName="SelectedValue"
                                    Type="String" />
                                <asp:ControlParameter ControlID="cbxCriterio" Name="criterio2" PropertyName="SelectedValue"
                                    Type="String" />
                                <asp:ControlParameter ControlID="TextBox1" Name="fini" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="TextBox2" Name="ffin" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
    </form>

</body>
</html>
