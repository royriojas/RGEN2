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

public partial class vSolicitudDatos : System.Web.UI.Page
{
  private RGen.Utiles.AtribucionesUsuario au;
  public string Editar = "false";
  public string numAjuste;
  public string qStringAjusteId;
  public string qStringSolicitudDocumentosId;
  protected void Page_Load(object sender, EventArgs e)
  {
    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

    if (au == null)
    {
      String urlActual = Request.Url.ToString();
      Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
    }


    String tipo = Request.QueryString["TipoAccion"];
    qStringAjusteId = Request.QueryString["AjusteId"];

    if (tipo == "Editar")
    {
      this.btnGenerarCarta.Visible = true;
      this.frmSolicitud.ChangeMode(FormViewMode.Edit);
      Panel1.Visible = true;
      Editar = "true";
      this.btnGuardarSolicitud.Text = "Guardar";
    }

    else //estamos en el caso del nuevo
    {
      numAjuste = RGen.GestorAjuste.dameNumeroAjuste(Convert.ToDecimal(Request.QueryString["AjusteId"]));
      TextBox temp = (TextBox)this.frmSolicitud.FindControl("enreferenciaTextBox");
      temp.Text = "Ajuste N° " + numAjuste;

      String NumSolicitudSecuencial = RGen.Gestores.gestorParametros.getNumeroActualSolicitud();
      temp = (TextBox)this.frmSolicitud.FindControl("numeroSolicitudTextBox");
      temp.Text = NumSolicitudSecuencial;

      this.btnGuardarSolicitud.Text = "Siguiente";

    }
    qStringSolicitudDocumentosId = this.lblSolicitud.Text = Request.QueryString["solicitudDocumentosId"];

    //requerimiento : filtrar automáticamente el ajuste por tipo de 

    if (!IsPostBack)
    {
      this.cbxRiesgos.DataBind();
      seteaRiesgoDelDocumento();
      sdsDocumentosRelacionadosAlRiesgo.Select(DataSourceSelectArguments.Empty);
    }

  }
  protected void seteaRiesgoDelDocumento()
  {
    decimal RamoActual = RGen.GestorAjuste.dameRiesgoIdDelAjuste(Convert.ToDecimal(Request.QueryString["AjusteId"]));
    ListItem TempItem = this.cbxRiesgos.Items.FindByValue(RamoActual.ToString());
    if (TempItem != null)
    {
      for (int i = 0; i < this.cbxRiesgos.Items.Count; i++)
      {
        this.cbxRiesgos.Items[i].Selected = false;
      }
      TempItem.Selected = true;
    }
  }
  protected void cbxRiesgos_DataBound(object sender, EventArgs e)
  {
    RGen.Utiles.utilidades.addItemTodos(sender, "TODOS", "-1", IsPostBack);
  }
  protected void sdsDocumentos_Inserting(object sender, SqlDataSourceCommandEventArgs e)
  {

    //utiles.debugClass.muestra(e.Command,Server.MapPath("documentos.txt"));

  }
  protected void frmSolicitud_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    if (au != null)
    {
      this.sdsDocumentos.InsertParameters.Add("Fecha", TypeCode.DateTime, DateTime.Today.ToString());
      this.sdsDocumentos.InsertParameters.Add("fcrea", TypeCode.DateTime, DateTime.Today.ToString());
      this.sdsDocumentos.InsertParameters.Add("fupdate", TypeCode.DateTime, DateTime.Today.ToString());

      this.sdsDocumentos.InsertParameters.Add("ucrea", TypeCode.String, au.UserName);
      this.sdsDocumentos.InsertParameters.Add("uupdate", TypeCode.String, au.UserName);
    }
  }
  protected void sdsDocumentos_Inserted(object sender, SqlDataSourceStatusEventArgs e)
  {
    String solicitudDocumentosId = (e.Command.Parameters["@SolicitudDocumentosId"].Value).ToString();

    if (solicitudDocumentosId != "")
    {
      RGen.Gestores.gestorParametros.actualizaNumeroCarta();
      Response.Redirect("vSolicitudDatos.aspx?TipoAccion=Editar&SolicitudDocumentosId=" + solicitudDocumentosId + "&AjusteId=" + Request.QueryString["AjusteId"]);
    }
  }
  protected void frmSolicitud_ItemUpdating(object sender, FormViewUpdateEventArgs e)
  {
    if (au != null)
    {
      this.sdsDocumentos.InsertParameters.Add("fupdate", TypeCode.DateTime, DateTime.Today.ToString());
      this.sdsDocumentos.InsertParameters.Add("uupdate", TypeCode.String, au.UserName);
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
  protected void btnGuardarSolicitud_Click(object sender, EventArgs e)
  {
    if (Request.QueryString["TipoAccion"] == "Editar")
    {
      this.frmSolicitud.UpdateItem(true);
      int numFilas = GridView1.Rows.Count;
      if (numFilas > 0)
      {
        for (int i = 0; i < numFilas; i++)
        {
          CheckBox AuxCheckBox = (CheckBox)GridView1.Rows[i].FindControl("chk");
          TextBox txtOrden = (TextBox)GridView1.Rows[i].FindControl("txtOrden");

          sdsDocumentosDeSolicitud.UpdateParameters.Clear();
          TextBox auxTextBox = (TextBox)this.GridView1.Rows[i].FindControl("chkfentrega");
          sdsDocumentosDeSolicitud.UpdateParameters.Add("FechaEntrega", TypeCode.DateTime, AuxCheckBox.Checked ? (Convert.ToDateTime(auxTextBox.Text)).ToString() : "");
          sdsDocumentosDeSolicitud.UpdateParameters.Add("fupdate", TypeCode.DateTime, DateTime.Now.ToString());
          sdsDocumentosDeSolicitud.UpdateParameters.Add("estado", AuxCheckBox.Checked ? "E" : "N");
          sdsDocumentosDeSolicitud.UpdateParameters.Add("uupdate", au.UserName);
          sdsDocumentosDeSolicitud.UpdateParameters.Add("requisitoId", this.GridView1.Rows[i].Cells[0].Text);
          sdsDocumentosDeSolicitud.UpdateParameters.Add("SolicitudDocumentosId", this.Request.QueryString["SolicitudDocumentosId"]);
          sdsDocumentosDeSolicitud.UpdateParameters.Add("orden", txtOrden.Text);
          sdsDocumentosDeSolicitud.Update();

        }
        Response.Redirect(Request.Url.ToString());

      }

    }
    if (Request.QueryString["TipoAccion"] == "Nuevo") this.frmSolicitud.InsertItem(true);


  }
  protected void btnAddRequisito_Click(object sender, EventArgs e)
  {
    int numFilas = grdViewDocumentosXRiesgo.Rows.Count;
    if (numFilas > 0)
    {
      for (int i = 0; i < numFilas; i++)
      {
        CheckBox AuxCheckBox = (CheckBox)grdViewDocumentosXRiesgo.Rows[i].FindControl("chkElegido");

        if (AuxCheckBox.Checked)
        {
          sdsInsertRequisitoEnAjuste.InsertParameters.Clear();
          sdsInsertRequisitoEnAjuste.InsertParameters.Add("RequisitoId", grdViewDocumentosXRiesgo.Rows[i].Cells[0].Text);
          sdsInsertRequisitoEnAjuste.InsertParameters.Add("SolicitudDocumentosId", Request.QueryString["SolicitudDocumentosId"]);
          sdsInsertRequisitoEnAjuste.InsertParameters.Add("ajusteId", Request.QueryString["AjusteId"]);
          sdsInsertRequisitoEnAjuste.InsertParameters.Add("ucrea", au.UserName);

          sdsInsertRequisitoEnAjuste.Insert();
        }


      }
      grdViewDocumentosXRiesgo.DataBind();
      GridView1.DataBind();



    }
  }
  protected void sdsDocumentosDeSolicitud_Updating(object sender, SqlDataSourceCommandEventArgs e)
  {
    utiles.debugClass.muestra(e.Command, Server.MapPath("documentos.txt"));
  }
  protected void sdsDocumentosDeSolicitud_Selected(object sender, SqlDataSourceStatusEventArgs e)
  {

  }
  protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
  {
    if (e.CommandName == "QUITAR")
    {
      sdsDocumentosDeSolicitud.DeleteParameters.Clear();
      sdsDocumentosDeSolicitud.DeleteParameters.Add("requisitoId", TypeCode.Decimal, e.CommandArgument.ToString());
      sdsDocumentosDeSolicitud.DeleteParameters.Add("solicitudDocumentosId", TypeCode.Decimal, Request.QueryString["solicitudDocumentosId"]);
      sdsDocumentosDeSolicitud.Delete();
    }
  }
  protected void btnBuscar_Click(object sender, EventArgs e)
  {
    this.sdsDocumentosRelacionadosAlRiesgo.Select(DataSourceSelectArguments.Empty);

  }
  protected void btnVolver_Click(object sender, EventArgs e)
  {
    Response.Redirect("vDocumentos.aspx?AjusteId=" + Request.QueryString["AjusteId"]);
  }
}
