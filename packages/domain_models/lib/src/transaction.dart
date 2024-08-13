enum TransactionType { deposit, withdraw }

class Transaction {
  final String id;
  final DateTime date;
  final double amount;
  final TransactionType type;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
  });
}
