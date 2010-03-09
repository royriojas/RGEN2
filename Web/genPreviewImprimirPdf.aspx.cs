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
using RGen.docs;
using System.IO;

public partial class genPreviewImprimirPdf : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    String TipoInforme = Request.QueryString["TI"];
    String AjusteId = Request.QueryString["AjusteId"];

    Byte[] bytes = GetPdf.GetMyInformeImprimirNow(Convert.ToInt32(AjusteId), TipoInforme);
    

    Response.Clear();
    Response.Buffer = true;
    Response.ContentType = "application/pdf";
    Response.BinaryWrite(bytes);
    Response.End();
  }
}
