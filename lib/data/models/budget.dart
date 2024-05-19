import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/data/models/mixin/query_builder.dart';

class Budget with QueryBuilder<Budget> {
  final String? id;
  final String? userId;
  final num? amount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Budget({
    this.id,
    this.userId,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
    }

    return Budget(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  Budget copyWith({
    String? id,
    String? userId,
    num? amount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Budget(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String get collectionName => "budgets";

  @override
  Budget fromJson(Map<String, dynamic> json) => Budget.fromJson(json);
}
