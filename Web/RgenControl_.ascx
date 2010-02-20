<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RgenControl_.ascx.cs" Inherits="RgenControl_" %>
<script type="text/javascript">
function VerInforme(ajusteId, informeId)
{
  ShowReport('vViewPdf.aspx?AjusteId='+ ajusteId + '&InformeId=' + informeId);
}
function VerConvenio(ajusteId)
{
  ShowReport('vViewPdf.aspx?AjusteId='+ajusteId+'&TI=CA');
}
</script>

<div id="ctrl" style="position:relative;">
<div runat="server" id="news_content" style=" overflow:auto; font-size:10px;  padding:10px; z-index:30;font-family:Verdana, Arial, Helvetica, sans-serif; color:#003366; position:absolute; left: 492px; top: 14px; width: 324px; height: 99px; background-color: #FFFFCC; background-color: #FFFFCC; border: 1px none #000000;" ><div style="height:3px;border-bottom:#003366 solid 1px;"></div><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting   industry. Lorem Ipsum has been the industry's standard dummy text ever since the   1500s, when an unknown printer took a galley of type and scrambled it to make a   type specimen book. It has survived not only five centuries, but also the leap   into electronic typesetting, remaining essentially unchanged. It was popularised   in the 1960s with the release of Letraset sheets containing Lorem Ipsum   passages, and more recently with desktop publishing software like Aldus   PageMaker including versions of Lorem Ipsum. </div>
<div id="tipo_estado_div" style="position:absolute; z-index:30; left: 607px; top: 423px; width: 234px; height: 49px; font-family:Verdana, Arial, Helvetica, sans-serif;color:#FFFFFF;font-size:12px;">
  <p id="estadoAjuste" runat="server" align="center" style="margin: 3px;font-weight:bold;">En Solicitud</p>
  <p id="tipoAjuste" runat="server" align="center" style="margin: 3px;font-weight:bold;">Liquidaci&oacute;n Normal</p>
  <p id="DiasEnAjuste" runat="server" align="center" style="margin: 3px;font-weight:bold;">Días</p>
