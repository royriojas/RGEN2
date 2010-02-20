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

public partial class vAsignarEquipoAAjuste : System.Web.UI.Page
{
    public int num = 1;
    public String numAjuste;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            numAjuste = Request.QueryString["numAjuste"];
            if (numAjuste != "")
            {
               numAjuste = RGen.GestorAjuste.dameNumeroAjuste(Convert.ToDecimal(numAjuste));
            }
            lblAjusteNumero.Text += " " + numAjuste;
        }
        
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            dsEquipoAjusteTableAdapters.EquipoAjusteTableAdapter itemAdapter = new dsEquipoAjusteTableAdapters.EquipoAjusteTableAdapter();
            itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
            GridView2.DataBind();
            Response.Redirect(Request.Url.ToString());
        }
    }
    protected void btnAgregar_Click(object sender, EventArgs e)
    {
        odsEquipo.Insert();
        Response.Redirect(Request.Url.ToString());
        txtEspecialidad.Text = "";
        txtNombre.Text = "";
    }
}
