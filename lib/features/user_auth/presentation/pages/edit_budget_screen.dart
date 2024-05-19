import 'package:flutter/material.dart';

class EditBudgetScreen extends StatelessWidget {
  final double whiteHeightRatio;

  const EditBudgetScreen({super.key, this.whiteHeightRatio = 0.75});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Budget'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.transparent, // Make scaffold background transparent to show the gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black, // Black color at the top
              Colors.white, // White color at the bottom
            ],
            stops: [1 - whiteHeightRatio, 1 - whiteHeightRatio], // Adjust transition point
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16), // Add padding outside the container
                  child: Container(
                    padding: EdgeInsets.all(16), // Internal padding of the container
                    height: 148,
                    width: 357,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: -1,
                          blurRadius: 7.5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50), // Add padding outside the container
                  child: Column(
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.all(16), // Internal padding of the container
                        height: 148,
                        width: 298,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30), // Add padding outside the container
                  child: Column(
                    children: [
                      Text(
                        'Yesterday',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.all(16), // Internal padding of the container
                        height: 148,
                        width: 298,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
