import 'dart:async';
import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/services/location_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locations_event.dart';

part 'locations_state.dart';

part 'locations_bloc.freezed.dart';

@lazySingleton
class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final LocationService _locationService;
  StreamSubscription? _onLocationDataStreamSubscription;

  LocationsBloc(this._locationService) : super(const LocationsState()) {
    on<_StartCollection>(_startCollection);
    on<_StopCollection>(_stopCollection);
    on<_AddNewLocationData>(_addNewLocationData);
    on<_RefreshCollection>(_refreshCollection);
    on<_DeleteCollection>(_deleteCollection);
    on<_ClearAll>(_clearAll);
  }

  _startCollection(event, emit) async {
    await _locationService.startService();
    _onLocationDataStreamSubscription = _locationService.onLocationData().listen((data) {
      final location = LocationData.fromJson(json.decode(data));
      add(LocationsEvent.addNewLocationData(location: location));
    });
    _onLocationDataStreamSubscription?.resume();
  }

  _stopCollection(event, emit) async {
    await _locationService.stopService();
    _onLocationDataStreamSubscription?.pause();
    _onLocationDataStreamSubscription?.cancel();
    _onLocationDataStreamSubscription = null;
  }

  _addNewLocationData(_AddNewLocationData event, emit) {
    if (!(state.locations.any((location) => location.id == event.location.id))) {
      final List<LocationData> temp = List.from(state.locations)..insert(0, event.location);
      emit(state.copyWith(locations: temp));
    }
  }

  _refreshCollection(event, emit) async {
    final locations = await _locationService.getAllLocations();
    emit(state.copyWith(locations: locations));
  }

  _deleteCollection(_DeleteCollection event, emit) async {
    await _locationService.deleteById(event.id);
    add(const LocationsEvent.refreshCollection());
  }

  _clearAll(event, emit) async {
    await _locationService.deleteAllData();
    emit(state.copyWith(locations: []));
    add(const LocationsEvent.refreshCollection());
  }
}
