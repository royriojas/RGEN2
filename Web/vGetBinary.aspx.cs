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

public partial class vGetBinary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      decimal AjusteId = decimal.Parse(Request.QueryString["AjusteId"]);
      decimal ArchivoId = decimal.Parse(Request.QueryString["ArchivoId"]);

      dsAnexoTableAdapters.AnexoDescargaTableAdapter descargaAdapter = new dsAnexoTableAdapters.AnexoDescargaTableAdapter();
      dsAnexo.AnexoDescargaDataTable descargaTable = (dsAnexo.AnexoDescargaDataTable)descargaAdapter.GetData(ArchivoId, AjusteId);
      dsAnexo.AnexoDescargaRow descargaRow = (dsAnexo.AnexoDescargaRow)descargaTable.Rows[0];

      MemoryStream AuxStream = new MemoryStream(descargaRow.archivoFisico);

      Response.AddHeader("Content-disposition", "attachment; filename=" + descargaRow.nombrearchivo);
      Response.ContentType = "application/octet-stream";
      Response.BinaryWrite(AuxStream.ToArray());

    }
}
