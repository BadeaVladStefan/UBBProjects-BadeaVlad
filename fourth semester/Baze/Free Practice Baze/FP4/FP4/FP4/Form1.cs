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

namespace FP4
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlDataAdapter DataAdapterDevelopers;
        SqlDataAdapter DataAdapterTasks;
        DataSet dataSet;
        SqlCommandBuilder commandBuilder;

        void fillData()
        {
            connection = new SqlConnection("Data Source=DESKTOP-DD18S5T;Initial Catalog=FP4;Integrated Security=True");

            DataAdapterDevelopers = new SqlDataAdapter("SELECT * FROM Developers", connection);
            DataAdapterTasks = new SqlDataAdapter("SELECT * FROM Tasks", connection);
            dataSet = new DataSet();

            DataAdapterDevelopers.Fill(dataSet, "Developers");
            DataAdapterTasks.Fill(dataSet, "Tasks");

            commandBuilder = new SqlCommandBuilder(DataAdapterTasks);

            dataSet.Relations.Add("Tasks_Developers", dataSet.Tables["Developers"].Columns["DeveloperId"], dataSet.Tables["Tasks"].Columns["DeveloperId"]);

            this.DGVDevelopers.DataSource = dataSet.Tables["Developers"];
            this.DGVTasks.DataSource = this.DGVDevelopers.DataSource;
            this.DGVTasks.DataMember = "Tasks_Developers";

            commandBuilder.GetInsertCommand();
            commandBuilder.GetUpdateCommand();
            commandBuilder.GetDeleteCommand();
        }

        public Form1()
        {
            InitializeComponent();
            fillData();
        }

        private void SaveButton_Click(object sender, EventArgs e)
        {
            DataAdapterTasks.Update(dataSet, "Tasks");
        }
    }
}
