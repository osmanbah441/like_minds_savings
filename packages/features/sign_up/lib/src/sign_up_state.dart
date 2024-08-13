part of 'sign_up_cubit.dart';

class RegistrationState extends Equatable {
  final Name fullName;
  final DateOfBirth dateOfBirth;
  final Email email;
  final PhoneNumber phoneNumber;
  final Nationality nationality;
  final PassportNumber passportNumber;
  final int currentStep; // the current step for the [Stepper]
  final SubmissionStatus status;

  const RegistrationState({
    this.fullName = const Name.unvalidated(),
    this.dateOfBirth = const DateOfBirth.unvalidated(),
    this.email = const Email.unvalidated(),
    this.phoneNumber = const PhoneNumber.unvalidated(),
    this.nationality = const Nationality.unvalidated(),
    this.passportNumber = const PassportNumber.unvalidated(),
    this.currentStep = 0,
    this.status = SubmissionStatus.idle,
  });

  get isFirstStep => currentStep == 0;
  get isSecondStep => currentStep == 1;
  get isThirdStep => currentStep == 2;

  RegistrationState copyWith({
    Name? fullName,
    DateOfBirth? dateOfBirth,
    Email? email,
    PhoneNumber? phoneNumber,
    Nationality? nationality,
    PassportNumber? passportNumber,
    int? currentStep,
    SubmissionStatus? status,
  }) {
    return RegistrationState(
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nationality: nationality ?? this.nationality,
      passportNumber: passportNumber ?? this.passportNumber,
      currentStep: currentStep ?? this.currentStep,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        dateOfBirth,
        email,
        phoneNumber,
        nationality,
        passportNumber,
        currentStep,
        status,
      ];
}

enum SubmissionStatus {
  idle,
  inprogress,
  success,
  failure;

  bool get isSuccess => this == SubmissionStatus.success;
  bool get isInprogress => this == SubmissionStatus.inprogress;
}
