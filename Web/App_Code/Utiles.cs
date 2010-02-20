using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

/// <summary>
/// Summary description for Utiles
/// </summary>
/// 
namespace CCSOL.Utiles
{
  public class Utilidades
  {
    public Utilidades()
    {
      //
      // TODO: Add constructor logic here
      //
    }

    /// <summary>
    /// Obtiene un arreglo de BYTES que representan el contenido binario de un archivo para enviarlo directamente a una BD o hacer algun trabajo con él.
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
    /// Reemplaza las tíldes y otros símbolos por sus respectivas codificaciones HTML 
    /// </summary>
    /// <param name="s">Cadena de donde se obtienen los valores a reemplazar</param>
    /// <returns>Cadena con los valores cambiados</returns>
    public static String encodeStringToHTMLSimbols(String s)
    {
      String html_reporte = s;

      html_reporte = html_reporte.Replace("á", "&aacute;");
      html_reporte = html_reporte.Replace("Á", "&Aacute;");

      html_reporte = html_reporte.Replace("é", "&eacute;");
      html_reporte = html_reporte.Replace("É", "&Eacute;");

      html_reporte = html_reporte.Replace("í", "&iacute;");
      html_reporte = html_reporte.Replace("Í", "&Iacute;");

      html_reporte = html_reporte.Replace("ó", "&oacute;");
      html_reporte = html_reporte.Replace("Ó", "&Oacute;");

      html_reporte = html_reporte.Replace("ú", "&uacute;");
      html_reporte = html_reporte.Replace("Ú", "&Uacute;");

      html_reporte = html_reporte.Replace("$", "US$");

      html_reporte = html_reporte.Replace("ñ", "&ntilde;");
      html_reporte = html_reporte.Replace("Ñ", "&Ntilde;");

      return html_reporte;
    }

    /// <summary>
    /// Añade un item no "bound" a un combobox, util para añadir el texto "elija" o "todos" a los comboboxes
    /// </summary>
    /// <param name="sender">DropDownList al que se le quiere agregar un item</param>
    /// <param name="text">Texto que se mostrará</param>
    /// <param name="value">Valor que tendrá</param>
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
    /// <returns>El valor de la propiedad SelectedValue o cadena vacía en caso no encontrarlo</returns>
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
    /// <returns>El valor de la propiedad SelectedValue o cadena vacía en caso no encontrarlo</returns>
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
    /// Devuelve el valor de la expresión parametro_GET, siempre que no sea null, devuelve un Valor por Omisión en caso contrario
    /// </summary>
    /// <param name="parametro_GET">el valor del parametro a analizar</param>
    /// <param name="valorPorOmision">valor a devolver en caso la cadena sea vacia o null</param>
    /// <returns>el valor del parametro_GET o el valorPorOmision en caso parametro_GET sea null o vacío</returns>
    public static String isNull(String parametro_GET, String valorPorOmision)
    {
      return (!String.IsNullOrEmpty(parametro_GET)) ? parametro_GET : valorPorOmision;
    }

    public static void setInternalValue(String TextBoxId, String value, FormView frm)
    {
      TextBox t = frm.FindControl(TextBoxId) as TextBox;

      if (t != null)
      {
        t.Text = value;
      }
    }
    public static void redirectToUrlWhenIsNull(object au, HttpResponse Response, String urlActual)
    {
      if (au == null)
      {
        Response.Redirect(urlActual);
        Response.End();
      }
    }

    public static Boolean inhabilitarASBControl(FormView frm, string asbName)
    {
      return true;
    }

    public static byte[] ResizeImageFile(byte[] imageFile, int targetSize)
    {
      using (System.Drawing.Image oldImage = System.Drawing.Image.FromStream(new MemoryStream(imageFile)))
      {
        Size newSize = CalculateDimensions(oldImage.Size, targetSize);
        using (Bitmap newImage = new Bitmap(newSize.Width, newSize.Height, PixelFormat.Format24bppRgb))
        {
          using (Graphics canvas = Graphics.FromImage(newImage))
          {
            canvas.SmoothingMode = SmoothingMode.AntiAlias;
            canvas.InterpolationMode = InterpolationMode.HighQualityBicubic;
            canvas.PixelOffsetMode = PixelOffsetMode.HighQuality;

            ImageAttributes imgattrs = new ImageAttributes();

            canvas.DrawImage(oldImage, new Rectangle(new Point(0, 0), newSize));

            MemoryStream m = new MemoryStream();
            newImage.Save(m, ImageFormat.Jpeg);

            return m.GetBuffer();
          }
        }
      }
    }

    public static Size CalculateDimensions(Size oldSize, int targetSize)
    {
      Size newSize = new Size();
      if (oldSize.Height > oldSize.Width)
      {
        newSize.Width = (int)(oldSize.Width * ((float)targetSize / (float)oldSize.Height));
        newSize.Height = targetSize;
      }
      else
      {
        newSize.Width = targetSize;
        newSize.Height = (int)(oldSize.Height * ((float)targetSize / (float)oldSize.Width));
      }
      return newSize;
    }

    public static byte[] ResizeImageFile(byte[] imageFile)
    {
      System.Drawing.Image oldImage = System.Drawing.Image.FromStream(new MemoryStream(imageFile));

      if (oldImage.Width > 640)
      {
        return ResizeImageFile(imageFile, 640);
      }
      else
      {
        return imageFile;
      }
    }

    public static String IsNull(Object Field)
    {
      if ((Field == null) || (Field.ToString() =="")) return "display:none;";
      else return "";
    }
  }
}
