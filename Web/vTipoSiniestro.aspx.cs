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

public partial class vTipoSiniestro : System.Web.UI.Page
{
    private RGen.Utiles.AtribucionesUsuario au = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.RawUrl);

        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }

        string inserted = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["inserted"], "false");
        if (inserted == "true")
        {
            this.pnlMensajeConfirmacion.Visible = true;
        }       
    }

    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values.Add("ucrea", au.UserName);
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        e.NewValues.Add("uupdate", au.UserName);
    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        Response.Redirect(Request.Path + "?inserted=true");
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        this.pnlFilters.Style.Remove(HtmlTextWriterStyle.Display);
        this.pnlFilters.Style.Add(HtmlTextWriterStyle.Display, "block");

        this.pnlNewItem.Style.Remove(HtmlTextWriterStyle.Display);
        this.pnlNewItem.Style.Add(HtmlTextWriterStyle.Display, "none");

       
    }
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        this.lblMensaje.Text = "El Tipo de siniestro ha sido actualizado correctamente";
        this.pnlMensajeConfirmacion.Visible = true;        
    }
    protected void sdsTipoSiniestro_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        int i = 0;
    }
}
