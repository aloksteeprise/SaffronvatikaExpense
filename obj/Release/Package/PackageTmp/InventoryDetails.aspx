<%@ Page Title="Inventory Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InventoryDetails.aspx.cs" Inherits="RestoExpense.InventoryDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#txtcalender").datepicker({
                dateFormat: "mm/dd/yy",
                maxDate: new Date(),
                minDate: new Date(new Date() - 1 * 24 * 60 * 60 * 1000)
            });

            $("#calendar-icon").click(function () {
                $("#txtcalender").focus();
            });
        });
    </script>
    <style type="text/css">
        #txtcalender {
            width: 100%;
        }

        #calendar-icon {
            right: 10px;
            top: 5px;
        }
    </style>
    <div style="padding: 0 10px 0 10px;">
        <h2>Inventory Details</h2>
        <table width="100%">
            <tr>
                <td>
                    <div>Inventory Category:</div>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlInventCate" DataTextField="InventoryCategory" DataValueField="ID" ClientIDMode="Static" Style="width: 100%;"
                        AutoPostBack="True" OnSelectedIndexChanged="ddlInventCate_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <div>Inventory SubCategory:</div>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlInventSubCate" DataTextField="InventorySubCategory" DataValueField="ID" ClientIDMode="Static"
                        Style="width: 100%;">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <div>Calender:</div>
                </td>
                <td>
                    <input type="text" id="txtcalender" runat="server" placeholder="MM/DD/YYYY" autocomplete="off" maxlength="10" clientidmode="Static" />
                    <span id="calendar-icon" style="cursor: pointer;">
                        <img src="https://i.imgur.com/u6upaAs.png" alt="calendar icon" />
                    </span>
                </td>
            </tr>
            <tr>
                <td>
                    <div>Amount:</div>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtAmount" ClientIDMode="Static" Style="width: 100%;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="float: right; padding-right: 20px;">
                    <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnID" runat="server" value="0" />
    </div>
</asp:Content>
