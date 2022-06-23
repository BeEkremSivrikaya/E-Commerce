import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/user.dart';
import 'package:flutter/material.dart';

class UserUpdate extends StatelessWidget {
  User? user;
  UserUpdate({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              user!.name = value.toString();
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: user!.name.toString(),
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              user!.surname = value.toString();
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: user!.surname.toString(),
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              user!.eMail = value.toString();
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: user!.eMail.toString(),
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              user!.password = value.toString();
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: user!.password.toString(),
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          TextFormField(
            onChanged: (value) {
              user!.telNumber = value.toString();
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: user!.telNumber.toString(),
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ElevatedButton(onPressed: ()=>{
            FirebaseHelper().updateUser(user!),
            Navigator.pop(context),
          }, child: Text("Update"))
          
        ],
      ),
    );
  }
}
