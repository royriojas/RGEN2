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

public partial class vRegistroPreliminar : System.Web.UI.Page
{
  public string qStringAjusteId;
  public string qStringTipoInforme;

  private RGen.Utiles.AtribucionesUsuario au;
  protected void Page_Load(object sender, EventArgs e)
  {
    qStringTipoInforme = Request.QueryString["tInforme"];
    qStringAjusteId = Request.QueryString["AjusteId"];

    Decimal ajusteId = Convert.ToDecimal(qStringAjusteId);

    if (RGen.GestorAjuste.GetCodigoAseguradora(ajusteId) == "RIMAC")
    {
        Response.Redirect(String.Format("~/RimacInforme/InformeBasico.aspx?AjusteId={0}", qStringAjusteId));
        return;
    }

    generarHyperLink.NavigateUrl = "javascript:GenerarInforme('" + qStringAjusteId + "',0);";
    observarHyperLink.NavigateUrl = "javascript:GenerarInforme('" + qStringAjusteId + "',1);";
    hlnlVistaPrevia.NavigateUrl = String.Format("vVistaPrevia.aspx?AjusteId={0}&TI={1}", qStringAjusteId, "I" + qStringTipoInforme);
    hlnVistaPreviaPdf.NavigateUrl = "javascript:GenerarVistaPreviaPdf('" + qStringAjusteId + "','"+qStringTipoInforme+"');";


    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
    if (au == null)
    {
      String urlActual = Request.Url.ToString();
      Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
    }
    //veificamos si que tipo de ajuste es: Normal o Rápido
    if (RGen.GestorAjuste.dameTipoAjuste(Convert.ToDecimal(qStringAjusteId)) == 2)
    {
      Response.Redirect("blankPage.aspx?AjusteId=" + qStringAjusteId);
    }

    if (((RGen.GestorAjuste.dameCodigoEstado(Convert.ToDecimal(qStringAjusteId)) >= 5) && (qStringTipoInforme == "P")))
    {
      //Response.Redirect("vMuestraMensaje.aspx?mensaje=No se Puede Editar El Registro Básico después que este ha sido aprobado. Pero puede generar informes del Tipo Preliminar y Complementario ");
      // this.ImageButton1.Visible = false;
        if ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Asistente") || (au.TipoUsuario == "EjecutivoSiniestros"))
      {
        this.observarHyperLink.Visible = false;
        this.generarHyperLink.Visible = false;
      }

    }

    if ((RGen.GestorAjuste.dameCodigoEstado(Convert.ToDecimal(qStringAjusteId)) >= 8) && (qStringTipoInforme == "C"))
    {
      //Response.Redirect("vMuestraMensaje.aspx?mensaje=No se Puede Editar El Registro Básico después que este ha sido aprobado. Pero puede generar informes del Tipo Preliminar y Complementario ");
      this.ImageButton1.Visible = false;
      if ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Asistente"))
      {
        this.observarHyperLink.Visible = false;
        this.generarHyperLink.Visible = false;
      }

    }


    if (!au.verificaAtributo("APROBARINFORMES"))
    {
      observarHyperLink.Visible = false;
      //si no es el administrador no sale la notificacion

    }
    this.LnkDocumentosSolicitados.OnClientClick = "return muestraVentanaPopUrl('vDocumentos.aspx?AjusteId=" + qStringAjusteId + "');";
  }

  protected void FormViewInspeccion_ItemUpdating1(object sender, FormViewUpdateEventArgs e)
  {

  }
  protected void grabar()
  {
    FormViewInspeccion.UpdateItem(true);
    FormViewDatosGenerales.UpdateItem(true);
    FormViewOcurrencia.UpdateItem(true);
    FormViewReclamo.UpdateItem(true);
    FormViewInformacionComplementaria.UpdateItem(true);

  }
  protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
  {
    this.grabar();
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
    Response.Redirect("vSeccionesAdicionales.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Request.Url);
  }


}
