// import 'package:e_commerce_app/utility/admin.dart';
import 'dart:developer';

import 'package:e_commerce_app/views/basket.dart';
import 'package:e_commerce_app/views/details.dart';
import 'package:e_commerce_app/views/e_commerce.dart';
import 'package:e_commerce_app/views/purches.dart';
import 'package:e_commerce_app/views/register.dart';
import 'package:e_commerce_app/views/admin.dart';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce_app/views/seller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'E-Commerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //kullanıcı giriş sayfasına yönlerdirir
        home: Admin());
  }
}
// satıcının sattığı ürünleri görme.
// kayıt olan her kullanıcıya account atama
// admin paneli yapılacak

