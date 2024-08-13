import 'package:form_fields/src/form_input/form_input.dart';

class DateOfBirth extends FormInput<String, DateOfBirthValidationError> {
  const DateOfBirth.unvalidated([super.value = '']) : super.unvalidated();

  const DateOfBirth.validated(super.value) : super.validated();

  @override
  DateOfBirthValidationError? validator(String value) {
    return _isValidDate(value) ? null : DateOfBirthValidationError.invalid;
  }

  bool _isValidDate(String value) {
    // Implement your date validation logic here
    // Example: return value is in format 'YYYY-MM-DD'
    return RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value);
  }
}

enum DateOfBirthValidationError {
  invalid;

  String get message => switch (this) {
        DateOfBirthValidationError.invalid => 'Invalid date of birth',
      };
}
