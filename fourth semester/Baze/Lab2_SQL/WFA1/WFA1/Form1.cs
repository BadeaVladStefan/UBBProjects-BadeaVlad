using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace WFA1
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlDataAdapter dataAdapterManufacturers;
        SqlDataAdapter dataAdapterTeams;
        DataSet dataSet;
        SqlCommandBuilder commandBuilder;

        string parentQuery;
        string childQuery;
        string parentTableName;
        string childTableName;
        string parentPrimaryKey;
        string childForeignKey;

        public Form1()
        {
            InitializeComponent();
            LoadSettings();
            FillData();
        }

        void LoadSettings()
        {
            parentQuery = ConfigurationManager.AppSettings["ParentQuery"];
            childQuery = ConfigurationManager.AppSettings["ChildQuery"];
            parentTableName = ConfigurationManager.AppSettings["ParentTableName"];
            childTableName = ConfigurationManager.AppSettings["ChildTableName"];
            parentPrimaryKey = ConfigurationManager.AppSettings["ParentPrimaryKey"];
            childForeignKey = ConfigurationManager.AppSettings["ChildForeignKey"];
        }

        void FillData()
        {
            try
            {
                connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);

                dataAdapterManufacturers = new SqlDataAdapter(parentQuery, connection);
                dataAdapterTeams = new SqlDataAdapter(childQuery, connection);

                dataSet = new DataSet();
                dataAdapterManufacturers.Fill(dataSet, parentTableName);
                dataAdapterTeams.Fill(dataSet, childTableName);

                commandBuilder = new SqlCommandBuilder(dataAdapterTeams);

                dataSet.Relations.Add(
                    new DataRelation(
                        "ParentChildRelation",
                        dataSet.Tables[parentTableName].Columns[parentPrimaryKey],
                        dataSet.Tables[childTableName].Columns[childForeignKey]
                    )
                );

                dataGridViewManufacturers.DataSource = dataSet.Tables[parentTableName];
                dataGridViewTeams.DataSource = dataSet.Tables[parentTableName];
                dataGridViewTeams.DataMember = "ParentChildRelation";

                commandBuilder.GetUpdateCommand();
                commandBuilder.GetDeleteCommand();
                commandBuilder.GetInsertCommand();
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                throw;
            }
        }

        private void UpdateButton_Click(object sender, EventArgs e)
        {
            try
            {
                dataAdapterTeams.Update(dataSet, childTableName);
                MessageBox.Show("Changes were saved successfully.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                throw;
            }
        }

    }
}
