import 'dart:convert';
import 'dart:developer';

const tablePositions = "table_positions";

class DBPositionFields {
  static const id = "id";
  static const latitude = "latitude";
  static const longitude = "longitude";
  static const altitude = "altitude";
  static const accuracy = "accuracy";
  static const dateTime = "dateTime";

  static final dbPositionFieldValues = [
    id,
    latitude,
    longitude,
    altitude,
    accuracy,
    dateTime,
  ];
}

class DBPosition {
  DBPosition({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.accuracy,
    required this.dateTime,
  });

  int? id;
  double latitude = 0.0;
  double longitude = 0.0;
  double altitude = 0.0;
  double accuracy = 0.0;
  DateTime dateTime = DateTime.now();

  DBPosition.fromJson(dynamic map) {
    try {
      if (map is Map<String, dynamic> && map.isNotEmpty) {
        id = map[DBPositionFields.id] ?? id;
        latitude = map[DBPositionFields.latitude] ?? latitude;
        longitude = map[DBPositionFields.longitude] ?? longitude;
        altitude = map[DBPositionFields.altitude] ?? altitude;
        accuracy = map[DBPositionFields.accuracy] ?? accuracy;
        dateTime = DateTime.tryParse(map[DBPositionFields.dateTime] ?? "") ?? dateTime;
      }
    } catch (err) {
      log("fromJson: $err");
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    try {
      map[DBPositionFields.id] = id;
      map[DBPositionFields.latitude] = latitude;
      map[DBPositionFields.longitude] = longitude;
      map[DBPositionFields.altitude] = altitude;
      map[DBPositionFields.accuracy] = accuracy;
      map[DBPositionFields.dateTime] = dateTime.toIso8601String();
    } catch (_) {}
    return map;
  }

  DBPosition copyWith({
    int? id,
    double? latitude,
    double? longitude,
    double? altitude,
    double? accuracy,
    DateTime? dateTime,
  }) =>
      DBPosition(
          id: id ?? this.id,
          latitude: latitude ?? this.latitude,
          longitude: longitude ?? this.longitude,
          altitude: altitude ?? this.altitude,
          accuracy: accuracy ?? this.accuracy,
          dateTime: dateTime ?? this.dateTime);

  Map<String, dynamic> toJson() => toMap();

  @override
  String toString() => json.encode(this);
}
