using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class InventoryModel
{
    public int ID { get; set; }
    public string InventoryCategory { get; set; }
    public string InventorySubCategory { get; set; }
    public string InventoryDate { get; set; }
    public string Amount { get; set; }
    public int? Amount1 { get; set; }
    public int? Amount2 { get; set; }
    public int? Amount3 { get; set; }
    public string FromDate { get; set; }
    public string ToDate { get; set; }
}
