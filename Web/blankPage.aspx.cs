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

public partial class blankPage : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    String qAjuste = Request.QueryString["AjusteId"];
    this.lblEstadoActual.Text = "--";
    this.lblTipoAjuste.Text = "--";

    //CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(qAjuste, Response, Request.Url.ToString());
    if (qAjuste != null)
    {
      decimal ajusteId;
      try
      {
        ajusteId = Convert.ToDecimal(qAjuste);
      }
      catch (Exception ex)
      {
        ajusteId = -1;
      }
      if (ajusteId != -1)
      {
        this.lblEstadoActual.Text = GestorAjuste.dameEstado(ajusteId);
        dsAjax.AjaxDatosCabeceraAjusteRow row = GestorAjuste.dameAjuste(ajusteId);
        if (row != null)
          this.lblTipoAjuste.Text = row.tajuste;
      }

    }




  }
}
