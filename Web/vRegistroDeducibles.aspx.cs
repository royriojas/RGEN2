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

public partial class vRegistroDeducibles : System.Web.UI.Page
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
    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        //recorro grilla de deducibles
        int numFilas = this.gridDeducibles.Rows.Count;

        for (int i = 0; i < numFilas; i++)
        {
            CheckBox AuxCheckBox = (CheckBox)gridDeducibles.Rows[i].FindControl("CheckDeducible");
            if (AuxCheckBox.Checked)
            {
                odsInsertDeduciblesAjuste.InsertParameters.Clear();
                odsInsertDeduciblesAjuste.InsertParameters.Add("ajusteId", this.AjusteId);
                odsInsertDeduciblesAjuste.InsertParameters.Add("polizaId", this.PolizaId);
                odsInsertDeduciblesAjuste.InsertParameters.Add("atributoId", ((Label)gridDeducibles.Rows[i].FindControl("lblDeducible")).Text);
                odsInsertDeduciblesAjuste.InsertParameters.Add("usuario", au.UserName);
                odsInsertDeduciblesAjuste.InsertMethod = "Insert";
                odsInsertDeduciblesAjuste.Insert();
            }
            else 
            {
                dsPolizaTableAdapters.AtributoPolizaSelectByIdTableAdapter itemAdapter = new dsPolizaTableAdapters.AtributoPolizaSelectByIdTableAdapter();
                itemAdapter.DeleteDeduciblesAjuste(Convert.ToDecimal(((Label)gridDeducibles.Rows[i].FindControl("lblDeducible")).Text),Convert.ToDecimal(AjusteId));
            }
        }
        
    }
    protected void odsDeducibles_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if (((DataTable)e.ReturnValue).Rows.Count == 0)
        {
            btnGuardar.Visible = false;
        }
        else btnGuardar.Visible = true;
    }
    protected void gridDeducibles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;
            if (Convert.ToDecimal(AuxRow["FLAGExiste"]) == 0)
            {
                CheckBox AuxCheckBox = (CheckBox)e.Row.FindControl("CheckDeducible");
                AuxCheckBox.Checked = true;
            }

        }
    }
}
