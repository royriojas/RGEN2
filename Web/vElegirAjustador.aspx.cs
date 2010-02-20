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
using AjaxPro;
using RGen.Gestores;
using RGen;

public partial class vElegirAjustador : System.Web.UI.Page
{
  public String huboPostBack = "false";
  private RGen.Utiles.AtribucionesUsuario au;
  protected void Page_Load(object sender, EventArgs e)
  {
    AjaxPro.Utility.RegisterTypeForAjax(typeof(vElegirAjustador));
    au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
    if (au == null)
    {
      String urlActual = Request.Url.ToString();
      Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
    }
    validaCasoUso();

  }
  protected void validaCasoUso()
  {
    //verifico que el usuario pueda ejecutar este caso de uso
    if (!au.verificaAtributo("ASIGNARAJUSTADOR"))
    {
      String urlActual = Request.Url.ToString();
      Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
    }
  }
  protected void btnRegistrar_Click(object sender, EventArgs e)
  {
    odsAsignarAjustador.UpdateParameters.Add("usuario", au.Usuario);
    odsAsignarAjustador.Update();

    if (this.chkNotificar.Checked)
    {
      enviarNotificacion(this.txtCorreo.Text, this.DropDownList1.SelectedItem.Text);
    }

    this.huboPostBack = "true";
  }

  private void enviarNotificacion(string correo, string nombrePersona)
  {
    RGen.Utiles.RGenMailer mailSender = new RGen.Utiles.RGenMailer();
    try
    {
      mailSender.enviaMensaje(this.txtCorreo.Text, "Notificación de Asignación de Ajuste | fecha " + DateTime.Now.ToString(), "Sr. " + nombrePersona + " el administrador del Sistema Riesgos Generales le ha asignado el Ajuste N° " + GestorAjuste.dameNumeroAjuste(Convert.ToDecimal(Request.QueryString["AjusteId"])) + "<br /> se le agradecerá tome las medidas necesarias para atender el caso en la brevedad posible.");
    }
    catch (Exception ex)
    {
      LoggerFacade.Log(ex);
      Response.Redirect("vMuestraMensaje.aspx?mensaje=Error: " + Server.UrlEncode(ex.Message));
    }




  }

  [AjaxPro.AjaxMethod]
  public string obtenCorreoPersona(int personaid)
  {
    string correo = "";
    try
    {
      correo = GestorUsuarios.getUserEmail(Convert.ToDecimal(personaid));
    }
    catch (Exception ex)
    {
      correo = "error : " + ex.Message;
    }

    return correo;
  }
}
