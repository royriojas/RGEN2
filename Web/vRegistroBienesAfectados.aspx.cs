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
using AjaxPro;

public partial class vRegistroBienesAfectados : System.Web.UI.Page
{
    public int num = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(utiles.ajax.gestorAjax));
    }
    protected void btnAgregar_Click(object sender, EventArgs e)
    {
        odsBienesAfectados.Insert();
        GridView1.DataBind();
        txtLocal.Text = "";
        txtMontoRep.Text = "";
        txtMontoSoles.Text = "";
        txtDescripcion.Text = "";
        txtBien.Text = "";

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            dsBienesTableAdapters.BienAfectadoSelectByIdTableAdapter itemAdapter = new dsBienesTableAdapters.BienAfectadoSelectByIdTableAdapter();
            itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
            GridView1.DataBind();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.QueryString["urlAnterior"]);
    }
}
