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

public enum HeaderLinks : int
{
  ajuste = 1,
  poliza = 2,
  libreria = 3,
  reportes = 4,
  estadisticas = 5,
  opciones = 6
}

public partial class ucHeader : System.Web.UI.UserControl
{
  RGen.Utiles.AtribucionesUsuario au;
  public int tipoUsuarioInt;
  public String NombreUsuario;
  public String TipoUsuario;

  private HeaderLinks tabActual = 0;

  public HeaderLinks TabActual
  {
    get { return tabActual; }
    set { tabActual = value; }
  }

  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(ucHeader));

    //hacer las validaciones necesarias para validar las opciones que se presentan a cada usuario del Sistema y las posibles rutas que pueden tomar
    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
    validaCasoUso();

    switch (TabActual)
    {
      case HeaderLinks.ajuste: this.LnkAjuste.Attributes.Add("class", "MenuItemOver");
        break;
      case HeaderLinks.poliza: this.LnkPoliza.Attributes.Add("class", "MenuItemOver");
        break;
      case HeaderLinks.libreria: this.lnkLibreriaPolizas.Attributes.Add("class", "MenuItemOver");
        break;
      case HeaderLinks.reportes: this.LnkReportes.Attributes.Add("class", "MenuItemOver");
        break;
      case HeaderLinks.estadisticas: this.LnkEstadisticas.Attributes.Add("class", "MenuItemOver");
        break;
      case HeaderLinks.opciones: this.LnkOpciones.Attributes.Add("class", "MenuItemOver");
        break;
      default:
        break;
    }

  }
  protected void validaCasoUso()
  {
    if (au == null)
    {
      String urlActual = Request.Url.ToString();
      Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);

    }
    else
    {
      cambiaLinks();
    }

    this.NombreUsuario = au.Usuario == null ? "" : Convert.ToString(Session["NombreUsuario"]);
    this.TipoUsuario = au.TipoUsuario == null ? "" : Convert.ToString(Session["TipoUsuario"]);

  }
  protected void cambiaLinks()
  {

    this.Sep1.Visible = au.verificaAtributo("LNKAJUSTE");
    this.LnkAjuste.Visible = au.verificaAtributo("LNKAJUSTE");

    this.Sep3.Visible = au.verificaAtributo("LNKPOLIZA"); //sep poliza    
    this.LnkPoliza.Visible = au.verificaAtributo("LNKPOLIZA");

    this.Sep4.Visible = au.verificaAtributo("LNKOPCIONES");
    this.LnkOpciones.Visible = au.verificaAtributo("LNKOPCIONES");

    this.Sep5.Visible = au.verificaAtributo("LNKREPORTES");
    this.LnkReportes.Visible = au.verificaAtributo("LNKREPORTES");

    this.Sep6.Visible = au.verificaAtributo("LNKLIBRERIACLAUSULAS"); //sep Libreria
    this.lnkLibreriaPolizas.Visible = au.verificaAtributo("LNKLIBRERIACLAUSULAS"); //libreia de clausulas       

  }
  protected void lnkCerrarSesion_ServerClick(object sender, EventArgs e)
  {
    Session.Abandon();
    Response.Redirect("vLogin.aspx");
  }
  public String setTime()
  {
    return "?nocache=" + DateTime.Now.ToString();
  }

  [AjaxPro.AjaxMethod]
  public String RefreshSession()
  {
    RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)HttpContext.Current.Session["datosUsuario"];
    if (au == null)
    {
      return "No Session Active";
    }
    else
    {
      return "Session refreshed for " + au.UserName;
    }
  }
}
