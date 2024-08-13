part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final Email email;
  final Password password;
  final SubmissionStatus status;

  const SignInState({
    this.email = const Email.unvalidated(),
    this.password = const Password.unvalidated(),
    this.status = SubmissionStatus.idle,
  });

  SignInState copyWith({
    Email? email,
    Password? password,
    SubmissionStatus? status,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}

enum SubmissionStatus {
  idle,
  inprogress,
  invalidCredentails,
  success;

  bool get isSuccess => this == SubmissionStatus.success;
  bool get isInvalidCredentails => this == SubmissionStatus.invalidCredentails;
  bool get isInprogress => this == SubmissionStatus.inprogress;
}
