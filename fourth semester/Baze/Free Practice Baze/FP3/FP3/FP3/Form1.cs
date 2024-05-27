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

namespace FP3
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlDataAdapter adapterComenzi;
        SqlDataAdapter adapterPreparateComenzi;
        DataSet dataSet;
        SqlCommandBuilder commandBuilder;

        void fillData()
        { 
            connection = new SqlConnection("Data Source=DESKTOP-DD18S5T;Initial Catalog=FP3;Integrated Security=True");

            adapterComenzi = new SqlDataAdapter("SELECT * FROM Comenzi", connection);
            adapterPreparateComenzi = new SqlDataAdapter("SELECT * FROM PreparateComanda", connection);

            dataSet = new DataSet();

            adapterComenzi.Fill(dataSet, "Comenzi");
            adapterPreparateComenzi.Fill(dataSet, "PreparateComanda");

            commandBuilder = new SqlCommandBuilder(adapterPreparateComenzi);

            DataRelation relation = new DataRelation("FK_Comenzi_PreparateComanda", dataSet.Tables["Comenzi"].Columns["ComandaId"], dataSet.Tables["PreparateComanda"].Columns["ComandaId"]);

            dataSet.Relations.Add(relation);

            this.ComboBoxComenzi.DataSource = dataSet.Tables["Comenzi"];
            this.ComboBoxComenzi.DisplayMember = "ComandaId";
            this.DGVPreparateComenzi.DataSource = this.ComboBoxComenzi.DataSource;
            this.DGVPreparateComenzi.DataMember = "FK_Comenzi_PreparateComanda";
        
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
            adapterPreparateComenzi.Update(dataSet, "PreparateComanda");
        }
    }
}
