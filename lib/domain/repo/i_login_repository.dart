import 'package:boilerplate/infrastructure/login/error_login.dart';
import 'package:fpdart/fpdart.dart';

abstract class ILoginRepository {
  Future<Either<ErrorLogin,Unit>> onLogin({required String email, required String password});
}
