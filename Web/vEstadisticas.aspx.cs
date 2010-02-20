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
using dotnetCHARTING;
using System.Drawing;
using System.IO;
using RGen.Utiles;

public partial class vEstadisticas : System.Web.UI.Page
{

  SeriesCollection getRandomData()
  {
    SeriesCollection SC = new SeriesCollection();
    dsEstadisticasTableAdapters.AjustesporAseguradoTableAdapter myTa = new dsEstadisticasTableAdapters.AjustesporAseguradoTableAdapter();
    dsEstadisticas.AjustesporAseguradoDataTable myTD = myTa.GetData();

    foreach (dsEstadisticas.AjustesporAseguradoRow row in myTD)
    {
      Series s = new Series();
      s.Name = row.Asegurado;

      Element e = new Element();
      e.Name = "Porcentaje";
      e.YValue = Convert.ToDouble(row.Porcentaje);
      e.ShowValue = true;

      s.Elements.Add(e);

      SC.Add(s);

    }

    return SC;
  }

  public string image = "";
  RGen.Utiles.AtribucionesUsuario au;
  void Page_Load(Object sender, EventArgs e)
  {

    if (!IsPostBack)
    {
      cambiaNombre();
      this.cbxAnho.ClearSelection();
      this.cbxAnho.Items.FindByValue(DateTime.Today.Year.ToString()).Selected = true;
    }

    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

    CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.Url.ToString());



    this.TextBox1.Text = cbxAnho.SelectedValue.ToString() + "01";
    this.TextBox2.Text = cbxAnho.SelectedValue.ToString() + "12";

    this.lblEstadisticas.Text = "ESTADISTICAS POR " + this.cbxCriterio.Text;


    // this.SqlDataSource1.DataBind();

    this.generarGraficos(cbxOperacion.SelectedValue, cbxCriterio.SelectedValue);


    //Response.Write(image);

