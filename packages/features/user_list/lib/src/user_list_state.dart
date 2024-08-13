part of 'user_list_cubit.dart';

sealed class UserListState {
  const UserListState();
}

class UserListStateLoading extends UserListState {
  const UserListStateLoading();
}

class UserListStateSuccess extends UserListState {
  const UserListStateSuccess({
    required this.users,
  });

  final List<User> users;
}

class UserListStateFailed extends UserListState {
  const UserListStateFailed();
}
