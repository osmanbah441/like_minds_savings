import 'package:go_router/go_router.dart';
import 'package:like_minds_savings/routes/path_contant.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_up/sign_up.dart';
import 'package:user_details/user_details.dart';
import 'package:user_list/user_list.dart';
import 'package:user_repository/user_repository.dart';

final class AppRouter {
  AppRouter() : _userRepository = UserRepository();
  GoRouter get router => GoRouter(
        initialLocation: PathConstant.userDetailsPath(id: 'supervisor1'),
        routes: [
          _signUpRoute,
          _signInRoute,
          _userListRoute,
          _userDetailsRoute,
        ],
      );

  final UserRepository _userRepository;

  GoRoute get _signUpRoute => GoRoute(
        path: PathConstant.signUpPath,
        builder: (context, state) => SignUpScreen(
          userRepository: _userRepository,
          onSignUpSuccess: () => context.go(PathConstant.userListPath),
          onCancelledTap: () => context.go(PathConstant.userListPath),
        ),
      );

  GoRoute get _signInRoute => GoRoute(
        path: PathConstant.signInPath,
        builder: (context, state) => SignInScreen(
          userRepository: _userRepository,
          onSignInSuccess: () => context.go(PathConstant.userListPath),
        ),
      );

  GoRoute get _userListRoute => GoRoute(
        path: PathConstant.userListPath,
        builder: (context, state) => UserListScreen(
          userRepository: _userRepository,
          onAddNewUserTapped: () => context.go(PathConstant.signUpPath),
          onUserCardTap: (id) =>
              context.go(PathConstant.userDetailsPath(id: id.toString())),
        ),
      );

  GoRoute get _userDetailsRoute => GoRoute(
        path: PathConstant.userDetailsPath(),
        builder: (context, state) => UserDetailsScreen(
            // userRepository: _userRepository,
            userId: state.pathParameters[PathConstant.userIdParam]!
            // onBackButtonTap: () => context.go(PathConstant.userListPath),
            ),
      );
}
