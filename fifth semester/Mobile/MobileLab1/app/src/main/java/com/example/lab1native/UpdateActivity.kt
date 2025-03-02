package com.example.lab1native

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.example.lab1native.model.F1Driver
import com.example.lab1native.repository.F1DriverRepository

class UpdateActivity : AppCompatActivity() {
    private lateinit var driverRepository: F1DriverRepository
    private lateinit var driverId: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_update)

        driverRepository = F1DriverRepository.getInstance()


        driverId = intent.getStringExtra("DRIVER_ID") ?: ""
        val driver = driverRepository.getAllDrivers().find { it.id == driverId }


        driver?.let {
            findViewById<EditText>(R.id.name_input2).setText(it.name)
            findViewById<EditText>(R.id.team_input2).setText(it.team)
            findViewById<EditText>(R.id.nationality_input2).setText(it.nationality)
            findViewById<EditText>(R.id.age_input2).setText(it.age.toString())
            findViewById<EditText>(R.id.wins_input2).setText(it.wins.toString())
        }

        val updateButton = findViewById<Button>(R.id.update_driver_button)
        updateButton.setOnClickListener {
            val name = findViewById<EditText>(R.id.name_input2).text.toString().trim()
            val team = findViewById<EditText>(R.id.team_input2).text.toString().trim()
            val nationality = findViewById<EditText>(R.id.nationality_input2).text.toString().trim()
            val ageString = findViewById<EditText>(R.id.age_input2).text.toString().trim()
            val winsString = findViewById<EditText>(R.id.wins_input2).text.toString().trim()


            if (name.isEmpty()) {
                showToast("Name cannot be empty")
                return@setOnClickListener
            }
            if (team.isEmpty()) {
                showToast("Team cannot be empty")
                return@setOnClickListener
            }
            if (nationality.isEmpty()) {
                showToast("Nationality cannot be empty")
                return@setOnClickListener
            }
            if (ageString.isEmpty() || ageString.toIntOrNull() == null || ageString.toInt() < 0) {
                showToast("Please enter a valid age")
                return@setOnClickListener
            }
            if (winsString.isEmpty() || winsString.toIntOrNull() == null || winsString.toInt() < 0) {
                showToast("Please enter a valid number of wins")
                return@setOnClickListener
            }

            val age = ageString.toInt()
            val wins = winsString.toInt()


            driverRepository.updateDriver(driverId, name, team, nationality, age, wins)
            Toast.makeText(this, "Driver updated successfully", Toast.LENGTH_SHORT).show()
            finish()
        }

        val deleteButton = findViewById<Button>(R.id.delete_driver_button)
        deleteButton.setOnClickListener {
            showDeleteConfirmationDialog()
        }
    }

    private fun showDeleteConfirmationDialog() {
        AlertDialog.Builder(this)
            .setTitle("Delete Driver")
            .setMessage("Are you sure you want to delete this driver?")
            .setPositiveButton("Yes") { _, _ ->
                driverRepository.deleteDriver(driverId)
                Toast.makeText(this, "Driver deleted successfully", Toast.LENGTH_SHORT).show()
                finish()
            }
            .setNegativeButton("No", null)
            .show()
    }

    private fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }
}
