final class User {
  final String name;
  final String email;
  final String phoneNumber;
  final UserRole role;
  final String? photoURL;
  final String id;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.photoURL,
  });
}

enum UserRole {
  supervisor,
  staff,
  customer,
}
