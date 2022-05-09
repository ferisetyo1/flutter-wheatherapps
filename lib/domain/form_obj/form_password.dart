import 'package:code_id_flutter/code_id_flutter.dart';
import 'package:boilerplate/domain/core/failures.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

class FormPassword extends ValueObject<ValueFailure<String>, String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const FormPassword._(this.value);

  // ignore: empty_constructor_bodies
  factory FormPassword(String input){
    if(input.isEmpty) return FormPassword._(left(ValueFailure.empty(failedValue: input)));
    if(input.length<6) return FormPassword._(left(ValueFailure.lengthTooShort(failedValue: input, min: 6)));
    return FormPassword._(right(input));
  }

  factory FormPassword.fromError(ValueFailure<String> error){
    return FormPassword._(left(error));
  }
}