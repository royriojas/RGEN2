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
using System.Xml;

public partial class vSubaccesos : System.Web.UI.Page
{
    RGen.Utiles.AtribucionesUsuario au;

    protected void Page_Load(object sender, EventArgs e)
    {
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        if (au == null)
        {
            String urlActual = Request.Url.ToString();
            Response.Redirect("vLogin.aspx?urlAnterior=" + urlActual);
        }
        if (!IsPostBack)
        {
            aplicaReglasDelPerfil();
            controlArchivoXML("R");
            parametrosTableAdapters.CorreosADMTableAdapter ta = new parametrosTableAdapters.CorreosADMTableAdapter();
            this.txtNumInicial.Text = ta.dameNumeroActualdeAjuste();
        }
        
    }

    private void controlArchivoXML(string accion)
    {
        XmlDocument subaccesoDoc = new XmlDocument();
        subaccesoDoc.Load(Server.MapPath("Conf/SubAcceso.xml"));
        XmlNodeList nodoConfiguracion = subaccesoDoc.GetElementsByTagName("SubAcceso");

        // Lectura del documento XML de configuración de los campos a mostrar en el certificado
        foreach (XmlElement valorConf in nodoConfiguracion[0].ChildNodes)
        {
            try
            {
                TextBox valorTextBox = (TextBox)subaccesoPanel.FindControl(valorConf.Name);
                Label valorLabel = (Label)subaccesoPanel.FindControl(valorConf.Name + "Label");
                if (accion == "R")
                {
                    valorTextBox.Text = valorConf.InnerText;
                    valorLabel.Text = valorConf.Attributes["Descripcion"].Value;
                }
                else if (accion == "W")
                    valorConf.InnerText = valorTextBox.Text;
            }
            catch (Exception Ex)
            {
                Console.Write(Ex.Message);
            }
        }

        if (accion == "W")
            subaccesoDoc.Save(Server.MapPath("Conf/SubAcceso.xml"));
    }

    private void aplicaReglasDelPerfil()
    {
        aseguradoraIdCombo.DataBind();


        // el panel de broker se oculta cuando ingresa un administador de RGen
        if (au.TipoUsuario == "Administrador") 
        {
            brokerPanel.Style[HtmlTextWriterStyle.Display] = "none";   
            
        }

        // el panel de aseguradora se oculta cuando ingresa un administrador de aseguradora
        // y se debe setear el valor del Combo al ID de la aseguradora

        if (au.TipoUsuario == "AdminCiaSeguros")
        {
            try
            {
                String valueToFind = RGen.Gestores.GestorUsuarios.getCompania(Convert.ToDecimal(au.UserId));

                hdfAseguradoraId.Value = valueToFind;

                this.aseguradoraIdCombo.Items.FindByValue(valueToFind).Selected = true;
                aseguradoraPanel.Style[HtmlTextWriterStyle.Display] = "none";
                subaccesoGridView.Visible = false;
                subaccesoPanel.Visible = false;
            }
            catch (Exception ex)
            {
                Response.Redirect("vMuestraMensaje.aspx?mensaje=El Siguiente Error ha ocurrido : " + ex.Message);
            }
        }
        if (au.TipoUsuario == "EjecutivoCiaSeguros")
        {
            try
            {
                this.aseguradoraIdCombo.Items.FindByValue(au.UsuarioCreadorId).Selected = true;
                aseguradoraPanel.Style[HtmlTextWriterStyle.Display] = "none";
                subaccesoGridView.Visible = false;
                subaccesoPanel.Visible = false;
            }
            catch (Exception ex)
            {
                Response.Redirect("vMuestraMensaje.aspx?mensaje=El Siguiente Error ha ocurrido : " + ex.Message);
            }
        }
        if (au.TipoUsuario == "AdminBroker")
        {
            Response.Redirect("vListaUsuario.aspx");
            
        }

        //Ahora con el nuevo rol de Asistente en el menu de opciones no se ven todas las opciones
        if (au.TipoUsuario == "Asistente")
        {
            brokerPanel.Style[HtmlTextWriterStyle.Display] = "none";
            aseguradoraPanel.Style[HtmlTextWriterStyle.Display] = "none";
            subaccesoGridView.Visible = false;
            mensajeLabel.Visible = false;
            btnMantenimientoUsuarios.Visible = false;
        }

        if (au.TipoUsuario == "Ajustador")
        {
            brokerPanel.Style[HtmlTextWriterStyle.Display] = "none";
            aseguradoraPanel.Style[HtmlTextWriterStyle.Display] = "none";
            subaccesoGridView.Visible = false;
            mensajeLabel.Visible = false;
            btnMantenimientoUsuarios.Visible = false;
        }

    }

    protected void odsSubaccesoAseguradora_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        bool visibilidad;
        if (((DataTable)e.ReturnValue).Rows.Count > 0)
        {
            visibilidad = true;

        }
        else visibilidad = false;

        //guardarImageButton.Visible = visibilidad;
        mensajeLabel.Visible = !visibilidad;
    }

    protected void guardarImageButton_Click(object sender, ImageClickEventArgs e)
    {
        decimal aseguradoraId = -1;
        decimal brokerId = -1;

        if (aseguradoraIdCombo.SelectedValue != "") aseguradoraId = decimal.Parse(aseguradoraIdCombo.SelectedValue);
        if (brokerIdCombo.SelectedValue != "") brokerId = decimal.Parse(brokerIdCombo.SelectedValue);

        /*
         recorriendo los privilegios para ver cuales puede entregar...
         */
        foreach (GridViewRow subaccesoRow in subaccesoGridView.Rows)
        {
            decimal funcionalidadId = decimal.Parse(subaccesoRow.Cells[0].Text);
            CheckBox accesoCheckBox = (CheckBox)subaccesoRow.Cells[2].FindControl("accesoCheckBox");

            dsUsuariosTableAdapters.SubAccesoTableAdapter subaccesoAdapter = new dsUsuariosTableAdapters.SubAccesoTableAdapter();
            subaccesoAdapter.SubAccesoInsert(funcionalidadId, aseguradoraId, brokerId, accesoCheckBox.Checked, (string)Session["usuario"]);
        }

        controlArchivoXML("W");
        RGen.App.grabaNumeroInicialAjuste(this.txtNumInicial.Text);
        try
        {
            this.frmUpdateNumCarta.UpdateItem(true);
            this.frmConfiguracion.UpdateItem(true);
        }
        catch (Exception ex)
        {

        }
    }

    protected void brokerIdCombo_SelectedIndexChanged(object sender, EventArgs e)
    {
        bool visibilidad;
        if (brokerIdCombo.SelectedValue != "")
        {
            visibilidad = true;
        }
        else
            visibilidad = false;

        subaccesoGridView.Visible = visibilidad;
        guardarImageButton.Visible = visibilidad;
        mensajeLabel.Visible = !visibilidad;
    }


}
