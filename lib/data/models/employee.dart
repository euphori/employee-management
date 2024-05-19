import 'package:hotel/data/models/mixin/query_builder.dart';

class Employee with QueryBuilder<Employee> {
  final String? name;
  final String? position;
  final String? contact_info;
  final String? department;
  final String? id;

  Employee({
    this.name,
    this.position,
    this.contact_info,
    this.department,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "position": position,
      "contact_info": contact_info,
      "department": department,
      "id": id,
    };
  }

  @override
  // TODO: implement collectionName
  String get collectionName => "employees";

  @override
  Employee fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      position: json['position'],
      contact_info: json['contact_info'],
      department: json['department'],
      id: json['id'],
    );
  }
}
