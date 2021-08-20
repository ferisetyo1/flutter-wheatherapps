import 'package:boilerplate/domain/i_login_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILoginRepository)
class LoginRepository implements ILoginRepository {
  @override
  Future<void> login() {
    // TODO: implement login
    throw UnimplementedError();
  }
}
