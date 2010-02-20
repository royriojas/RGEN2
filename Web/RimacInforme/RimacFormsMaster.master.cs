using System;
using R3M.Controls;

public partial class RimacInforme_RimacFormsMaster : System.Web.UI.MasterPage
{
    protected void Page_Init(object sender, EventArgs e)
    {
        LoadJavascripts();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    public void LoadJavascripts()
    {
        Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/jquery.js"), FileType.Javascript);
        Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/jquery-ui.js"), FileType.Javascript);
        Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/Date.js"), FileType.Javascript);

        Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/css/reset-fonts.css"), FileType.Css);
        Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/css/form.css"), FileType.Css);


    }
}
