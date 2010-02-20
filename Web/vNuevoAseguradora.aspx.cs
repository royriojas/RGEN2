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

public partial class vNuevoAseguradora : System.Web.UI.Page
{
    private AtribucionesUsuario au = null; 

    protected void Page_Load(object sender, EventArgs e)
    {
        au = Session["datosUsuario"] as AtribucionesUsuario;

        CCSOL.Utiles.Utilidades.redirectToUrlWhenIsNull(au, Response,"vLogin.aspx?urlAnterior=" + Request.RawUrl);

        String noShowBtn = CCSOL.Utiles.Utilidades.isNull(Request.QueryString["noShowSeparateBtn"], "false");
        if (noShowBtn == "true")
        {
            this.lnkSeparar.Visible = false;
        }

        string action = utilidades.isNull(Request.QueryString["action"], "nuevo");
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
        this.FormView1.ChangeMode(FormViewMode.Edit);
        this.FormView1.DefaultMode = FormViewMode.Edit;

        this.nuevoRegDiv.Style.Value = "display:none;";
    }

    private void doNewActions()
    {
        this.FormView1.ChangeMode(FormViewMode.Insert);
        this.FormView1.DefaultMode = FormViewMode.Insert;
        this.nuevoRegDiv.Style.Value = "display:block;";
        
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (au != null)
        {
            e.Values.Add("ucrea", au.UserName);
        }
        e.Values.Add("chkPersonaJuridica", true);
    }


    public string muestraEstado(String estado)
    {
        String salida = "<b>Inhabilitado</b>";
        if (estado == "A") salida = "Habilitado";
        return salida;
    }

    public String setDireccion(decimal personaId) 
    {
        return "document.location.href = '" + this.Request.Path + "?action=editar&AseguradoraId=" + personaId.ToString() + "';return false;";
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
            mensaje = "Inhabilitar esta Aseguradora";
        }
        else
        {
            mensaje = "Habilitar esta Aseguradora";
        }
        return mensaje;
    }

    public String setMensajeConfirmacion(string estado)
    {
        String mensaje = "";
        if (estado == "A")
        {
            mensaje = "return confirm('¿Confirma la Inhabilitación de esta Aseguradora?')";
        }
        else
        {
            mensaje = "return confirm('¿Confirma la Habilitación de esta Aseguradora?')";
        }
        return mensaje;
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (au != null)
        {
            e.Values.Add("@uupdate", au.UserName);
        }
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        if (au != null)
        {
            e.NewValues.Add("ucrea", au.UserName);
            e.NewValues.Add("chkPersonaJuridica", true);
        }
    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        this.GridView1.DataBind();
    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        this.GridView1.DataBind();
    }
    public string setUrlAssignUser(decimal personaId)
    {
        return "document.location.href = 'vAsignarUsuario.aspx?rolId=3&PersonaId=" + personaId.ToString() + "';return false;";
    }
}
