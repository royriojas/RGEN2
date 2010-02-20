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

public partial class vListaInforme : System.Web.UI.Page
{
    public String UrlAnterior; 
    protected void Page_Load(object sender, EventArgs e)
    {
        RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        if (au != null)
        {
            if (!au.verificaAtributo("VERINFORMES"))
            {
                String urlActual = Request.Url.ToString();
				Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
            }
        }
        
        UrlAnterior =  Request.Url.ToString();
    }
  protected void gridInformacionRelevante_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      DataRowView AuxRow = (DataRowView)e.Row.DataItem;
      HyperLink informeHyperLink = (HyperLink)e.Row.FindControl("informeHyperLink");
      informeHyperLink.NavigateUrl = "javascript:VerInforme(" + AuxRow["ajusteId"].ToString() + ", " + AuxRow["informeId"].ToString() + ");";
     /* HyperLink emailHyperLink = (HyperLink)e.Row.FindControl("emailHyperLink");
      emailHyperLink.NavigateUrl = "javascript:EnviarMail(" + AuxRow["ajusteId"].ToString() + ", " + AuxRow["informeId"].ToString() + ");";*/
    }
  }
}
        