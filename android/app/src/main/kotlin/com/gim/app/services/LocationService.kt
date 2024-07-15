package com.gim.app.services

import android.Manifest
import com.gim.app.R
import android.os.*
import android.app.*
import android.util.*
import android.content.*
import android.location.*
import androidx.core.app.*
import kotlinx.coroutines.*
import com.gim.app.dao.LocationDao
import android.content.pm.PackageManager
import androidx.annotation.RequiresApi
import com.gim.app.database.LocationDatabase
import kotlin.coroutines.CoroutineContext
import com.gim.app.entity.LocationData
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale


class LocationService : Service(), CoroutineScope {
  private val notificationId = 1
  private lateinit var handler: Handler
  private val TAG = "LocationUpdateService"
  private lateinit var locationDao: LocationDao
  private lateinit var locationManager: LocationManager
  private val notificationChannelId = "location_updates_channel"

  private lateinit var wakeLock: PowerManager.WakeLock

  private var job: Job = Job()
  override val coroutineContext: CoroutineContext
    get() = Dispatchers.Main + job

  @RequiresApi(Build.VERSION_CODES.S)
  override fun onCreate() {
    super.onCreate()
    createNotificationChannel()
    startForeground(notificationId, createNotification(null))
    handler = Handler(Looper.getMainLooper())
    locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
    locationDao = LocationDatabase.getDatabase(this).locationDao()
    val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
    wakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "LocationService::lock")
    wakeLock.acquire(24 * 60 * 60 * 1000L)

    fetchLocation()
    scheduleLocationFetch()
  }

  override fun onDestroy() {
    super.onDestroy()
    handler.removeCallbacks(locationRunnable)
    stopForeground(true)
    job.cancel()

    if (wakeLock.isHeld) {
      wakeLock.release()
    }
  }

  private fun checkLocationPermission(): Boolean {
    return ActivityCompat.checkSelfPermission(
      this, Manifest.permission.ACCESS_FINE_LOCATION
    ) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
      this, Manifest.permission.ACCESS_COARSE_LOCATION
    ) == PackageManager.PERMISSION_GRANTED
  }

  private fun scheduleLocationFetch() {
    handler.post(locationRunnable)
  }

  private val locationRunnable = object : Runnable {
    @RequiresApi(Build.VERSION_CODES.S)
    override fun run() {
      fetchLocation()
      handler.postDelayed(this, 10000)
    }
  }

  @RequiresApi(Build.VERSION_CODES.S)
  private fun fetchLocation() {
    if (checkLocationPermission()) {
      try {
        val location = locationManager.getLastKnownLocation(LocationManager.FUSED_PROVIDER)
        location?.let {
          updateNotification(it)
          launch {
            saveLocationData(it.latitude, it.longitude)
          }
        }
      } catch (ex: SecurityException) {
        Log.e(TAG, "Location permission not granted: ${ex.message}")
      }
    }
  }

  private fun saveLocationData(latitude: Double, longitude: Double) {
    val currentTimeMillis = System.currentTimeMillis()
    val locationData = LocationData(0, latitude, longitude, currentTimeMillis)
    launch {
      locationDao.insertLocation(locationData)
    }
  }

  private fun updateNotification(location: Location) {
    val notification = createNotification(location)
    val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    notificationManager.notify(notificationId, notification)
  }

  private fun createNotificationChannel() {
    val channelName = "Location Service"
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      val channel = NotificationChannel(
        notificationChannelId, channelName, NotificationManager.IMPORTANCE_DEFAULT
      )
      channel.description = "Background service for location updates"
      val manager = getSystemService(NotificationManager::class.java)
      manager.createNotificationChannel(channel)
    }
  }

  private fun createNotification(location: Location?): Notification {
    val notificationBuilder =
      NotificationCompat.Builder(this, notificationChannelId).setContentTitle("Location Service")
        .setSmallIcon(R.drawable.ic_notification).setPriority(NotificationCompat.PRIORITY_MAX)
        .setOngoing(true)
        .setSound(null)

    location?.let {
      val currentTime = SimpleDateFormat("hh:mm:ss", Locale.getDefault()).format(Date())
      notificationBuilder.setContentText("${it.latitude} - ${it.longitude} at $currentTime")
    } ?: run {
      notificationBuilder.setContentText("Fetching location...")
    }

    return notificationBuilder.build()
  }

  override fun onBind(intent: Intent?): IBinder? {
    return null
  }
}
