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

public partial class vRegistroClausula : System.Web.UI.Page
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
		if (au == null) 
		{
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }
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


    protected void btnAsociarClausulas_Click(object sender, EventArgs e)
    {

        
    }
    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        //recorro grilla de clausulas
        int numFilas = this.gridClausulas.Rows.Count;

        for (int i = 0; i < numFilas; i++)
        {
            CheckBox AuxCheckBox = (CheckBox)gridClausulas.Rows[i].FindControl("CheckClausula");
            if (AuxCheckBox.Checked)
            {
                odsInsertClausulasAjuste.InsertParameters.Clear();
                odsInsertClausulasAjuste.InsertParameters.Add("ajusteId", this.AjusteId);
                odsInsertClausulasAjuste.InsertParameters.Add("polizaId", this.PolizaId);
                odsInsertClausulasAjuste.InsertParameters.Add("clausulasId", ((Label)gridClausulas.Rows[i].FindControl("lblClausula")).Text);
                odsInsertClausulasAjuste.InsertParameters.Add("usuario", au.UserName);
                odsInsertClausulasAjuste.InsertMethod = "Insert";
                odsInsertClausulasAjuste.Insert();
            }
            else 
            {
                dsPolizaTableAdapters.ClausulasSelectByIdTableAdapter itemAdapter = new dsPolizaTableAdapters.ClausulasSelectByIdTableAdapter();
                itemAdapter.DeleteClausulasAjuste(Convert.ToDecimal(((Label)gridClausulas.Rows[i].FindControl("lblClausula")).Text),Convert.ToDecimal(AjusteId));
            }
        }
       
    }


   
    protected void gridClausulas_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;
            if (Convert.ToDecimal(AuxRow["FLAGExiste"]) == 0)
            {
                CheckBox AuxCheckBox = (CheckBox)e.Row.FindControl("CheckClausula");
                AuxCheckBox.Checked = true;
            }

        }
    }
    protected void gridClausulas_DataBound(object sender, EventArgs e)
    {
        if (gridClausulas.Rows.Count == 0)
        {
            btnGuardar.Visible = false;
        }
        else btnGuardar.Visible = true;
    }
}
