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
using System.Text.RegularExpressions;

public partial class InformesPlantillas_HeaderInformeDefault : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }

  private string GetTipoInforme(string TI)
  {
    Label lblFechaSiniestro = this.frmDatosCabecera.FindControl("lblFechaSiniestro") as Label;
    if (lblFechaSiniestro != null)
    {
      lblFechaSiniestro.Text = DateTime.Now.ToShortDateString();
    }

    switch (TI)
    {
      case "IB": return "INFORME BÁSICO";
        break;
      case "IP": return "INFORME PRELIMINAR";
        break;
      case "IC": return "INFORME COMPLEMENTARIO";
        break;
      case "IF":
        String tituloInforme = "";
        string s_ajusteId = Request.QueryString["AjusteId"];
        if (!Regex.IsMatch(s_ajusteId, "d*")) s_ajusteId = "0";
        Int32 ajusteId = Convert.ToInt32(s_ajusteId);
        if (GestorAjuste.dameTipoAjuste(ajusteId) != 2)
        {
          tituloInforme = "INFORME FINAL";
        }
        else
        {
          tituloInforme = "INFORME FINAL RÁPIDO";
        }

        Label re = this.frmDatosCabecera.FindControl("lblTipoMonto") as Label;
        if (re != null)
          re.Text = "INDEMNIZACIÓN";

        Label mi = this.frmDatosCabecera.FindControl("reservaLabel") as Label;
        if (mi != null)
        {
          decimal gAI = GestorAjuste.dameTotalIndemnizacion(ajusteId);

          mi.Text = gAI.ToString("#,##0.00");
        }

        return tituloInforme;
        break;
    }
    return String.Empty;

  }
  protected void frmDatosCabecera_DataBound(object sender, EventArgs e)
  {
    String TipoInforme = GetTipoInforme(Request.QueryString["TI"]);

    Label tI = this.frmDatosCabecera.FindControl("lblTipoInforme") as Label;
    if (tI != null)
      tI.Text = TipoInforme;

  }
}
