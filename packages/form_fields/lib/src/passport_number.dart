import 'package:form_fields/src/form_input/form_input.dart';

class PassportNumber extends FormInput<String, PassportNumberValidationError> {
  const PassportNumber.unvalidated([super.value = '']) : super.unvalidated();

  const PassportNumber.validated(super.value) : super.validated();

  @override
  PassportNumberValidationError? validator(String value) {
    return _isValidPassportNumber(value)
        ? null
        : PassportNumberValidationError.invalid;
  }

  bool _isValidPassportNumber(String value) {
    // Implement your passport number validation logic here
    // Example: return true if value has at least 6 characters
    return value.length >= 6;
  }
}

enum PassportNumberValidationError {
  invalid;

  String get message => switch (this) {
        PassportNumberValidationError.invalid => 'Invalid passport number',
      };
}
