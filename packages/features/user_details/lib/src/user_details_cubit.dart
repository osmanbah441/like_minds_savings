import 'package:flutter_bloc/flutter_bloc.dart';

import 'mock_data.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit({
    required UserRepository userRepository,
    required String userId,
  })  : _userRepository = userRepository,
        _userId = userId,
        super(const UserDetailsStateLoading()) {
    _fetchUserDetails();
  }

  final UserRepository _userRepository;
  final String _userId;

  void _fetchUserDetails() async {
    try {
      final user = await _userRepository.getUserDetails(_userId);
      emit(UserDetailsStateSuccess(user: user));
    } catch (_) {
      emit(const UserDetailsStateFailed());
    }
  }
}
