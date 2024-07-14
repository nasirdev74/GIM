import 'dart:async';

import 'package:app/enum/enums.dart';
import 'package:location/location.dart';
import 'package:injectable/injectable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app/enum/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart' as pm;

part 'permission_bloc.freezed.dart';

part 'permission_event.dart';

part 'permission_state.dart';

@singleton
class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  StreamSubscription<ServiceStatus>? _locationServiceStatusStreamSubscription;

  PermissionBloc() : super(const PermissionState()) {
    on<_CheckLocationPermission>(_checkLocationPermission);
    on<_RequestLocationPermission>(_requestLocationPermission);
    on<_RequestBatteryOptimization>(_requestBatteryOptimization);
    on<_CheckBatteryOptimizationPermission>(_checkBatteryOptimizationPermission);

    _locationServiceStatusStreamSubscription ??= GeolocatorPlatform.instance.getServiceStatusStream().listen((_) {
      add(const PermissionEvent.checkLocationPermission());
    });
  }

  _checkLocationPermission(event, emit) async {
    final permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
      case LocationPermission.unableToDetermine:
        emit(state.copyWith(locationState: LocationState.noPermission));
        break;
      case LocationPermission.deniedForever:
        emit(state.copyWith(locationState: LocationState.permissionDeniedForever));
        break;
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        final serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
        if (serviceEnabled) {
          emit(state.copyWith(locationState: LocationState.permissionGrantedServiceOn));
        } else {
          emit(state.copyWith(locationState: LocationState.permissionGrantedServiceOff));
        }
    }
  }

  _requestLocationPermission(event, emit) async {
    final permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
      case LocationPermission.unableToDetermine:
        await _geolocatorPlatform.requestPermission();
        break;
      case LocationPermission.deniedForever:
        await _geolocatorPlatform.openLocationSettings();
        break;
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        await Location.instance.requestService();
    }
    await _checkLocationPermission(event, emit);
  }

  _checkBatteryOptimizationPermission(event, emit) async {
    final status = await pm.Permission.ignoreBatteryOptimizations.status;
    emit(state.copyWith(batteryOptimizationGranted: status == pm.PermissionStatus.granted));
  }

  _requestBatteryOptimization(event, emit) async {
    await pm.Permission.ignoreBatteryOptimizations.request();
    add(const PermissionEvent.checkBatteryOptimizationPermission());
  }

  @override
  Future<void> close() {
    _locationServiceStatusStreamSubscription?.cancel();
    return super.close();
  }
}
