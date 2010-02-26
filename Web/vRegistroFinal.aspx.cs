using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ASB;
using System.IO;

public partial class vRegistroFinal : System.Web.UI.Page
{
  public string qStringAjusteId;
  public string qStringTipoInforme;

  RGen.Utiles.AtribucionesUsuario au;
  protected void Page_Load(object sender, EventArgs e)
  {
    qStringTipoInforme = Request.QueryString["tInforme"];
    qStringAjusteId = Request.QueryString["AjusteId"];

    Decimal ajusteId = Convert.ToDecimal(qStringAjusteId);

    if (RGen.GestorAjuste.GetCodigoAseguradora(ajusteId) == "RIMAC")
    {
        Response.Redirect(String.Format("~/RimacInforme/InformeBasico.aspx?AjusteId={0}&TipoInforme={1}", qStringAjusteId, "IF"));
        return;
    }

    generarHyperLink.NavigateUrl = "javascript:GenerarInforme('" + qStringAjusteId + "',0);";
    observarHyperLink.NavigateUrl = "javascript:GenerarInforme('" + qStringAjusteId + "',1);";
    hlnlVistaPrevia.NavigateUrl = String.Format("vVistaPrevia.aspx?AjusteId={0}&TI={1}", qStringAjusteId, "IF");
    hlnVistaPreviaPdf.NavigateUrl = "javascript:GenerarVistaPreviaPdf('" + qStringAjusteId + "','F');";

    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
    if (au == null)
    {
      String urlActual = Request.Url.ToString();
      Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
    }

    if (RGen.GestorAjuste.dameCodigoEstado(Convert.ToDecimal(qStringAjusteId)) >= 8)
    {
      //Response.Redirect("vMuestraMensaje.aspx?mensaje=No se Puede Editar El Registro Básico después que este ha sido aprobado. Pero puede generar informes del Tipo Preliminar y Complementario ");
      //this.ImageButton1.Visible = false;
        if ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Asistente") || (au.TipoUsuario == "EjecutivoSiniestros"))
      {
        this.observarHyperLink.Visible = false;
        this.generarHyperLink.Visible = false;
      }

    }

    if (!au.verificaAtributo("APROBARINFORMES"))
    {
      observarHyperLink.Visible = false;

    }
  }
  protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
  {
    this.grabar();
  }
  protected void grabar()
  {
    FormViewInspeccion.UpdateItem(true);
    FormViewDatosGenerales.UpdateItem(true);
    FormViewOcurrencia.UpdateItem(true);
    FormViewReclamo.UpdateItem(true);
    FormViewInformacionComplementaria.UpdateItem(true);

  }
  protected void odsInpeccion_Updating(object sender, ObjectDataSourceMethodEventArgs e)
  {
    // String hola = "hola";
  }
  protected void LinkButton1_Click(object sender, EventArgs e)
  {
    grabar();
    Response.Redirect("vRegistroBienesAfectados.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Request.Url);
  
  }
  protected void LinkButton2_Click(object sender, EventArgs e)
  {
    grabar();
    Response.Redirect("vEditorPolizaAjuste.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Request.Url);
  
  }
  protected void Button1_Click(object sender, EventArgs e)
  {
    grabar();
    Session["UrlAnterior"] = Request.Url.ToString();
    Response.Redirect("vSeccionesAdicionales.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Request.Url);

  }
  protected void lnkSeccionesAdicionales_Click(object sender, EventArgs e)
  {
    grabar();
    Response.Redirect("vSeccionesInformeFinal.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Request.Url);

  }

}
