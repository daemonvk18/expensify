import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;
  final String logoPath; // Firebase Storage path

  Category({required this.name, required this.logoPath});

  factory Category.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Category(
      name: data['name'],
      logoPath: data['logo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logo': logoPath,
    };
  }
}
