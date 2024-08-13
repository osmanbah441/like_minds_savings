import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this._userRepository) : super(const RegistrationState());

  final UserRepository _userRepository;

  void onFullNameChanged(String value) {
    final fullName = state.fullName.shouldValidate
        ? Name.validated(value)
        : Name.unvalidated(value);
    emit(state.copyWith(fullName: fullName));
  }

  void onFullNameUnfocused() {
    final fullName = Name.validated(state.fullName.value);
    emit(state.copyWith(fullName: fullName));
  }

  void onDateOfBirthChanged(String value) {
    final dateOfBirth = state.dateOfBirth.shouldValidate
        ? DateOfBirth.validated(value)
        : DateOfBirth.unvalidated(value);
    emit(state.copyWith(dateOfBirth: dateOfBirth));
  }

  void onDateOfBirthUnfocused() {
    final dateOfBirth = DateOfBirth.validated(state.dateOfBirth.value);
    emit(state.copyWith(dateOfBirth: dateOfBirth));
  }

  void onEmailChanged(String value) {
    final email = state.email.shouldValidate
        ? Email.validated(value)
        : Email.unvalidated(value);
    emit(state.copyWith(email: email));
  }

  void onEmailUnfocused() {
    final email = Email.validated(state.email.value);
    emit(state.copyWith(email: email));
  }

  void onPhoneNumberChanged(String value) {
    final phoneNumber = state.phoneNumber.shouldValidate
        ? PhoneNumber.validated(value)
        : PhoneNumber.unvalidated(value);
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void onPhoneNumberUnfocused() {
    final phoneNumber = PhoneNumber.validated(state.phoneNumber.value);
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void onNationalityChanged(String value) {
    final nationality = state.nationality.shouldValidate
        ? Nationality.validated(value)
        : Nationality.unvalidated(value);
    emit(state.copyWith(nationality: nationality));
  }

  void onNationalityUnfocused() {
    final nationality = Nationality.validated(state.nationality.value);
    emit(state.copyWith(nationality: nationality));
  }

  void onPassportNumberChanged(String value) {
    final passportNumber = state.passportNumber.shouldValidate
        ? PassportNumber.validated(value)
        : PassportNumber.unvalidated(value);
    emit(state.copyWith(passportNumber: passportNumber));
  }

  void onPassportNumberUnfocused() {
    final passportNumber = PassportNumber.validated(state.passportNumber.value);
    emit(state.copyWith(passportNumber: passportNumber));
  }

  void onStepContinue() {
    if (state.isFirstStep) return _validatePersonalInfo();
    if (state.isSecondStep) return _validateContactInfo();
    _validateIndentification();
  }

  void onStepCancel() {
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void _validatePersonalInfo() {
    final fullName = Name.validated(state.fullName.value);
    final dateOfBirth = DateOfBirth.validated(state.dateOfBirth.value);
    final isValid = validateFormFields([fullName, dateOfBirth]);
    emit(state.copyWith(
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      currentStep: isValid ? state.currentStep + 1 : null,
    ));
  }

  void _validateContactInfo() {
    final email = Email.validated(state.email.value);
    final phoneNumber = PhoneNumber.validated(state.phoneNumber.value);
    final isValid = validateFormFields([email, phoneNumber]);
    emit(state.copyWith(
      email: email,
      phoneNumber: phoneNumber,
      currentStep: isValid ? state.currentStep + 1 : null,
    ));
  }

  void _validateIndentification() {
    final nationality = Nationality.validated(state.nationality.value);
    final passportNumber = PassportNumber.validated(state.passportNumber.value);
    final isValid = validateFormFields([nationality, passportNumber]);
    emit(state.copyWith(
      nationality: nationality,
      passportNumber: passportNumber,
      status: isValid ? SubmissionStatus.inprogress : SubmissionStatus.failure,
    ));

    if (isValid) _submit();
  }

  void _submit() async {
    await _userRepository.register(
      fullName: state.fullName.value,
      dateOfBirth: state.dateOfBirth.value,
      email: state.email.value,
      phoneNumber: state.phoneNumber.value,
      nationality: state.nationality.value,
      passportNumber: state.passportNumber.value,
    );

    emit(state.copyWith(status: SubmissionStatus.success));
  }
}
