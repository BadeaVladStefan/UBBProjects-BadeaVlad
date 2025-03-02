package com.example.lab1native.repository

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.lab1native.model.F1Driver
import java.util.UUID

class F1DriverRepository private constructor() {

    private val drivers = mutableListOf<F1Driver>()
    private val _driversLiveData = MutableLiveData<List<F1Driver>>(drivers)
    val driversLiveData: LiveData<List<F1Driver>> get() = _driversLiveData

    init {
        initializeDrivers()
    }

    private fun initializeDrivers() {
        drivers.add(F1Driver("1", "Lewis Hamilton", "Mercedes", "British", 38, 100))
        drivers.add(F1Driver("2", "Max Verstappen", "Red Bull Racing", "Dutch", 26, 35))
        drivers.add(F1Driver("3", "Sebastian Vettel", "Aston Martin", "German", 36, 53))
        drivers.add(F1Driver("4", "Charles Leclerc", "Ferrari", "Monegasque", 26, 8))
        drivers.add(F1Driver("5", "Fernando Alonso", "Aston Martin", "Spanish", 43, 32))
        _driversLiveData.value = drivers.toList()
    }

    companion object {
        @Volatile
        private var INSTANCE: F1DriverRepository? = null

        fun getInstance(): F1DriverRepository {
            return INSTANCE ?: synchronized(this) {
                INSTANCE ?: F1DriverRepository().also { INSTANCE = it }
            }
        }
    }

    fun addDriver(name: String, team: String, nationality: String, age: Int, wins: Int) {
        val driver = F1Driver(
            id = UUID.randomUUID().toString(),
            name = name,
            team = team,
            nationality = nationality,
            age = age,
            wins = wins
        )
        drivers.add(driver)
        _driversLiveData.value = drivers.toList()
    }

    fun deleteDriver(id: String) {
        drivers.removeAll { it.id == id }
        _driversLiveData.value = drivers.toList()
    }

    fun updateDriver(id: String, name: String, team: String, nationality: String, age: Int, wins: Int) {
        val driverIndex = drivers.indexOfFirst { it.id == id }
        if (driverIndex != -1) {
            val updatedDriver = drivers[driverIndex].copy(
                name = name,
                team = team,
                nationality = nationality,
                age = age,
                wins = wins
            )
            drivers[driverIndex] = updatedDriver
            _driversLiveData.value = drivers.toList()
        }
    }

    fun getAllDrivers(): List<F1Driver> {
        return drivers.toList()
    }
}
