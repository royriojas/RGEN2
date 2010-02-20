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

public partial class vRegistroComunicacion : System.Web.UI.Page
{
    public int num = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Page.Title = "Bitácoras";
        
        RGen.Utiles.AtribucionesUsuario au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response, "vLogin.aspx?urlAnterior=" + Request.RawUrl);

        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }

        if (Request.QueryString["AjusteId"]==null)
        {
            Response.Redirect("vLogin.aspx");
        }
        this.txtAjusteId.Text = Request.QueryString["AjusteId"];

        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
        {
            this.imgInicial.Attributes.Add("style", "display:none;");
            this.gwListaComunicacion.Columns[13].Visible = false;
        }
        if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
        {
          this.imgInicial.Attributes.Add("style", "display:none;");
          this.gwListaComunicacion.Columns[13].Visible = false;
        }
        if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
        {
          this.imgInicial.Attributes.Add("style", "display:none;");
          this.gwListaComunicacion.Columns[13].Visible = false;
        }
        if (IsPostBack)
        {
            this.ContenidoComunicacion.Style.Add(HtmlTextWriterStyle.Display, "inline");

        }
    }
  
    protected void gwListaComunicacion_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Eliminar")
        {
            txtComunicacionId.Text = e.CommandArgument.ToString();
            odsComunicacionEditor.Delete();
            gwListaComunicacion.DataBind();
        }
    }
    protected void btnAgregar_Click(object sender, EventArgs e)
    {
        Boolean fechaBuena = true;
        if (txtFechaCom.Text != "")
        {
            try
            {
                DateTime fechaDate = Convert.ToDateTime(this.txtFechaCom.Text);
                txtFechaCom.Text = fechaDate.ToString();
            }
            catch (Exception ex)
            {
                fechaBuena = false;
            }   
        }

        if (fechaBuena)
        {
            this.txtNombreArchivo.Text = fupArchivo.FileName;
            odsComunicacionEditor.Insert();
            Response.Redirect("vRegistroComunicacion.aspx?AjusteId=" + this.txtAjusteId.Text);
        }
        else
        {
            this.lblError.Visible = true;
        }

    }
}
