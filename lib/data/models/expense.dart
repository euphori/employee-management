import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/data/models/mixin/query_builder.dart';

class Expense with QueryBuilder<Expense> {
  final String? id;
  final String? userId;
  final String? name;
  final String? amount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Expense({
    this.id,
    this.userId,
    this.name,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
    }

    return Expense(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      amount: json['amount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  String get collectionName => "expenses";

  @override
  Expense fromJson(Map<String, dynamic> json) => Expense.fromJson(json);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "amount": amount,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
