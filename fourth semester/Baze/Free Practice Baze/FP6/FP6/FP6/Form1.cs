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

namespace FP6
{
    public partial class Form1 : Form
    {
        SqlConnection conntection;
        SqlDataAdapter classDataAdapter;
        SqlDataAdapter speciesDataAdapter;
        DataSet dataSet;
        SqlCommandBuilder commandBuilder;

        void fillData()
        {
            try
            {
                conntection = new SqlConnection("Data Source=DESKTOP-DD18S5T;Initial Catalog=FP6;Integrated Security=True");

                classDataAdapter = new SqlDataAdapter("SELECT * FROM Classes", conntection);
                speciesDataAdapter = new SqlDataAdapter("SELECT * FROM Species", conntection);

                dataSet = new DataSet();

                classDataAdapter.Fill(dataSet, "Classes");
                speciesDataAdapter.Fill(dataSet, "Species");

                commandBuilder = new SqlCommandBuilder(speciesDataAdapter);

                dataSet.Relations.Add("Classes_Species", dataSet.Tables["Classes"].Columns["ClassID"], dataSet.Tables["Species"].Columns["ClassID"]);

                this.ClassComboBox.DataSource = dataSet.Tables["Classes"];
                this.ClassComboBox.DisplayMember = "ClassName";
                this.SpeciesDataGridView.DataSource = dataSet.Tables["Classes"];
                this.SpeciesDataGridView.DataMember = "Classes_Species";

                commandBuilder.GetInsertCommand();
                commandBuilder.GetUpdateCommand();
                commandBuilder.GetDeleteCommand();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public Form1()
        {
            InitializeComponent();
            fillData();
        }

        private void SaveChangesButton_Click(object sender, EventArgs e)
        {
            try
            {
                speciesDataAdapter.Update(dataSet, "Species");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
