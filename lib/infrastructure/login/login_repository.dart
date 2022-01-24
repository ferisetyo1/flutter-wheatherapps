import 'package:boilerplate/domain/i_login_repository.dart';
import 'package:code_id_network/code_id_network.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: ILoginRepository)
class LoginRepository implements ILoginRepository {
  final INetworkService networkService;
  const LoginRepository(this.networkService);
  @override
  Future<void> login() {
    throw UnimplementedError();
    // try {
    //   networkService.getHttp(path: path)
    // } catch (e) {
    //   throw e;
    // }
  }
}
