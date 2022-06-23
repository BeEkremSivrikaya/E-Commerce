import 'package:e_commerce_app/components/users_card.dart';
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
      ),

      //  body: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Container(
      //       padding: EdgeInsets.only(top: 16),
      //       child: ListView.builder(
      //         itemCount: Users.length,
      //         shrinkWrap: true,
      //         physics: ClampingScrollPhysics(),
      //         itemBuilder: (context, index) {
      //           return UsersCard(product: products[index]);
      //         },
      //       ),
      //     ),
      //   )
    );
  }
}
