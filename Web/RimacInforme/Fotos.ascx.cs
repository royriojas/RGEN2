﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class RimacInforme_Fotos : System.Web.UI.UserControl
{

    public event EventHandler EmptyFotos;

    private void InvokeEmptyFotos(EventArgs e)
    {
        EventHandler fotos = EmptyFotos;
        if (fotos != null) fotos(this, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Num2++;
            if ((Num2 % 2) == 0)
            {
                Literal ltl = e.Item.FindControl("separator") as Literal;
                if (ltl != null)
                    ltl.Visible = true;
            }
            if ((Num2 % 4) == 0)
            {
                Literal ltl2 = e.Item.FindControl("TableEnd") as Literal;
                if (ltl2 != null)
                    ltl2.Visible = true;
            }
        }
    }
    protected void Repeater2_DataBinding(object sender, EventArgs e)
    {
        Num2 = 0;
    }

    private Int32 _num2;
    public Int32 Num2
    {
        get
        {
            return _num2;
        }
        set
        {
            _num2 = value;
        }
    }

    protected void odsImagenes_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {
        this.divImagenes.Visible = (((System.Data.DataTable)e.ReturnValue).Rows.Count > 0);
        if (!this.divImagenes.Visible)
        {
            InvokeEmptyFotos(new EventArgs());
        }
    }
}
