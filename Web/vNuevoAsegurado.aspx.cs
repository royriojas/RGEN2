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
using RGen.Utiles;

public partial class vNuevoAsegurado : System.Web.UI.Page
{
  private AtribucionesUsuario au = null;

  protected void Page_Load(object sender, EventArgs e)
  {
    au = (AtribucionesUsuario)Session["datosUsuario"];

    CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + this.Request.RawUrl);

    String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
    if (noShowBtn == "true")
    {
      this.lnkSeparar.Visible = false;
    }

    //redireccionar al Login 
    //verificar el permiso MANTENIMIENTO_ASEGURADOS
    String action = utilidades.isNull(Request.QueryString["action"], "nuevo");
    switch (action)
    {
      case "nuevo": doNewActions();
        break;
      case "editar": doEditActions();
        break;
    }
  }


  private void doEditActions()
  {
    this.nuevoRegDiv.Style.Value = "display: block";
    this.FormView1.ChangeMode(FormViewMode.Edit);
    FormView1.DefaultMode = FormViewMode.Edit;
  }

  private void doNewActions()
  {
    this.nuevoRegDiv.Style.Value = "display: none";
    this.FormView1.ChangeMode(FormViewMode.Insert);
  }
  protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
  {
    if (au != null)
    {
      e.Values.Add("ucrea", au.UserName);

    }
    //e.Values.Add("chkPersonaJuridica", true);
  }
  protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {

  }
  protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
  {
    if (au != null)
    {
      e.Values.Add("@uupdate", au.UserName);
    }
  }

  public String muestraEstado(String estado)
  {
    String result = "<b>Inhabilitado</b>";
    switch (estado)
    {
      case "A": result = "Habilitado";
        break;
    }
    return result;
  }
  protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
  {

    Boolean myValue = false;

    RadioButtonList r = FormView1.FindControl("rbgrpNaturalJuridica") as RadioButtonList;

    if (r != null)
    {
      myValue = Convert.ToBoolean(r.SelectedValue);
    }

    e.NewValues.Add("chkPersonaJuridica", myValue);
    if (au != null) e.NewValues.Add("ucrea", au.UserName);
  }

  protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
  {
    this.GridView1.DataBind();
  }
  protected void FormView1_DataBound(object sender, EventArgs e)
  {

  }
  public String setMensajeConfirmacion(string estado)
  {
    String mensaje = "";
    if (estado == "A")
    {
      mensaje = "return confirm('¿Confirma la Inhabilitación de este Asegurado?')";
    }
    else
    {
      mensaje = "return confirm('¿Confirma la Habilitación de este Asegurado?')";
    }
    return mensaje;
  }
  public String setImage(string estado)
  {
    String mensaje = "";
    if (estado == "A")
    {
      mensaje = "./imgRGen/button_ok.gif";
    }
    else
    {
      mensaje = "./imgRGen/deleteItem.gif";
    }
    return mensaje;
  }
  public String setToolTip(String estado)
  {
    String mensaje = "";
    if (estado == "A")
    {
      mensaje = "Inhabilitar este Asegurado";
    }
    else
    {
      mensaje = "Habilitar este Asegurado";
    }
    return mensaje;
  }
  public String setDireccion(decimal personaId)
  {
    return "document.location.href = '" + this.Request.Path + "?action=editar&AseguradoId=" + personaId.ToString() + "';return false;";
  }
  protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
  {
    this.GridView1.DataBind();
  }
  protected void btnSearch_Click(object sender, EventArgs e)
  {
    this.GridView1.DataBind();
  }
}
