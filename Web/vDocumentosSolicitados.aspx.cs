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

public partial class vDocumentosSolicitados : System.Web.UI.Page
{
    public int num = 1;
    public string AjusteId;
    protected void Page_Load(object sender, EventArgs e)
    {
        AjusteId = Request.QueryString["AjusteId"];
    }
    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        int numFilas = GridView1.Rows.Count;
        if (numFilas > 0)
        {
            for (int i = 0; i < numFilas; i++)
            {
                CheckBox AuxCheckBox = (CheckBox)GridView1.Rows[i].FindControl("chk");

                odsDocumentosSolicitados.UpdateParameters.Clear();
                odsDocumentosSolicitados.UpdateParameters.Add("requisitoId", this.GridView1.Rows[i].Cells[0].Text);
                TextBox auxTextBox = (TextBox)this.GridView1.Rows[i].FindControl("chkfentrega");
                odsDocumentosSolicitados.UpdateParameters.Add("FechaEntrega",AuxCheckBox.Checked? auxTextBox.Text : "");
                odsDocumentosSolicitados.UpdateParameters.Add("fupdate", "");
                odsDocumentosSolicitados.UpdateParameters.Add("estado", AuxCheckBox.Checked? "E" : "NE");
                odsDocumentosSolicitados.UpdateParameters.Add("uupdate", "SYSTEM");
                odsDocumentosSolicitados.UpdateParameters.Add("solicitudDocumentosId", this.GridView1.Rows[i].Cells[1].Text);
                odsDocumentosSolicitados.UpdateParameters.Add("ajusteId", AjusteId);

                odsDocumentosSolicitados.Update();

            }
            GridView1.DataBind();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView)e.Row.DataItem;
            if (Convert.ToString(AuxRow["estado"]) == "E")
            {
                CheckBox AuxCheckBox = (CheckBox)e.Row.FindControl("chk");
                AuxCheckBox.Checked = true;
                TextBox auxTextBox = (TextBox)e.Row.FindControl("chkfentrega");
                DateTime dt = Convert.ToDateTime(Convert.ToString(AuxRow["FechaEntrega"]));
                auxTextBox.Text = dt.ToShortDateString();
                auxTextBox.Style.Add(HtmlTextWriterStyle.Display, "inline");
                
            }
            
        }
    }
}
