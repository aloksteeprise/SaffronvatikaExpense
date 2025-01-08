using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RestoExpense
{
    public partial class InventoryList : System.Web.UI.Page
    {
        InventoryDataHandler inventoryDataHandler = new InventoryDataHandler();
        InventoryModel inventoryModel = new InventoryModel();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.AddDays(-15).ToString("MM/dd/yyyy");
                txtToDate.Text = DateTime.Now.ToString("MM/dd/yyyy");

                inventoryModel.FromDate = DateTime.Now.AddDays(-15).ToString("MM/dd/yyyy");
                inventoryModel.ToDate = DateTime.Now.ToString("MM/dd/yyyy");

                BindGridInventoryDetails(inventoryModel);
            }
        }

        protected void BindGridInventoryDetails(InventoryModel inventoryModel)
        {
            try
            {
                DataTable dt = inventoryDataHandler.GetInventoryDetails(inventoryModel);

                if (dt != null && dt.Rows.Count > 0)
                {
                    GridInventoryDetails.DataSource = dt;
                    GridInventoryDetails.DataBind();
                    GridInventoryDetails.Visible = true;
                    lblNoRecords.Visible = false;
                }
                else
                {
                    GridInventoryDetails.Visible = false;
                    lblNoRecords.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // Optionally log the error or show it somewhere for debugging
                string error = ex.ToString();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            List<string> errorMessages = new List<string>();
            string datePattern = "^(0[1-9]|1[012])([/])(0[1-9]|[12][0-9]|3[01])([/])(19|20)\\d\\d$"; // MM/DD/YYYY pattern

            DateTime fromDate = default;
            DateTime toDate = default;

            if (string.IsNullOrWhiteSpace(txtFromDate.Text) || !System.Text.RegularExpressions.Regex.IsMatch(txtFromDate.Text, datePattern))
            {
                errorMessages.Add("Please enter a valid 'From Date' (MM/DD/YYYY).");
            }
            else
            {
                if (!DateTime.TryParse(txtFromDate.Text, out fromDate))
                {
                    errorMessages.Add("Please enter a valid 'From Date'.");
                }
            }

            if (string.IsNullOrWhiteSpace(txtToDate.Text) || !System.Text.RegularExpressions.Regex.IsMatch(txtToDate.Text, datePattern))
            {
                errorMessages.Add("Please enter a valid 'To Date' (MM/DD/YYYY).");
            }
            else
            {
                if (!DateTime.TryParse(txtToDate.Text, out toDate))
                {
                    errorMessages.Add("Please enter a valid 'To Date'.");
                }
            }

            if (fromDate > toDate)
            {
                errorMessages.Add("'From Date' should be earlier than or equal to 'To Date'.");
            }

            if (errorMessages.Count > 0)
            {
                lblError.Text = string.Join("<br/>", errorMessages);
                lblError.Visible = true;
            }
            else
            {
                inventoryModel.FromDate = fromDate.ToString("yyyy-MM-dd");
                inventoryModel.ToDate = toDate.ToString("yyyy-MM-dd");

                lblError.Visible = false;

                BindGridInventoryDetails(inventoryModel);
            }
        }


    }
}