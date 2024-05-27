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

namespace PracticalExamTest
{
    public partial class Form1 : Form
    {
        SqlConnection connectionString = new SqlConnection("Data Source=DESKTOP-DD18S5T;Initial Catalog=PracticalExamPractice;Integrated Security=True");
        DataSet dataSet = new DataSet();
        SqlDataAdapter dataAdapterUsers = new SqlDataAdapter("SELECT * FROM Users", connectionString);
        SqlDataAdapter dataAdapterPosts = new SqlDataAdapter("SELECT * FROM Users", connectionString);

        SqlCommandBuilder commandBuilderPosts = new SqlCommandBuilder();

        BindingSource bindingSourceUsers = new BindingSource();
        BindingSource bindingSourcePosts = new BindingSource();


        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            dataAdapterUsers.Fill(dataSet, "Users");
            dataAdapterPosts.Fill(dataSet, "Posts");

        }
    }
}
