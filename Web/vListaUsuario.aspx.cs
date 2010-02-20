using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class vListaUsuario : Page
{
    private int rolId;
    RGen.Utiles.AtribucionesUsuario au;
    
    protected void Page_Load(object sender, EventArgs e)
    {
      au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

      CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.Url.ToString());
    }
    
    protected void listaUsuariosGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        listaUsuariosGridView.PageIndex = e.NewPageIndex;
        listaUsuariosGridView.DataBind();
    }
    protected void btnBuscar_Click(object sender, ImageClickEventArgs e)
    {
        
    }

    protected void rolIdCombo_DataBound(object sender, EventArgs e)
    {
        ListItem item = new ListItem("TODOS", "");
        rolIdCombo.Items.Insert(0, item);        
    }
    protected void odsListaUsuario_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        encabezadoLabel.Text = "Bandeja de Usuarios (" + ((DataTable)(e.ReturnValue)).Rows.Count.ToString() + ")";
    }

    protected void listaUsuariosGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView AuxRow = (DataRowView) e.Row.DataItem;
            HyperLink AuxLink = (HyperLink) e.Row.FindControl("viewHyperLink");
            AuxLink.NavigateUrl = "javascript:ShowEdit(" + AuxRow["usuarioId"].ToString() + ",'V')";

            AuxLink = (HyperLink) e.Row.FindControl("editHyperLink");
            AuxLink.Visible = true;
            AuxLink.NavigateUrl = "javascript:ShowEdit(" + AuxRow["usuarioId"].ToString() + ",'E',"+AuxRow["personaId"].ToString()+")";
            AuxLink = (HyperLink) e.Row.FindControl("deleteHyperLink");
            AuxLink.Visible = true;
            AuxLink.NavigateUrl = "javascript:ShowEdit(" + AuxRow["usuarioId"].ToString() + ",'D')";
        }
    }
    
    
    protected void listaUsuariosGridView_DataBinding(object sender, EventArgs e)
    {
        //if (rolIdCombo.SelectedValue != "") listaUsuariosGridView.Columns[2].Visible = false;
        //else listaUsuariosGridView.Columns[2].Visible = true;

        //if (estadoUsuarioIdCombo.SelectedValue != "") listaUsuariosGridView.Columns[2].Visible = false;
        //else listaUsuariosGridView.Columns[4].Visible = true;
    }

    protected void odsRolCombo_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["TipoUsuario"] = Session["TipoUsuario"].ToString();
    }
    protected void odsListaUsuario_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {

      String companiaId = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

      if (!String.IsNullOrEmpty(companiaId))
      {
        e.InputParameters["companiaId"] = companiaId;
      }      
    }
}
