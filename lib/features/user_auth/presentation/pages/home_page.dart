import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel/features/user_auth/presentation/pages/add_expenses_screen.dart';
import 'package:hotel/features/user_auth/presentation/pages/add_planner_screen.dart';
import 'package:hotel/features/user_auth/presentation/pages/edit_budget_screen.dart';
import 'package:intl/intl.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("FinanceZ")
      ),
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Column(
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
                          child: Icon(Icons.delete),
                        ),
                        trailing: GestureDetector(
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
            //Diri ko nag start code----------------------------------------------------
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(16),
                height: 300,
                width: 357,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: -1,
                      blurRadius: 7.5,
                      offset: Offset(0,3), 
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                    Text(
                    "Weekly Budget", 
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Text(
                      formattedDate,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        //add here balance
                      ),
                      ), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddExpensesScreen()), 
                              );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline),
                                SizedBox(width: 3), 
                                Text("Add Expenses"),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditBudgetScreen()), 
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit_square), 
                                SizedBox(width: 8), 
                                Text("Edit Budget"),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(25),
                      height: 72,
                      width: 357,
                      child: Text(
                        "Previous Day Expenses",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                          ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  height: 72,
                  width: 307,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: -1,
                        blurRadius: 7.5,
                        offset: Offset(0,2), 
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "No Data", //insert previous day expenses
                    //insert right side, previous date (MM/DD/YYYY)
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      ),
                  ),
                ),
                Center(
                  child: Column(
                    children:[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [ 
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          height: 72,
                          width: 155,
                          child: Text(
                            "Planners",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Colors.white,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddPlannerScreen()), 
                              );
                            }, 
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline), 
                                SizedBox(width: 8),
                                Text("Add Planner",
                                style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                  Container(
                    padding: EdgeInsets.all(16),
                    height: 72,
                    width: 307,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: -1,
                          blurRadius: 7.5,
                          offset: Offset(0,2), 
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.emoji_food_beverage_rounded,
                              color: Colors.black, 
                            ),
                            SizedBox(width: 8),
                            Text(
                              "No Data",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.add), 
                          color: Colors.black, 
                          onPressed: () {
                            // Add functionality here
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } // diri ang end ka code ko---------------------------------------------------------------------

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