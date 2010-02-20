using System;
using System.Data;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using AjaxPro;
using LlankAnaERP.Callback;
using RGen.Utiles;

public partial class vEditorUsuario : Page
{
    protected string deboCerrar = "false";
    private string acc;

    public string rolId;

    private int idUsuario;

    public RGen.Utiles.AtribucionesUsuario au;
    public bool ocultarCompania = false;

    public EventControl usuarioEventControl = new EventControl();

    private void SetupEventControl()
    {
        #region registro de Script
        this.usuarioEventControl.ScriptCallback += new EventControl.delScriptCallBack(usuarioEventControl_ScriptCallback);
        this.AddParsedSubObject(usuarioEventControl);
        #endregion
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        this.SetupEventControl();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        idUsuario = int.Parse(Request.QueryString["uid"]);

        rolId = (String)Session["TipoUsuario"];

        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        aplicaReglasDelPerfil();

        acc = Request.QueryString["acc"];
        this.imgBtnAsignarMails.Visible = false;
        switch (acc)
        {
            case "N": usuarioFormView.ChangeMode(FormViewMode.Insert);
                usuarioFormView.DefaultMode = FormViewMode.Insert;
                this.Page.Title = "Nuevo Usuario";
                break;
            case "E": usuarioFormView.ChangeMode(FormViewMode.Edit);
                this.Page.Title = "Editar Usuario";
                this.imgBtnAsignarMails.Visible = true;
                this.imgBtnAsignarMails.PostBackUrl = "vAsignarMail.aspx?personaId=" + Request.QueryString["personaId"];
                break;
            case "D": usuarioFormView.ChangeMode(FormViewMode.ReadOnly);
                guardarImageButton.ImageUrl = "Images/IconDelete32Dark.gif";
                guardarImageButton.ToolTip = "Eliminar registro";
                this.Page.Title = "Eliminar Usuario";
                break;
            case "V": usuarioFormView.ChangeMode(FormViewMode.ReadOnly);
                guardarImageButton.Visible = false;
                this.Page.Title = "Ver Usuario";
                break;
        }

        if (IsPostBack)
        {
            this.Validate();
        }

    }

    private void aplicaReglasDelPerfil()
    {

        if (au == null)
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }

        if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros") ||
            (au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
        {
            ocultarCompania = true;
        }

    }
    private void ocultarASB()
    {
        String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));
        ASB.AutoSuggestBox asb = ((ASB.AutoSuggestBox)usuarioFormView.FindControl("asbCompanias"));
        asb.SelectedValue = valueToFind;
        asb.Text = RGen.Gestores.GestorUsuarios.getCompaniaNombre(Convert.ToDecimal(valueToFind));
        asb.Enabled = false;
    }

    protected void guardarImageButton_Click(object sender, ImageClickEventArgs e)
    {
        switch (usuarioFormView.CurrentMode)
        {
            case FormViewMode.Insert:
                usuarioFormView.InsertItem(false);
                break;
            case FormViewMode.Edit:
                if (acc == "E")
                {
                    usuarioFormView.UpdateItem(false);
                }
                break;
            case FormViewMode.ReadOnly:
                if (acc == "D")
                {
                    try
                    { usuarioFormView.DeleteItem(); }
                    catch
                    { }
                }
                break;
        }

        deboCerrar = "true";
    }
    protected void rolIdCombo_DataBound(object sender, EventArgs e)
    {
        /* utilidades.addItemTodos(sender, "<Elija>", "", IsPostBack);*/
    }
    protected void usuarioFormView_DataBound(object sender, EventArgs e)
    {
        switch (acc)
        {
            case "N": usuarioFormView.ChangeMode(FormViewMode.Insert); break;
            case "E": usuarioFormView.ChangeMode(FormViewMode.Edit); break;
            case "D": usuarioFormView.ChangeMode(FormViewMode.ReadOnly); guardarImageButton.ImageUrl = "Images/IconDelete32Dark.gif"; guardarImageButton.ToolTip = "Eliminar registro"; break;
            case "V": usuarioFormView.ChangeMode(FormViewMode.ReadOnly); guardarImageButton.Visible = false; break;
        }
        if (usuarioFormView.CurrentMode == FormViewMode.Edit)
        {
            string password = ((TextBox)usuarioFormView.FindControl("passwordAuxTextBox")).Text;

            string script = "document.getElementById(\"usuarioFormView_passwordTextBox\").value = '" + password + "';\n";
            script += "document.getElementById(\"usuarioFormView_password2TextBox\").value = '" + password + "';\n";
            ClientScript.RegisterStartupScript(this.GetType(), "ScriptPasswords", script, true);
        }

        
        if (ocultarCompania)
        {
            ocultarASB();
        }
    }

    protected void tipoPersonaCombo_DataBound(object sender, EventArgs e)
    {
        /*utilidades.addItemTodos(sender, "<Elija>", "", IsPostBack);*/
    }

    protected void tdocidIdCombo_DataBound(object sender, EventArgs e)
    {
        /*utilidades.addItemTodos(sender, "<Elija>", "", IsPostBack);*/
    }
    protected void usuarioFormView_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        string rol = Request.Form["usuarioFormView$rolIdCombo"];
        int rolId = 0;
        if (rol != null) rolId = int.Parse(rol);

        if ((rolId == 4) || (rolId == 8))
            e.Values.Add("creadorId", Session["UsuarioID"]);

        String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

        if (!ocultarCompania)
        {
            ASB.AutoSuggestBox asb = ((ASB.AutoSuggestBox)usuarioFormView.FindControl("asbCompanias"));
            valueToFind = asb.SelectedValue;
        }

        e.Values.Add("companiaId", valueToFind);
    }
    protected void usuarioFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        string rol = Request.Form["usuarioFormView$rolIdCombo"];
        int rolId = 0;
        if (rol != null) rolId = int.Parse(rol);

        if ((rolId == 4) || (rolId == 8))
            e.NewValues.Add("creadorId", Session["UsuarioID"]);

        String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

        if (!ocultarCompania)
        {
            ASB.AutoSuggestBox asb = ((ASB.AutoSuggestBox)usuarioFormView.FindControl("asbCompanias"));
            valueToFind = asb.SelectedValue;
        }
        e.NewValues.Add("companiaId", valueToFind);
    }
    protected void odsUsuario_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {

    }

    #region CallBack Usuario
    public string usuarioEventControl_ScriptCallback(CallbackEventArgs eventArgument)
    {
        dsUsuariosTableAdapters.UsuariosByNameTableAdapter usuarioAdapter = new dsUsuariosTableAdapters.UsuariosByNameTableAdapter();
        dsUsuarios.UsuariosByNameDataTable usuarioTable = new dsUsuarios.UsuariosByNameDataTable();

        usuarioAdapter.Fill(usuarioTable, eventArgument.Parameters[0].ToString());

        if (usuarioTable.Rows.Count > 0)
        {
            decimal idUsuarioParam = ((dsUsuarios.UsuariosByNameRow)(usuarioTable.Rows[0])).usuarioId;

            if (idUsuario == idUsuarioParam) return "True";
            return "False";
        }
        return "True";
    }
    #endregion
}
