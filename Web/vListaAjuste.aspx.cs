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

public partial class vListaAjuste : System.Web.UI.Page
{
  private string url_destino;
  RGen.Utiles.AtribucionesUsuario au;
  private void doSearch()
  {
    this.GridView1.DataSourceID = "ObjectDataSource1";
    this.GridView1.DataBind();
  }
  protected void Page_Load(object sender, EventArgs e)
  {
    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

    CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.Url.ToString());

    if ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Administrador") || (au.TipoUsuario == "Asistente") || (au.TipoUsuario == "EjecutivoSiniestros"))
    {
      this.url_destino = "vEditorCasoAjuste.aspx";
    }
    if (
        (au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker")
        || (au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros")
       )
    {
      this.url_destino = "vVisorCasoAjuste_.aspx";
    }

    this.GridView1.DataSourceID = "";
    if (!IsPostBack)
    {
      this.validaControles();
      doSearch();
    }



  }

  private void validaControles()
  {

    ListItem item = new ListItem("TODOS", "");

    this.cbxEstatus.Items.Insert(0, item);
    this.cbxLiquidacion.Items.Insert(0, item);
    this.cbxRamo.Items.Insert(0, item);
  }
  protected void ibtnBuscar_Click(object sender, ImageClickEventArgs e)
  {
    Label1.Text = "Lista de Ajustes";
    if (this.Page.IsValid)
    {
      doSearch();
    }
  }

  private bool IsValidDate(string aDate)
  {
    if (String.IsNullOrEmpty(aDate)) return true;
    DateTime dt = DateTime.Now;
    return DateTime.TryParse(aDate, out dt);
  }
  protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
  {

    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      decimal ajusteId_d = -1;
      try
      {
        ajusteId_d = Convert.ToDecimal(AuxRow["AjusteId"]);
      }
      catch (Exception ex)
      {
        LoggerFacade.Log(ex);
        ajusteId_d = -1;
      }

      Boolean doMouseOver = true;
      //au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
      if ((au != null) && (ajusteId_d != -1) && ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Asistente")))
      {
        doMouseOver = !GestorAjuste.elCasoEstaEnControlCalidad(ajusteId_d);
      }

      if (doMouseOver)
      {
        e.Row.Attributes.Add("id", e.Row.ClientID);
        e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
        e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");
        e.Row.Attributes.Add("onClick", "javascript:Redirect('" + this.url_destino + "?AjusteId=" + AuxRow["AjusteId"].ToString() + "');");
      }

    }
  }

  protected void ObjectDataSource1_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    if (e.Exception == null)
    {
      this.Label1.Text = "Lista de Ajustes (" + R3M.Common.Util.GetRowCount(e.ReturnValue) + ")";
    }
    else
    {
      LoggerFacade.Log(e.Exception);
    }

  }
  protected void cbxCia_DataBound(object sender, EventArgs e)
  {
    if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
    {

      String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

      this.cbxCia.ClearSelection();
      ListItem li = cbxCia.Items.FindByValue(valueToFind);

      if (li != null)
      {
        li.Selected = true;
        cbxCia.Enabled = false;

      }
      this.GridView1.Columns[0].Visible = false;
      Boolean viewReserva = GestorNotificacion.hasVisibilityPermissionAseguradora(Convert.ToDecimal(valueToFind), "V_RESERVAS");
      if (!viewReserva) this.GridView1.Columns[12].Visible = false;

    }
    ListItem item = new ListItem("TODOS", "");
    this.cbxCia.Items.Insert(0, item);

  }
  protected void cbxBroker_DataBound(object sender, EventArgs e)
  {
    if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
    {


      String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

      this.cbxBroker.ClearSelection();
      ListItem li = cbxBroker.Items.FindByValue(valueToFind);

      if (li != null)
      {
        li.Selected = true;
        cbxBroker.Enabled = false;

      }

      this.GridView1.Columns[1].Visible = false; 

    }
    ListItem item = new ListItem("TODOS", "");
    this.cbxBroker.Items.Insert(0, item);
  }
  protected void cbxAjustador_DataBound(object sender, EventArgs e)
  {
    if (au.TipoUsuario == "Ajustador")
    {

      this.cbxAjustador.ClearSelection();
      ListItem li = cbxAjustador.Items.FindByValue(Session["UsuarioId"].ToString());

      if (li != null)
      {
        li.Selected = true;
        cbxAjustador.Enabled = false;
      }
      this.GridView1.Columns[8].Visible = false;
    }
    ListItem item = new ListItem("TODOS", "");
    this.cbxAjustador.Items.Insert(0, item);
  }
  protected void cbxEjecutivoSiniestros_DataBound(object sender, EventArgs e)
  {
      if (au.TipoUsuario == "EjecutivoSiniestros")
      {

          this.cbxAjustador.ClearSelection();
          ListItem li = cbxEjecutivoSiniestros.Items.FindByValue(Session["UsuarioId"].ToString());

          if (li != null)
          {
              li.Selected = true;
              //cbxEjecutivoSiniestros.Enabled = false;
          }
          this.GridView1.Columns[8].Visible = false;
      }
      ListItem item = new ListItem("TODOS", "");
      this.cbxEjecutivoSiniestros.Items.Insert(0, item);

  }
  public String muestraSimbolo(object aseguradoraId, object brokerId, Object simbolo, Object monto)
  {
    String simboloSalida = "";
    try
    {
      //au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
      simboloSalida = Convert.ToString(simbolo);
      String montoSalida = Convert.ToString(monto);

      decimal aseguradoraId_d = Convert.ToDecimal(aseguradoraId);

      decimal brokerId_d = Convert.ToDecimal(brokerId);

      Boolean viewReserva = GestorNotificacion.hasVisibilityPermissionBroker(brokerId_d, aseguradoraId_d, "V_RESERVAS");

      if ((String.IsNullOrEmpty(montoSalida)) || (montoSalida == ".00"))
      {
        simboloSalida = "";
      }
      if (((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker")) && (!viewReserva))
      {
        simboloSalida = "";
      }
    }
    catch
    {
      simboloSalida = "";
    }
    return simboloSalida;
  }
  public String muestraReserva(object aseguradoraId, object brokerId, object monto)
  {

    String montoSalida = "";
    try
    {
      montoSalida = Convert.ToString(monto);
      decimal aseguradoraId_d = Convert.ToDecimal(aseguradoraId);
      decimal brokerId_d = Convert.ToDecimal(brokerId);

      Boolean viewReserva = GestorNotificacion.hasVisibilityPermissionBroker(brokerId_d, aseguradoraId_d, "V_RESERVAS");
      if (String.IsNullOrEmpty(montoSalida) || montoSalida == ".00")
      {
        montoSalida = "";
      }
      if (((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker")) && (!viewReserva))
      {
        montoSalida = "No Disponible";
      }
    }
    catch
    {
      montoSalida = "";
    }
    return montoSalida;
  }
  protected void ObjectDataSource1_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
  {
    e.Cancel = !(IsValidDate(String.Format("{0}", e.InputParameters["fInicio"])) && IsValidDate(String.Format("{0}", e.InputParameters["fFin"])));

    if (e.Cancel)
    {
      this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "ErrorKey", "alert('El rango de fechas no es válido');", true);
    }
  }
  protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
  {
    args.IsValid = IsValidDate(args.Value);
  }
  protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
  {
    args.IsValid = IsValidDate(args.Value);
  }
  protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
  {
    this.GridView1.DataSourceID = "ObjectDataSource1";
    this.GridView1.PageIndex = e.NewPageIndex;
  }
    
}
