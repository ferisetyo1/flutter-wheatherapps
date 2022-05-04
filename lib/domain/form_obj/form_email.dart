import 'package:code_id_flutter/code_id_flutter.dart';
import 'package:boilerplate/domain/core/failures.dart';
import 'package:email_validator/email_validator.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

class FormEmail extends ValueObject<ValueFailure<String>, String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const FormEmail._(this.value);

  // ignore: empty_constructor_bodies
  factory FormEmail(String input) {
    if (input.isEmpty)
      return FormEmail._(left(ValueFailure.empty(failedValue: input)));
    if (!EmailValidator.validate(input))
      return FormEmail._(left(ValueFailure.invalidEmail(failedValue: input)));
    return FormEmail._(right(input));
  }

  factory FormEmail.fromError(ValueFailure<String> error) {
    return FormEmail._(left(error));
  }
}
