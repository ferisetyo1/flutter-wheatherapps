import 'package:boilerplate/domain/model/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class IRegisterRepository{
  Future<Either<String,Unit>> onRegister({required User user});
}