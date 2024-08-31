import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String categoryLogo;
  final String categoryName;
  final String title;
  final double amount;
  final String type; // "expense" or "income"
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.categoryLogo,
    required this.categoryName,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  // Method to create TransactionModel from Firestore DocumentSnapshot
  factory TransactionModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return TransactionModel(
      id: doc.id,
      categoryLogo: doc['categoryLogo'] ?? '',
      categoryName: doc['categoryName'] ?? '',
      title: doc['title'] ?? '',
      amount: doc['amount']?.toDouble() ?? 0.0,
      type: doc['type'] ?? '',
      date: (doc['date'] as Timestamp).toDate(),
    );
  }
}
