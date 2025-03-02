package com.example.lab1native.adapter

import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.lab1native.R
import com.example.lab1native.model.F1Driver
import com.example.lab1native.UpdateActivity

class F1DriverAdapter(private var drivers: List<F1Driver>) : RecyclerView.Adapter<F1DriverAdapter.DriverViewHolder>() {

    class DriverViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val nameTextView: TextView = itemView.findViewById(R.id.driver_name)
        val teamTextView: TextView = itemView.findViewById(R.id.driver_team)
        val nationalityTextView: TextView = itemView.findViewById(R.id.driver_nationality)
        val ageTextView: TextView = itemView.findViewById(R.id.driver_age)
        val winsTextView: TextView = itemView.findViewById(R.id.driver_wins)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DriverViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.driver_item, parent, false)
        return DriverViewHolder(view)
    }

    override fun onBindViewHolder(holder: DriverViewHolder, position: Int) {
        val driver = drivers[position]
        holder.nameTextView.text = driver.name
        holder.teamTextView.text = driver.team
        holder.nationalityTextView.text = driver.nationality
        holder.ageTextView.text = driver.age.toString()
        holder.winsTextView.text = driver.wins.toString()


        holder.itemView.setOnClickListener {
            val context = holder.itemView.context
            val intent = Intent(context, UpdateActivity::class.java).apply {
                putExtra("DRIVER_ID", driver.id)
            }
            context.startActivity(intent)
        }
    }

    override fun getItemCount(): Int = drivers.size

    fun updateDrivers(newDrivers: List<F1Driver>) {
        drivers = newDrivers
        notifyDataSetChanged()
    }
}
