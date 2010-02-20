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

public partial class vListaClausulasComunes : System.Web.UI.Page
{
    public int num = 1;
    public string PolizaId;
    public String urlAnterior;
    RGen.Utiles.AtribucionesUsuario au;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //urlAnterior = Request.QueryString["UrlAnterior"];
        PolizaId = Request.QueryString["PolId"];
        au = (RGen.Utiles.AtribucionesUsuario)Session["datosUsuario"];
        this.btnVolver.PostBackUrl = (String)Session["returnPath"];
    }
   
    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {

        int numFilas = gridListaClausulas.Rows.Count;

        int contador = 0;
        for (int i = 0; i < numFilas; i++)
        {
            CheckBox AuxCheckBox = (CheckBox)gridListaClausulas.Rows[i].FindControl("chkClausulas");
            if (AuxCheckBox.Checked)
            {
                contador++;
            }
        }
        if (contador > 0)
        {
            for (int i = 0; i < numFilas; i++)
            {
                CheckBox AuxCheckBox = (CheckBox)gridListaClausulas.Rows[i].FindControl("chkClausulas");
                if (AuxCheckBox.Checked)
                {
                    SqlDataSource1.InsertParameters.Clear();
                    SqlDataSource1.InsertParameters.Add("ClausulasId", "");
                    SqlDataSource1.InsertParameters.Add("PolizaId",this.PolizaId);
                    SqlDataSource1.InsertParameters.Add("nombre", gridListaClausulas.Rows[i].Cells[2].Text);
                    SqlDataSource1.InsertParameters.Add("contenido", gridListaClausulas.Rows[i].Cells[3].Text);
                    SqlDataSource1.InsertParameters.Add("usuario", au.UserName);
                    SqlDataSource1.Insert();
                  
                }
            }
        }

    }
   
    protected void cbxRamo_SelectedIndexChanged(object sender, EventArgs e)
    {
        sqlClausulasComunes.DataBind();
        gridListaClausulas.DataBind();
    }
    protected void cbxRamo_DataBound(object sender, EventArgs e)
    {
        ListItem todosItem = new ListItem("TODOS", "-1");
        this.cbxRamo.Items.Insert(0, todosItem);
    }
       
    protected void SqlDataSource1_Inserting1(object sender, SqlDataSourceCommandEventArgs e)
    {
        utiles.debugClass.muestra(e.Command,Server.MapPath("log2.txt"));
    }
    protected void btnVolver_Click(object sender, ImageClickEventArgs e)
    {

    }
}
