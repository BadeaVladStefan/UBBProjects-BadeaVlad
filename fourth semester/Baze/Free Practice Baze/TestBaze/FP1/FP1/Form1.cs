using System;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace FP1
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlDataAdapter dataAdapterParent;
        SqlDataAdapter dataAdapterChild;
        DataSet dataSet;
        SqlCommandBuilder commandBuilder;
        BindingSource bindingSourceParent;
        BindingSource bindingSourceChild;

        string parentQuery;
        string childQuery;
        string parentTableName;
        string childTableName;
        string parentPrimaryKey;
        string childForeignKey;

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

                dataAdapterParent = new SqlDataAdapter(parentQuery, connection);
                dataAdapterChild = new SqlDataAdapter(childQuery, connection);

                dataSet = new DataSet();
                dataAdapterParent.Fill(dataSet, parentTableName);
                dataAdapterChild.Fill(dataSet, childTableName);


                dataSet.Relations.Add(
                    new DataRelation(
                        "ParentChildRelation",
                        dataSet.Tables[parentTableName].Columns[parentPrimaryKey],
                        dataSet.Tables[childTableName].Columns[childForeignKey]
                    )
                );

                bindingSourceParent = new BindingSource();
                bindingSourceChild = new BindingSource();

                bindingSourceParent.DataSource = dataSet;
                bindingSourceParent.DataMember = parentTableName;

                bindingSourceChild.DataSource = bindingSourceParent;
                bindingSourceChild.DataMember = "ParentChildRelation";


                DGVNeighborhoods.DataSource = bindingSourceParent;
                DGVSmartHomes.DataSource = bindingSourceChild;

                commandBuilder = new SqlCommandBuilder(dataAdapterChild);

                commandBuilder.GetUpdateCommand();
                commandBuilder.GetDeleteCommand();
                commandBuilder.GetInsertCommand();
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void SaveButton_Click(object sender, EventArgs e)
        {
            try
            {
                dataAdapterChild.Update(dataSet, childTableName);
                MessageBox.Show("Changes were saved successfully.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public Form1()
        {
            InitializeComponent();
            LoadSettings();
            FillData();
        }
    }
}
