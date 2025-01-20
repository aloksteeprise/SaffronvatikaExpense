using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RestoExpense 
{
    public partial class Expenses : System.Web.UI.Page
    {
        int InventoryTotal = 0;
        InventoryDataHandler inventoryDataHandler = new InventoryDataHandler();
        InventoryModel inventoryModel = new InventoryModel();
        DateTime istdate = new DateTime();
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime utcdate = DateTime.UtcNow;
            istdate = TimeZoneInfo.ConvertTimeFromUtc(utcdate, TimeZoneInfo.FindSystemTimeZoneById("India Standard Time"));
            if (!IsPostBack)
            {
                txtPurchaseDate.Text = istdate.ToString("MM/dd/yyyy");
                inventoryModel.InventoryDate = istdate.ToString("MM/dd/yyyy");

                BindGrid(inventoryModel);
            }
        }

        protected void BindGrid(InventoryModel inventoryModel)
        {
            var data = inventoryDataHandler.GetInventoryList(inventoryModel);

            GridInventoryDetails.DataSource = data;
            GridInventoryDetails.DataBind();

            lblInventoryTotal.Text = InventoryTotal == 0 ? "" : InventoryTotal.ToString();
        }

        protected void GridInventoryDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var amount1 = DataBinder.Eval(e.Row.DataItem, "Amount1");
                var amount2 = DataBinder.Eval(e.Row.DataItem, "Amount2");
                var amount3 = DataBinder.Eval(e.Row.DataItem, "Amount3");
                var id = DataBinder.Eval(e.Row.DataItem, "ID").ToString();
                hdnID.Value = id;

                var inventoryCategory = DataBinder.Eval(e.Row.DataItem, "InventoryCategory");

                TextBox txtAmount1 = (TextBox)e.Row.FindControl("txtAmount1");
                TextBox txtAmount2 = (TextBox)e.Row.FindControl("txtAmount2");
                TextBox txtAmount3 = (TextBox)e.Row.FindControl("txtAmount3");
                Label lblTotalAmount = (Label)e.Row.FindControl("lblTotalAmount");
                lblTotalAmount.Text = string.IsNullOrWhiteSpace(lblTotalAmount.Text) || Convert.ToInt32(lblTotalAmount.Text) == 0 ? "" : lblTotalAmount.Text;

                if (txtAmount1.Text == "0")
                {
                    txtAmount1.Text = "";
                }
                else if (amount1 != DBNull.Value && Convert.ToInt32(amount1) != 0)
                {
                    txtAmount1.Enabled = false;
                }

                if (txtAmount2.Text == "0")
                {
                    txtAmount2.Text = "";
                }
                else if (amount2 != DBNull.Value && Convert.ToInt32(amount2) != 0)
                {
                    txtAmount2.Enabled = false;
                }

                if (txtAmount3.Text == "0")
                {
                    txtAmount3.Text = "";
                }
                else if (amount3 != DBNull.Value && Convert.ToInt32(amount3) != 0)
                {
                    txtAmount3.Enabled = false;
                }
                if (DateTime.TryParse(txtPurchaseDate.Text, out DateTime purchaseDate))
                {
                    if (purchaseDate < istdate.AddDays(-2))
                    {
                        btnSave.Visible = false;
                        txtAmount1.Enabled = false;
                        txtAmount2.Enabled = false;
                        txtAmount3.Enabled = false;
                    }
                    else
                    {
                        btnSave.Visible = true;
                    }
                }

                InventoryTotal += string.IsNullOrWhiteSpace(lblTotalAmount.Text) ? 0 : Convert.ToInt32(lblTotalAmount.Text);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridInventoryDetails.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    inventoryModel.ID = Convert.ToInt32(GridInventoryDetails.DataKeys[row.RowIndex].Value);

                    var inventoryCategoryLabel = row.FindControl("lblInventoryID") as Label;
                    inventoryModel.InventoryCategory = inventoryCategoryLabel != null ? inventoryCategoryLabel.Text.Trim() : string.Empty;

                    var txtAmount1 = (TextBox)row.FindControl("txtAmount1");
                    inventoryModel.Amount1 = !string.IsNullOrWhiteSpace(txtAmount1?.Text) ? Convert.ToInt32(txtAmount1.Text) : 0;

                    var txtAmount2 = (TextBox)row.FindControl("txtAmount2");
                    inventoryModel.Amount2 = !string.IsNullOrWhiteSpace(txtAmount2?.Text) ? Convert.ToInt32(txtAmount2.Text) : 0;

                    var txtAmount3 = (TextBox)row.FindControl("txtAmount3");
                    inventoryModel.Amount3 = !string.IsNullOrWhiteSpace(txtAmount3?.Text) ? Convert.ToInt32(txtAmount3.Text) : 0;

                    inventoryModel.InventoryDate = txtPurchaseDate.Text;

                    if (txtAmount1.Text == "" && txtAmount2.Text == "" && txtAmount3.Text == "")
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Confirmpopup", string.Format("showInformationPopup();"), true);
                    }

                    inventoryDataHandler.SaveInventoryList(inventoryModel);
                    BindGrid(inventoryModel);
                }
            }
        }

        protected void txtPurchaseDate_TextChanged(object sender, EventArgs e)
        {
            if (Convert.ToDateTime(txtPurchaseDate.Text) > istdate)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "Confirmpopup", string.Format("alert('Expense Date can not be greater than today.');"), true);
                txtPurchaseDate.Text = istdate.ToString("MM/dd/yyyy");
            }

            inventoryModel.InventoryDate = txtPurchaseDate.Text;
            BindGrid(inventoryModel);
        }
    }
}