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

public partial class vBusquedaDocumentos : System.Web.UI.Page
{
    public int num = 1;
    public string AjusteId = "57";
    public decimal solicitudId;
    protected void Page_Load(object sender, EventArgs e)
    {
        AjusteId = Request.QueryString["AjusteId"];
    }
    protected void cbxTipoSiniestro_SelectedIndexChanged(object sender, EventArgs e)
    {
        odsDocumentosTipoSiniestro.DataBind();
        gridListaDocumentos.DataBind();

    }
    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        
        int numFilas = gridListaDocumentos.Rows.Count;

        int contador = 0;
        for(int i=0;i<numFilas;i++)
        {
            CheckBox AuxCheckBox = (CheckBox) gridListaDocumentos.Rows[i].FindControl("chkDocumentos");
            if (AuxCheckBox.Checked)
            {
                contador++;
            }
        }
        if (contador > 0)
        {
            odsCarta.Insert();

            

            for (int i = 0; i < numFilas; i++)
            {
                CheckBox AuxCheckBox = (CheckBox)gridListaDocumentos.Rows[i].FindControl("chkDocumentos");
                if (AuxCheckBox.Checked)
                {
                    odsInsertaRequisito.InsertParameters.Clear();
                    odsInsertaRequisito.InsertParameters.Add("requisitoId",gridListaDocumentos.Rows[i].Cells[1].Text);
                    odsInsertaRequisito.InsertParameters.Add("AjusteId", this.AjusteId);
                    odsInsertaRequisito.InsertParameters.Add("SolDocId", Convert.ToString(this.solicitudId));
                    odsInsertaRequisito.InsertParameters.Add("ucrea", "SYSTEM");
                    odsInsertaRequisito.InsertParameters.Add("uupdate", "SYSTEM");
                    odsInsertaRequisito.InsertMethod = "Insert";
                    odsInsertaRequisito.Insert(); 

                }
            }
        }

    }
    protected void cbxTipoSiniestro_DataBound(object sender, EventArgs e)
    {
        ListItem todosItem = new ListItem("TODOS", "-1");
        this.cbxTipoSiniestro.Items.Insert(0, todosItem);

    }
    protected void odsCarta_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        e.InputParameters.Clear();
        
        e.InputParameters.Add("AjusteId", AjusteId);
        e.InputParameters.Add("SolDocId", "");
        e.InputParameters.Add("ucrea", "SYSTEM");
        e.InputParameters.Add("uupdate", "SYSTEM");
        

    }
    protected void odsCarta_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        this.solicitudId = (decimal) e.OutputParameters["SolDocId"];
    }
    protected void odsInsertaRequisito_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        
    }
}
