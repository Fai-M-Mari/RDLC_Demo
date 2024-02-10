<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Supplier_Report.aspx.cs" Inherits="Rdlc_Demo.Supplier_Report" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div>
            <div>
    <table>
        <tr>
            <td colspan="2" class="center">
                <label>Search Filters</label>
            </td>
        </tr>
        <tr>
            <td>
                <label>Company Name</label>
            </td>
            <td>
                <input type="text" id="txtCompanyName" name="txtCompanyName" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <label>Contract Name</label>
            </td>
            <td>
                <input type="text" id="txtContract" name="txtContract" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Search" title="Search" CssClass="btn" OnClick="btnSubmit_Click" />
            </td>
            <asp:Label ID="lblErrorMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
        </tr>
    </table>
</div>

        </div>
        <rsweb:ReportViewer ID="RV_Supplier" runat="server" BackColor="" ClientIDMode="AutoID" Height="417px" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" Width="1103px" ZoomMode="PageWidth">
            <LocalReport ReportPath="Rdlc Reports\r_Supplier.rdlc">
                   <DataSources>
                        <rsweb:ReportDataSource DataSourceId="spSupplier" Name="DS_SpSupplier" />
                    </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:SqlDataSource ID="spSupplier" runat="server" ConnectionString="<%$ ConnectionStrings:TEST_DBConnectionString %>" SelectCommand="Sp_Supplier" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="CompanyName" SessionField="txtCompany" Type="String" />
                <asp:SessionParameter Name="ContractName" SessionField="txtContract" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
