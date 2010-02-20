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

public partial class vGetBinaryClausula : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      decimal clausulaId = decimal.Parse(Request.QueryString["clausulaId"]);

      dsPolizaTableAdapters.descargarClausulasComunesTableAdapter descargaAdapter = new dsPolizaTableAdapters.descargarClausulasComunesTableAdapter();
      dsPoliza.descargarClausulasComunesDataTable descargaTable = (dsPoliza.descargarClausulasComunesDataTable)descargaAdapter.GetData(clausulaId);
      dsPoliza.descargarClausulasComunesRow descargaRow = (dsPoliza.descargarClausulasComunesRow)descargaTable.Rows[0];

      MemoryStream AuxStream = new MemoryStream(descargaRow.archivo);

      Response.AddHeader("Content-disposition", "attachment; filename=" + descargaRow.nombreArchivo);
      Response.ContentType = "application/octet-stream";
      Response.BinaryWrite(AuxStream.ToArray());
    }
}
