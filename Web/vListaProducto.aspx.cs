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
using RGen.Utiles;

public partial class vListaProducto : System.Web.UI.Page
{
  private AtribucionesUsuario au;

  protected void Page_Load(object sender, EventArgs e)
  {

    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

    CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.RawUrl);

    String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
    if (noShowBtn == "true")
    {
      this.lnkSeparar.Visible = false;
    }
  }
  protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {
    this.sdsProducto.UpdateParameters.Add("uupdate", TypeCode.String, au.UserName);
  }
  protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
  {
    //this.sdsProducto.DeleteParameters.Add("uupdate", TypeCode.String, "SYSTEM");
    e.Values.Add("@uupdate", au.UserName);
  }
  protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    e.Values.Add("ucrea", au.UserName);
  }

  protected void sdsProducto_Inserted(object sender, SqlDataSourceStatusEventArgs e)
  {
    decimal outputValue = (decimal)(e.Command.Parameters)[0].Value;
    String NombreProducto = Convert.ToString((e.Command.Parameters)[1].Value);

    Response.Redirect("./Mantenimientos/vAsociaProductos.aspx?ProductoId=" + outputValue + "&nombreProducto=" + NombreProducto);
  }
  public String setNavigateUrl(object productoId, object nombre)
  {
    return String.Format("./Mantenimientos/vAsociaProductos.aspx?ProductoId={0}&nombreProducto={1}", productoId, nombre);
  }
  protected void btnSearch_Click(object sender, EventArgs e)
  {
    this.GridView1.DataBind();
  }
}
