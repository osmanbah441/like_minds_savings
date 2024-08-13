import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up/src/sign_up_cubit.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final _fullNameFocusNode = FocusNode();
  final _dateOfBirthFocusNode = FocusNode();

  RegistrationCubit get _cubit => context.read<RegistrationCubit>();

  @override
  void initState() {
    super.initState();
    _setupFullNameListener();
    _setupDateOfBirthListener();
  }

  void _setupFullNameListener() => _fullNameFocusNode.addListener(() {
        if (!_fullNameFocusNode.hasFocus) _cubit.onFullNameUnfocused();
      });

  void _setupDateOfBirthListener() => _dateOfBirthFocusNode.addListener(() {
        if (!_dateOfBirthFocusNode.hasFocus) _cubit.onDateOfBirthUnfocused();
      });

  @override
  void dispose() {
    _dateOfBirthFocusNode.dispose();
    _fullNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              'personal info',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              onChanged: _cubit.onFullNameChanged,
              focusNode: _fullNameFocusNode,
              decoration: InputDecoration(
                labelText: 'Full Name',
                errorText: state.fullName.error?.message,
              ),
            ),
            TextField(
              onChanged: _cubit.onDateOfBirthChanged,
              focusNode: _dateOfBirthFocusNode,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                errorText: state.dateOfBirth.error?.message,
              ),
            ),
          ],
        );
      },
    );
  }
}
