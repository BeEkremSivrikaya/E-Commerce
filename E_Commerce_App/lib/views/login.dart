import 'dart:convert';

import 'package:e_commerce_app/utility/user.dart';
import 'package:e_commerce_app/views/admin/admin.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/views/register.dart';

import '../helper/firebase_helper.dart';
import 'e_commerce.dart';

class Login extends StatefulWidget {
  static User user = User();
  static String userId = "";
  static bool admin = false;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseHelper firebaseHelper = FirebaseHelper();

  String? name, surname, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      email = value.toString();
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value.toString();
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text("Remember me"),
                    contentPadding: EdgeInsets.zero,
                    value: true,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: ((value) => {}),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var user = await firebaseHelper.signIn(email!, password!);
                      firebaseHelper
                          .firestoreGet("Person", user!.uid)
                          .then((doc) {
                        Login.admin = doc["admin"];
                        User loginUser = User(
                            id: user.uid,
                            name: doc["name"],
                            surname: doc["surname"],
                            accountId: doc["accountId"],
                            eMail: doc["eMail"],
                            password: doc["password"],
                            telNumber: doc["telNumber"],
                            products: doc["products"]);
                        Login.user = loginUser;
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ECommerce(
                            user: user,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not registered yet?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        },
                        child: const Text('Create an account'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
