import 'package:form_fields/src/form_input/form_input.dart';

class Nationality extends FormInput<String, NationalityValidationError> {
  const Nationality.unvalidated([super.value = '']) : super.unvalidated();

  const Nationality.validated(super.value) : super.validated();

  @override
  NationalityValidationError? validator(String value) {
    return value.isNotEmpty ? null : NationalityValidationError.empty;
  }
}

enum NationalityValidationError {
  empty;

  String get message => switch (this) {
        NationalityValidationError.empty => 'Nationality cannot be empty',
      };
}
