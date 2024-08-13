import 'package:form_fields/src/form_input/form_input.dart';
import 'package:form_fields/src/password.dart';

class ConfirmPassword
    extends FormInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.unvalidated([super.value = ''])
      : password = const Password.unvalidated(),
        super.unvalidated();

  const ConfirmPassword.validated(super.value, {required this.password})
      : super.validated();

  final Password password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    return password.value == value
        ? null
        : ConfirmPasswordValidationError.mismatch;
  }
}

enum ConfirmPasswordValidationError {
  mismatch;

  String get message => switch (this) {
        ConfirmPasswordValidationError.mismatch => 'Passwords do not match',
      };
}
