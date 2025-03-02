package com.example.lab1native

import android.content.Intent
import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.lab1native.R
import com.example.lab1native.adapter.F1DriverAdapter
import com.example.lab1native.model.F1Driver
import com.example.lab1native.repository.F1DriverRepository
import com.google.android.material.floatingactionbutton.FloatingActionButton

class MainActivity : AppCompatActivity() {
    private lateinit var driverRepository: F1DriverRepository
    private lateinit var driverAdapter: F1DriverAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        driverRepository = F1DriverRepository.getInstance()

        val recyclerView = findViewById<RecyclerView>(R.id.recyclerView)
        driverAdapter = F1DriverAdapter(emptyList())
        recyclerView.adapter = driverAdapter
        recyclerView.layoutManager = LinearLayoutManager(this)


        driverRepository.driversLiveData.observe(this, Observer { drivers ->
            driverAdapter.updateDrivers(drivers)
        })

        val addButton = findViewById<FloatingActionButton>(R.id.add_button)

        addButton.setOnClickListener {
            val intent = Intent(this, AddActivity::class.java)
            startActivityForResult(intent, ADD_DRIVER_REQUEST)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == ADD_DRIVER_REQUEST && resultCode == RESULT_OK) {
            driverRepository.driversLiveData.value?.let {
                driverAdapter.updateDrivers(it)
            }
        }
    }

    companion object {
        private const val ADD_DRIVER_REQUEST = 1
    }
}
