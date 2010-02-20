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

public partial class vEditorCasoAjuste : System.Web.UI.Page
{
    public string qStringAjusteId;
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(utiles.ajax.gestorAjax));
        qStringAjusteId = Request.QueryString["AjusteId"];

        this.lnkEliminarAjuste.HRef = "vEliminarCasoAjuste.aspx?AjusteId=" + qStringAjusteId;
        this.lnkFinalizar.HRef = "vFinalizarCaso.aspx?AjusteId=" + qStringAjusteId;
        this.lnkAdminEstados.NavigateUrl = "~/changeEstados.aspx?AjusteId=" + qStringAjusteId;

        RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario) Session["datosUsuario"];
        if (au == null)
        {
             String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }
        if (!au.verificaAtributo("ELIMINARAJUSTE")) 
        {
            this.lnkEliminarAjuste.Disabled = true ;
            
        }
        if (!au.verificaAtributo("FINALIZARAJUSTE"))
        {
            this.lnkFinalizar.Disabled = true;
        }
       
        this.lnkAdminEstados.Visible = (au.TipoUsuario == "Administrador");


    }
    
}
