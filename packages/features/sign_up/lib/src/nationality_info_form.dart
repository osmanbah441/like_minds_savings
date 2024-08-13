import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up/src/sign_up_cubit.dart';

class NationalityInfoForm extends StatefulWidget {
  const NationalityInfoForm({
    super.key,
  });

  @override
  State<NationalityInfoForm> createState() => _NationalityInfoFormState();
}

class _NationalityInfoFormState extends State<NationalityInfoForm> {
  final _nationalityFocusNode = FocusNode();
  final _passportNumberFocusNode = FocusNode();

  RegistrationCubit get _cubit => context.read<RegistrationCubit>();

  @override
  void initState() {
    super.initState();
    _setupNationalityListener();
    _setupPassportNumberListener();
  }

  void _setupNationalityListener() => _nationalityFocusNode.addListener(() {
        if (!_nationalityFocusNode.hasFocus) _cubit.onNationalityUnfocused();
      });

  void _setupPassportNumberListener() =>
      _passportNumberFocusNode.addListener(() {
        if (!_passportNumberFocusNode.hasFocus) {
          _cubit.onPassportNumberUnfocused();
        }
      });

  @override
  void dispose() {
    _passportNumberFocusNode.dispose();
    _nationalityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              'indentification info',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              onChanged: _cubit.onNationalityChanged,
              focusNode: _nationalityFocusNode,
              decoration: InputDecoration(
                labelText: 'Nationality',
                errorText: state.nationality.error?.message,
              ),
            ),
            TextField(
              onChanged: _cubit.onPassportNumberChanged,
              focusNode: _passportNumberFocusNode,
              decoration: InputDecoration(
                labelText: 'Passport Number',
                errorText: state.passportNumber.error?.message,
              ),
            ),
          ],
        );
      },
    );
  }
}
