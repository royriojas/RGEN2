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
using System.Globalization;
using utiles;
using System.Net.Sockets;

public partial class vEditorRegistroInicialAjuste : System.Web.UI.Page
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
    {
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

    }

    protected Boolean strToDate(TextBox t)
    {
        String fechaStr = t.Text;
        //asumo que si alguno de los 3 campos de la reunión viajan vacios se permite dejarlas viajar así como nulas a la BD
        if (fechaStr != "")
        {
            Boolean valido = true;
            DateTime temp;
            try
            {
                temp = Convert.ToDateTime(fechaStr);
            }
            catch (Exception ex)
            {
                valido = false;

            }
            return valido;
        }
        else return true;
    }

    protected Boolean verificaCamposFecha()
    {
        Boolean camposValidos =
            strToDate((TextBox)this.FormView1.FindControl("txtFechaHoraAviso")) &&
            strToDate((TextBox)this.FormView1.FindControl("txtFechaConfirmacion")) &&
            strToDate((TextBox)this.FormView1.FindControl("txtFechaHoraSiniestro")) &&
            strToDate((TextBox)this.FormView1.FindControl("txtFechaHoraCoordinacion")) &&
            strToDate((TextBox)this.FormView1.FindControl("txtFechaHoraProgramacionInspeccion")) &&
            strToDate((TextBox)this.FormView1.FindControl("txtFechaHoraReunion"));

        if (camposValidos)
        {
            #region validacionFechas
            if (((TextBox)FormView1.FindControl("txtFechaConfirmacion")).Text != "")
            {
                if (((TextBox)FormView1.FindControl("txtFechaHoraAviso")).Text != "")
                {
                    if (Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaConfirmacion")).Text) < Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraAviso")).Text))
                    {
                        this.lblError.Text = "La fecha de confirmación no puede ser anterior que la fecha de aviso. El caso de Ajuste no se ha podido registrar. ";
                        camposValidos = false;
                    }
                }
            }
            if (((TextBox)FormView1.FindControl("txtFechaHoraSiniestro")).Text != "")
            {
                if (((TextBox)FormView1.FindControl("txtFechaHoraAviso")).Text != "")
                {
                    if (Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraSiniestro")).Text) > Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraAviso")).Text))
                    {
                        this.lblError.Text = "La fecha del Siniestro no puede ser posterior a la fecha de aviso. El caso de Ajuste no se ha podido registrar.";
                        camposValidos = false;
                    }
                }
            }

            if (((TextBox)FormView1.FindControl("txtFechaHoraCoordinacion")).Text != "")
            {
                if (((TextBox)FormView1.FindControl("txtFechaHoraAviso")).Text != "")
                {
                    if (Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraAviso")).Text) > Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraCoordinacion")).Text))
                    {
                        this.lblError.Text = "La fecha de Aviso no puede ser posterior a la fecha de coordinación. El caso de Ajuste no se ha podido registrar.";
                        camposValidos = false;
                    }
                }
            }
            if ((((TextBox)FormView1.FindControl("txtFechaHoraCoordinacion")).Text != "") && (((TextBox)FormView1.FindControl("txtFechaHoraReunion")).Text != ""))
            {
                if (Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraCoordinacion")).Text) > Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraReunion")).Text))
                {
                    this.lblError.Text = "La fecha de la Coordinación no puede ser posterior a la fecha de programación de inspección. El caso de Ajuste no se ha podido registrar. ";
                    camposValidos = false;
                }

            }
            if ((((TextBox)FormView1.FindControl("txtFechaHoraCoordinacion")).Text != "") && (((TextBox)FormView1.FindControl("txtFechaHoraProgramacionInspeccion")).Text != "") &&
                (((TextBox)FormView1.FindControl("txtFechaHoraReunion")).Text != ""))
            {
                if (Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraCoordinacion")).Text) > Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraReunion")).Text))
                {
                    this.lblError.Text = "La fecha de la Coordinación no puede ser posterior a la fecha de programación de inspección. El caso de Ajuste no se ha podido registrar. ";
                    camposValidos = false;
                }
                if (Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraCoordinacion")).Text) > Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraProgramacionInspeccion")).Text))
                {
                    this.lblError.Text = "La fecha de la Coordinación no puede ser posterior a la fecha de reunión de inspección. El caso de Ajuste no se ha podido registrar. ";
                    camposValidos = false;
                }
                if (Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraReunion")).Text) > Convert.ToDateTime(((TextBox)FormView1.FindControl("txtFechaHoraProgramacionInspeccion")).Text))
                {
                    this.lblError.Text = "La fecha de la inspección no puede ser anterior a la fecha de programación de inspección. El caso de Ajuste no se ha podido registrar. ";
                    camposValidos = false;
                }
            }


            #endregion validacionFechas
        }
        if (!camposValidos)
        {
            this.pnlMsgError.Visible = true;
        }
        return camposValidos;
    }


    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        if (verificaCamposFecha())
        {

            pnlMsgError.Visible = false;
            try
            {
                decimal AjusteId = Convert.ToDecimal(qStringAjusteId);
                string Cuerpo = "";
                this.FormView1.UpdateItem(true);
                this.actualizaEstado();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptcierra", "recargaVentanaPadre();", true);

                if (cumplioLaInspeccion())
                {

                    if (!String.IsNullOrEmpty(qStringAjusteId))
                    {

                        Cuerpo = GestorNotificacion.armaCuerpo(AjusteId, Server.MapPath("Conf/plantillaNotificacion.html"), "Se notifica que ya se ha cunplido con realizar la INSPECCIÓN");
                        Boolean itDoes = GestorNotificacion.sendMail(AjusteId,
                                                    "inspeccion_realizada_" + qStringAjusteId,
                                                    "N_INSPECCIONREALIZADA",
                                                    "Notificación de cumplimiento de INSPECCIÓN",
                                                    Cuerpo,
                                                    null,
                                                    DateTime.Now);

                    }

                }
                if (RGen.GestorAjuste.dameTipoAjuste(AjusteId) == 2)
                {

                    GestorNotificacion.cancelarMailPeriodico("dias_informe_basico_" + AjusteId.ToString());

                    Cuerpo = GestorNotificacion.armaCuerpo(AjusteId, Server.MapPath("Conf/plantillaNotificacion.html"), "Se notifica que se ha cumplido el plazo de entrega del INFORME FINAL RÁPIDO");

                    DateTime fechaEnvio = DateTime.Now;

                    RGen.ControlDiasAseguradora control = RGen.GestorAjuste.dameControlAseguradora(RGen.GestorAjuste.dameAjuste(AjusteId).aseguradoraId);
                    if (control != null)
                    {

                        Boolean itDoes = GestorNotificacion.sendMailPeriodicoAjustador(AjusteId,
                                                  "dias_informe_final_rapido_" + AjusteId.ToString(),
                                                  "Notificación de cumplimiento de plazo para el INFORME FINAL RÁPIDO",
                                                  Cuerpo,
                                                  null,
                                                  control.DiasIFR);
                    }

                }
                else
                {
                    if (RGen.GestorAjuste.dameTipoAjuste(AjusteId) == 1)
                    {
                        GestorNotificacion.cancelarMailPeriodico("dias_informe_final_rapido_" + AjusteId.ToString());

                        Cuerpo = GestorNotificacion.armaCuerpo(AjusteId, Server.MapPath("Conf/plantillaNotificacion.html"), "Se notifica que se ha cumplido el plazo de entrega del INFORME BÁSICO");

                        DateTime fechaEnvio = DateTime.Now;

                        RGen.ControlDiasAseguradora control = RGen.GestorAjuste.dameControlAseguradora(RGen.GestorAjuste.dameAjuste(AjusteId).aseguradoraId);
                        if (control != null)
                        {
                            Boolean itDoes = GestorNotificacion.sendMailPeriodicoAjustador(AjusteId,
                                                  "dias_informe_basico_" + AjusteId.ToString(),
                                                  "Notificación de cumplimiento del plazo para el INFORME BÁSICO",
                                                  Cuerpo,
                                                  null,
                                                  control.DiasIB);
                        }
                    }
                }



            }

            catch (Exception ex)
            {
                this.lblError.Text = "Revise que todos los campos sean correctos por favor";
                this.pnlMsgError.Visible = true;
            }

        }





    }

    private bool cumplioLaInspeccion()
    {
        return !String.IsNullOrEmpty(CCSOL.Utiles.Utilidades.getInternalValueFromForm(this.FormView1, "txtFechaHoraCoordinacion")) &&
                !String.IsNullOrEmpty(CCSOL.Utiles.Utilidades.getInternalValueFromForm(this.FormView1, "txtFechaHoraProgramacionInspeccion")) &&
                !String.IsNullOrEmpty(CCSOL.Utiles.Utilidades.getInternalValueFromForm(this.FormView1, "txtFechaHoraReunion"));

    }
    protected void actualizaEstado()
    {
        //TextBox temp = (TextBox) FormView1.FindControl("txtFechaHoraCoordinacion");
        this.sdsCambioEstado.InsertParameters.Clear();
        /*
        */

        TextBox temp = (TextBox)FormView1.FindControl("txtFechaHoraCoordinacion");
        //viene validada la fecha desde el lado del cliente por lo cual no se necesita mayores cambios
        if (temp.Text != "")
        {

            String estadoAjuste = "14";
            this.sdsCambioEstado.InsertParameters.Clear();
            this.sdsCambioEstado.InsertParameters.Add("fechaAux", TypeCode.DateTime, temp.Text);
            this.sdsCambioEstado.InsertParameters.Add("AjusteId", this.qStringAjusteId);
            this.sdsCambioEstado.InsertParameters.Add("estadoAjusteId", estadoAjuste);
            this.sdsCambioEstado.InsertParameters.Add("u_ucrea", au.UserName);
            this.sdsCambioEstado.Insert();
        }
        temp = (TextBox)FormView1.FindControl("txtFechaHoraProgramacionInspeccion");
        //viene validada la fecha desde el lado del cliente por lo cual no se necesita mayores cambios
        if (temp.Text != "")
        {

            String estadoAjuste = "15";
            this.sdsCambioEstado.InsertParameters.Clear();
            this.sdsCambioEstado.InsertParameters.Add("fechaAux", TypeCode.DateTime, temp.Text);
            this.sdsCambioEstado.InsertParameters.Add("AjusteId", this.qStringAjusteId);
            this.sdsCambioEstado.InsertParameters.Add("estadoAjusteId", estadoAjuste);
            this.sdsCambioEstado.InsertParameters.Add("u_ucrea", au.UserName);
            this.sdsCambioEstado.Insert();
        }




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



    protected void sdsRegistroInicial_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        utiles.debugClass.muestra(e.Command, Server.MapPath("updating.log"));
    }
    protected void FormView1_DataBound(object sender, EventArgs e)
    {

        sincronizaTipoSiniestro();
        desactivaComboAjustador();
   
    }

    private void sincronizaTipoSiniestro()
    {
        //Logger logger = new Logger(Server.MapPath("log.txt"));

        fillCbxTipoSiniestro();

        TextBox frm_txtTipoSiniestroId = this.FormView1.FindControl("txtTipoSiniestroId") as TextBox;

        if (frm_txtTipoSiniestroId == null)
        {
            //logger.addLogItem(new LogItem("no se pudo encontrar el campo txtTipoSiniestroId dentro del FormView1"));
            LoggerFacade.Log("no se pudo encontrar el campo txtTipoSiniestroId dentro del FormView1");
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

                    LoggerFacade.Log("no se pudo encontrar dentro de la coleccion de valores del combobox un valor con el valor de Id : " + frm_txtTipoSiniestroId.Text);
                }
            }
            else
            {
                LoggerFacade.Log("no se pudo encontrar el combo cbxTipoSiniestro dentro del FormView1");
                //logger.addLogItem(new LogItem("no se pudo encontrar el combo cbxTipoSiniestro dentro del FormView1"));
            }
        }


        //logger.writeLog();


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
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        //Logger logger = new Logger(Server.MapPath("log.txt"));
        DropDownList cbxTipoSiniestro = this.FormView1.FindControl("cbxTipoSiniestro") as DropDownList;
        if (cbxTipoSiniestro != null)
        {
            e.NewValues.Add("tipoSiniestroId", cbxTipoSiniestro.SelectedValue);
        }
        else
        {
            LoggerFacade.Log("No ha sido posible grabar el nuevo valor del Tipo de siniestro, no es posible hallar el combobox cbxTipoSiniestro");
        }

        DropDownList cbxEjecutivoSiniestro = FormView1.FindControl("cbxEjecutivoSiniestro") as DropDownList;
        if (cbxEjecutivoSiniestro != null)
        {
            e.NewValues.Add("ejecutivoSiniestrosid", cbxEjecutivoSiniestro.SelectedValue);
        }





    }
    protected void sdsRegistroInicial_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {

        if (e.AffectedRows > 0)
        {
            this.pnlConfirmacion.Visible = true;
        }
        else
        {
            LoggerFacade.Log("aparentenmente no se está actualizando el registro Inicial del Ajuste, no se han afectado filas. ventana vEditorRegistroInicialAjuste.aspx");
        }

    }

}
