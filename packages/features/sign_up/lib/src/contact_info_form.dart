import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up/src/sign_up_cubit.dart';

class ContactInfoForm extends StatefulWidget {
  const ContactInfoForm({
    super.key,
  });

  @override
  State<ContactInfoForm> createState() => _ContactInfoFormState();
}

class _ContactInfoFormState extends State<ContactInfoForm> {
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();

  RegistrationCubit get _cubit => context.read<RegistrationCubit>();

  @override
  void initState() {
    super.initState();
    _setupEmailListener();
    _setupPhoneNumberListener();
  }

  void _setupEmailListener() => _emailFocusNode.addListener(() {
        if (!_emailFocusNode.hasFocus) _cubit.onEmailUnfocused();
      });

  void _setupPhoneNumberListener() => _phoneNumberFocusNode.addListener(() {
        if (!_phoneNumberFocusNode.hasFocus) _cubit.onPhoneNumberUnfocused();
      });

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              'contact info',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              onChanged: _cubit.onEmailChanged,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: state.email.error?.message,
              ),
            ),
            TextField(
              onChanged: _cubit.onPhoneNumberChanged,
              focusNode: _phoneNumberFocusNode,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                errorText: state.phoneNumber.error?.message,
              ),
            ),
          ],
        );
      },
    );
  }
}
