import 'package:boilerplate/domain/model/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class IProfileRepository{
  Future<Either<Unit,User>> getDataUser();
  Future<Either<Unit,Unit>> updateDataUser({required User user});
  Future<Either<Unit,Unit>> logout();
}