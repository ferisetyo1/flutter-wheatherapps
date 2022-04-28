import 'package:boilerplate/domain/repo/i_auth_repository.dart';
import 'package:code_id_storage/code_id_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  AuthRepository();
  @override
  Future<Either<Unit, Unit>> checkAuth() async {
    try {
      await Storage.openBox('Auth');
      String? token = await Storage.getData(key: 'userSigned') as String?;
      if (token != null) {
        return right(unit);
      }
      return left(unit);
    }  catch (e) {
      print(e);
      return left(unit);
    }
  }

  @override
  // ignore: override_on_non_overriding_member
  Future<void> close() async {
    await Storage.close();
  }
}