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

public partial class vRegistroClausulaPoliza : System.Web.UI.Page
{
    RGen.Utiles.AtribucionesUsuario au;
    public String qStringPolizaId;
    public String UrlAnterior;
    public int num = 1;
    String AjusteId;
    String PolizaId;


    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        qStringPolizaId = Request.QueryString["PolizaId"];
        UrlAnterior = Request.Url.ToString();
        //ojo cambio el nombre del QueryString PolizaId por PolId para evitar duplicidad de QueryString poliza
        btnAsociarClausulas.PostBackUrl = "vListaClausulasComunes.aspx?PolId=" + qStringPolizaId;
        Session["returnPath"] = UrlAnterior;
        AjusteId = Request.QueryString["AjusteId"];
        PolizaId = Request.QueryString["PolizaId"];

    }

    protected void btnRegistrarClausula_Click(object sender, EventArgs e)
    {
        sdsClausulasXPolizaSelect.InsertParameters.Add("usuario", au.UserName);
        sdsClausulasXPolizaSelect.Insert();
        gridClausulas.DataBind();
        txtClausulas.Text = "";
        txtNombre.Text = "";

    }
    protected void gridClausulas_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            dsPolizaTableAdapters.ClausulasSelectByIdTableAdapter itemAdapter = new dsPolizaTableAdapters.ClausulasSelectByIdTableAdapter();
            itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
            gridClausulas.DataBind();
        }
    }


   
}
