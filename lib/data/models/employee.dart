import 'package:hotel/data/models/mixin/query_builder.dart';

class Employee with QueryBuilder<Employee> {
  final String? id;
  final String? userId;
  final String? name;
  final String? position;
  final String? contact_info;
  final String? department;

  Employee({
    this.id,
    this.userId,
    this.name,
    this.position,
    this.contact_info,
    this.department,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "name": name,
      "position": position,
      "contact_info": contact_info,
      "department": department,
    };
  }

  @override
  String get collectionName => "employees";

  @override
  Employee fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      position: json['position'],
      contact_info: json['contact_info'],
      department: json['department'],
    );
  }
}
