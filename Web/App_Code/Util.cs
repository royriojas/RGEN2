using System;
using System.Data;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections.Generic;
using ExpertPdf.HtmlToPdf;
using System.Drawing;



namespace R3M.Common
{

    /// <summary>
    /// Methods that will be used in the Web Application, just so simply to have a special dll for them.
    /// </summary>
    public class Util
    {
        #region Independent Methods, really low Coupled
        const string MoreWordsToken = "...";

        /// <summary>
        /// Generic Method to do special Casting to type T 
        /// </summary>
        /// <typeparam name="T">the Expected Type to be returned</typeparam>
        /// <param name="aValue">the Object with the value to be casted</param>
        /// <param name="aDefaultValue">the Default Value if aValue is null</param>
        /// <returns></returns>
        public static T XDefault<T>(Object aValue, T aDefaultValue)
        {
            try
            {
                return aValue == null || Convert.IsDBNull(aValue) ? aDefaultValue : (T)aValue;    
            }
            catch(Exception)
            {
                return aDefaultValue;
            }
            
        }

        /// <summary>
        /// if a Value is not null return the Value, if a Value is null return defaultValue
        /// </summary>
        /// <typeparam name="T">the Type of the value to be return</typeparam>
        /// <param name="aValue">The Value to check if null</param>
        /// <param name="defaultValue">The Default value to use</param>
        /// <returns>a T Object</returns>
        public static T XIsNull<T>(T aValue, T defaultValue)
        {
            return Equals(aValue, default(T)) ? defaultValue : aValue;
        }

        /// <summary>
        /// Special Wrapper to use XIsNull In DataBound Controls like FormView, GridView, Datalist or Repeaters
        /// </summary>
        /// <param name="aValue"></param>
        /// <param name="defaultValue"></param>
        /// <returns></returns>
        public static Object XIsNull(Object aValue, Object defaultValue)
        {
            return XIsNull<Object>(aValue, defaultValue);
        }


        /// <summary>
        /// Limit the Length of a string, if the string exceeds 30 characters it will be truncated and concatenated with a More Words Token
        /// </summary>
        /// <param name="aString">the String to limit</param>
        /// <returns>a Limited String</returns>
        public static String CheckStringLength(String aString)
        {
            const int limit = 30;
            return CheckStringLength(aString, limit);
        }

        /// <summary>
        ///  Limit the Length of a string, if the string exceeds the characters limit it will be truncated and concatenated with a More Words Token
        /// </summary>
        /// <param name="aString">the String to limit</param>
        /// <param name="limit">the amount of characters allowed for a given string</param>
        /// <returns></returns>
        public static String CheckStringLength(String aString, int limit)
        {
            if (!String.IsNullOrEmpty(aString))
            {
                int len = aString.Length;
                if (len > limit)
                {
                    return aString.Remove(limit - 1) + MoreWordsToken;
                }
                else { return aString; }

            }
            else return "";
        }

