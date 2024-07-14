import 'dart:convert';
import 'dart:developer';

import 'package:app/models/models.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class LocationService {
  static const _platformChannel = MethodChannel('com.gim.app/location_service');
  static const _eventChannel = EventChannel('com.gim.app/location_stream');

  Future startService() async {
    try {
      await _platformChannel.invokeMethod('startService');
    } catch (err) {
      log("$err");
    }
  }

  Future stopService() async {
    try {
      await _platformChannel.invokeMethod('stopService');
    } catch (err) {
      log("$err");
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await _platformChannel.invokeMethod('deleteById', id);
    } catch (err) {
      log("$err");
    }
  }

  Future<void> deleteAllData() async {
    try {
      await _platformChannel.invokeMethod('deleteAllData');
    } catch (err) {
      log("$err");
    }
  }

  Future<List<LocationData>> getAllLocations() async {
    final locations = <LocationData>[];
    final ids = <int>{};
    try {
      final data = await _platformChannel.invokeMethod('getAllData');
      if (data is Iterable && data.isNotEmpty) {
        for (final temp in data) {
          final location = LocationData.fromJson(jsonDecode(temp));
          if (ids.add(location.id)) {
            locations.add(location);
          }
        }
      }
    } catch (err) {
      log("$err");
    }
    return Future.value(locations);
  }

  Stream onLocationData() {
    return _eventChannel.receiveBroadcastStream();
  }
}
