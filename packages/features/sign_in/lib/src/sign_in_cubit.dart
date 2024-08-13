import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const SignInState());

  final UserRepository _userRepository;

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

  void onPasswordChanged(String value) {
    final password = state.password.shouldValidate
        ? Password.validated(value)
        : Password.unvalidated(value);

    emit(state.copyWith(password: password));
  }

  void onPasswordUnfocused() {
    final password = Password.validated(state.password.value);

    emit(state.copyWith(password: password));
  }

  void onSubmit() async {
    final email = Email.validated(state.email.value);
    final password = Password.validated(state.password.value);

    final isValid = validateFormFields([email, password]);

    emit(state.copyWith(
      email: email,
      password: password,
      status: isValid ? SubmissionStatus.inprogress : null,
    ));

    if (isValid) {
      try {
        await _userRepository.signIn(
          email: email.value,
          password: password.value,
        );
        emit(state.copyWith(status: SubmissionStatus.success));
      } on InvalidCredentialsException catch (_) {
        emit(state.copyWith(status: SubmissionStatus.invalidCredentails));
      }
    }
  }
}
