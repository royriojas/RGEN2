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
using utiles;

public partial class vViewRegistroInicial : System.Web.UI.Page
{
    RGen.Utiles.AtribucionesUsuario au;
    public String qStringAjusteId;
    public String FechaHoraReunionAnterior;
    public String FechaHoraInspeccion;
    
    protected void Page_Load(object sender, EventArgs e)
    {

      au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
      qStringAjusteId = Request.QueryString["AjusteId"];

      if (!IsPostBack) cargaOpcionesDelPerfil();
    }
    private void cargaOpcionesDelPerfil()
    {/*
      if (au != null)
      {
        if (!au.verificaAtributo("EDITORAJUSTE"))
        {
          String urlActual = Request.Url.ToString();
          Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }
        //desactivaComboAjustador();
      }
      else
      {
        String urlActual = Request.Url.ToString();
        Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
      }
        */
    }

  
    protected void desactivaComboAjustador()
    {
      DropDownList cbxA = (DropDownList)this.FormView1.FindControl("cbxAjustador");
      if (cbxA != null)
      {
        if (!au.verificaAtributo("ASIGNARAJUSTADOR"))
        {
          cbxA.Enabled = false;
        }
      }

    }


    protected void seleccionaValorDelCombo(DropDownList cbx, String valueToSet)
    {
      cbx.ClearSelection();
      ListItem li = cbx.Items.FindByValue(valueToSet);

      if (li != null)
      {
        li.Selected = true;
      }
    }



   
    protected void FormView1_DataBound(object sender, EventArgs e)
    {
      sincronizaTipoSiniestro();
      desactivaComboAjustador();
    }

    private void sincronizaTipoSiniestro()
    {
      Logger logger = new Logger(Server.MapPath("log.txt"));

      fillCbxTipoSiniestro();

      TextBox frm_txtTipoSiniestroId = this.FormView1.FindControl("txtTipoSiniestroId") as TextBox;

      if (frm_txtTipoSiniestroId == null)
      {
        logger.addLogItem(new LogItem("no se pudo encontrar el campo txtTipoSiniestroId dentro del FormView1"));
      }
      else
      {
        DropDownList cbxTipoSiniestro = this.FormView1.FindControl("cbxTipoSiniestro") as DropDownList;
        if (cbxTipoSiniestro != null)
        {
          ListItem item = cbxTipoSiniestro.Items.FindByValue(frm_txtTipoSiniestroId.Text) as ListItem;
          if (item != null)
          {
            cbxTipoSiniestro.ClearSelection();
            item.Selected = true;
          }
          else
          {
            logger.addLogItem(new LogItem("no se pudo encontrar dentro de la coleccion de valores del combobox un valor con el valor de Id : " + frm_txtTipoSiniestroId.Text));
          }
        }
        else
        {
          logger.addLogItem(new LogItem("no se pudo encontrar el combo cbxTipoSiniestro dentro del FormView1"));
        }
      }


      logger.writeLog();


    }

    protected void btnFillTiposSiniestro_Click(object sender, EventArgs e)
    {
      fillCbxTipoSiniestro();
    }

    private void fillCbxTipoSiniestro()
    {
      DropDownList cbxTipoSiniestro = this.FormView1.FindControl("cbxTipoSiniestro") as DropDownList;

      if (cbxTipoSiniestro != null)
      {
        cbxTipoSiniestro.DataBind();
        RGen.Utiles.utilidades.addItemTodos(cbxTipoSiniestro, "[Elija uno]", "-1", false);
      }
    }
    
   
}




