import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/domain/core/failures.dart';
import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/repo/i_register_repository.dart';
import 'package:code_id_storage/code_id_storage.dart';
import 'package:fpdart/fpdart.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: IRegisterRepository)
class RegisterRepository implements IRegisterRepository{
  @override
  Future<Either<ValueFailure<String>, Unit>> onRegister({required User user}) async {
    try {
      IStorage userStorage=Storage;
      IStorage authStorage=Storage;
      await userStorage.openBox('User');
      String? token = await userStorage.getData(key: user.email) as String?;
      if (token != null) {
        return left(ValueFailure.unregisteredEmail(failedValue: user.email));
      }
      userStorage.putDatum(key: user.email, value: jsonEncode(user.toJson()));
      await authStorage.openBox('Auth');
      authStorage.putDatum(key: 'userSigned',value: user.email);
      return right(unit);
    } catch (e) {
      print(e);
      return left(ValueFailure.unknownError(errMsg: e.toString()));
    }
  }

  
}