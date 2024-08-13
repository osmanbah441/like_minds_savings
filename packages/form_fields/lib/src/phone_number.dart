import 'package:form_fields/src/form_input/form_input.dart';

class PhoneNumber extends FormInput<String, PhoneNumberValidationError> {
  const PhoneNumber.unvalidated([super.value = '']) : super.unvalidated();

  const PhoneNumber.validated(super.value) : super.validated();

  static final RegExp _phoneRegExp = RegExp(
    r'^\+?[1-9]\d{1,14}$', // E.164 format
  );

  @override
  PhoneNumberValidationError? validator(String value) {
    return _phoneRegExp.hasMatch(value)
        ? null
        : PhoneNumberValidationError.invalid;
  }
}

enum PhoneNumberValidationError {
  invalid;

  String get message => switch (this) {
        PhoneNumberValidationError.invalid =>
          'Please enter a valid phone number',
      };
}
