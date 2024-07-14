package com.gim.app.dao

import androidx.room.*
import androidx.lifecycle.LiveData
import com.gim.app.entity.LocationData

@Dao
interface LocationDao {

  @Insert(onConflict = OnConflictStrategy.REPLACE)
  suspend fun insertLocation(locationData: LocationData)

  @Query("SELECT * FROM location_data ORDER BY id DESC")
  suspend fun getAllLocations(): List<LocationData>

  @Query("SELECT * FROM location_data ORDER BY timestamp DESC LIMIT 1")
  fun getLatestLocation(): LiveData<LocationData?>

  @Query("DELETE FROM location_data WHERE id = :id")
  suspend fun deleteById(id: Int)

  @Query("DELETE FROM location_data")
  suspend fun deleteAllLocations()
}
