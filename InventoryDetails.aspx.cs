using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RestoExpense
{
    public partial class InventoryDetails : System.Web.UI.Page
    {
        InventoryDataHandler inventoryDataHandler = new InventoryDataHandler();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == false)
            {
                BindInventoryCategory();
                BindInventorySubCategory();

                if (Request.QueryString["ID"] != null)
                {
                    int ID = int.Parse(Request.QueryString["ID"]);

                    BindInventoryDetails(ID);
                }
            }
        }

        protected void BindInventoryCategory()
        {
            try
            {
                var ds = inventoryDataHandler.GetInventoryCategory();
                if (ds != null)
                {
                    ddlInventCate.DataTextField = "Name";
                    ddlInventCate.DataValueField = "ID";
                    ddlInventCate.DataSource = ds;
                    ddlInventCate.DataBind();
                }

                ListItem listItem = new ListItem("Select", "0");
                ddlInventCate.Items.Insert(0, listItem);

                BindInventorySubCategory();
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
            }
        }

        protected void BindInventorySubCategory()
        {
            try
            {
                int id = Convert.ToInt32(ddlInventCate.SelectedValue);
                var ds = inventoryDataHandler.GetInventorySubCategory(id);

                if (ds != null)
                {
                    ddlInventSubCate.DataTextField = "SubName";
                    ddlInventSubCate.DataValueField = "ID";
                    ddlInventSubCate.DataSource = ds;
                    ddlInventSubCate.DataBind();
                }

                ddlInventSubCate.Items.Insert(0, new ListItem("Select", "0"));
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
            }
        }

        protected void ddlInventCate_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindInventorySubCategory();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            InventoryModel inventoryModel = new InventoryModel();
            try
            {
                inventoryModel.ID = Convert.ToInt32(hdnID.Value);
                inventoryModel.InventoryCategory = ddlInventCate.SelectedValue;
                inventoryModel.InventorySubCategory = ddlInventSubCate.SelectedValue;
                inventoryModel.InventoryDate = txtcalender.Value;
                inventoryModel.Amount = txtAmount.Text;

                var saveresp = inventoryDataHandler.SaveInventoryDetails(inventoryModel);
                Response.Redirect("InventoryList.aspx");
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
            }
        }
        protected void BindInventoryDetails(int ID)
        {
            try
            {
                InventoryModel inventoryModel = new InventoryModel();
                inventoryModel.ID = ID;
                DataTable dt2 = new DataTable();

                dt2 = inventoryDataHandler.GetInventoryDetailByID(inventoryModel.ID);

                if (dt2.Rows.Count > 0 && dt2 != null)
                {
                    hdnID.Value = dt2.Rows[0]["ID"].ToString();
                    ddlInventCate.SelectedValue = dt2.Rows[0]["InventoryCategory"].ToString();

                    BindInventorySubCategory();

                    ddlInventSubCate.SelectedValue = dt2.Rows[0]["InventorySubCategory"].ToString();
                    txtcalender.Value = dt2.Rows[0]["InventoryDate"].ToString();
                    txtAmount.Text = dt2.Rows[0]["Amount"].ToString();
                }
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
            }
        }
    }
}