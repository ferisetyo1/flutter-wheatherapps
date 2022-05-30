import 'package:boilerplate/domain/model/user.dart';
import 'package:boilerplate/domain/repo/i_profile_repository.dart';
import 'package:code_id_storage/code_id_storage.dart';
// ignore: implementation_imports
import 'package:fpdart/src/unit.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  @override
  Future<Either<Unit, User>> getDataUser() async {
    try {
      IStorage userStorage = Storage;
      IStorage authStorage = Storage;
      await authStorage.openBox('Auth');
      await userStorage.openBox('User');
      String email = await authStorage.getData(key: "userSigned") as String;
      final userJson = await userStorage.getData(key: email);
      return right(User.fromJson(Map<String, dynamic>.from(userJson)));
    } catch (e) {
      print(e);
      return left(unit);
    }
  }

  @override
  Future<Either<Unit, Unit>> logout() async {
    try {
      IStorage authStorage = Storage;
      await authStorage.openBox('Auth');
      authStorage.delete(key: "userSigned");
      return right(unit);
    } catch (e) {
      print(e);
      return left(unit);
    }
  }

  @override
  Future<Either<Unit, Unit>> updateDataUser({required User user}) async {
    try {
      IStorage userStorage = Storage;
      await userStorage.openBox('User');
      userStorage.putDatum(key: user.email,value: user.toJson());
      return right(unit);
    } catch (e) {
      print(e);
      return left(unit);
    }
  }
}