</div>
<div style="position:relative;">
    <table border="0" cellpadding="0" cellspacing="0" width="847">
        <!-- fwtable fwsrc="rgn_ctrl.png" fwbase="rgn_ctrl.gif" fwstyle="Dreamweaver" fwdocid = "817309276" fwnested="0" -->
        <tr>
            <td>
                <img src="ctrlImg/spacer.gif" width="35" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="58" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="63" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="48" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="10" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="61" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="57" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="66" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="56" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="62" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="55" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="68" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="56" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="152" height="1" border="0" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="1" border="0" alt="" /></td>
        </tr>
        <tr>
            <td colspan="14" style="height: 24px">
                <img name="rgn_ctrl_r1_c1" src="ctrlImg/rgn_ctrl_r1_c1.jpg" width="847" height="24"
                    border="0" id="rgn_ctrl_r1_c1" alt="" /></td>
            <td style="height: 24px">
                <img src="ctrlImg/spacer.gif" width="1" height="24" border="0" alt="" /></td>
        </tr>
        <tr>
            <td>
                <img name="rgn_ctrl_r2_c1" src="ctrlImg/rgn_ctrl_r2_c1.jpg" width="35" height="56"
                    border="0" id="rgn_ctrl_r2_c1" alt="" /></td>
            <td>
                <a id="lnkDatos" href="#" runat="server">
                    <img src="ctrlImg/datos.jpg" width="58" height="56" border="0" id="datos"
                        alt="" runat="server"/></a></td>
            <td colspan="12">
                <img name="rgn_ctrl_r2_c3" src="ctrlImg/rgn_ctrl_r2_c3.gif" width="754" height="56"
                    border="0" id="rgn_ctrl_r2_c3" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="56" border="0" alt="" /></td>
        </tr>
        <tr>
            <td colspan="8">
                <img name="rgn_ctrl_r3_c1" src="ctrlImg/rgn_ctrl_r3_c1.gif" width="398" height="56"
                    border="0" id="rgn_ctrl_r3_c1" alt="" /></td>
            <td>
                <a id="lnkInformeBasico" href="#" runat="server">
                    <img src="ctrlImg/informebasico.jpg" width="56" height="56"
                        border="0" id="informebasico" alt="" runat="server"/></a></td>
            <td rowspan="2" colspan="5">
                <img name="rgn_ctrl_r3_c10" src="ctrlImg/rgn_ctrl_r3_c10.gif" width="393" height="113"
                    border="0" id="rgn_ctrl_r3_c10" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="56" border="0" alt="" /></td>
        </tr>
        <tr>
            <td colspan="6">
                <img name="rgn_ctrl_r4_c1" src="ctrlImg/rgn_ctrl_r4_c1.gif" width="275" height="57"
                    border="0" id="rgn_ctrl_r4_c1" alt="" /></td>
            <td>
                <a id="lnkCoordinacion" href="#" runat="server">
                    <img src="ctrlImg/coordinacioninspeccion.jpg"
                        width="57" height="57" border="0" id="coordinacioninspeccion" alt="" runat="server"/></a></td>
            <td colspan="2">
                <img name="rgn_ctrl_r4_c8" src="ctrlImg/rgn_ctrl_r4_c8.gif" width="122" height="57"
                    border="0" id="rgn_ctrl_r4_c8" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="57" border="0" alt="" /></td>
        </tr>
        <tr>
            <td rowspan="5">
                <img name="rgn_ctrl_r5_c1" src="ctrlImg/rgn_ctrl_r5_c1.gif" width="35" height="272"
                    border="0" id="rgn_ctrl_r5_c1" alt="" /></td>
            <td><a id="lnkRegistroInicial"  href="#" runat="server">
                    	<img src="ctrlImg/registroinicial.jpg" width="58"
                        height="58" border="0" id="registroinicial" alt="" runat="server"/></a></td>
            <td rowspan="5">
                <img name="rgn_ctrl_r5_c3" src="ctrlImg/rgn_ctrl_r5_c3.gif" width="63" height="272"
                    border="0" id="rgn_ctrl_r5_c3" alt="" /></td>
            <td colspan="2">
                <a id="lnkRegistroAvanzado"  href="#" runat="server">
                    <img src="ctrlImg/registroAvanzado.jpg" width="58"
                        height="58" border="0" id="registroAvanzado" alt="" runat="server"/></a></td>
            <td colspan="3">
                <img name="rgn_ctrl_r5_c6" src="ctrlImg/rgn_ctrl_r5_c6.gif" width="184" height="58"
                    border="0" id="rgn_ctrl_r5_c6" alt="" /></td>
            <td>
                <a id="lnkSolicitudDocumentos" href="#" runat="server">
                    <img  src="ctrlImg/solicituddocumentos.jpg" width="56"
                        height="58" border="0" id="solicituddocumentos" alt="" runat="server"/></a></td>
            <td rowspan="5">
                <img name="rgn_ctrl_r5_c10" src="ctrlImg/rgn_ctrl_r5_c10.gif" width="62" height="272"
                    border="0" id="rgn_ctrl_r5_c10" alt="" /></td>
            <td>
                <a runat="server" id ="lnkinformesComplementarios" href="#">
                    <img  src="ctrlImg/informescomplementarios.jpg"
                        width="55" height="58" border="0" id="informescomplementarios" alt="" runat="server"/></a></td>
            <td rowspan="2" colspan="3">
                <img name="rgn_ctrl_r5_c12" src="ctrlImg/rgn_ctrl_r5_c12.gif" width="276" height="117"
                    border="0" id="rgn_ctrl_r5_c12" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="58" border="0" alt="" /></td>
        </tr>
        <tr>
            <td rowspan="3">
                <img name="rgn_ctrl_r6_c2" src="ctrlImg/rgn_ctrl_r6_c2.gif" width="58" height="166"
                    border="0" id="rgn_ctrl_r6_c2" alt="" /></td>
            <td rowspan="3" colspan="3">
                <img name="rgn_ctrl_r6_c4" src="ctrlImg/rgn_ctrl_r6_c4.gif" width="119" height="166"
                    border="0" id="rgn_ctrl_r6_c4" alt="" /></td>
            <td>
                <a id="lnkInspeccion" runat="server" href="#">
                    <img  src="ctrlImg/inspeccion.jpg" width="57" height="59"
                        border="0" id="inspeccion" alt="" runat="server"/></a></td>
            <td colspan="2">
                <img name="rgn_ctrl_r6_c8" src="ctrlImg/rgn_ctrl_r6_c8.gif" width="122" height="59"
                    border="0" id="rgn_ctrl_r6_c8" alt="" /></td>
            <td>
                <img name="rgn_ctrl_r6_c11" src="ctrlImg/rgn_ctrl_r6_c11.gif" width="55" height="59"
                    border="0" id="rgn_ctrl_r6_c11" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="59" border="0" alt="" /></td>
        </tr>
        <tr>
            <td rowspan="2" colspan="2">
                <img name="rgn_ctrl_r7_c7" src="ctrlImg/rgn_ctrl_r7_c7.gif" width="123" height="107"
                    border="0" id="rgn_ctrl_r7_c7" alt="" /></td>
            <td>
                <a id="lnkInformePreliminar"  href="#" runat="server">
                    <img src="ctrlImg/informepreliminar.jpg" width="56"
                        height="54" border="0" id="informepreliminar" alt="" runat="server"/></a></td>
            <td>
                <a id="lnkConvenio" href="#" runat="server">
                    <img src="ctrlImg/conveniodeajuste.jpg" width="55"
                        height="54" border="0" id="conveniodeajuste" alt="" runat="server"/></a></td>
            <td rowspan="3">
                <img name="rgn_ctrl_r7_c12" src="ctrlImg/rgn_ctrl_r7_c12.gif" width="68" height="155"
                    border="0" id="rgn_ctrl_r7_c12" alt="" /></td>
            <td>
                <a id="lnkInformeFinal" href="#" runat="server">
                    <img src="ctrlImg/informefinal.jpg" width="56" height="54"
                        border="0" id="informefinal" alt="" runat="server"/></a></td>
            <td rowspan="3">
                <img name="rgn_ctrl_r7_c14" src="ctrlImg/rgn_ctrl_r7_c14.gif" width="152" height="155"
                    border="0" id="rgn_ctrl_r7_c14" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="54" border="0" alt="" /></td>
        </tr>
        <tr>
            <td>
                <img name="rgn_ctrl_r8_c9" src="ctrlImg/rgn_ctrl_r8_c9.gif" width="56" height="53"
                    border="0" id="rgn_ctrl_r8_c9" alt="" /></td>
            <td rowspan="2">
                <img name="rgn_ctrl_r8_c11" src="ctrlImg/rgn_ctrl_r8_c11.gif" width="55" height="101"
                    border="0" id="rgn_ctrl_r8_c11" alt="" /></td>
            <td rowspan="2">
                <img name="rgn_ctrl_r8_c13" src="ctrlImg/rgn_ctrl_r8_c13.gif" width="56" height="101"
                    border="0" id="rgn_ctrl_r8_c13" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="53" border="0" alt="" /></td>
        </tr>
        <tr>
            <td>
                <a id="lnkComunicaciones"  href="#" runat="server">
                    <img src="ctrlImg/comunicaciones.jpg" width="58" height="48"
                        border="0" id="comunicaciones" alt="" runat="server"/></a></td>
            <td>
                <a id="lnkAnexos" href="#" runat="server"  >
                    <img runat="server" src="ctrlImg/anexos.jpg" width="48" height="48" border="0" id="anexos"
                        alt="" /></a></td>
            <td colspan="2">
                <img name="rgn_ctrl_r9_c5" src="ctrlImg/rgn_ctrl_r9_c5.gif" width="71" height="48"
                    border="0" id="rgn_ctrl_r9_c5" alt="" /></td>
            <td>
                <a id="lnkActividades" runat="server" href="#"  >
                    <img src="ctrlImg/actividades.jpg" width="57" height="48" border="0"
                        id="actividades" alt="" runat="server"/></a></td>
            <td>
                <img name="rgn_ctrl_r9_c8" src="ctrlImg/rgn_ctrl_r9_c8.gif" width="66" height="48"
                    border="0" id="rgn_ctrl_r9_c8" alt="" /></td>
            <td>
                <a id="lnkGastos" runat="server" href="#" >
                    <img runat="server" src="ctrlImg/gastos.jpg" width="56" height="48" border="0" id="gastos"
                        alt="" /></a></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="48" border="0" alt="" /></td>
        </tr>
        <tr>
            <td colspan="14">
                <img name="rgn_ctrl_r10_c1" src="ctrlImg/rgn_ctrl_r10_c1.jpg" width="847" height="19"
                    border="0" id="rgn_ctrl_r10_c1" alt="" /></td>
            <td>
                <img src="ctrlImg/spacer.gif" width="1" height="19" border="0" alt="" /></td>
        </tr>
    </table>
  </div>
