part of 'user_details_cubit.dart';

sealed class UserDetailsState {
  const UserDetailsState();
}

class UserDetailsStateLoading extends UserDetailsState {
  const UserDetailsStateLoading();
}

class UserDetailsStateSuccess extends UserDetailsState {
  const UserDetailsStateSuccess({
    required this.user,
  });

  final User user;
}

class UserDetailsStateFailed extends UserDetailsState {
  const UserDetailsStateFailed();
}
