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

public partial class vInformacionRelevante : System.Web.UI.Page
{
    public int num = 1;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        odsInformacionRelevante.Insert();
        gridInformacionRelevante.DataBind();
        txtTitulo.Text = "";
        txtDescripcion.Text = "";

    }
    protected void gridInformacionRelevante_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            dsInformacionRelevanteTableAdapters.InformacionRelevanteTableAdapter itemAdapter = new dsInformacionRelevanteTableAdapters.InformacionRelevanteTableAdapter();
            itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
            gridInformacionRelevante.DataBind();
        }
    }
    
}
