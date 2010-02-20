using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class RimacInforme_detalleSublimitesAfectados : System.Web.UI.UserControl
{
    private String Concepto1 = null;
    private String Concepto2 = null;
    protected Int32 Num = 0;
    private decimal _ajusteId;
    public decimal AjusteId
    {
        get
        {
            return this._ajusteId;
        }
        set
        {
            this._ajusteId = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindData()
    {
        if (this.AjusteId != null)
        {
            this.repeaterSublimites.DataSourceID = "odsPolizaDetalle";
            this.odsPolizaDetalle.SelectParameters.Clear();
            this.odsPolizaDetalle.SelectParameters.Add("ajusteid", this.AjusteId.ToString());
            this.repeaterSublimites.DataBind();
        }
    }

    protected void odsPolizaDetalle_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        Num = 1;
    }
    protected void odsPolizaDetalle_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        this.divSublimitesAfectados.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
    }
    protected void repeaterSublimites_ItemCreated1(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Footer)
        {
            Label lbl1 = this.repeaterSublimites.Controls[0].FindControl("concepto1Label") as Label;
            Label lbl2 = this.repeaterSublimites.Controls[0].FindControl("concepto2Label") as Label;
            if (lbl1 != null)
                lbl1.Text = Concepto1;
            if (lbl2 != null)
                lbl2.Text = Concepto2;
        }

    }
    protected void repeaterSublimites_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {

            DataRowView drow = e.Item.DataItem as DataRowView;
            if (drow == null) return;
            dsReporte.InformeBasicoPolizaDetalleRow row = ((dsReporte.InformeBasicoPolizaDetalleRow)drow.Row);
            if (!row.IsconceptoNull()) Concepto1 = row.concepto;
            if (!row.Isconcepto2Null()) Concepto2 = row.concepto2;

        }

    }
}
