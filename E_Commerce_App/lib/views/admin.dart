import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        centerTitle: true,
      ),
    );
  }
}
