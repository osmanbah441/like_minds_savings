import 'package:form_fields/src/form_input/form_input.dart';

class Password extends FormInput<String, PasswordValidationError> {
  const Password.unvalidated([super.value = '']) : super.unvalidated();

  const Password.validated(super.value) : super.validated();

  @override
  PasswordValidationError? validator(String value) {
    return value.length >= 8 ? null : PasswordValidationError.tooShort;
  }
}

enum PasswordValidationError {
  tooShort;

  String get message => switch (this) {
        PasswordValidationError.tooShort =>
          'Password must be at least 8 characters',
      };
}
