import 'package:form_fields/src/form_input/form_input.dart';

class Email extends FormInput<String, EmailValidationError> {
  const Email.unvalidated([super.value = ''])
      : isAlreadyRegistered = false,
        super.unvalidated();

  const Email.validated(super.value, {this.isAlreadyRegistered = false})
      : super.validated();

  final bool isAlreadyRegistered;

  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  @override
  EmailValidationError? validator(String value) {
    return !_emailRegExp.hasMatch(value)
        ? EmailValidationError.invalid
        : isAlreadyRegistered
            ? EmailValidationError.alreadyRegistered
            : null;
  }
}

enum EmailValidationError {
  alreadyRegistered,
  invalid;

  String get message => switch (this) {
        EmailValidationError.invalid => 'Please enter a valid email',
        EmailValidationError.alreadyRegistered => 'Email is already registered',
      };
}
