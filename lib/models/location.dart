import 'dart:convert';
import 'dart:developer';

class LocationData {
  int id = 0;
  double latitude = 0;
  double longitude = 0;
  int timestamp = 0;

  LocationData.fromJson(dynamic map) {
    try {
      if (map is Map<String, dynamic> && map.isNotEmpty) {
        id = map["a"] ?? 0;
        latitude = map["b"] ?? 0;
        longitude = map["c"] ?? 0;
        timestamp = map["d"] ?? 0;
      }
    } catch (err) {
      log("$err");
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["timestamp"] = timestamp;
    return map;
  }

  Map<String, dynamic> toJson() => toMap();

  @override
  String toString() => json.encode(this);
}
