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
using FreeTextBoxControls;
using RGen.Utiles;
using System.Globalization;
using System.IO;

public partial class vEditorRegistroBasico : System.Web.UI.Page
{
    public string QStringAjusteId;
    public string ApplicationPath;

    RGen.Utiles.AtribucionesUsuario au;
    protected void Page_Load(object sender, EventArgs e)
    {
        QStringAjusteId = Request.QueryString["AjusteId"];

        Decimal ajusteId = Convert.ToDecimal(QStringAjusteId);

        if (RGen.GestorAjuste.GetCodigoAseguradora(ajusteId) == "RIMAC")
        {
            Response.Redirect(String.Format("~/RimacInforme/InformeBasico.aspx?AjusteId={0}&TipoInforme{1}", QStringAjusteId, "IB"));
            return;
        }

        generarHyperLink.NavigateUrl = "javascript:GenerarInforme('" + QStringAjusteId + "',0);";
        observarHyperLink.NavigateUrl = "javascript:GenerarInforme('" + QStringAjusteId + "',1);";
        hlnlVistaPrevia.NavigateUrl = String.Format("vVistaPrevia.aspx?AjusteId={0}&TI={1}", QStringAjusteId, "IB");
        hlnVistaPreviaPdf.NavigateUrl = "javascript:GenerarVistaPreviaPdf('" + QStringAjusteId + "','B');";



        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        if (au == null)
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }

        //veificamos si que tipo de ajuste es: Normal o Rápido
        if (RGen.GestorAjuste.dameTipoAjuste(Convert.ToDecimal(QStringAjusteId)) == 2)
        {
            Response.Redirect("blankPage.aspx?AjusteId=" + QStringAjusteId);
        }


        if (RGen.GestorAjuste.dameCodigoEstado(Convert.ToDecimal(QStringAjusteId)) >= 4)
        {
            //Response.Redirect("vMuestraMensaje.aspx?mensaje=No se Puede Editar El Registro Básico después que este ha sido aprobado. Pero puede generar informes del Tipo Preliminar y Complementario ");
            // this.ImageButton1.Visible = false;
            if ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Asistente") || (au.TipoUsuario == "EjecutivoSiniestros"))
            {
                this.observarHyperLink.Visible = false;
                this.generarHyperLink.Visible = false;
            }

        }

        if (!au.verificaAtributo("APROBARINFORMES"))
        {
            observarHyperLink.Visible = false;
            //adicionalmente tenemos que evitar la posibilidad de que genere una notificacion


        }
        this.LnkDocumentosSolicitados.OnClientClick = "return muestraVentanaPopUrl('vDocumentos.aspx?AjusteId=" + QStringAjusteId + "');";

        // verificamos si se trata de un informe de pacifico para poder incluir los campos adicionales para pacifico
        if (!("PACIFICO" == RGen.GestorAjuste.GetCodigoAseguradora(Convert.ToDecimal(QStringAjusteId))))
        {
            Button btnSeccionesAdicionales = (Button)FormViewInformacionComplementaria.FindControl("btnSeccionesAdicionales");
            btnSeccionesAdicionales.Visible = false;
        }
    }

    protected void FormViewInspeccion_ItemUpdating1(object sender, FormViewUpdateEventArgs e)
    {

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        this.grabar();
    }
    private void grabar()
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
        Response.Redirect("vSeccionesAdicionales.aspx?AjusteId=" + Request.QueryString["AjusteId"] + "&urlAnterior=" + Request.Url);
    }


    protected void FormViewOcurrencia_DataBound(object sender, EventArgs e)
    {
        FreeTextBox ftb = FormViewOcurrencia.FindControl("txtInvestigaciones") as FreeTextBox;
        if (ftb != null)
        {
            ftb.Visible = true;
        }

    }
}
