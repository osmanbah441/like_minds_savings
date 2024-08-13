import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up/src/contact_info_form.dart';
import 'package:sign_up/src/nationality_info_form.dart';
import 'package:sign_up/src/personal_info_form.dart';
import 'package:user_repository/user_repository.dart';

import 'sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
    required this.userRepository,
    required this.onSignUpSuccess,
    required this.onCancelledTap,
  });

  final UserRepository userRepository;
  final VoidCallback onSignUpSuccess;
  final VoidCallback onCancelledTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(userRepository),
      child: RegistrationForm(
        onSignUpSuccess: onSignUpSuccess,
        onCancelledTap: onCancelledTap,
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({
    super.key,
    required this.onSignUpSuccess,
    required this.onCancelledTap,
  });

  final VoidCallback onSignUpSuccess;
  final VoidCallback onCancelledTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state.status.isSuccess) onSignUpSuccess();
        if (state.currentStep.isNegative) onCancelledTap();
      },
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();

        return Scaffold(
          body: Stepper(
            elevation: 0,
            type: StepperType.horizontal,
            currentStep: state.currentStep.isNegative ? 0 : state.currentStep,
            onStepContinue: cubit.onStepContinue,
            onStepCancel: cubit.onStepCancel,
            steps: [
              Step(
                state: StepState.disabled,
                title: const Text(''),
                content: const PersonalInfoForm(),
                isActive: state.currentStep >= 0,
              ),
              Step(
                title: const Text(''),
                state: StepState.disabled,
                content: const ContactInfoForm(),
                isActive: state.currentStep >= 1,
              ),
              Step(
                title: const Text(''),
                state: StepState.disabled,
                content: const NationalityInfoForm(),
                isActive: state.currentStep >= 2,
              ),
            ],
            controlsBuilder: (context, details) {
              return state.status.isInprogress
                  ? ExpandedElevatedButton.inProgress('loading')
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: details.onStepCancel,
                          child:
                              Text(state.currentStep == 0 ? 'cancel' : 'back'),
                        ),
                        TextButton(
                          onPressed: details.onStepContinue,
                          child: Text(state.isThirdStep ? 'submit' : 'next'),
                        )
                      ],
                    );
            },
          ),
        );
      },
    );
  }
}
