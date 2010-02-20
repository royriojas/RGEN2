using System;
using RGen.Utiles;

public partial class vLogIn : System.Web.UI.Page
{
    private String urldestino = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        // verifica por el QueryString que se haya recibido la cadena desde una
        // determinada aseguradora y crea una variable de Session necesaria para 
        // incluir algunos banners
        //
        // cargaBanners();
        //
        if (Request.QueryString["urlAnterior"] != null)
        {
            urldestino = Request.QueryString["urlAnterior"].ToString();
        }
        this.Session.Timeout = 30;
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        /*Estos metodos seran cambiados por un solo metodo validar
         * que deberá devolver 
         * el tipo de Usuario en una variable de Session
         * el Nombre de Usuario en una variable de Session
         * 
         * */

       
        
        AtribucionesUsuario au = null;
        try
        {
            RGen.Gestores.GestorUsuarios.validaUsuario(this.stlogin.Text, stclave.Text, out au);
        }
        catch (System.Data.Common.DbException ex)
        {            
            Response.Redirect("vMuestraMensaje.aspx?mensaje=Ocurrió un error durante la conexión con el servidor, por favor haga clic en el botón atrás e inténtelo nuevamente&Titulo=Error Grave",true);
        }

        

        if (au != null)
        {
            Session["datosUsuario"] = au;
            Session["TipoUsuario"] = au.TipoUsuario;
            //Por compatibilidad hacia atrás...
            //ya no son necesarios pero en algunas paginas se les puede estar referenciando
            if ((au.TipoUsuario == "AdminCiaSeguros") || (au.TipoUsuario == "EjecutivoCiaSeguros"))
            {
                Session["TipoUsuario"] = "Aseguradora";
            }
            if ((au.TipoUsuario == "AdminBroker") || (au.TipoUsuario == "EjecutivoBroker"))
            {
                Session["TipoUsuario"] = "Broker";
            }

         /*   if ((au.TipoUsuario == "Asistente")) {
                Session["TipoUsuario"] = "Administrador";
            }*/
            Session["NombreUsuario"] = au.Usuario;
            Session["usuario"] = au.UserName;
            Session["UsuarioID"] = au.UserId;

            if (urldestino == null)
            {
                Response.Redirect("vListaAjuste.aspx");
            }
            else
            {
                Response.Redirect(urldestino);
            }
        }
        else
        {
            this.strespuesta.Visible = true;
        }
    }
}
