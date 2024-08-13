/// Abstract class representing a form input.
///
/// Handles input validation and error management.
///
/// Type parameters:
///   T: Type of the input value.
///   E: Type of the error message.
abstract class FormInput<T, E> {
  const FormInput._(this.value, this.shouldValidate);

  /// Creates a new FormInput instance without validation.
  const FormInput.unvalidated(T value) : this._(value, false);

  /// Creates a new FormInput instance with validation enabled.
  const FormInput.validated(T value) : this._(value, true);

  final T value;
  final bool shouldValidate;

  /// Returns the validation error if `shouldValidate` is true and the input is invalid, otherwise returns null.
  E? get error => shouldValidate ? validator(value) : null;

  /// Indicates whether the input is valid.
  bool get isValid => error == null;

  /// Abstract method to be implemented by subclasses.
  /// Returns an error message if the input is invalid, otherwise returns null.
  E? validator(T value);
}

/// Validates a list of FormInput instances.
///
/// Returns true if all inputs are valid, otherwise returns false.
bool validateFormFields(List<FormInput> inputs) =>
    inputs.every((i) => i.isValid);
