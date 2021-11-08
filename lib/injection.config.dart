// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:code_id_flutter/code_id_flutter.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i3;

import 'domain/i_login_repository.dart' as _i6;
import 'infrastructure/core/register_module.dart' as _i8;
import 'infrastructure/login/login_repository.dart' as _i7;
import 'simple_bloc_delegate.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.Logger>(() => registerModule.logger);
  gh.factory<_i4.SimpleBlocObserver>(
      () => _i4.SimpleBlocObserver(get<_i3.Logger>()));
  gh.factory<String>(() => registerModule.baseUrl, instanceName: 'baseUrl');
  await gh.lazySingletonAsync<_i5.INetworkService>(
      () => registerModule.network(get<String>(instanceName: 'baseUrl')),
      preResolve: true);
  gh.lazySingleton<_i6.ILoginRepository>(
      () => _i7.LoginRepository(get<_i5.INetworkService>()));
  return get;
}

class _$RegisterModule extends _i8.RegisterModule {}
