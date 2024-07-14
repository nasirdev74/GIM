part of 'permission_bloc.dart';

@freezed
class PermissionEvent with _$PermissionEvent {
  const factory PermissionEvent.checkLocationPermission() = _CheckLocationPermission;

  const factory PermissionEvent.requestLocationPermission() = _RequestLocationPermission;

  const factory PermissionEvent.checkBatteryOptimizationPermission() = _CheckBatteryOptimizationPermission;

  const factory PermissionEvent.requestBatteryOptimization() = _RequestBatteryOptimization;
}
