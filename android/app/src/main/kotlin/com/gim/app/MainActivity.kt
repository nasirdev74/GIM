package com.gim.app

import android.os.Build
import android.util.Log
import android.content.Intent
import androidx.annotation.RequiresApi
import com.gim.app.database.LocationDatabase
import com.gim.app.services.LocationService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import com.google.gson.Gson


class MainActivity : FlutterActivity() {
  private val TAG = "MainActivity"
  private val EVENT_CHANNEL = "com.gim.app/location_stream"
  private val METHOD_CHANNEL = "com.gim.app/location_service"

  private val gson = Gson()

  @OptIn(DelicateCoroutinesApi::class)
  @RequiresApi(Build.VERSION_CODES.O)
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(
      flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL
    ).setMethodCallHandler { call, result ->
      when (call.method) {
        "startService" -> {
          startLocationService()
          result.success("Service Started")
        }

        "stopService" -> {
          stopLocationService()
          result.success("Service Stopped")
        }

        "deleteById" -> {
          val id = call.arguments as Int
          GlobalScope.launch {
            LocationDatabase.getDatabase(applicationContext).locationDao().deleteById(id)
            result.success("Data with ID $id deleted")
          }
        }

        "deleteAllData" -> {
          GlobalScope.launch {
            LocationDatabase.getDatabase(applicationContext).locationDao().deleteAllLocations()
            result.success("All data deleted")
          }
        }

        "getAllData" -> {
          GlobalScope.launch {
            val allData =
              LocationDatabase.getDatabase(applicationContext).locationDao().getAllLocations()
            val jsonList = allData.map {
              gson.toJson(
                mapOf(
                  "a" to it.id,
                  "b" to it.latitude,
                  "c" to it.longitude,
                  "d" to it.timestamp
                )
              )
            }
            result.success(jsonList)
          }
        }

        else -> result.notImplemented()
      }
    }

    EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
      object : EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
          LocationDatabase.getDatabase(applicationContext).locationDao().getLatestLocation()
            .observe(this@MainActivity) { locations ->
              locations?.let {
                val locationData = mapOf(
                  "a" to it.id,
                  "b" to it.latitude,
                  "c" to it.longitude,
                  "d" to it.timestamp
                )
                events?.success(gson.toJson(locationData))
              }
            }
        }

        override fun onCancel(arguments: Any?) {
          Log.d(TAG, "onCancel: $arguments")
        }
      }
    )
  }

  @RequiresApi(Build.VERSION_CODES.O)
  private fun startLocationService() {
    val intent = Intent(this, LocationService::class.java)
    startForegroundService(intent)
  }

  private fun stopLocationService() {
    val intent = Intent(this, LocationService::class.java)
    stopService(intent)
  }
}
