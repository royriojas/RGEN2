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

public partial class InformesPlantillas_InformeDefault : System.Web.UI.Page
{
  public String tipoInforme;
  public String titulos;

  private int _num = 0;

  public Boolean IsFinal
  {
    get
    {
      return Request.QueryString["TI"] == "IF";
    }
  }

  public int Num
  {
    get { return _num; }
    set { _num = value; }
  }

  private String Concepto1 = null;
  private String Concepto2 = null;

  public decimal SumaDetalleOcurrencia
  {
    get
    {
      if (ViewState["SumaDetalleOcurrencia"] == null) return 0;
      return Convert.ToDecimal(ViewState["SumaDetalleOcurrencia"]);
    }
    set { ViewState["SumaDetalleOcurrencia"] = value; }
  }


  protected void Page_Load(object sender, EventArgs e)
  {
    tipoInforme = Request.QueryString["TI"];

    switch (tipoInforme)
    {

      case "IB":
        {
          this.titulos = "Informe Básico";
          this.divLiquidacion.Visible = false;
          this.divSubtitulosAdicionales.Visible = false;
          this.divTitulosAdionales.Visible = false;
          break;
        }
      case "IP":
        {
          this.titulos = "Informe Preliminar";
          this.divLiquidacion.Visible = false;
          break;
        }
      case "IC":
        {
          this.titulos = "Informe Complementario";
          this.divLiquidacion.Visible = false;
          break;
        }
      case "IF":
        {
          this.titulos = "Informe Final";

        }
        break;
    }

  }

  public String GetNumeroEnTexto(Object numero, Object Simbolo)
  {
    String Moneda = String.Empty;
    if (Simbolo != null && Simbolo != DBNull.Value)
    {
      decimal MonedaId = (decimal)Simbolo;
      dsAjusteNewTableAdapters.QueriesTableAdapter qta = new dsAjusteNewTableAdapters.QueriesTableAdapter();
      Moneda = String.Format("{0}", qta.getMonedaById(MonedaId));
    }

    if (numero != null && numero != DBNull.Value)
    {
      return String.Format("{0} {1}", R3M.Common.Util.getNumberAsLetters(Convert.ToDouble(numero)), Moneda);
    }
    return "0";
  }

  protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    {
      DataRowView drow = e.Item.DataItem as DataRowView;
      if (drow == null) return;
      dsReporte.InformeBasicoOcurrenciaDetalleRow row = ((dsReporte.InformeBasicoOcurrenciaDetalleRow)drow.Row);
      if (!row.IsestimacionNull()) SumaDetalleOcurrencia += row.estimacion;
    }

  }
  protected void odsOcurrenciaDetalle_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
  {
    SumaDetalleOcurrencia = 0;
    Num = 1;
  }
  protected void odsPolizaDetalle_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
  {
    Num = 1;
  }
  protected void odsPolizaDetalle_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.divSublimitesAfectados.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
  }

  protected void repeaterSublimites_ItemCreated1(object sender, RepeaterItemEventArgs e)
  {
    if (e.Item.ItemType == ListItemType.Footer)
    {
      Label lbl1 = this.repeaterSublimites.Controls[0].FindControl("concepto1Label") as Label;
      Label lbl2 = this.repeaterSublimites.Controls[0].FindControl("concepto2Label") as Label;
      if (lbl1 != null)
        lbl1.Text = Concepto1;
      if (lbl2 != null)
        lbl2.Text = Concepto2;

    }

  }
  protected void repeaterSublimites_ItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    {

      DataRowView drow = e.Item.DataItem as DataRowView;
      if (drow == null) return;
      dsReporte.InformeBasicoPolizaDetalleRow row = ((dsReporte.InformeBasicoPolizaDetalleRow)drow.Row);
      if (!row.IsconceptoNull()) Concepto1 = row.concepto;
      if (!row.Isconcepto2Null()) Concepto2 = row.concepto2;

    }

  }
  protected void odsDocumentosSolicitados_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.divDocumentacionSolicitada.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
  }
  protected void odsClausulas_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.divClausulas.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
  }
  protected void odsDeducibles_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.divDeducibles.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
  }
  protected void odsOcurrenciaDetalle_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.divDanos.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
  }
  protected void odsTitulosAdicionales_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.divTitulosAdionales.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
  }

  protected void odsImagenes_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.divImagenes.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
  }


  protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    {
      Num2++;
      if ((Num2 % 2) == 0)
      {
        Literal ltl = e.Item.FindControl("separator") as Literal;
        if (ltl != null)
          ltl.Visible = true;
      }
      if ((Num2 % 4) == 0)
      {
        Literal ltl2 = e.Item.FindControl("TableEnd") as Literal;
        if (ltl2 != null)
          ltl2.Visible = true;
      }
    }
  }
  protected void Repeater2_DataBinding(object sender, EventArgs e)
  {
    Num2 = 0;
  }

  private Int32 _num2;
  public Int32 Num2
  {
    get
    {
      return _num2;
    }
    set
    {
      _num2 = value;
    }
  }

  protected void odsLiquidacion_Selected(object sender, ObjectDataSourceStatusEventArgs e)
  {
    this.divLiquidacion.Visible = !RGen.GestorAjuste.AjusteRechazado(Convert.ToInt32(Request.QueryString["AjusteId"]));
  }
}
