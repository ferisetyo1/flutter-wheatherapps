import 'dart:convert';

import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/repo/i_login_repository.dart';
import 'package:boilerplate/infrastructure/login/error_login.dart';
import 'package:code_id_storage/code_id_storage.dart';
import 'package:fpdart/fpdart.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: ILoginRepository)
class LoginRepository implements ILoginRepository {
  const LoginRepository();

  @override
  Future<Either<ErrorLogin, Unit>> onLogin(
      {required String email, required String password}) async {
    try {
      IStorage userStorage = Storage;
      IStorage authStorage = Storage;
      await authStorage.openBox('User');
      await userStorage.openBox('Auth');
      String? jsonData = await userStorage.getData(key: email) as String?;
      if (jsonData != null) {
        Map<String, dynamic> obj = jsonDecode(jsonData);
        User user = User.fromJson(obj);
        if (password == user.password) {
          authStorage.putDatum(key: "userSigned",value: email);
          right(unit);
        }
        return left(ErrorLogin.WRONG_PASSWORD);
      }
      return left(ErrorLogin.NOT_REGISTERED_EMAIL);
    } catch (e) {
      print(e);
      return left(ErrorLogin.UNKNOWN_ERROR);
    }
  }
}
