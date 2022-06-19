import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Users"),
      centerTitle: true,
    ));
  }
}
