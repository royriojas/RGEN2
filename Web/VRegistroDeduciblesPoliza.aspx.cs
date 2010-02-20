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

public partial class VRegistroDeduciblesPoliza : System.Web.UI.Page
{
    public int num = 1;
    String AjusteId;
    String PolizaId;
    RGen.Utiles.AtribucionesUsuario au;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        AjusteId = Request.QueryString["AjusteId"];
        PolizaId = Request.QueryString["PolizaId"];
    }

    protected void gridDeducibles_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            dsPolizaTableAdapters.AtributoPolizaSelectByIdTableAdapter itemAdapter = new dsPolizaTableAdapters.AtributoPolizaSelectByIdTableAdapter();
            itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
            gridDeducibles.DataBind();

        }
    }
    protected void btnRegistrarDeducible_Click(object sender, EventArgs e)
    {
        odsDeducibles.Insert();
        gridDeducibles.DataBind();
        txtDeducible.Text = "";
    }
    
    
}
