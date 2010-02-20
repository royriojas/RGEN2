using System;
using System.Configuration;
using System.Collections;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class vNuevoCasoAjuste : Page
{
    public string deboAceptarFoco = "true";
    public String NumeroAjuste;
    public String ruta;



    public class Contacto
    {
        private string nombre;

        public string Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }
        private string telefono;

        public string Telefono
        {
            get { return telefono; }
            set { telefono = value; }
        }
        private string email;

        public string Email
        {
            get { return email; }
            set { email = value; }
        }

    }


    RGen.Utiles.AtribucionesUsuario au;

    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(vNuevoCasoAjuste));
        try
        {
            au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
            aplicaReglasDelPerfil();
        }
        catch (Exception ex)
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }
    }

    private void aplicaReglasDelPerfil()
    {
        if (au == null)
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }

        this.rqValidatorTxtAsegurado.Enabled = false;

        if (!au.verificaAtributo("NUEVOAJUSTECOMPLETO"))
        {

            this.lnkSinRamo.Visible = false;

            this.rqValidatorTxtAsegurado.Enabled = true;


            AjustadorInspeccion.Visible = false;
            //cbxEjecutivoSiniestros.Visible = false;
            //para el javascript que interpreta el manejo del foco
            this.deboAceptarFoco = "false";
            this.btnBuscaPoliza.Visible = false;


            this.txtNumPoliza.ReadOnly = false;
            this.txtNumPoliza.Enabled = true;
            this.txtNumPoliza.Width = new Unit(195);

            this.txtPersonaAsegurada.ReadOnly = false;
            this.txtPersonaAsegurada.Enabled = true;

            this.txtContratante.ReadOnly = false;
            this.txtContratante.Enabled = true;

            /*this.txtRamo.Enabled = true;
            this.txtRamo.ReadOnly = false;*/

            this.txtRamoAfectado.Visible = false;
            this.cbxRamo.Visible = true;

            /*
             * 
             *  TODO: Cambiar las verificaciones por ROL a verificaciones por acceso a una funcionalidad
             * 
             * 
             */
            if (!IsPostBack)
            {
                this.cbxCiaSeguros.DataBind();

                this.cbxCiaSeguros.DataBind();
            }
            if (au.TipoUsuario == "AdminCiaSeguros")
            {
                String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

                this.cbxCiaSeguros.ClearSelection();
                ListItem li = cbxCiaSeguros.Items.FindByValue(valueToFind);

                if (li != null)
                {
                    li.Selected = true;
                    cbxCiaSeguros.Enabled = false;

                }

                this.cbxTipoComunicacionConfirmacion.DataBind();

                this.cbxQuienNotifico.Items.FindByValue("Cia Seguros").Enabled = false;
            }
            if (au.TipoUsuario == "EjecutivoCiaSeguros")
            {
                String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

                this.cbxCiaSeguros.ClearSelection();
                ListItem li = cbxCiaSeguros.Items.FindByValue(valueToFind);

                if (li != null)
                {
                    li.Selected = true;
                    cbxCiaSeguros.Enabled = false;

                }

                this.cbxTipoComunicacionConfirmacion.DataBind();
                this.cbxTipoComunicacionConfirmacion.Items.FindByValue("5").Selected = true;
                this.cbxQuienNotifico.Items.FindByValue("Cia Seguros").Enabled = false;

            }
            if (au.TipoUsuario == "AdminBroker")
            {
                String companiaId = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));
                this.asbBroker.SelectedValue = companiaId;
                this.asbBroker.Text = RGen.Gestores.GestorUsuarios.getCompaniaNombre(Convert.ToDecimal(companiaId));

                this.asbBroker.Enabled = false;

                this.cbxTipoComunicacionConfirmacion.Enabled = false;
                this.txtNombreConfirmante.Enabled = false;
                this.txtPuesto.Enabled = false;
                this.txtFechaConfirmacion.Enabled = false;
                this.cbxQuienNotifico.Items.FindByValue("Broker").Enabled = false;

            }
            if (au.TipoUsuario == "EjecutivoBroker")
            {
                String companiaId = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));
                this.asbBroker.SelectedValue = companiaId;
                this.asbBroker.Text = RGen.Gestores.GestorUsuarios.getCompaniaNombre(Convert.ToDecimal(companiaId));

                this.asbBroker.Enabled = false;

                this.cbxTipoComunicacionConfirmacion.Enabled = false;
                this.txtNombreConfirmante.Enabled = false;
                this.txtPuesto.Enabled = false;
                this.txtFechaConfirmacion.Enabled = false;
                this.cbxQuienNotifico.Items.FindByValue("Broker").Enabled = false;

            }
        }
        // agregar la opcion Ajustador Por asignar
        if ((String)Session["TipoUsuario"] == "Ajustador")
        {
            if (!IsPostBack)
            {
                this.odsAjustador.DataBind();
                this.cbxAjustador.DataBind();
                ListItem aux = new ListItem("Por Asignar", "", true);
                this.cbxAjustador.Items.Insert(0, aux);
                this.cbxAjustador.Enabled = false;
                this.txtRamoAfectado.Visible = true;
                this.cbxRamo.Visible = false;

            }
        }
        if (((String)Session["TipoUsuario"] == "Administrador") || ((String)Session["TipoUsuario"] == "Asistente") || ((String)Session["TipoUsuario"] == "EjecutivoSiniestro"))
        {
            if (!IsPostBack)
            {
                this.txtRamoAfectado.Visible = true;
                this.cbxRamo.Visible = false;

            }
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
                temp = Convert.ToDateTime(fechaStr,CultureInfo.GetCultureInfo("es-PE"));
            }
            catch (Exception ex)
            {
                valido = false;

            }
            return valido;
        }
        else return true;
    }

    private static DateTime? ConvertToDateInEsPeFormat(String date)
    {
        if (string.IsNullOrEmpty(date)) return null;
        return Convert.ToDateTime(date, CultureInfo.GetCultureInfo("es-PE"));
    }

    protected Boolean VerificaCamposFecha()
    {
        Boolean camposValidos =
            strToDate(txtFechaHoraAviso) &&
            strToDate(txtFechaConfirmacion) &&
            strToDate(txtFechaHoraSiniestro) &&
            strToDate(txtFechaHoraCoordinacion) &&
            strToDate(txtFechaHoraProgramacionInspeccion) &&
            strToDate(txtFechaHoraReunion);

        if (camposValidos)
        {
            #region validacionFechas

            DateTime? fechaHoraAviso = ConvertToDateInEsPeFormat(txtFechaHoraAviso.Text);
            DateTime? fechaConfirmacion = ConvertToDateInEsPeFormat(txtFechaConfirmacion.Text);
            DateTime? fechaSiniestro = ConvertToDateInEsPeFormat(txtFechaHoraSiniestro.Text);
            DateTime? fechaCoordinacion = ConvertToDateInEsPeFormat(txtFechaHoraCoordinacion.Text);
            DateTime? fechaReunion = ConvertToDateInEsPeFormat(txtFechaHoraReunion.Text);
            DateTime? fechaProgramaInspeccion = ConvertToDateInEsPeFormat(txtFechaHoraProgramacionInspeccion.Text);

            if (fechaConfirmacion != null && fechaHoraAviso != null && fechaConfirmacion < fechaHoraAviso)
            {
                lblError.Text =
                    "EL AJUSTE NO SE PUEDE REGISTRAR.<br />La fecha de confirmación no puede ser anterior a la fecha de aviso.";
                camposValidos = false;
            }
            if (fechaSiniestro != null && (fechaHoraAviso != null && fechaSiniestro > fechaHoraAviso))
            {
                lblError.Text =
                    "EL AJUSTE NO SE PUEDE REGISTRAR.<br />La fecha del Siniestro no puede ser posterior a la fecha de aviso.";
                camposValidos = false;
            }

            if (fechaCoordinacion != null && (fechaHoraAviso != null && fechaHoraAviso > fechaCoordinacion))
            {
                lblError.Text =
                    "EL AJUSTE NO SE PUEDE REGISTRAR.<br />La fecha de Aviso no puede ser posterior a la fecha de coordinación.";
                camposValidos = false;
            }
            if ((fechaCoordinacion != null) && (fechaReunion != null) && fechaCoordinacion > fechaReunion)
            {
                lblError.Text =
                    "EL AJUSTE NO SE PUEDE REGISTRAR.<br />La fecha de la Coordinación no puede ser posterior a la fecha de programación de inspección.";
                camposValidos = false;
            }
            if ((fechaCoordinacion !=null) && (fechaProgramaInspeccion != null) && (fechaReunion != null))
            {
                if (fechaCoordinacion > fechaReunion)
                {
                    lblError.Text = "EL AJUSTE NO SE PUEDE REGISTRAR.<br />La fecha de la Coordinación no puede ser posterior a la fecha de programación de inspección.";
                    camposValidos = false;
                }
                else if (fechaCoordinacion > fechaProgramaInspeccion)
                {
                    lblError.Text = "EL AJUSTE NO SE PUEDE REGISTRAR.<br />La fecha de la Coordinación no puede ser posterior a la fecha de reunión de inspección.";
                    camposValidos = false;
                } else if (fechaReunion > fechaProgramaInspeccion)
                {
                    lblError.Text = "EL AJUSTE NO SE PUEDE REGISTRAR.<br />La fecha de la inspección no puede ser posterior a la fecha de programación de inspección. ";
                    camposValidos = false;
                }
            }


            #endregion validacionFechas
        }
        if (!camposValidos)
        {
            pnlMsgError.Visible = true;
        }
        return camposValidos;
    }

    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        //Logger logger = new Logger(Server.MapPath("log.txt"));
        if (VerificaCamposFecha())
        {
            if (!au.verificaAtributo("NUEVOAJUSTECOMPLETO"))
            {
                #region caso_incompleto

                try
                {
                    odsNuevoAjusteAseguradora1.InsertParameters.Add("usuario", ((au != null) ? au.Usuario : "SYSTEM"));
                    odsNuevoAjusteAseguradora1.Insert();
                }
                catch (Exception ex)
                {
                    //logger.addLogItem(new LogItem("No se pudo registrar el caso de ajuste. El error asociado es : " + ex.Message));
                    LoggerFacade.Log(ex);
                }

                #endregion caso_incompleto
            }
            else
            {
                sqlNuevoAjuste.Insert();

            }
        }
    }

    public String formaHTML()
    {
        #region correoHTML

        String html_mail = File.ReadAllText(Server.MapPath("~/Conf/plantilla_correo_adm.html"));

        html_mail = html_mail.Replace("{MEDIONOTIFICACION}", this.cbxQuienNotifico.SelectedItem.Text);
        html_mail = html_mail.Replace("{NOMBRENOTIFICANTE}", this.txtNotificante.Text);
        html_mail = html_mail.Replace("{QUIENCONFIRMO}", this.txtNombreConfirmante.Text);
        html_mail = html_mail.Replace("{CARGOCONFIRMANTE}", this.txtPuesto.Text);
        html_mail = html_mail.Replace("{FECHAHORAAVISO}", this.txtFechaHoraAviso.Text);
        html_mail = html_mail.Replace("{ASEGURADORA}", this.cbxCiaSeguros.SelectedItem.Text);
        html_mail = html_mail.Replace("{CONTACTOASEGURADO}", this.txtContactoPersona.Text);
        html_mail = html_mail.Replace("{TELEFONORESPONSABLE}", this.txtTelefonoContacto.Text);
        html_mail = html_mail.Replace("{DIRECCIONSINIESTRO} ", this.txtLugarDelSiniestro.Text + " " + txtDatoUbigeo.Text);
        html_mail = html_mail.Replace("{ASEGURADO}", this.txtPersonaAsegurada.Text);
        html_mail = html_mail.Replace("{CONTRATANTE}", this.txtContratante.Text);
        html_mail = html_mail.Replace("{RAMOAFECTADO}", this.cbxRamo.SelectedValue);
        html_mail = html_mail.Replace("{NUMPOLIZA}", this.txtNumPoliza.Text);
        html_mail = html_mail.Replace("{NUMAJUSTE}", this.NumeroAjuste);
        html_mail = html_mail.Replace("{URLTOREDIRECT}", ruta + "vAsignarAjustador.aspx");
        html_mail = html_mail.Replace("{SHORTDATE}", DateTime.Today.ToShortDateString());
        html_mail = html_mail.Replace("{FECHAHORA}", DateTime.Today.ToString());



        html_mail = RGen.Utiles.utilidades.encodeStringToHTMLSimbols(html_mail);
        #endregion correoHTML

        return html_mail;


    }

    protected void odsNuevoAjusteAseguradora1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            this.NumeroAjuste = e.Command.Parameters["@numeroAjuste"].Value.ToString();
            string ajusteId = e.Command.Parameters["@ajuId"].Value.ToString();
            //Enviar un correo al administrador para que atienda el caso de ajuste (crea el ajuste pero no pone ninguna poliza)
            RGen.Utiles.RGenMailer mailSender = new RGen.Utiles.RGenMailer();

            ArrayList para = new ArrayList();

            //obtenemos los correos que están en la BD como parametros y correosADM
            para = RGen.Gestores.gestorParametros.getCorreosAdministrativos();

            para.Add(ConfigurationManager.AppSettings["correoAdministrador"]);

            try
            {
                this.ruta = R3M.Common.Util.ResolveURL("./");
            }
            catch (Exception ex)
            {
                //logger.addLogItem(new LogItem("la ruta de instalacion no se encuentra : " + ex.Message));
                LoggerFacade.Log(ex);
            }

            try
            {
                mailSender.enviaMensaje(para, "Notificación de Ajuste Vía Web", formaHTML());
            }
            catch (Exception ex)
            {
                //logger.addLogItem(new LogItem("El mensaje no pudo enviarse. El error asociado es : " + ex.Message));
                LoggerFacade.Log(ex);
            }

            Response.Redirect(String.Format("vMensaje.aspx?AjusteId={0}&NumAjuste={1}", ajusteId, this.NumeroAjuste));
        }
        else
        {
            LoggerFacade.Log(e.Exception);
        }


    }
    protected void sqlNuevoAjuste_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception == null)
        {
            this.NumeroAjuste = e.Command.Parameters["@numeroAjuste"].Value.ToString();
            string ajusteId = e.Command.Parameters["@ajusteId"].Value.ToString();

            enviaMailPeriodico(Convert.ToDecimal(ajusteId));

            Response.Redirect(String.Format("vMensaje.aspx?AjusteId={0}&NumAjuste={1}", ajusteId, this.NumeroAjuste));
        }
        else
        {
            LoggerFacade.Log(e.Exception);
        }
    }

    private void enviaMailPeriodico(decimal ajusteId)
    {
        try
        {

            string Cuerpo = "";

            if (RGen.GestorAjuste.dameTipoAjuste(ajusteId) == 2)
            {
                Cuerpo = GestorNotificacion.armaCuerpo(ajusteId, Server.MapPath("Conf/plantillaNotificacion.html"), "Se notifica que se ha cumplido el plazo de entrega del INFORME FINAL RÁPIDO");
                DateTime fechaEnvio = DateTime.Now;
                RGen.ControlDiasAseguradora control = RGen.GestorAjuste.dameControlAseguradora(Convert.ToDecimal(cbxCiaSeguros.SelectedValue));
                Boolean itDoes = GestorNotificacion.sendMailPeriodicoAjustador(ajusteId,
                                          "dias_informe_final_rapido_" + ajusteId.ToString(),
                                          "Notificación de cumplimiento de plazo para el INFORME FINAL RÁPIDO",
                                          Cuerpo,
                                          null,
                                          control.DiasIFR);

            }
            else
            {
                if (RGen.GestorAjuste.dameTipoAjuste(ajusteId) == 1)
                {
                    Cuerpo = GestorNotificacion.armaCuerpo(ajusteId, Server.MapPath("Conf/plantillaNotificacion.html"), "Se notifica que se ha cumplido el plazo de entrega del INFORME BÁSICO");

                    DateTime fechaEnvio = DateTime.Now;
                    RGen.ControlDiasAseguradora control = RGen.GestorAjuste.dameControlAseguradora(Convert.ToDecimal(cbxCiaSeguros.SelectedValue));
                    Boolean itDoes = GestorNotificacion.sendMailPeriodicoAjustador(ajusteId,
                                          "dias_informe_basico_" + ajusteId.ToString(),
                                          "Notificación de cumplimiento del plazo para el INFORME BÁSICO",
                                          Cuerpo,
                                          null,
                                          control.DiasIB);
                }
            }


        }
        catch (Exception e)
        {
            LoggerFacade.Log(e);
        }


    }

    protected void sqlNuevoAjuste_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        //if (false) utiles.debugClass.muestra(e.Command, Server.MapPath("DebugFile"));
    }

    protected void cbxCiaSeguros_DataBound(object sender, EventArgs e)
    {
        if ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Administrador"))
        {
            RGen.Utiles.utilidades.addItemTodos(sender, "[Elija una]", "-1", IsPostBack);
        }
    }

    protected void cbxCorredorSeguros_DataBound(object sender, EventArgs e)
    {
        if ((au.TipoUsuario == "Ajustador") || (au.TipoUsuario == "Administrador") || (au.TipoUsuario != "Broker"))
        {
            RGen.Utiles.utilidades.addItemTodos(sender, "[Elija uno]", "-1", IsPostBack);
        }
    }

    protected void cbxTipoComunicacion_DataBound(object sender, EventArgs e)
    {
        RGen.Utiles.utilidades.addItemTodos(sender, "[Elija uno]", "-1", IsPostBack);
    }

    protected void cbxTipoSiniestro_DataBound(object sender, EventArgs e)
    {
        if (!au.verificaAtributo("NUEVOAJUSTECOMPLETO"))
        {
            RGen.Utiles.utilidades.addItemTodos(sender, "[Elija un Ramo]", "-1", IsPostBack);
        }
        else
        {
            RGen.Utiles.utilidades.addItemTodos(sender, "[Elija una Póliza]", "-1", IsPostBack);
        }
    }

    protected void cbxTipoAjuste_DataBound(object sender, EventArgs e)
    {
        RGen.Utiles.utilidades.addItemTodos(sender, "[Elija uno]", "-1", IsPostBack);
    }

    protected void cbxAjustador_DataBound(object sender, EventArgs e)
    {
        RGen.Utiles.utilidades.addItemTodos(sender, "[Elija uno]", "-1", IsPostBack);
    }

    protected void cbxTipoComunicacionConfirmacion_DataBound(object sender, EventArgs e)
    {
        RGen.Utiles.utilidades.addItemTodos(sender, "[Elija uno]", "-1", IsPostBack);
    }
    protected void btnFillTiposSiniestro_Click(object sender, EventArgs e)
    {
        doFill();
    }
    private void doFill()
    {
        this.cbxTipoSiniestro.DataBind();
        RGen.Utiles.utilidades.addItemTodos(this.cbxTipoSiniestro, "[Elija uno]", "-1", false);
    }

    protected void lnkSinRamo_Click(object sender, EventArgs e)
    {
        if (this.lnkSinRamo.Text == "Sin Ramo")
        {
            this.lnkSinRamo.Text = "Con Ramo";
            this.lnkSinRamo.OnClientClick = "return CheckIfPossible(1);";
            this.sdsTiposDeSiniestroByRamoId.SelectParameters.Clear();
            this.sdsTiposDeSiniestroByRamoId.SelectParameters.Add("ramoId", TypeCode.Int32, "-1");

            doFill();
        }
        else
        {
            this.lnkSinRamo.Text = "Sin Ramo";
            this.lnkSinRamo.OnClientClick = "return CheckIfPossible(0);";

            this.sdsTiposDeSiniestroByRamoId.SelectParameters.Clear();
            this.sdsTiposDeSiniestroByRamoId.SelectParameters.Add("ramoId", TypeCode.Int32, txtRamoId.Text);

            doFill();
        }
    }


    [AjaxPro.AjaxMethod]
    public Contacto getEjecutivoAseguradora(int personaId)
    {

        Contacto c = new Contacto();

        dsAutoCompletesTableAdapters.EjecutivoTableAdapter ta = new dsAutoCompletesTableAdapters.EjecutivoTableAdapter();
        dsAutoCompletes.EjecutivoDataTable dt = ta.GetData(Convert.ToDecimal(personaId));
        if (dt.Rows.Count > 0)
        {
            try
            {
                c.Nombre = dt[0].persona;
            }
            catch (Exception ex)
            {
                c.Nombre = "--";
            }


            try
            {
                c.Telefono = dt[0].TFIJO;
            }
            catch (Exception ex)
            {
                c.Telefono = "--";
            }


            try
            {
                c.Email = dt[0].email;
            }
            catch (Exception ex)
            {
                c.Email = "--";
            }
        }

        return c;
    }




}
