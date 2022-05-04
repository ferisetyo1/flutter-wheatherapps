import 'package:code_id_flutter/code_id_flutter.dart';
import 'package:boilerplate/domain/core/failures.dart';
import 'package:email_validator/email_validator.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

class FormNonEmpty extends ValueObject<ValueFailure<String>, String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const FormNonEmpty._(this.value);

  // ignore: empty_constructor_bodies
  factory FormNonEmpty(String input) {
    if (input.isEmpty)
      return FormNonEmpty._(left(ValueFailure.empty(failedValue: input)));
    return FormNonEmpty._(right(input));
  }

  factory FormNonEmpty.fromError(ValueFailure<String> error) {
    return FormNonEmpty._(left(error));
  }
}