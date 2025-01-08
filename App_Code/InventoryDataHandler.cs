using System;
using System.Data.SqlClient;
using System.Data;
using MySql.Data.MySqlClient;
using System;
using System.Data;
public class InventoryDataHandler
{
    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["RestoExpense"].ToString();

    public InventoryDataHandler()
    {
    }

    public DataSet GetInventoryCategory()
    {
        SqlDataAdapter sda = new SqlDataAdapter();
        DataSet ds = new DataSet();
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("usp_GetInventoryCategory", con))
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = CommandType.StoredProcedure;
                    sda.SelectCommand = cmd;
                    sda.Fill(ds);
                }

                con.Close();
                con.Dispose();
            }
        }
        catch (Exception ex)
        {
            string error = ex.ToString();
        }

        return ds;
    }

    public DataSet GetInventorySubCategory(int ID)
    {
        SqlDataAdapter sda = new SqlDataAdapter();
        DataSet ds = new DataSet();
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("usp_GetInventorySubCategory", con) { CommandType = System.Data.CommandType.StoredProcedure })
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", ID);
                    sda.SelectCommand = cmd;
                    sda.Fill(ds);
                }

                con.Close();
                con.Dispose();
            }
        }
        catch (Exception ex)
        {
            string error = ex.ToString();
        }

        return ds;
    }

    public string SaveInventoryDetails(InventoryModel model)
    {
        string response = "";
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("usp_SaveInventory", con) { CommandType = System.Data.CommandType.StoredProcedure })
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", model.ID);
                    cmd.Parameters.AddWithValue("@InventoryCategory", model.InventoryCategory);
                    cmd.Parameters.AddWithValue("@InventorySubCategory", model.InventorySubCategory);
                    cmd.Parameters.AddWithValue("@InventoryDate", model.InventoryDate);
                    cmd.Parameters.AddWithValue("@Amount", model.Amount);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
                con.Dispose();
            }
        }
        catch (Exception ex)
        {
            string error = ex.ToString();
            response = "Error occured";
        }

        return response;
    }

    public DataTable GetInventoryDetails(InventoryModel model)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("usp_GetInventoryDetails", con) { CommandType = System.Data.CommandType.StoredProcedure })
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FromDate", model.FromDate);
                    cmd.Parameters.AddWithValue("@ToDate", model.ToDate);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
                con.Close();
                con.Dispose();
            }
        }
        catch (Exception ex)
        {
            string error = ex.ToString();
        }

        return dt;
    }

    public DataTable GetInventoryDetailByID(int ID)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("usp_GetInventoryDetailsByID", con) { CommandType = System.Data.CommandType.StoredProcedure })
                {
                    cmd.Parameters.AddWithValue("@ID", ID);
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = CommandType.StoredProcedure;
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
                con.Close();
                con.Dispose();
            }
        }
        catch (Exception ex)
        {
            string error = ex.ToString();
        }

        return dt;
    }

    public string SaveInventoryList(InventoryModel model)
    {
        string response = "";
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("usp_SaveInventoryList", con) { CommandType = System.Data.CommandType.StoredProcedure })
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", model.ID);
                    cmd.Parameters.AddWithValue("@InventoryCategoryID", model.InventoryCategory);
                    cmd.Parameters.AddWithValue("@Amount1", model.Amount1);
                    cmd.Parameters.AddWithValue("@Amount2", model.Amount2);
                    cmd.Parameters.AddWithValue("@Amount3", model.Amount3);
                    cmd.Parameters.AddWithValue("@InventoryDate", model.InventoryDate);
                    cmd.ExecuteNonQuery();
                }

                con.Close();
                con.Dispose();
            }
        }
        catch (Exception ex)
        {
            string error = ex.ToString();
            response = "Error occured";
        }

        return response;
    }

    public DataTable GetInventoryList(InventoryModel model)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("usp_GetInventoryList", con) { CommandType = System.Data.CommandType.StoredProcedure })
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@InventoryDate", model.InventoryDate);
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                }
                con.Close();
                con.Dispose();
            }
        }
        catch (Exception ex)
        {
            string error = ex.ToString();
            throw;
        }

        return dt;
    }

}
