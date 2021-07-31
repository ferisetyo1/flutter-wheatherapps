// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart' as _i3;
import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/core/i_storage.dart' as _i4;
import 'infrastructure/core/register_module.dart' as _i8;
import 'infrastructure/core/storage.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.Connectivity>(() => registerModule.connectivity);
  gh.lazySingleton<_i4.IStorage>(() => _i5.Storage(get<_i6.HiveInterface>()));
  gh.factory<String>(() => registerModule.baseUrl, instanceName: 'baseUrl');
  gh.lazySingleton<_i7.Dio>(
      () => registerModule.dio(get<String>(instanceName: 'baseUrl')));
  return get;
}

class _$RegisterModule extends _i8.RegisterModule {}
