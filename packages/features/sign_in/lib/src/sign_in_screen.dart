import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in/src/sign_in_cubit.dart';
import 'package:user_repository/user_repository.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
    required this.userRepository,
    required this.onSignInSuccess,
  });

  final UserRepository userRepository;
  final VoidCallback onSignInSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(userRepository: userRepository),
      child: SignInView(
        onSignInSuccess: onSignInSuccess,
      ),
    );
  }
}

@visibleForTesting
class SignInView extends StatefulWidget {
  const SignInView({super.key, required this.onSignInSuccess});

  final VoidCallback onSignInSuccess;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  SignInCubit get _cubit => context.read<SignInCubit>();

  @override
  void initState() {
    super.initState();
    _setupEmailListener();
    _setupPasswordListener();
  }

  void _setupEmailListener() {
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _cubit.onEmailUnfocused();
      }
    });
  }

  void _setupPasswordListener() {
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _cubit.onPasswordUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInCubit, SignInState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isSuccess) {
            return widget.onSignInSuccess();
          }

          if (state.status.isInvalidCredentails) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('invalid email or password')));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  focusNode: _emailFocusNode,
                  onChanged: _cubit.onEmailChanged,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    enabled: !state.status.isInprogress,
                    errorText: state.email.error?.message,
                  ),
                ),
                TextField(
                  focusNode: _passwordFocusNode,
                  onChanged: _cubit.onPasswordChanged,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabled: !state.status.isInprogress,
                    errorText: state.password.error?.message,
                  ),
                ),
                const SizedBox(height: 16),
                state.status.isInprogress
                    ? ExpandedElevatedButton.inProgress('sign in')
                    : ExpandedElevatedButton(
                        label: 'sign in',
                        onTap: _cubit.onSubmit,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
