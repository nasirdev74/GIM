part of 'locations_bloc.dart';

@freezed
class LocationsState with _$LocationsState {
  const factory LocationsState({
    @Default(<LocationData>[]) List<LocationData> locations,
  }) = _LocationsState;
}
