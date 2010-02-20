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

public partial class vRegistroClausulasComunes : System.Web.UI.Page
{
    RGen.Utiles.AtribucionesUsuario au;
    public int num = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
    }
    protected void btnRegistrarClausula_Click(object sender, EventArgs e)
    {
      int BinLength = fupArchivo.PostedFile.ContentLength;

      if (BinLength > 0)
      {
        nombreArchivoHiddenField.Value = fupArchivo.FileName;
        odsClausulasComunesInsert.InsertParameters.Add("usuario", au.UserName);
        
        odsClausulasComunesInsert.Insert();
        gridClausulas.DataBind();
        
      }
      
        
    }

  protected void gridClausulas_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      HyperLink descargaHyperLink = (HyperLink)e.Row.FindControl("descargaHyperLink");
      try 
      { 
          descargaHyperLink.NavigateUrl = "javascript:GetBinaryClausula('vGetBinaryClausula.aspx?clausulaId=" + AuxRow["clausulaId"].ToString() + "')";
      }
      catch (Exception ex)
      {
                 
      }
      
    }
  }
  protected void gridClausulas_RowCommand(object sender, GridViewCommandEventArgs e)
  {
    if (e.CommandName == "Eliminar")
    {
      dsClausulasComunesTableAdapters.ClausulasComunesTableAdapter itemAdapter = new dsClausulasComunesTableAdapters.ClausulasComunesTableAdapter();
      itemAdapter.Delete(decimal.Parse(e.CommandArgument.ToString()));
      gridClausulas.DataBind();
    }
  }
    protected void cbxRamoFiltro_DataBound(object sender, EventArgs e)
    {
        ListItem item = new ListItem("TODOS", "");
        this.cbxRamoFiltro.Items.Insert(0, item);
    }
}
