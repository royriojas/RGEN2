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
using RGen;
using System.Xml;
using System.Text.RegularExpressions;

public partial class vSeccionesAdicionales : System.Web.UI.Page
{
  public int num = 1;


  public decimal AjusteId
  {
    get
    {
      try
      {
        return Convert.ToDecimal(Request.QueryString["AjusteId"]);
      }
      catch (Exception ex)
      {
        LoggerFacade.Log(ex);
        return -1;
      }
    }
  }

  protected void Page_Load(object sender, EventArgs e)
  {
    //AjusteId = ;
    if (!IsPostBack)
    {
      if (AjusteId != -1)
      {
        if ((GestorAjuste.GetCodigoAseguradora(AjusteId) == "PACIFICO") && (!GestorAjuste.SystemFieldsInserted(AjusteId)))
        {
          GestorAjuste.InsertSystemSubtitles(AjusteId, (Session["usuario"] != null) ? Session["usuario"].ToString() : "");
        }
      }
    }
  }
  protected void btnRegistrar_Click(object sender, EventArgs e)
  {

    

    odsSeccionesAjuste.Insert();
    gridSeccionesAjuste.DataBind();
    txtTitulo.Text = "";
    txtDescripcion.Text = "";


  }

  
  protected void Button1_Click(object sender, EventArgs e)
  {
    Response.Redirect(Request.QueryString["urlAnterior"]);
  }
  protected void gridSeccionesAjuste_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {
    e.NewValues["uupdate"] = Session["NombreUsuario"];
  }

  protected void gridInformacionRelevante_RowCommand(object sender, GridViewCommandEventArgs e)
  {

    if (e.CommandName == "Eliminar")
    {
      dsInformesTableAdapters.SeccionesAjusteTableAdapter itemAdapter = new dsInformesTableAdapters.SeccionesAjusteTableAdapter();
      itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
      gridSeccionesAjuste.DataBind();
    }
  }
  protected void gridSeccionesAjuste_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      ImageButton img = e.Row.FindControl("ImageButton1") as ImageButton;
      dsInformes.SeccionesAjusteRow DRow = (dsInformes.SeccionesAjusteRow)((System.Data.DataRowView)(e.Row.DataItem)).Row;

      if (img != null)
      {
        if (DRow != null)
          img.Visible = DRow.IskeyNameNull();
      }

      TextBox txtTitulo = e.Row.FindControl("txtTitulo") as TextBox;
      if (txtTitulo != null) txtTitulo.Visible = ((DRow != null) && DRow.IskeyNameNull());

    }
  }
  protected void gridSeccionesAjuste_RowUpdated(object sender, GridViewUpdatedEventArgs e)
  {
    this.ContenidoClausula.Visible = true;
  }
  protected void gridSeccionesAjuste_RowEditing(object sender, GridViewEditEventArgs e)
  {
    this.ContenidoClausula.Visible = false;
  }
  protected void gridSeccionesAjuste_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
  {
    this.ContenidoClausula.Visible = true;
  }
}
