using System;
using R3M.Controls;

public partial class RimacInforme_initTinyMCE : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        R3M.Controls.Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/tiny_mce/tiny_mce.js"), FileType.Javascript);
        R3M.Controls.Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/tiny_mce/jquery.tinymce.js"), FileType.Javascript);
        R3M.Controls.Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/common.js"), FileType.Javascript);
        R3M.Controls.Common.AddFileToPageHeader(Page, ResolveUrl("~/RimacInforme/scripts/R3M.Validator/R3M.Validator.js"), FileType.Javascript);
    }
}