    this.gvReserva.DataBind();
    this.gvDatos.DataBind();
    this.rpt_cantidad.DataBind();
    this.rpt_reserva.DataBind();
  }

  public void cambiaNombre()
  {
    this.Chart1.FileManager.FileName = "t" + DateTime.Now.ToFileTime().ToString();
    Session["fileNameChart"] = this.Chart1.FileManager.FileName;
  }

  public static byte[] getBinaryFromFile(FileInfo f)
  {
    byte[] buffer = null;
    if (f.Exists)
    {
      try
      {
        buffer = new byte[f.OpenRead().Length];
        f.OpenRead().Read(buffer, 0, (int)f.OpenRead().Length);
      }
      catch (Exception ex)
      {
        LoggerFacade.Log(ex);
      }
    }
    return buffer;
  }


  private System.Data.DataTable dataPie(string formatoSeleccionado1, string formatoSeleccionado2)
  {
    System.Data.SqlClient.SqlConnection sqlcnx = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["rgen2ConnectionString"].ConnectionString);
    //new System.Data.SqlClient.SqlConnection("Data Source=desarrollo;Initial Catalog=rgen4;Persist Security Info=True;User ID=sa;password=roca");




    System.Data.SqlClient.SqlCommand sqlcmd = new System.Data.SqlClient.SqlCommand();

    sqlcmd = new System.Data.SqlClient.SqlCommand("sp_rgen_estadistica_general", sqlcnx);
    sqlcmd.CommandType = CommandType.StoredProcedure;

    System.Data.SqlClient.SqlParameter par;

    par = new System.Data.SqlClient.SqlParameter("@criterio1", SqlDbType.VarChar);
    par.Value = formatoSeleccionado1;
    sqlcmd.Parameters.Add(par);

    par = new System.Data.SqlClient.SqlParameter("@criterio2", SqlDbType.VarChar);
    par.Value = formatoSeleccionado2;
    sqlcmd.Parameters.Add(par);

    par = new System.Data.SqlClient.SqlParameter("@fini", SqlDbType.VarChar);
    par.Value = cbxAnho.SelectedValue.ToString() + "01";
    sqlcmd.Parameters.Add(par);

    par = new System.Data.SqlClient.SqlParameter("@ffin", SqlDbType.VarChar);
    par.Value = cbxAnho.SelectedValue.ToString() + "12";
    sqlcmd.Parameters.Add(par);

    //agregamos la compañiaId
    decimal aValue = 0;

    par = new System.Data.SqlClient.SqlParameter("@companiaId", SqlDbType.Decimal);
    par.Value = null;

    String stringValue = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

    if (decimal.TryParse(stringValue, out aValue))
    {
      par.Value = aValue;
    }

    sqlcmd.Parameters.Add(par);


    //sp_rgen_estadistica_general 'SUM','SINIESTRO','200601','200612'

    System.Data.DataTable dtEstadistica = new DataTable();
    System.Data.SqlClient.SqlDataAdapter sqlda =
           new System.Data.SqlClient.SqlDataAdapter(sqlcmd);

    System.Data.DataSet ds = new DataSet();

    sqlda.Fill(ds);

    return ds.Tables[0];
  }

  private void formatoGrafico(dotnetCHARTING.Chart chGrafico, string tipo)
  {

    switch (tipo)
    {
      case "PIE":

        chGrafico.Type = ChartType.Pies;

        chGrafico.LegendBox.Visible = false;
        chGrafico.LegendBox.Template = "%Icon - %Value - %Name";
        chGrafico.LegendBox.Position = LegendBoxPosition.Bottom;

        chGrafico.DefaultElement.ShowValue = true;
        chGrafico.DefaultElement.LabelTemplate = "%Name";// [%Value]";
        chGrafico.YAxis.Percent = true;
        chGrafico.PieLabelMode = PieLabelMode.Outside;
        chGrafico.TempDirectory = "GRAPHICSTEMP";
        break;

      case "BARRAS":
        chGrafico.Type = ChartType.Combo;
        chGrafico.LegendBox.Visible = false;
        chGrafico.DefaultElement.ShowValue = true;
        chGrafico.DefaultElement.LabelTemplate = "%Name";
        chGrafico.TempDirectory = "GRAPHICSTEMP";

        break;

      case "TABLA":
        chGrafico.Type = ChartType.Combo;
        chGrafico.ChartArea.Visible = false;
        chGrafico.LegendBox.Visible = true;
        chGrafico.LegendBox.Template = "%Name%Value";
        chGrafico.DefaultElement.ShowValue = false;
        chGrafico.TempDirectory = "GRAPHICSTEMP";
        break;

    }
  }

  private void generarGraficos(string formatoSeleccionado1, string formatoSeleccionado2)
  {
    DataEngine de = new DataEngine();

    Chart1.TitleBox.Visible = false;


    if (formatoSeleccionado1 == "SUM")
      Chart1.Title = "Numero de Ajustes por ";
    else
      Chart1.Title = "Promedio de Ajustes por ";


    de.DataFields = "XAxis=descripcion,YAxis=cantidad,Name=descripcion";
    Chart1.Series.DataFields = "XAxis=descripcion,YAxis=cantidad,Name=descripcion";

    switch (formatoSeleccionado2)
    {
      case "SINIESTRO":
        Chart1.Title += "Siniestro";
        break;
      case "PRODUCTO":
        Chart1.Title += "Producto";
        break;
      case "RAMO":
        Chart1.Title += "Ramo";
        break;
      case "ASEGURADORA":
        Chart1.Title += "Aseguradora";
        break;
      case "COBERTURA":
        Chart1.Title += "Cobertura";
        break;
      case "BROKER":
        Chart1.Title += "Broker";
        break;
      case "AJUSTADOR":
        Chart1.Title += "Ajustador";
        break;
    }

    formatoGrafico(this.Chart1, "PIE");

    de.Data = dataPie(formatoSeleccionado1, formatoSeleccionado2);
    Chart1.SeriesCollection.Clear();
    Chart1.SeriesCollection.Add(de.GetSeries());
    Chart1.DataBind();

  }

  protected void CbxChangedIndex(object sender, EventArgs e)
  {
    this.cambiaNombre();
  }
  protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
  {
    // utiles.debugClass.muestra(e.Command, Server.MapPath("log.txt"));
    String companiaId = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

    if (companiaId == "") companiaId = "-1";

    if (this.SqlDataSource1.SelectParameters.Count < 5)
    {
      this.SqlDataSource1.SelectParameters.Add("companiaId", companiaId);
    }

  }
  protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
  {
    string s = "";

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
  public override void VerifyRenderingInServerForm(Control control)
  {
    // Confirms that an HtmlForm control is rendered for the 
    //specified ASP.NET server control at run time. 
  }
  protected void Chart1_PreRender(object sender, EventArgs e)
  {

  }
  protected void lnkExport_Click(object sender, ImageClickEventArgs e)
  {
    #region actualizaControlesASerRedenrizados
    this.rpt_cantidad.Visible = true;
    this.rpt_reserva.Visible = true;
    this.rpt_reserva.DataBind();
    this.rpt_cantidad.DataBind();
    #endregion

    string html_reporte = "";
    html_reporte = File.ReadAllText(Server.MapPath("Conf/est(1).txt"));

    html_reporte = html_reporte.Replace("{FECHA}", DateTime.Today.ToShortDateString());
    html_reporte = html_reporte.Replace("{USUARIO}", Session["NombreUsuario"].ToString());

    html_reporte = html_reporte.Replace("{CRITERIO}", this.cbxCriterio.SelectedItem.Text);
    html_reporte = html_reporte.Replace("{OPERACION}", this.cbxOperacion.SelectedItem.Text);
    html_reporte = html_reporte.Replace("{YEAR}", this.cbxAnho.SelectedItem.Text);


    #region renderRepeaters
    System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
    System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);

    this.rpt_cantidad.RenderControl(oHtmlTextWriter);
    this.rpt_reserva.RenderControl(oHtmlTextWriter);
    #endregion

    html_reporte += oStringWriter.ToString();


    html_reporte += File.ReadAllText(Server.MapPath("Conf/est(3).txt"));


    string fileName = Server.MapPath(this.Chart1.TempDirectory + "/" + Session["fileNameChart"].ToString() + ".png");

    #region getDataFromImageFile
    string data_from_image = "";
    try
    {
      FileInfo f = new FileInfo(fileName);
      if (f.Exists)
      {
        data_from_image = Convert.ToBase64String(utilidades.getBytesFromFile(f));
      }
      else
      {
        throw new Exception("No se pudo encontrar la imagen");
      }
    }
    catch (Exception ex)
    {
      data_from_image = "no fue posible encontrar la imagen " + this.Chart1.FileManager.FileName;
    }

    #endregion

    //File.ReadAllText(Server.MapPath("Conf/IMAGE.TXT"));

    #region reeemplazoTildes_y_simbolos

    html_reporte = RGen.Utiles.utilidades.encodeStringToHTMLSimbols(html_reporte);

    #endregion

    html_reporte = html_reporte.Replace("{IMAGE_CONTENTS_BASE64}", data_from_image);

    Response.Clear();
    Response.Buffer = true;
    Response.ContentType = "application/vnd.ms-excel";
    Response.AddHeader("Content-Disposition", "attachment;filename=estadisticas-" + DateTime.Now.ToShortDateString() + ".xls");
    Response.Charset = "UTF-16";
    Response.Write(html_reporte);

    Response.End();
  }
}
