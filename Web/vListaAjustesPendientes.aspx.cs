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

public partial class vListaAjustesPendientes : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }
  protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      e.Row.Attributes.Add("id", e.Row.ClientID);
      e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
      e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");
      e.Row.Attributes.Add("onClick", "javascript:Redirect('vEditorCasoAjuste.aspx?AjusteId=" + AuxRow["AjusteId"].ToString() + "');");

    }
  }
  protected void odsAjustesDelAjustador_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    if (e.Exception == null)
    {
      this.Label1.Text += String.Format(" ({0})", R3M.Common.Util.getRowCount(e.ReturnValue));
    }
    else
    {
      LoggerFacade.Log(e.Exception);
    }
  }
}
