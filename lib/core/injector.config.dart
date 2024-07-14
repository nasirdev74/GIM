// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/app/locations_bloc/locations_bloc.dart' as _i6;
import 'package:app/app/permission_bloc/permission_bloc.dart' as _i4;
import 'package:app/core/app.settings.dart' as _i3;
import 'package:app/services/location_service.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AppSettings>(() => _i3.AppSettings());
    gh.singleton<_i4.PermissionBloc>(() => _i4.PermissionBloc());
    gh.singleton<_i5.LocationService>(() => _i5.LocationService());
    gh.lazySingleton<_i6.LocationsBloc>(
        () => _i6.LocationsBloc(gh<_i5.LocationService>()));
    return this;
  }
}
