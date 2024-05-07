import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<UserModel>>(
              stream: _readData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text("No Data"),
                  );
                }
                final employees = snapshot.data;
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                      children: employees!.map((employee) {
                    return ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          _deleteData(employee.id!);
                        },
                        child: Icon(Icons.delete),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          // WIP
                          // Butangi nyo lang di pop-up nga may textfield
                          _updateData(UserModel(
                              id: employee.id,
                              name: "EDITED NAME",
                              position: "NEW POSITION",
                              contact_info: "NEW CONTACT INFO",
                              department: "NEW DEPARTMENT"));
                        },
                        child: Icon(Icons.update),
                      ),
                      title: Text("Name: " + employee.name!),
                      subtitle: Text("Position: " +
                          employee.position! +
                          "\nContact Info: " +
                          employee.contact_info! +
                          "\nDepartment: " +
                          employee.department!),
                    );
                  }).toList()),
                );
              }),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              _createData(UserModel(
                  name: "Erin",
                  position: "Chef",
                  contact_info: "1",
                  department: "CET"));
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text("Add Employee")),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text("Sign Out")),
            ),
          )
        ],
      ),
    );
  }

  Stream<List<UserModel>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("employees");

    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map(
          (e) => UserModel.fromSnapshot(e),
        )
        .toList());
  }

  void _createData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("employees");

    String id = userCollection.doc().id;

    final newEmployee = UserModel(
            name: userModel.name,
            position: userModel.position,
            contact_info: userModel.contact_info,
            department: userModel.department,
            id: id)
        .toJson();

    userCollection.doc(id).set(newEmployee);
  }

  void _updateData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("employees");

    final newData = UserModel(
            name: userModel.name,
            position: userModel.position,
            contact_info: userModel.contact_info,
            department: userModel.department,
            id: userModel.id)
        .toJson();

    userCollection.doc(userModel.id).update(newData);
  }

  void _deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("employees");

    userCollection.doc(id).delete();
  }
}

class UserModel {
  final String? name;
  final String? position;
  final String? contact_info;
  final String? department;
  final String? id;

  UserModel({
    this.name,
    this.position,
    this.contact_info,
    this.department,
    this.id,
  });

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      name: snapshot['name'],
      position: snapshot['position'],
      contact_info: snapshot['contact_info'],
      department: snapshot['department'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "position": position,
      "contact_info": contact_info,
      "department": department,
      "id": id,
    };
  }
}
