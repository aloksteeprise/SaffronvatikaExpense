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
        function showInformationPopup() {
            $('#SmokeDiv1').show();
            $('#InformationDiv').show();
            $('#btnOk').focus();
        }

        function HideInformationPopup() {
            $('#SmokeDiv1').hide();
            $('#InformationDiv').hide();
            window.location.href = "/Expenses";
        }
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
        .modal {
            position: fixed;
            top: 200px;
            left: 0;
            z-index: 1050;
            display: none;
            width: 100%;
            height: 100%;
            overflow: hidden;
            outline: 0;
        }

        .modal-content {
            border-radius: 10px;
            background-color: #ffa500;
            color: white;
        }

        .modal-header, .modal-footer {
            border: none;
            display: inline;
            text-align:center;
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
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" Font-Size="Medium" OnClick="btnSave_Click"/>
            </div>
        </div>
    </div>
    <div id="SmokeDiv1" style="position: fixed; top: 0; right: 0; bottom: 0; left: 0;
        background-color: #000; z-index: 2; opacity: 0.6; filter: alpha(opacity=60); display: none">
    </div>
    <div id="InformationDiv" class="pops modal" tabindex="-1" role="dialog" aria-labelledby="InformationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="InformationModalLabel" style="font-size: x-large; text-align: center;">Information!!!</h5>
            </div>
            <div class="modal-body" style="text-align: center;">
                <label runat="server" id="lblHeading1" style="color:white; font-size: medium;">Record Saved Successfully!!!</label>
            </div>
            <div class="modal-footer">
                <input type="button" id="btnOk" class="btn btn-secondary" style="font-size: small;" value="Ok" onclick="HideInformationPopup()" />
            </div>
        </div>
    </div>
</div>
</asp:Content>
