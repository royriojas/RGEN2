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
using System.IO;

public partial class vGetImageGrande : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        dsAnexoTableAdapters.AnexoEditorTableAdapter ta = new dsAnexoTableAdapters.AnexoEditorTableAdapter();

        byte[] imagenThumb;
        imagenThumb = (byte[])ta.getLargeImage(Convert.ToDecimal(Request.QueryString["AjusteId"]), Convert.ToDecimal(Request.QueryString["ArchivoId"]));
        MemoryStream auxStream = new MemoryStream(imagenThumb);

        Response.ContentType = "image/jpg";
        Response.BinaryWrite(auxStream.ToArray());
    }
}
