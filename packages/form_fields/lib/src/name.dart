import 'package:form_fields/src/form_input/form_input.dart';

class Name extends FormInput<String, NameValidationError> {
  const Name.unvalidated([super.value = '']) : super.unvalidated();

  const Name.validated(super.value) : super.validated();

  @override
  NameValidationError? validator(String value) {
    return value.isNotEmpty ? null : NameValidationError.empty;
  }
}

enum NameValidationError {
  empty;

  String get message => switch (this) {
        NameValidationError.empty => 'Please enter your full name',
      };
}
