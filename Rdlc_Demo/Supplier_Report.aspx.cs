using Microsoft.Reporting.WebForms;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;
using System;

namespace Rdlc_Demo
{
    public partial class Supplier_Report : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["TEST_DBConnectionString"].ConnectionString;
        string companyName = "";
        string contractName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblErrorMessage.Text = "";
                lblErrorMessage.Visible = false;
                Load_RV_Sppiler();
                txtCompanyName.Value = "";
                txtContract.Value = "";
            }
        }

        public void Load_RV_Sppiler() {

            if (!string.IsNullOrEmpty(txtCompanyName.Value.ToString()))
                companyName = txtCompanyName.Value.ToString();

            if (!string.IsNullOrEmpty(txtContract.Value.ToString()))
                contractName = txtContract.Value.ToString();

            DataTable dt = Get_Sp_SupplierList(companyName, contractName);
            List<ReportParameter> parameters = new List<ReportParameter>();
            parameters.Add(new ReportParameter("CompanyName", companyName));
            parameters.Add(new ReportParameter("ContractName", contractName));

            RV_Supplier.LocalReport.DataSources.Clear();
            

            RV_Supplier.ProcessingMode = ProcessingMode.Local;

            ReportDataSource reportData = new ReportDataSource("DS_SpSupplier", dt);
            RV_Supplier.LocalReport.SetParameters(parameters);
            RV_Supplier.LocalReport.DataSources.Add(reportData);
            RV_Supplier.LocalReport.Refresh();

        }
        public DataTable Get_Sp_SupplierList(string CompanyName, string ContractName)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("Sp_Supplier", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@CompanyName", CompanyName);
                    command.Parameters.AddWithValue("@ContractName", ContractName);
                    DataTable dt = new DataTable();
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        dt.Load(reader);
                    }
                    return dt;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblErrorMessage.Text = "";
            lblErrorMessage.Visible = false;
            try {
                if (!string.IsNullOrEmpty(txtCompanyName.Value.ToString()))
                    companyName = txtCompanyName.Value.ToString();

                if (!string.IsNullOrEmpty(txtContract.Value.ToString()))
                    contractName = txtContract.Value.ToString();
                txtCompanyName.Value = "";
                txtContract.Value = "";
                Load_RV_Sppiler();
            }
            catch (Exception ex) {
                LogException(ex);
                lblErrorMessage.Text = "An error occurred. Please try again later.";
                lblErrorMessage.Visible = true;
            }
        }
        private void LogException(Exception ex)
        {
            string logFilePath = Server.MapPath("~/App_Data/error.log");
            string logMessage = $"[{DateTime.Now}] Error: {ex.Message}\nStackTrace: {ex.StackTrace}\n\n";
            File.AppendAllText(logFilePath, logMessage);
        }
    }

}