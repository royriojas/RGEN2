using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class RimacInforme_Damage : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void odsOcurrenciaDetalle_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        SumaDetalleOcurrencia = 0;
        Num = 1;
    }

    private int _num = 0;
    public int Num
    {
        get { return _num; }
        set { _num = value; }
    }

    public decimal SumaDetalleOcurrencia
    {
        get
        {
            if (ViewState["SumaDetalleOcurrencia"] == null) return 0;
            return Convert.ToDecimal(ViewState["SumaDetalleOcurrencia"]);
        }
        set { ViewState["SumaDetalleOcurrencia"] = value; }
    }
    protected void odsOcurrenciaDetalle_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        this.divDanos.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = e.Item.DataItem as DataRowView;
            if (drow == null) return;
            dsReporte.InformeBasicoOcurrenciaDetalleRow row = ((dsReporte.InformeBasicoOcurrenciaDetalleRow)drow.Row);
            if (!row.IsestimacionNull()) SumaDetalleOcurrencia += row.estimacion;
        }

    }
}
