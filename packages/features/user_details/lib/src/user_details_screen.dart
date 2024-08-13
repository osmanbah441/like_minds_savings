import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mock_data.dart';
import 'user_details_cubit.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({
    super.key,
    // required this.userRepository,
    required this.userId,
  });

  // final UserRepository userRepository;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailsCubit(
        userRepository: UserRepository(),
        userId: userId,
      ),
      child: const UserDetailsView(),
    );
  }
}

@visibleForTesting
class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: BlocBuilder<UserDetailsCubit, UserDetailsState>(
        builder: (context, state) {
          return switch (state) {
            UserDetailsStateLoading() =>
              const Center(child: CircularProgressIndicator()),
            UserDetailsStateSuccess() => _buildUserDetails(context, state),
            UserDetailsStateFailed() =>
              const Center(child: Text('Failed to load user details')),
          };
        },
      ),
    );
  }

  Widget _buildUserDetails(
      BuildContext context, UserDetailsStateSuccess state) {
    final user = state.user;
    const userRole = UserRole.supervisor; // TODO:

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${user.name}',
              style: Theme.of(context).textTheme.titleSmall),
          Text('Email: ${user.email}'),
          if (userRole == UserRole.staff) ...[
            const SizedBox(height: 16),
            const Text('Transactions:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            // Display transactions related to the staff
            Expanded(
              child: ListView.builder(
                itemCount: user.transactions.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Transaction ${index + 1}'),
                  subtitle: Text(user.transactions[index].details),
                ),
              ),
            ),
          ] else if (userRole == UserRole.supervisor) ...[
            const SizedBox(height: 16),
            const Text('Customer Transactions:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            // Display customer transactions
            Expanded(
              child: ListView.builder(
                itemCount: user.customerTransactions.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Customer Transaction ${index + 1}'),
                  subtitle: Text(user.customerTransactions[index].details),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Staff Performance:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            // Display staff performance information
            Expanded(
              child: ListView.builder(
                itemCount: user.staffPerformance.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Staff ${index + 1}'),
                  subtitle: Text(user.staffPerformance[index].toString()),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
