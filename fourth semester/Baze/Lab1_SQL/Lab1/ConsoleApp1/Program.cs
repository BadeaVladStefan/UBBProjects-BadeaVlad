using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string connectionString = " Data Source=DESKTOP-DD18S5T;Initial Catalog=Moto GP;Integrated Security=True;";
            SqlConnection connection = new SqlConnection(connectionString); 
            connection.Open();
            Console.WriteLine("Connection Opened");

            //SqlCommand
            string stringManufacturers = "SELECT * FROM Manufacturers"; //Manufacturer(ManufacturerId,ManufacturerName)
            SqlCommand command = new SqlCommand(stringManufacturers, connection);

            //SqlDataReader
            using (SqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    Console.WriteLine("{0}, {1}", reader[0], reader[1]);
                }
            }
            connection.Close();
        }
    }
}
