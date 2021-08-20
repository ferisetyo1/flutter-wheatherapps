// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart' as _i3;
import 'package:dio/dio.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i9;

import 'domain/core/i_storage.dart' as _i7;
import 'domain/i_login_repository.dart' as _i5;
import 'infrastructure/core/auth_interceptor.dart' as _i11;
import 'infrastructure/core/register_module.dart' as _i13;
import 'infrastructure/core/storage.dart' as _i8;
import 'infrastructure/login/login_repository.dart' as _i6;
import 'simple_bloc_delegate.dart' as _i10;

const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.Connectivity>(() => registerModule.connectivity);
  gh.lazySingleton<_i4.HiveInterface>(() => registerModule.hive);
  gh.lazySingleton<_i5.ILoginRepository>(() => _i6.LoginRepository());
  gh.lazySingleton<_i7.IStorage>(() => _i8.Storage(get<_i4.HiveInterface>()),
      dispose: (i) => i.close());
  gh.lazySingleton<_i9.Logger>(() => registerModule.logger);
  gh.factory<_i10.SimpleBlocObserver>(
      () => _i10.SimpleBlocObserver(get<_i9.Logger>()));
  gh.factory<String>(() => registerModule.baseUrl,
      instanceName: 'baseUrl', registerFor: {_prod});
  gh.factory<_i11.AuthInterceptor>(
      () => _i11.AuthInterceptor(get<_i7.IStorage>(), get<String>()));
  await gh.lazySingletonAsync<_i12.Dio>(
      () => registerModule.dio(
          get<String>(instanceName: 'baseUrl'), get<_i7.IStorage>()),
      preResolve: true);
  return get;
}

class _$RegisterModule extends _i13.RegisterModule {}
