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

public partial class vRegistroObservacion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.RawUrl);

        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }
    }
    public void grabar()
    {
        odsRegistroObservacion.Update();
    }    
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        this.grabar();
    }
}
