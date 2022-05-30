import 'dart:convert';

import 'package:boilerplate/domain/core/failures.dart';
import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/repo/i_login_repository.dart';
import 'package:code_id_storage/code_id_storage.dart';
import 'package:fpdart/fpdart.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: ILoginRepository)
class LoginRepository implements ILoginRepository {
  const LoginRepository();

  @override
  Future<Either<ValueFailure<String>, Unit>> onLogin(
      {required String email, required String password}) async {
    try {
      IStorage userStorage = Storage;
      IStorage authStorage = Storage;
      await authStorage.openBox('Auth');
      await userStorage.openBox('User');
      Map<String, dynamic>? jsonData = await userStorage.getData(key: email) as Map<String, dynamic>?;
      if (jsonData != null) {
        User user = User.fromJson(jsonData);
        if (password == user.password) {
          authStorage.putDatum(key: "userSigned",value: email);
          right(unit);
        }
        return left(ValueFailure.objectNotMatch(failedValue: password, matchValue: ""));
      }
      return left(ValueFailure.unregisteredEmail(failedValue: email));
    } catch (e) {
      print(e);
      return left(ValueFailure.unknownError(errMsg: "Terjadi kesalahan internal"));
    }
  }
}
