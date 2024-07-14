package com.gim.app.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "location_data")
data class LocationData(
  @PrimaryKey(autoGenerate = true) val id: Long = 0,
  val latitude: Double,
  val longitude: Double,
  val timestamp: Long
)
