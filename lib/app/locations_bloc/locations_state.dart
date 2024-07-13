part of 'locations_bloc.dart';

@freezed
class LocationsState with _$LocationsState {
  const factory LocationsState({
    @Default(false) bool periodicCollectionRunning,
    @Default(<DBPosition>[]) List<DBPosition> positions,
  }) = _LocationsState;
}
