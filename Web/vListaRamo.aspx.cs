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

public partial class vListaRamo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }
    }

    protected void listaRamoGridView_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        if (e.ExceptionHandled)
        {
            string mensaje;
            if (((System.Data.SqlClient.SqlException)(e.Exception)).Number == 547) mensaje = "No se puede eliminar el registro por exister registros relacionados.";
            else mensaje = e.Exception.Message;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "DeleteError", "alert('" + mensaje + "');", true);
        }
    }
    protected void listaRamoGridView_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}

