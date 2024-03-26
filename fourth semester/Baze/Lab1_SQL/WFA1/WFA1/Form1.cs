using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WFA1
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlDataAdapter dataAdapterManufacturers; //for the table Manufacturers (parent table)
        SqlDataAdapter dataAdapterTeams; //for the table Teams (child table)
        DataSet dataSet;
        SqlCommandBuilder commandBuilder;

        string queryManufacturers = "SELECT * FROM Manufacturers";
        string queryTeams = "SELECT * FROM Teams";

        public Form1()
        {
            InitializeComponent();
            FillData();
        }
        void FillData()
        {
            try
            {
                connection = new SqlConnection(getConnectionString());

                //SqlDataAdapters:
                dataAdapterManufacturers = new SqlDataAdapter(queryManufacturers, connection);
                dataAdapterTeams = new SqlDataAdapter(queryTeams, connection);

                //dataSet:
                dataSet = new DataSet();
                dataAdapterManufacturers.Fill(dataSet, "Manufacturers");
                dataAdapterTeams.Fill(dataSet, "Teams");

                commandBuilder = new SqlCommandBuilder(dataAdapterTeams);

                //DataRelation:
                dataSet.Relations.Add(
                    new DataRelation(
                        "ManufacturerTeamsRelation",
                        dataSet.Tables["Manufacturers"].Columns["ManufacturerId"],
                        dataSet.Tables["Teams"].Columns["BikeManufacturerId"]
                    )
                );


                this.dataGridViewManufacturers.DataSource = dataSet.Tables["Manufacturers"];
                this.dataGridViewTeams.DataSource = this.dataGridViewManufacturers.DataSource;
                this.dataGridViewTeams.DataMember = "ManufacturerTeamsRelation";

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

        string getConnectionString()
        {
            return "Data Source=DESKTOP-DD18S5T;Initial Catalog=Moto GP;Integrated Security=True";
        }

        private void UpdateButton_Click(object sender, EventArgs e)
        {
            try
            {
                dataAdapterTeams.Update(dataSet, "Teams");
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                throw;
            }
            
        }
    }
}
