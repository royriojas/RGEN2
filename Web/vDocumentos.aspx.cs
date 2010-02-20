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

public partial class vDocumentos : System.Web.UI.Page
{
    public string qStringAjusteId;
    private string url_page;
    public decimal num = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{ 
        //    url_page = Request.Url.ToString();
        //}
        qStringAjusteId = Request.QueryString["AjusteId"];
        if (!(RGen.GestorAjuste.dameCodigoEstado(Convert.ToDecimal(qStringAjusteId)) >= 3))
        {
            this.contenedor.Style.Value = "display:none";

            this.pnlError.Visible = true;
            this.lblError.Visible = true;
        }
		RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.RawUrl);

        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }
    }
    protected void btnNuevaSolicitud_Click(object sender, EventArgs e)
    {
        Response.Redirect("vSolicitudDatos.aspx?AjusteId=" + Request.QueryString["AjusteId"]+"&TipoAccion=Nuevo");
    }
    protected void gViewDocumentos_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ELIMINAR")
        {
            this.sdsNuevaCarta.UpdateParameters.Clear();
            this.sdsNuevaCarta.UpdateParameters.Add("solicitudDocumentosId", TypeCode.Decimal, e.CommandArgument.ToString());
            this.sdsNuevaCarta.Update();
        }
        this.gViewDocumentos.DataBind();
        //Response.Redirect(url_page);
    }
    
}
