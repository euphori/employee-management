import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel/data/models/mixin/query_builder.dart';

class Planner with QueryBuilder<Planner> {
  final String? id;
  final String? userId;
  final String? name;
  final num? totalAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Planner({
    this.id,
    this.userId,
    this.name,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
  });

  factory Planner.fromJson(Map<String, dynamic> json) {
    if (json['created_at'] != null && json['created_at'] is Timestamp) {
      json['created_at'] = json['created_at'].toDate();
    }

    if (json['updated_at'] != null && json['updated_at'] is Timestamp) {
      json['updated_at'] = json['updated_at'].toDate();
    }

    return Planner(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      totalAmount: json['total_amount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "total_amount": totalAmount,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  @override
  String get collectionName => "planner";

  @override
  Planner fromJson(Map<String, dynamic> json) => Planner.fromJson(json);
}
