part of 'locations_bloc.dart';

@freezed
class LocationsEvent with _$LocationsEvent {
  const factory LocationsEvent.startCollection() = _StartCollection;

  const factory LocationsEvent.stopCollection() = _StopCollection;

  const factory LocationsEvent.collectLocation() = _CollectLocation;

  const factory LocationsEvent.refreshCollection() = _RefreshCollection;

  const factory LocationsEvent.deleteCollection({required int id}) = _DeleteCollection;
}
