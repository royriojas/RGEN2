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

public partial class linksAjustadorAdministrador : System.Web.UI.UserControl
{
    RGen.Utiles.AtribucionesUsuario au;
    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];  

        validaCasoUso();
    
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
    }
    public void cambiaLinks()
    {
        this.LnkRegistroAjuste.Visible = this.SepFinRegistroAjuste.Visible = au.verificaAtributo("NUEVOAJUSTE");
        this.LnkListaPendientes.Visible = this.SepListasPendientes.Visible = au.verificaAtributo("AJUSTESPENDIENTES");
        this.LnkAsignarAjustador.Visible = this.SepListaAsignarAjustador.Visible = au.verificaAtributo("ASIGNARAJUSTADOR") ;       
        //this.LnkParrafosComunes.Visible = this.SepTitulosComunes.Visible = au.verificaAtributo("TITULOSCOMUNES");
        //this.LnkListaAjustes.Visible = this.SepListaAjustes.Visible = au.verificaAtributo("LISTAAJUSTE");
        this.lnkAjusteMinimo.Visible = this.SepAjusteMinimo.Visible = au.verificaAtributo("NUEVOAJUSTE");
        this.lnkControlCalidadAjustes.Visible = this.au.verificaAtributo("CONTROLCALIDAD");


                
    }
}
