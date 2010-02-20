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
using FreeTextBoxControls;
using RGen;

public partial class vSeccionesInformeFinal : System.Web.UI.Page
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
    String ajusteId = Request.QueryString["AjusteId"];
  }

  protected void btnRegistrar_Click(object sender, EventArgs e)
  {
    try
    {
      odsSeccionesAjuste.Insert();
      this.txtDescripcion.Text = "";
      this.txtTitulo.Text = "";
    }
    catch (Exception ex)
    {
      LoggerFacade.Log(ex);
    }
    gridSeccionesAjuste.DataBind();

  }



  protected void titulosDataList_ItemDataBound(object sender, DataListItemEventArgs e)
  {
    //DataRowView auxRow = (DataRowView)e.Item.DataItem;
    //HyperLink auxLink = (HyperLink)e.Item.FindControl("HyperLink1");
    //auxLink.NavigateUrl = "javascript:window.top.showPopWin('vRegistroSubtitulo.aspx?sid=" + auxRow["seccionId"] + "&AjusteId=" + auxRow["ajusteId"] + "',650,400,null);";
  }
  protected void btnVolver_Click(object sender, EventArgs e)
  {
    Response.Redirect(Request.QueryString["urlAnterior"].ToString());
  }


  protected void odsSeccionesAjuste_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.txtDescripcion.Text = "";
    this.txtTitulo.Text = "";
  }
  protected void gridSeccionesAjuste_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {
    e.NewValues["uupdate"] = Session["NombreUsuario"];
  }

  protected void gridInformacionRelevante_RowCommand(object sender, GridViewCommandEventArgs e)
  {

    if (e.CommandName == "Eliminar")
    {
      dsInformesTableAdapters.SeccionesFinalTableAdapter TA = new dsInformesTableAdapters.SeccionesFinalTableAdapter();
      TA.Delete(decimal.Parse(e.CommandArgument.ToString()));
      //odsSeccionesAjuste.Delete();
      gridSeccionesAjuste.DataBind();


    }
  }
  protected void gridSeccionesAjuste_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      ImageButton img = e.Row.FindControl("ImageButton1") as ImageButton;
      dsSecInforme.SeccionesAdicionalesAjusteRow DRow = (dsSecInforme.SeccionesAdicionalesAjusteRow)((System.Data.DataRowView)(e.Row.DataItem)).Row;

      if (img != null)
      {
        if (DRow != null)
          img.Visible = DRow.IsKeyNameNull();
      }

      TextBox txtTitulo = e.Row.FindControl("txtTitulo") as TextBox;
      if (txtTitulo != null) txtTitulo.Visible = ((DRow != null) && DRow.IsKeyNameNull());

    }
  }

  protected void gridSeccionesAjuste_RowEditing(object sender, GridViewEditEventArgs e)
  {
    this.SeccionNew.Visible = false;
  }
  protected void gridSeccionesAjuste_RowUpdated(object sender, GridViewUpdatedEventArgs e)
  {
    this.SeccionNew.Visible = true;
  }
  protected void gridSeccionesAjuste_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
  {
    this.SeccionNew.Visible = true;
  }
}
