class UserRepository {
  static final _users = [
    User(
      id: 'staff1',
      name: 'Alice Smith',
      email: 'alice.smith@example.com',
      transactions: [
        Transaction(
          id: 'txn1',
          date: DateTime.now().subtract(const Duration(days: 1)),
          amount: 100.0,
          details: 'Deposit to savings account',
        ),
        Transaction(
          id: 'txn2',
          date: DateTime.now().subtract(const Duration(days: 2)),
          amount: -50.0,
          details: 'Withdrawal from checking account',
        ),
      ],
      customerTransactions: [],
      staffPerformance: [],
    ),

// Mock data for a supervisor user
    User(
      id: 'supervisor1',
      name: 'Bob Johnson',
      email: 'bob.johnson@example.com',
      transactions: [],
      customerTransactions: [
        Transaction(
          id: 'cust_txn1',
          date: DateTime.now().subtract(const Duration(days: 5)),
          amount: 200.0,
          details: 'Customer A deposit',
        ),
        Transaction(
          id: 'cust_txn2',
          date: DateTime.now().subtract(const Duration(days: 3)),
          amount: -75.0,
          details: 'Customer B withdrawal',
        ),
      ],
      staffPerformance: [
        Performance(
          staffId: 'staff1',
          completedTasks: 50,
          customerInteractions: 100,
        ),
        Performance(
          staffId: 'staff2',
          completedTasks: 40,
          customerInteractions: 90,
        ),
      ],
    ),
  ];

  // Mock user data for simplicity; replace with actual implementation
  Future<User> getUserDetails(String userId) async {
    return _users.firstWhere((u) => u.id == userId);
  }

  UserRole get currentUserRole {
    // Determine the role of the current user
    // This is just a placeholder; your implementation might differ
    return UserRole.staff;
  }
}

// Enum for user roles
enum UserRole { staff, supervisor }

// Data model for Transaction
class Transaction {
  final String id;
  final DateTime date;
  final double amount;
  final String details;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.details,
  });
}

// Data model for Performance
class Performance {
  final String staffId;
  final int completedTasks;
  final int customerInteractions;

  Performance({
    required this.staffId,
    required this.completedTasks,
    required this.customerInteractions,
  });
}

// Data model for User
class User {
  final String id;
  final String name;
  final String email;
  final List<Transaction> transactions;
  final List<Transaction> customerTransactions;
  final List<Performance> staffPerformance;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.transactions,
    required this.customerTransactions,
    required this.staffPerformance,
  });
}
