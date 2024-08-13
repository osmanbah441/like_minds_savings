import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_list/src/user_list_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:component_library/component_library.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({
    super.key,
    required this.userRepository,
    required this.onAddNewUserTapped,
    required this.onUserCardTap,
  });
  final UserRepository userRepository;
  final VoidCallback onAddNewUserTapped;
  final OnUserCardTap onUserCardTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserListCubit(userRepository: userRepository),
      child: UserListView(
        onAddNewTap: onAddNewUserTapped,
        onUserCardTap: onUserCardTap,
      ),
    );
  }
}

@visibleForTesting
class UserListView extends StatelessWidget {
  const UserListView({
    super.key,
    required this.onAddNewTap,
    required this.onUserCardTap,
  });
  final VoidCallback onAddNewTap;
  final OnUserCardTap onUserCardTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: onAddNewTap,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<UserListCubit, UserListState>(
              builder: (context, state) {
                return switch (state) {
                  UserListStateLoading() =>
                    const CenteredCircularProgressIndicator(),
                  UserListStateSuccess() => ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        return UserListCard(
                          user: state.users[index],
                          onUserCardTap: onUserCardTap,
                        );
                      },
                    ),
                  UserListStateFailed() =>
                    const Center(child: Text('something when wrong')),
                };
              },
            ),
          )
        ],
      ),
    );
  }
}
