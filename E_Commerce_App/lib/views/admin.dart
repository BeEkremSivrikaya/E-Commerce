import 'package:e_commerce_app/views/basket.dart';
import 'package:e_commerce_app/views/e_commerce.dart';
import 'package:e_commerce_app/views/users.dart';
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
        title: Text("Admin"), centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context, MaterialPageRoute(builder: (context) => Basket()));
        //       },
        //       icon: Icon(Icons.shopping_cart)),
        // ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 300,
              child: RaisedButton(
                color: Colors.amber,
                child: Text(
                  "Kullanıcılar",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Users()));
                },
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              height: 100,
              width: 300,
              child: RaisedButton(
                color: Colors.amber,
                child: Text(
                  "Ürünler",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ECommerce()));
                },
              ),
            )
            // onPressed: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => Basket()));
            //       },
            // Container(
            //     height: 100,
            //     width: 300,
            //     child: Center(child: Text('ürünler')),
            //     decoration: BoxDecoration(
            //       color: Colors.amber,
            //       shape: BoxShape.rectangle,
            //       border: Border.all(
            //         color: Colors.black,
            //         width: 2.0,
            //       ),
            //     )),
            // Container(
            //   height: 100,
            //   width: 300,
            //   child: Center(child: Text("Kullanıcılar")),
            //   decoration: BoxDecoration(
            //       color: Colors.amber,
            //       shape: BoxShape.rectangle,
            //       border: Border.all(
            //         color: Colors.black,
            //         width: 2.0,
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}