        /// <summary>
        /// Escape the characters that could be problematic when are embeed in the aspx pages in the javascripts blocks
        /// </summary>
        /// <param name="str">the string to be escaped</param>
        /// <returns>a safe string to be embedded in javascript as a string</returns>
        public static string EscapeStringForJavascript(String str)
        {
            return str.Replace(@"\", @"\\").Replace("'", @"\'").Replace(@"""", @"\""").Replace("\r", "").Replace("\n", "\\" + "n");
        }


        /// <summary>
        /// Get the Bytes of a FileInfo object
        /// </summary>
        /// <param name="f">the FileInfo</param>
        /// <returns>an array of bytes</returns>
        public static byte[] GetBytesFromFile(FileInfo f)
        {
            byte[] buffer = null;


            //try
            //{
            buffer = new byte[f.OpenRead().Length];
            f.OpenRead().Read(buffer, 0, (int)f.OpenRead().Length);
            //}
            //catch (Exception ex)
            //{
            //LoggerFacade.LogException(ex);
            //Eucalypto.LoggerFacade.Log.LogException(typeof(Util), ex);
            //  buffer = null;
            //}
            return buffer;
        }

        #endregion

        public static string ConvertToAString(byte[] byteArray)
        {
            String s = "";
            foreach (byte b in byteArray)
            {
                s += (char)b;
            }
            return s;
        }

        internal static List<T1> GetArrayFromBag<T1>(System.Collections.IList iList)
        {
            int capacity = 0;
            if (iList != null)
                capacity = iList.Count;
            List<T1> list = new List<T1>();
            if (capacity > 0 && iList != null) list.AddRange((IEnumerable<T1>)iList);
            return list;
        }

        /// <summary>
        /// Get an absolute Based on a Relative Url 
        /// </summary>
        /// <param name="relativeURL">the Relative Url to be converted to Absolute URL</param>
        /// <returns>an Absolute URL</returns>
        public static string ResolveURL(string relativeURL)
        {
            //TODO: check this assumption 
            if (relativeURL.ToLower().StartsWith("http://")) return relativeURL;

            string absPath = GetWebAppUrl();
            return (absPath.EndsWith("/") ? absPath : absPath + "/") + relativeURL;
        }

        public static string LocateServerPath(string path)
        {
            if (Path.IsPathRooted(path) == false)
                path = Path.Combine(AppDomain.CurrentDomain.SetupInformation.ApplicationBase, path);

            return path;
        }


        public static string CombineUrl(string baseUrl, string relativeUrl)
        {
            if (relativeUrl.Length == 0 || relativeUrl[0] != '/')
                relativeUrl = '/' + relativeUrl;

            if (baseUrl.Length > 0 && baseUrl[baseUrl.Length - 1] == '/')
                baseUrl = baseUrl.Substring(0, baseUrl.Length - 1);

            return baseUrl + relativeUrl;

            //Uri uriBase = new Uri(baseUrl);
            //Uri uriRelative = new Uri(relativeUrl, UriKind.Relative);
            //Uri uri = new Uri(uriBase, uriRelative);

            //return uri.AbsoluteUri;
        }

        /// <summary>
        /// Get the web site application root path. Combine the request.Url.GetLeftPart(UriPartial.Authority) with request.ApplicationPath
        /// </summary>
        /// <returns></returns>
        public static string GetWebAppUrl()
        {
            /*System.Web.HttpRequest request = System.Web.HttpContext.Current.Request;

            return CombineUrl(request.Url.GetLeftPart(UriPartial.Authority), request.ApplicationPath);
             * */

            return ConfigurationManager.AppSettings["ApplicationInstallURL"];
        }





        public static bool IsValidDateTime(string date)
        {
            DateTime d = DateTime.Now;
            return DateTime.TryParse(date, out d);
        }

        public static String getNumberAsLetters(double num)
        {
            CantidadLetra cletra = new CantidadLetra();
            return cletra.ConvertirCadena(num);
        }


        public static byte[] getPdf(String UrlBody, String UrlCabecera)
        {
            //      UrlBody;//@"E:\Proyectos\InformeRGen\informePacifico_Final.html";      

            PdfConverter pdfConverter = new PdfConverter();

            pdfConverter.LicenseKey = ConfigurationManager.AppSettings["PDF_CONVERTER_KEY"];
            pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.A4;
            pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal;
            pdfConverter.PdfDocumentOptions.ShowHeader = true;
            pdfConverter.PdfDocumentOptions.ShowFooter = true;
            pdfConverter.PdfDocumentOptions.LeftMargin = 30;
            pdfConverter.PdfDocumentOptions.RightMargin = 20;
            pdfConverter.PdfDocumentOptions.TopMargin = 10;
            pdfConverter.PdfDocumentOptions.BottomMargin = 10;
            pdfConverter.PdfDocumentOptions.GenerateSelectablePdf = true;
            //pdfConverter.AvoidImageBreak = true;

            pdfConverter.PdfDocumentOptions.ShowHeader = true;

            if (!String.IsNullOrEmpty(UrlCabecera))
            {

                pdfConverter.PdfHeaderOptions.HtmlToPdfArea = new HtmlToPdfArea(UrlCabecera);
                pdfConverter.PdfHeaderOptions.HeaderHeight = 180;


            }

            pdfConverter.PdfFooterOptions.DrawFooterLine = false;

            pdfConverter.PdfFooterOptions.FooterText = "";
            pdfConverter.PdfFooterOptions.PageNumberText = "Página";
            pdfConverter.PdfFooterOptions.ShowPageNumber = true;

            //pdfConverter.LicenseKey = "put your license key here";
            byte[] downloadBytes = pdfConverter.GetPdfFromUrlBytes(UrlBody);
            return downloadBytes;
        }


        public static string ReplaceASBR(Object StringEntrada)
        {
            if (StringEntrada == null) return String.Empty;
            String cadena = Convert.ToString(StringEntrada);
            //return encodeStringToHTMLSimbols(cadena.Replace(Environment.NewLine, "<br />"));
            String temp = cadena.Replace(Environment.NewLine, "\n");

            temp = Regex.Replace(temp, "(\n)+", "<br />");

            return encodeStringToHTMLSimbols(temp);
        }

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


        public static Int32 GetRowCount(Object returnValue)
        {
            DataTable dt = ((DataTable)returnValue);
            return dt != null ? dt.Rows.Count : 0;
        }

        


    }

    public enum ControlEditMode
    {
        View,
        Create,
        Edit,
        Delete
    }
}