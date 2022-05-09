import 'package:boilerplate/domain/core/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class ILoginRepository {
  Future<Either<ValueFailure<String>,Unit>> onLogin({required String email, required String password});
}
