<%@ Page Title="Inventory List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InventoryList.aspx.cs" Inherits="RestoExpense.InventoryList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

    <script type="text/javascript">
        $(function () {
            $("#<%= txtFromDate.ClientID %>").datepicker({
                dateFormat: "mm/dd/yy",
                maxDate: new Date()
            });

            $("#<%= txtToDate.ClientID %>").datepicker({
                dateFormat: "mm/dd/yy",
                maxDate: new Date()
            });

            $("#calendar-icon").click(function () {
                $("#<%= txtFromDate.ClientID %>").focus();
            });

            $("#calendar-icon1").click(function () {
                $("#<%= txtToDate.ClientID %>").focus();
            });
        });
    </script>

    <style type="text/css">
        #txtcalender {
            width: 177px;
            padding-right: 25px;
        }

        #calendar-icon {
            right: 10px;
            top: 5px;
        }
    </style>

    <div style="padding: 0 10px 0 10px;">
        <h2>Inventory List</h2>
    </div>
    <div style="padding: 0 10px 0 10px;">
        <asp:Label ID="lblNoRecords" runat="server" Text="No records found." ForeColor="Red" Visible="false" />
        <table cellspacing="2" cellpadding="3" width="100%" style="padding: 10px 10px">
            <tr>
                <td style="padding-left: 15px">
                    <div>From Date:</div>
                </td>
                <td>
                    <asp:TextBox ID="txtFromDate" runat="server" Width="92px" MaxLength="10" placeholder="MM/DD/YYYY" autocomplete="off"></asp:TextBox>
                    <span id="calendar-icon" style="cursor: pointer;">
                        <img src="https://i.imgur.com/u6upaAs.png" alt="calendar icon" />
                    </span>
                </td>
                <td style="padding-left: 15px">
                    <div>To Date:</div>
                </td>
                <td>
                    <asp:TextBox ID="txtToDate" runat="server" Width="92px" MaxLength="10" placeholder="MM/DD/YYYY" autocomplete="off"></asp:TextBox>
                    <span id="calendar-icon1" style="cursor: pointer;">
                        <img src="https://i.imgur.com/u6upaAs.png" alt="calendar icon" />
                    </span>
                </td>
                <td>
                    <div>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div style="padding: 0 10px 0 10px;">
        <asp:GridView ID="GridInventoryDetails" runat="server" AutoGenerateColumns="false" Width="100%" CellPadding="2" PageSize="15">
            <Columns>
                <asp:BoundField HeaderText="Inventory Category" DataField="InventoryCategory">
                    <ItemStyle Width="400px" VerticalAlign="Middle" HorizontalAlign="Left" />
                    <HeaderStyle Width="400px" VerticalAlign="Middle" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Inventory SubCategory" DataField="InventorySubCategory">
                    <ItemStyle Width="400px" VerticalAlign="Middle" HorizontalAlign="Left" />
                    <HeaderStyle Width="400px" VerticalAlign="Middle" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Inventory Date" DataField="InventoryDate">
                    <ItemStyle Width="400px" VerticalAlign="Middle" HorizontalAlign="Left" />
                    <HeaderStyle Width="400px" VerticalAlign="Middle" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Amount" DataField="Amount">
                    <ItemStyle Width="400px" VerticalAlign="Middle" HorizontalAlign="Left" />
                    <HeaderStyle Width="400px" VerticalAlign="Middle" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkbtnEdit" runat="server" Visible="true" Text="Edit" NavigateUrl='<%# string.Format("~/InventoryDetails.aspx?ID={0}", Eval("ID")) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:HiddenField ID="hdnID" runat="server" />
</asp:Content>
