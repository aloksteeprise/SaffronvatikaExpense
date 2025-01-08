<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Expenses.aspx.cs" Inherits="RestoExpense.Expenses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            //$(".numbers").keypress(function (e) {
            //    var r = ((e.keyCode >= 48 && e.keyCode <= 57))
            //    if (!r) {

            //    }
            //    return r;
            //});
            $(".numbers").on("input", function (e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        });
        $(function () {
            $("#<%= txtPurchaseDate.ClientID %>").datepicker({
                dateFormat: "mm/dd/yy",
                maxDate: new Date()
            });

            $("#calendar-icon").click(function () {
                $("#<%= txtPurchaseDate.ClientID %>").focus();
            });
        });
    </script>

    <style>
        .datepicker-icon {
            cursor: pointer;
        }

        .txt {
            pointer-events: none;
        }

        .fontsize {
            font-size: small;
        }

        .btn-primary {
            color: #fff;
            background-color: #ffa500;
            border-color: #ffa500;
        }

        .btn-primary:hover {
            color: #fff;
            background-color: #ffa500;
            border-color: #ffa500;
        }
        .h2, h2 {
            font-size: 2rem;
            color:#fff;
        }

        .numbers[disabled] {
            cursor: default !important;
            background-color: #f2f2f2;
            color: #495057;
        }

    </style>

    <div class="container my-4">
        <h1 class="text-left">Expenses List</h1>

        <asp:HiddenField ID="hdnID" ClientIDMode="Static" runat="server" />

        <div class="form-group row">
            <label for="txtPurchaseDate" class="col-sm-3 col-form-label" style="font-size: medium;">Expense Date:</label>
            <div class="col-sm-7">
                <div class="input-group">
                    <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="form-control txt fontsize" placeholder="MM/DD/YYYY"
                        autocomplete="off" OnTextChanged="txtPurchaseDate_TextChanged" AutoPostBack="True"></asp:TextBox>
                    <div class="input-group-append">
                        <span id="calendar-icon" class="input-group-text datepicker-icon">
                            <img src="https://i.imgur.com/u6upaAs.png" alt="Calendar Icon" />
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <asp:GridView ID="GridInventoryDetails" runat="server" CssClass="table table-bordered table-striped"
                AutoGenerateColumns="False" DataKeyNames="ID" OnRowDataBound="GridInventoryDetails_RowDataBound">
                <Columns>
                    <asp:BoundField HeaderText="Category" DataField="InventoryCategory" HeaderStyle-CssClass="form-control-lg" ItemStyle-CssClass="form-control-lg" />
                    <asp:TemplateField HeaderText="Amount" HeaderStyle-CssClass="form-control-lg" ItemStyle-CssClass="form-control-lg">
                        <ItemTemplate>
                            <div class="form-row">
                                <div class="col-4">
                                    <asp:TextBox ID="txtAmount1" runat="server" CssClass="form-control fontsize numbers" AutoCompleteType="Disabled" Text='<%# Eval("Amount1") %>' MaxLength="6" ClientIDMode="Static" />
                                </div>
                                <div class="col-4">
                                    <asp:TextBox ID="txtAmount2" runat="server" CssClass="form-control fontsize numbers" AutoCompleteType="Disabled" Text='<%# Eval("Amount2") %>' MaxLength="6" ClientIDMode="Static" />
                                </div>
                                <div class="col-4">
                                    <asp:TextBox ID="txtAmount3" runat="server" CssClass="form-control fontsize numbers" AutoCompleteType="Disabled" Text='<%# Eval("Amount3") %>' MaxLength="6" ClientIDMode="Static" />
                                </div>
                                <asp:Label ID="lblInventoryID" runat="server" Visible="false" Text='<%# Eval("InventoryID") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Amount" HeaderStyle-CssClass="form-control-lg" ItemStyle-CssClass="form-control-lg">
                        <ItemTemplate>
                            <asp:Label ID="lblTotalAmount" runat="server" CssClass="form-control-plaintext" Font-Bold="true" Font-Size="larger" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="row mt-4">
            <div class="col-md-6">
                <strong style="font-size: medium">Total Expense Amount:</strong>
                <asp:Label ID="lblInventoryTotal" runat="server" CssClass="ml-2" Font-Bold="true" Style="font-size: medium;"></asp:Label>
            </div>
            <div class="col-md-6 text-right">
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" Font-Size="Medium" OnClick="btnSave_Click" />
            </div>
        </div>
    </div>
</asp:Content>
