using System;
using System.Web.UI.WebControls;
using System.IO;

/// <summary>
/// Summary description for utilidades
/// </summary>
namespace RGen.Utiles
{
    public class utilidades
    {
        public utilidades()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        /// <summary>
        /// Obtiene un arreglo de BYTES que representan el contenido binario de un archivo para enviarlo directamente a una BD o hacer algun trabajo con �l.
        /// </summary>
        /// <param name="f">FileInfo f del archivo del cual se quiere obtener el arreglo de bytes</param>
        /// <returns>arreglo de bytes para hacer algun trabajo con el.</returns>
        
        public static byte[] getBytesFromFile(FileInfo f)
        {
            byte[] buffer = null;

            try
            {
                buffer = new byte[f.OpenRead().Length];
                f.OpenRead().Read(buffer, 0, (int)f.OpenRead().Length);
            }
            catch (Exception ex)
            {
                buffer = null;
            }
            return buffer;
        }

        /// <summary>
        /// Reemplaza las t�ldes y otros s�mbolos por sus respectivas codificaciones HTML 
        /// </summary>
        /// <param name="s">Cadena de donde se obtienen los valores a reemplazar</param>
        /// <returns>Cadena con los valores cambiados</returns>
        public static String encodeStringToHTMLSimbols(String s)
        {
            String html_reporte = s;
            
            html_reporte = html_reporte.Replace("�", "&aacute;");
            html_reporte = html_reporte.Replace("�", "&Aacute;");

            html_reporte = html_reporte.Replace("�", "&eacute;");
            html_reporte = html_reporte.Replace("�", "&Eacute;");

            html_reporte = html_reporte.Replace("�", "&iacute;");
            html_reporte = html_reporte.Replace("�", "&Iacute;");

            html_reporte = html_reporte.Replace("�", "&oacute;");
            html_reporte = html_reporte.Replace("�", "&Oacute;");

            html_reporte = html_reporte.Replace("�", "&uacute;");
            html_reporte = html_reporte.Replace("�", "&Uacute;");

            //html_reporte = html_reporte.Replace("$", "US$");

            html_reporte = html_reporte.Replace("�", "&ntilde;");
            html_reporte = html_reporte.Replace("�", "&Ntilde;");

            return html_reporte;
        }

        /// <summary>
        /// A�ade un item no "bound" a un combobox, util para a�adir el texto "elija" o "todos" a los comboboxes
        /// </summary>
        /// <param name="sender">DropDownList al que se le quiere agregar un item</param>
        /// <param name="text">Texto que se mostrar�</param>
        /// <param name="value">Valor que tendr�</param>
        /// <param name="posbackFlag">bandera para saber si agregar o no el item dependiendo del isPostBack</param>
        public static void addItemTodos(Object sender, String text, String value, Boolean posbackFlag)
        {
            if (!posbackFlag)
            {
                ((DropDownList)sender).ClearSelection();
                ListItem todosItem = new ListItem(text, value);
                ((DropDownList)sender).Items.Insert(0, todosItem);
            }
        }
        /// <summary>
        /// Devuelve el valor de la propiedad Text de un TextBox contenido dentro de un FormView.
        /// </summary>
        /// <param name="f">FormView del cual se quiere sacar el valor del campo de texto</param>
        /// <param name="Id">String Id del TextBox dentro del FormView</param>
        /// <returns>El valor de la propiedad Text del TextBox pasado como parametro o null si no lo encuentra.</returns>
        public static String getInternalValueFromForm(FormView f, String Id)
        {
            TextBox t = (TextBox)f.FindControl(Id);
            if (t != null)
            {
                return t.Text;
            }
            else return null;
        }
        /// <summary>
        /// Devuelve el valor de la propiedad Text de un TextBox contenido dentro de un FormView o un valor por defecto en caso no encontrarlo.
        /// </summary>
        /// <param name="f">FormView del cual se quiere sacar el valor del campo de texto</param>
        /// <param name="Id">String Id del TextBox dentro del FormView</param>
        /// <param name="DefaultValue">El valor por defecto en caso de no encontrar el DropDownList en el FormView</param>
        /// <returns>El valor de la propiedad Text del TextBox pasado como parametro o null si no lo encuentra.</returns>
        public static String getInternalValueFromForm(FormView f, String Id, String DefaultValue)
        {
            TextBox t = (TextBox)f.FindControl(Id);
            if (t != null)
            {
                return t.Text;
            }
            else return DefaultValue;
        }

        /// <summary>
        /// Devuelve el valor de la propiedad SelectedValue de un DropDownList contenido en un FormView
        /// </summary>
        /// <param name="frm">FormView que contiene el DropDownList</param>
        /// <param name="cbxName">Id del DropDownList contenido en el FormView</param>
        /// <returns>El valor de la propiedad SelectedValue o cadena vac�a en caso no encontrarlo</returns>
        public static String getInternalValueFromDropDownList(FormView frm, string cbxName)
        {
            DropDownList cbx = (DropDownList)frm.FindControl(cbxName);
            if (cbx != null) return cbx.SelectedValue;
            else return null;
        }
        /// <summary>
        /// Devuelve el valor de la propiedad SelectedValue de un DropDownList contenido en un FormView o un valor por defecto
        /// </summary>
        /// <param name="frm">FormView que contiene el DropDownList</param>
        /// <param name="cbxName">Id del DropDownList contenido en el FormView</param>      
        /// <param name="DefaultValue">El valor por defecto a devolver en caso no encontrar el componente</param>
        /// <returns>El valor de la propiedad SelectedValue o cadena vac�a en caso no encontrarlo</returns>
        public static String getInternalValueFromDropDownList(FormView frm, string cbxName, String DefaultValue)
        {
            DropDownList cbx = (DropDownList)frm.FindControl(cbxName);
            if (cbx != null) return cbx.SelectedValue;
            else return DefaultValue;
        }

        public static bool IsNumeric(string s)
        {
            try
            {
                Int32.Parse(s);
            }
            catch
            {
                return false;
            }
            return true;
        }
        /// <summary>
        /// Devuelve el valor de la expresi�n parametro_GET, siempre que no sea null, devuelve un Valor por Omisi�n en caso contrario
        /// </summary>
        /// <param name="parametro_GET">el valor del parametro a analizar</param>
        /// <param name="valorPorOmision">valor a devolver en caso la cadena sea vacia o null</param>
        /// <returns>el valor del parametro_GET o el valorPorOmision en caso parametro_GET sea null o vac�o</returns>
        public static String isNull(String parametro_GET, String valorPorOmision)
        {
            return ((parametro_GET != null) && (parametro_GET != "")) ? parametro_GET : valorPorOmision;
        }
		

    }
}