<div id="RgenControl1_registroinicial_div" style="position:absolute; display:none;  font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; font-weight:bold; width: 27px; height: 25px; left: 51px; top: 211px;">
</div>
<div id="RgenControl1_registroAvanzado_div" style="position:absolute; font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; width: 27px; height: 25px; left: 172px; top: 212px;">
</div>
<div id="RgenControl1_coordinacioninspeccion_div" style="position:absolute; font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; width: 27px; height: 25px; left: 291px; top: 156px;">
</div>
<div id="RgenControl1_inspeccion_div" style="position:absolute; font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; width: 27px; height: 25px; left: 293px; top: 269px;">
</div>
<div id="RgenControl1_informebasico_div" style="position:absolute; font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; width: 27px; height: 25px; left: 414px; top: 98px;">
</div>
<div id="RgenControl1_informepreliminar_div" style="position:absolute; font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; width: 27px; height: 25px; left: 413px; top: 327px;">
</div>
<div id="RgenControl1_informescomplementarios_div" style="position:absolute; font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; width: 27px; height: 25px; left: 530px; top: 211px;">
</div>
<div id="RgenControl1_conveniodeajuste_div" style="position:absolute; font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; width: 27px; height: 25px; left: 530px; top: 325px;">
</div>
<div id="RgenControl1_informefinal_div" style="position:absolute; font-family:Arial; font-size:20px; text-align:center;color:red; font-weight:bold; width: 27px; height: 25px; left: 656px; top: 325px;">
</div>
</div>



