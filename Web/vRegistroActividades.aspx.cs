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

public partial class vRegistroActividades : System.Web.UI.Page
{
  public int num = 1;
  private RGen.Utiles.AtribucionesUsuario au;
  protected void Page_Load(object sender, EventArgs e)
  {
      RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

      CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.RawUrl);

      String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
      if (noShowBtn == "true")
      {
          this.lnkSeparar.Visible = false;
      }

      if (Request.QueryString["AjusteId"] == null)
      {
          String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);           
      }
      au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
      
      // si puede agregar actividad puede quitarlas también
      if (!au.verificaAtributo("AGREGARACTIVIDAD"))
      {
          this.nuevaActividad.Attributes.Add("style", "display:none;");
          this.gwListaActividad.Columns[17].Visible = false;
      }
     
      
  }

  protected void actividadFormView_ItemInserted(object sender, FormViewInsertedEventArgs e)
  {
    gwListaActividad.DataBind();
  }

  private DateTime generarFecha(String fecha, String hora)
  {
    DateTime fechaDate = new DateTime(int.Parse(fecha.Substring(6, 4)), int.Parse(fecha.Substring(3, 2)),
      int.Parse(fecha.Substring(0, 2)), int.Parse(hora.Substring(0, 2)), int.Parse(hora.Substring(3, 2)), 0);

    return fechaDate;
  }
}





  

