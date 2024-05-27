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

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlDataAdapter dataAdapterFise;
        SqlDataAdapter dataAdapterProceduri;
        DataSet dataSet;
        SqlCommandBuilder commandBuilder;

        void fillData()
        {
            try
            {
                connection = new SqlConnection("Data Source=DESKTOP-DD18S5T;Initial Catalog=FP5;Integrated Security=True");

                dataAdapterFise = new SqlDataAdapter("SELECT * FROM Fise", connection);
                dataAdapterProceduri = new SqlDataAdapter("SELECT * FROM FisaProceduri", connection);

                dataSet = new DataSet();

                dataAdapterFise.Fill(dataSet, "Fise");
                dataAdapterProceduri.Fill(dataSet, "FisaProceduri");

                commandBuilder = new SqlCommandBuilder(dataAdapterProceduri);

                DataRelation dataRelation = new DataRelation("FK_Fise_FisaProceduri", dataSet.Tables["Fise"].Columns["FisaId"], dataSet.Tables["FisaProceduri"].Columns["FisaId"]);
                dataSet.Relations.Add(dataRelation);

                this.DGVFise.DataSource = dataSet.Tables["Fise"];
                this.DGVProceduri.DataSource = this.DGVFise.DataSource;
                this.DGVFise.DataMember = "FK_Fise_FisaProceduri";

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

        private void ButtonSave_Click(object sender, EventArgs e)
        {
            try
            {
                dataAdapterProceduri.Update(dataSet, "FisaProceduri");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
