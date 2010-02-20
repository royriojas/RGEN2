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

public partial class vDetallesPoliza : System.Web.UI.Page
{
    public String qStringAjusteId;
    public String qStringPolizaId;
    protected void Page_Load(object sender, EventArgs e)
    {
      qStringAjusteId = Request.QueryString["AjusteId"];
      qStringPolizaId = Request.QueryString["PolizaId"];
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
      dsPolizaTableAdapters.PolizaSelectTableAdapter polizaAdapter = new dsPolizaTableAdapters.PolizaSelectTableAdapter();
      string fileName = (string)polizaAdapter.GetFileName(decimal.Parse(qStringPolizaId));

      //FileInfo archivo = new FileInfo(Server.MapPath("Informes") + "\\PASA-IB1-1432006143541812.pdf");
      FileInfo archivo = new FileInfo(Server.MapPath("Polizas") + "\\" + fileName);
      if (archivo.Exists)
      {
        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.WriteFile(archivo.FullName);
        Response.End();
      }
    }
}
