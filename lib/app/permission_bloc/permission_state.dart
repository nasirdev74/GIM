part of 'permission_bloc.dart';

@freezed
class PermissionState with _$PermissionState {
  const factory PermissionState({
    @Default(LocationState.noPermission) LocationState locationState,
  }) = _PermissionState;
}
