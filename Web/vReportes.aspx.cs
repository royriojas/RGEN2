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
using System.IO;
using System.Text;

public partial class vReportes : System.Web.UI.Page
{
  public int num = 0;
  private string url_destino;
  RGen.Utiles.AtribucionesUsuario au;
  protected void Page_Load(object sender, EventArgs e)
  {
    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    if (!IsPostBack)
    {
      this.validaControles();

    }
    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

    CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.Url.ToString());

    if ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Administrador") || (au.TipoUsuario == "Asistente"))
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
  }

  private void validaControles()
  { /*
    this.txtFechaInicio.Text = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
    this.txtFechaFin.Text = DateTime.Now.ToString("dd/MM/yyyy");
      */


    ListItem item = new ListItem("TODOS", "");
    ListItem itemEstado = new ListItem("Sin Informe Final", "-1");
    this.cbxEstatus.Items.Insert(0, item);
    this.cbxEstatus.Items.Insert(1, itemEstado);
    this.cbxLiquidacion.Items.Insert(0, item);
    this.cbxRamo.Items.Insert(0, item);
  }
  protected void ibtnBuscar_Click(object sender, ImageClickEventArgs e)
  {
    this.txtFechaFinTemp.Text = "";
    this.txtFechaIniTemp.Text = "";
    if (this.txtFechaInicio.Text != "")
    {
      DateTime fi = Convert.ToDateTime(this.txtFechaInicio.Text);
      this.txtFechaIniTemp.Text = fi.Year + "/" + fi.Month + "/" + fi.Day;
    }
    if (this.txtFechaFin.Text != "")
    {
      DateTime ff = Convert.ToDateTime(this.txtFechaFin.Text);
      this.txtFechaFinTemp.Text = ff.Year + "/" + ff.Month + "/" + ff.Day;
    }

  }
  protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    /*

    if (e.Row.RowType == DataControlRowType.DataRow)
    {
        DataRowView AuxRow = (DataRowView)e.Row.DataItem;
        e.Row.Attributes.Add("id", e.Row.ClientID);
        e.Row.Attributes.Add("onMouseOver", "MouseOver('" + e.Row.ClientID + "');");
        e.Row.Attributes.Add("onMouseOut", "MouseOut('" + e.Row.ClientID + "');");
        e.Row.Attributes.Add("onClick", "javascript:Redirect('" + this.url_destino + "?AjusteId=" + AuxRow["AjusteId"].ToString() + "');");
    }
  */
  }

  protected void ObjectDataSource1_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    try
    {
      this.Label1.Text = "Lista de Ajustes (" + ((System.Data.DataTable)e.ReturnValue).Rows.Count + ")";
    }
    catch (Exception ex)
    {
    }
  }
  protected void cbxCia_DataBound(object sender, EventArgs e)
  {
    if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
    {
      // RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
      // String valueToFind = ((au.UsuarioCreadorId == "-1") || (au.UsuarioCreadorId == null)) ? au.UserId : au.UsuarioCreadorId;

      String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

      this.cbxCia.ClearSelection();
      ListItem li = cbxCia.Items.FindByValue(valueToFind);

      if (li != null)
      {
        li.Selected = true;
        cbxCia.Enabled = false;

      }
      this.gViewReporte.Columns[0].Visible = false;
      Boolean viewReserva = GestorNotificacion.hasVisibilityPermissionAseguradora(Convert.ToDecimal(valueToFind), "V_RESERVAS");
      if (!viewReserva) this.gViewReporte.Columns[12].Visible = false;

    }
    ListItem item = new ListItem("TODOS", "");
    this.cbxCia.Items.Insert(0, item);

  }
  protected void cbxBroker_DataBound(object sender, EventArgs e)
  {
    if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
    {

      au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
      String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

      this.cbxBroker.ClearSelection();
      ListItem li = cbxBroker.Items.FindByValue(valueToFind);

      if (li != null)
      {
        li.Selected = true;
        cbxBroker.Enabled = false;

      }

      this.gViewReporte.Columns[1].Visible = false;
      //this.gViewReporte.Columns[12].Visible = false;

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
      this.gViewReporte.Columns[8].Visible = false;
    }
    ListItem item = new ListItem("TODOS", "");
    this.cbxAjustador.Items.Insert(0, item);
  }
  protected void cbxProducto_DataBound(object sender, EventArgs e)
  {
    ListItem item = new ListItem("TODOS", "");
    this.cbxProducto.Items.Insert(0, item);

  }
  protected void cbxCobertura_DataBound(object sender, EventArgs e)
  {
    ListItem item = new ListItem("TODOS", "");
    this.cbxCobertura.Items.Insert(0, item);

  }
  public String muestraSimbolo(object aseguradoraId, object brokerId, Object simbolo, Object monto)
  {
    String simboloSalida = "";
    try
    {
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
  protected void ibtnExportar_Click2(object sender, ImageClickEventArgs e)
  {
    this.GrillaRepeater.Visible = true;
    this.GrillaRepeater.DataBind();

    string html_reporte = "";
    try
    {
      html_reporte = File.ReadAllText(Server.MapPath("Conf/cabecera_reportex.html"));
    }
    catch (Exception ex)
    {

    }

    html_reporte = html_reporte.Replace("{Fecha}", DateTime.Today.ToShortDateString());
    html_reporte = html_reporte.Replace("{Usuario}", Convert.ToString(Session["NombreUsuario"]));

    html_reporte += addCriterios();

    System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
    System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);


    this.GrillaRepeater.Visible = true;
    this.GrillaRepeater.DataBind();


    this.GrillaRepeater.RenderControl(oHtmlTextWriter);


    html_reporte += "<br />" + oStringWriter.ToString() + "</body></html>";

    #region reeemplazoTildes_y_simbolos

    html_reporte = RGen.Utiles.utilidades.encodeStringToHTMLSimbols(html_reporte);

    #endregion




    Response.Clear();
    Response.Buffer = true;
    Response.ContentType = "application/vnd.ms-excel";
    Response.AddHeader("Content-Disposition", "attachment;filename=Reportes_Riesgos_Generales.xls");
    Response.Charset = "UTF-16";
    Response.Write(html_reporte);

  }
  private string addCriterios()
  {

    String cadenaOri = File.ReadAllText(Server.MapPath("Conf/criterios_reportex.html"));

    ListItemCollection Criterios = new ListItemCollection();

    #region AqadiendoCriterios
    Criterios.Add(new ListItem("Asegurado", this.txtAsegurado.Text));
    Criterios.Add(new ListItem("Aseguradora", this.cbxCia.SelectedItem.Text));
    Criterios.Add(new ListItem("Broker", this.cbxBroker.SelectedItem.Text));
    Criterios.Add(new ListItem("Encargado Aseguradora", this.txtEjecutivo.Text));
    Criterios.Add(new ListItem("Encargado Broker", this.txtEjecutivoBroker.Text));
    Criterios.Add(new ListItem("Encargado Ajustador", this.cbxAjustador.SelectedItem.Text));
    Criterios.Add(new ListItem("Nro. Poliza", this.txtPoliza.Text));
    Criterios.Add(new ListItem("Status", this.cbxEstatus.SelectedItem.Text));
    if ((this.txtFechaInicio.Text != "") || (this.txtFechaFin.Text != "")) Criterios.Add(new ListItem("Fecha de Siniestro", this.txtFechaInicio.Text + " y " + this.txtFechaFin.Text));
    if ((this.txtDiasEntre.Text != "") || (this.txtDiasHasta.Text != "")) Criterios.Add(new ListItem("Dmas de asignado", this.txtDiasEntre.Text + " y " + this.txtDiasHasta.Text));
    Criterios.Add(new ListItem("Producto", this.cbxProducto.SelectedItem.Text));
    Criterios.Add(new ListItem("Ramo", this.cbxRamo.SelectedItem.Text));
    Criterios.Add(new ListItem("Cobertura", this.cbxCobertura.SelectedItem.Text));
    Criterios.Add(new ListItem("Tipo de Ajuste", this.cbxLiquidacion.SelectedItem.Text));
    Criterios.Add(new ListItem("Tipo de Siniestro", this.txtSiniestro.Text));
    Criterios.Add(new ListItem("N0 Siniestro", this.txtNroSiniestroCia.Text));
    Criterios.Add(new ListItem("N0 Broker", this.txtNroSiniestroBroker.Text));
    Criterios.Add(new ListItem("N0 Ajuste", this.txtNroAjuste.Text));
    if ((this.txtReservaEntre.Text != "") || (this.txtReservaHasta.Text != "")) Criterios.Add(new ListItem("Reserva Neta", this.txtReservaEntre.Text + " y " + this.txtReservaHasta.Text));
    if ((this.txtEntre.Text != "") || (this.txtFin.Text != "")) Criterios.Add(new ListItem("Dmas desde el zltimo Cambio de Estado", this.txtEntre.Text + " y " + this.txtFin.Text));
    #endregion

    String str_html_total = "";

    foreach (ListItem ite in Criterios)
    {
      string str_html = "";
      if (ite.Value != "")
      {
        str_html = cadenaOri.Replace("{CRITERIO}", ite.Text);
        str_html = str_html.Replace("{VALOR}", ite.Value);
      }
      str_html_total += str_html;
    }

    return str_html_total;


  }


  protected void ibtnExportar_Click(object sender, ImageClickEventArgs e)
  {
    //export to excel
    this.gViewReporte.AllowPaging = false;
    this.gViewReporte.DataBind();

    String buffer = "";

    #region cabecera

    buffer = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><metahttp-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" /><title>Reporte Riesgos Generales</title></head><body>";
    buffer += "<table width=\"1000\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px;\">" +
              "<tr style=\"font-size:20px;font-weight:bold;\">" +
                "<td height=\"30\" width=\"1000\" colspan=\"14\" bgcolor=\"#FFFFFF\" style=\"text-align:center;vertical-align:middle;width:1000px; \" >Reporte de Riesgos Generales </td>" +
              "</tr><tr style=\"font-size:10px;font-weight:bold;\"><td height=\"30\" colspan=\"14\" bgcolor=\"#FFFFFF\" style=\"text-align:center;vertical-align:middle;\" >Preventores Asociados S.A.C.</td></tr><tr><td height=\"19\" style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\" >&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
                "<td style=\"text-align:center;vertical-align:middle;\" bgcolor=\"#FFFFFF\">&nbsp;</td>" +
              "</tr></table><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px;\"><tr><td height=\"22\" colspan=\"2\">Fecha:</td>" +
                "<td colspan=\"2\" style=\"text-align:left;vertical-align:middle;\">" + DateTime.Today.ToShortDateString() + "</td>  </tr>  <tr>    <td height=\"22\" colspan=\"2\">Usuario:</td>    <td colspan=\"2\">" + Convert.ToString(Session["NombreUsuario"]) + "</td>  </tr>  <tr>    <td height=\"22\" colspan=\"2\"><b>Filtrado Por</b> :</td>    <td >&nbsp;</td>" +
                "<td >&nbsp;</td>  </tr>  <tr>    <td height=\"12\">&nbsp;</td>    <td  height=\"12\">&nbsp;</td>    <td height=\"12\">&nbsp;</td>    <td height=\"12\">&nbsp;</td>  </tr></table>";

    #endregion


    buffer += this.createFilterChoosed();




    System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
    System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);


    this.GrillaRepeater.Visible = true;
    this.GrillaRepeater.DataBind();


    this.GrillaRepeater.RenderControl(oHtmlTextWriter);


    buffer += "<br />" + oStringWriter.ToString() + "</body></html>";

    #region reeemplazoTildes_y_simbolos
    buffer = buffer.Replace("a", "&aacute;");
    buffer = buffer.Replace("A", "&Aacute;");

    buffer = buffer.Replace("i", "&eacute;");
    buffer = buffer.Replace("I", "&Eacute;");

    buffer = buffer.Replace("m", "&iacute;");
    buffer = buffer.Replace("M", "&Iacute;");

    buffer = buffer.Replace("s", "&oacute;");
    buffer = buffer.Replace("S", "&Oacute;");

    buffer = buffer.Replace("z", "&uacute;");
    buffer = buffer.Replace("Z", "&Uacute;");

    buffer = buffer.Replace("$", "US$");



    #endregion



    Response.Clear();
    Response.Buffer = true;
    Response.ContentType = "application/vnd.ms-excel";
    Response.AddHeader("Content-Disposition", "attachment;filename=Reportes_Riesgos_Generales.xls");
    Response.Charset = "UTF-16";
    Response.Write(buffer);

    this.gViewReporte.AllowPaging = true;
    this.GrillaRepeater.Visible = false;


    Response.End();



  }

  private string createFilterChoosed()
  {
    String cadena = "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px;\">" +
                          criterioAsegurado() +
                          "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Aseguradora</p></td>    <td>" + isEmpty(cbxCia.SelectedItem.Text) + "</td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>" +
                          "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Broker</p></td>    <td>" + isEmpty(cbxBroker.SelectedItem.Text) + "</td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>" +
                          criterioEngargadoAseguradora() +
                          criterioBroker() +
                          "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Encargado    Ajustador</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.cbxAjustador.SelectedItem.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>" +
                          criterioPoliza() +
                          "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Status</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.cbxEstatus.SelectedItem.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>" +
                          criterioFechas() +
                          criterioDias() +
                          "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Producto</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.cbxProducto.SelectedItem.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>" +
                          "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Ramo</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.cbxRamo.SelectedItem.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>" +
                          "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Cobertura&nbsp;</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.cbxCobertura.SelectedItem.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>" +
                          "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Tipo de    Ajuste</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.cbxLiquidacion.SelectedItem.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>" +
                          criterioSiniestro() +
                          criterioNumeroSiniestroCia() +
                          criterioNumeroSiniestroBroker() +
                          criterioNumeroAjuste() +
                          criterioReserva() +
                          criteriosDiasDesde() +
                     "</table>";

    return cadena;

  }

  #region criterios
  private string criteriosDiasDesde()
  {
    if ((this.txtEntre.Text != "") || (this.txtFin.Text != ""))
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>D&iacute;as desde    el &uacute;ltimo Cambio de Estado</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Entre " + isEmpty(this.txtEntre.Text) + " y " + isEmpty(this.txtFin.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }

  }

  private string criterioReserva()
  {
    if ((this.txtReservaEntre.Text != "") || (this.txtReservaHasta.Text != ""))
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Reserva    Neta</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Entre " + isEmpty(this.txtReservaEntre.Text) + " y " + isEmpty(this.txtReservaHasta.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string criterioNumeroAjuste()
  {
    if (this.txtNroAjuste.Text != "")
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>N&deg; Ajuste</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.txtNroAjuste.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string criterioNumeroSiniestroBroker()
  {
    if (this.txtNroSiniestroBroker.Text != "")
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>N&deg; Broker</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.txtNroSiniestroBroker.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string criterioNumeroSiniestroCia()
  {
    if (this.txtNroSiniestroCia.Text != "")
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>N&deg;    Siniestro</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.txtNroSiniestroCia.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string criterioSiniestro()
  {
    if (this.txtSiniestro.Text != "")
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Tipo de    Siniestro</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.txtSiniestro.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string criterioDias()
  {
    if ((this.txtDiasEntre.Text != "") || (this.txtDiasHasta.Text != ""))
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>D&iacute;as de    asignado</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Entre " + isEmpty(this.txtDiasEntre.Text) + " y " + isEmpty(this.txtDiasHasta.Text) + "</p></td>     <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }


  }

  private string criterioFechas()
  {
    if ((this.txtFechaInicio.Text != "") || (this.txtFechaFin.Text != ""))
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Fecha de    Siniestro</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Entre las fechas " + isEmpty(this.txtFechaInicio.Text) + " y " + isEmpty(this.txtFechaFin.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string criterioPoliza()
  {
    if (this.txtPoliza.Text != "")
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Nro.    Poliza</p></td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>" + isEmpty(this.txtPoliza.Text) + "</p></td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string criterioBroker()
  {
    if (this.txtEjecutivoBroker.Text != "")
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Encargado    Broker</p></td>    <td>" + isEmpty(this.txtEjecutivoBroker.Text) + "</td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string criterioEngargadoAseguradora()
  {
    if (this.txtEjecutivo.Text != "")
    {
      return "<tr>    <td>&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Encargado    Aseguradora</p></td>    <td>" + isEmpty(this.txtEjecutivo.Text) + "</td>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }

  }

  private string criterioAsegurado()
  {
    if (this.txtAsegurado.Text != "")
    {

      return "<tr>    <td width=\"38\">&nbsp;</td>    <td width=\"131\" nowrap=\"nowrap\" valign=\"bottom\"><p>Asegurado</p></td>    <td width=\"127\">" + this.isEmpty(this.txtAsegurado.Text) + "</td>    <td width=\"82\">&nbsp;</td>    <td width=\"84\">&nbsp;</td>  </tr>";
    }
    else
    {
      return "";
    }
  }

  private string isEmpty(string p)
  {
    return ((p != null) && (p != "")) ? p : "--";
  }

  #endregion

  public override void VerifyRenderingInServerForm(Control control)
  {
    // Confirms that an HtmlForm control is rendered for the 
    //specified ASP.NET server control at run time. 
  }


  private void ClearControls(Control control)
  {
    for (int i = control.Controls.Count - 1; i >= 0; i--)
    {
      ClearControls(control.Controls[i]);
    }

    if (!(control is TableCell))
    {
      if (control.GetType().GetProperty("SelectedItem") != null)
      {
        LiteralControl literal = new LiteralControl();
        control.Parent.Controls.Add(literal);
        try
        {
          literal.Text = (string)control.GetType().GetProperty("SelectedItem").GetValue(control, null);
        }
        catch
        {
        }
        control.Parent.Controls.Remove(control);
      }
      else
        if (control.GetType().GetProperty("Text") != null)
        {
          LiteralControl literal = new LiteralControl();
          control.Parent.Controls.Add(literal);
          literal.Text = (string)control.GetType().GetProperty("Text").GetValue(control, null);
          control.Parent.Controls.Remove(control);
        }
    }
    return;

  }
}
