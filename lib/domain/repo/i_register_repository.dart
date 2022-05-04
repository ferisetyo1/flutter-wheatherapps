import 'package:boilerplate/domain/core/failures.dart';
import 'package:boilerplate/domain/model/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class IRegisterRepository{
  Future<Either<ValueFailure<String>,Unit>> onRegister({required User user});
}