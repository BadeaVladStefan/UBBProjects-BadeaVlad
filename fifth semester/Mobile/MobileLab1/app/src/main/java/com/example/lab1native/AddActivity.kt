package com.example.lab1native

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import com.example.lab1native.repository.F1DriverRepository

class AddActivity : AppCompatActivity() {
    private lateinit var driverRepository: F1DriverRepository

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_add)

        driverRepository = F1DriverRepository.getInstance()

        val nameInput = findViewById<EditText>(R.id.name_input)
        val teamInput = findViewById<EditText>(R.id.team_input)
        val nationalityInput = findViewById<EditText>(R.id.nationality_input)
        val ageInput = findViewById<EditText>(R.id.age_input)
        val winsInput = findViewById<EditText>(R.id.wins_input)
        val addButton = findViewById<Button>(R.id.add_new_driver_button)

        addButton.setOnClickListener {
            val name = nameInput.text.toString().trim()
            val team = teamInput.text.toString().trim()
            val nationality = nationalityInput.text.toString().trim()
            val ageString = ageInput.text.toString().trim()
            val winsString = winsInput.text.toString().trim()

            if (name.isEmpty()) {
                Toast.makeText(this, "Name cannot be empty", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            if (team.isEmpty()) {
                Toast.makeText(this, "Team cannot be empty", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            if (nationality.isEmpty()) {
                Toast.makeText(this, "Nationality cannot be empty", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            val age = ageString.toIntOrNull()
            if (age == null || age <= 0) {
                Toast.makeText(this, "Please enter a valid age", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            val wins = winsString.toIntOrNull()
            if (wins == null || wins < 0) {
                Toast.makeText(this, "Wins cannot be negative", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            driverRepository.addDriver(name, team, nationality, age, wins)

            Toast.makeText(this, "Driver added successfully", Toast.LENGTH_SHORT).show()
            finish()
        }
    }
}
