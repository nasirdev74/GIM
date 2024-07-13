import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/local_database/db_position.dart';
import 'package:app/local_database/local_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locations_event.dart';

part 'locations_state.dart';

part 'locations_bloc.freezed.dart';

@lazySingleton
class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final _localDatabase = LocalDatabase.instance;
  StreamSubscription? periodicStreamSubscription;

  LocationsBloc() : super(const LocationsState()) {
    on<_StartCollection>(_startCollection);
    on<_StopCollection>(_stopCollection);
    on<_CollectLocation>(_collectLocation);
    on<_RefreshCollection>(_refreshCollection);
    on<_DeleteCollection>(_deleteCollection);
  }

  _startCollection(event, emit) async {
    try {
      add(const LocationsEvent.collectLocation());
      emit(state.copyWith(periodicCollectionRunning: true));
      periodicStreamSubscription = Stream.periodic(const Duration(seconds: 10)).listen((_) {
        add(const LocationsEvent.collectLocation());
      });
      periodicStreamSubscription?.resume();
    } catch (err) {
      log("$err");
    }
  }

  _stopCollection(event, emit) async {
    periodicStreamSubscription?.pause();
    periodicStreamSubscription?.cancel();
    periodicStreamSubscription = null;
    emit(state.copyWith(periodicCollectionRunning: false));
  }

  _collectLocation(event, emit) async {
    try {
      final p = await GeolocatorPlatform.instance.getCurrentPosition();
      final dbPosition = DBPosition(
        id: null,
        latitude: p.latitude,
        longitude: p.longitude,
        altitude: p.altitude,
        accuracy: p.accuracy,
        dateTime: DateTime.now(),
      );
      dbPosition.id = await _localDatabase.save(dbPosition);
      final List<DBPosition> temp = List.from(state.positions)..insert(0, dbPosition);
      emit(state.copyWith(positions: temp));
    } catch (err) {
      log("$err");
    }
  }

  _refreshCollection(event, emit) async {
    emit(state.copyWith(positions: await _localDatabase.getAll()));
  }

  _deleteCollection(_DeleteCollection event, emit) async {
    await _localDatabase.deleteById(id: event.id);
    add(const LocationsEvent.refreshCollection());
  }
}
