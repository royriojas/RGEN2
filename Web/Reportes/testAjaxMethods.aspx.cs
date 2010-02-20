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
using AjaxPro;
public partial class Reportes_testAjaxMethods : System.Web.UI.Page
{
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

    protected void Page_Load(object sender, EventArgs e)
    {
        Utility.RegisterTypeForAjax(typeof(Reportes_testAjaxMethods));
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
