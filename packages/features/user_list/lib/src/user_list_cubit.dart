import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserListStateLoading()) {
    _fetchUsers();
  }

  final UserRepository _userRepository;

  void _fetchUsers() async {
    final users = await _userRepository.getAllUsers();
    emit(UserListStateSuccess(users: users));
  }
}
