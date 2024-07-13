// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/app/locations_bloc/locations_bloc.dart' as _i6;
import 'package:app/app/permission_bloc/permission_bloc.dart' as _i5;
import 'package:app/core/app.settings.dart' as _i3;
import 'package:app/core/register_module.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.AppSettings>(() => _i3.AppSettings());
    await gh.factoryAsync<_i4.SharedPreferences>(
      () => registerModule.getPrefs(),
      preResolve: true,
    );
    gh.singleton<_i5.PermissionBloc>(() => _i5.PermissionBloc());
    gh.lazySingleton<_i6.LocationsBloc>(() => _i6.LocationsBloc());
    return this;
  }
}

class _$RegisterModule extends _i7.RegisterModule {}
