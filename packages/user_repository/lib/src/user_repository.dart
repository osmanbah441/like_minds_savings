import 'package:domain_models/domain_models.dart';

final class UserRepository {
  int _idGen = 0;
  static final _users = [
    User(
      id: 'default id',
      name: 'osman',
      email: 'osman@mail.com',
      phoneNumber: '232 5030302',
      role: UserRole.staff,
    ),
  ];

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<List<User>> getAllUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    return _users;
  }

  Future<User> getUserById(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    return _users.firstWhere((u) => u.id == id);
  }

  Future<void> register({
    required String fullName,
    required String dateOfBirth,
    required String email,
    required String phoneNumber,
    required String nationality,
    required String passportNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    _idGen++;
    final user = User(
      id: 'userId $_idGen',
      name: fullName,
      email: email,
      phoneNumber: phoneNumber,
      role: UserRole.customer,
    );

    _users.add(user);
  }
}
