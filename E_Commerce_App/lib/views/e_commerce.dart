import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/views/admin.dart';
import 'package:e_commerce_app/views/basket.dart';
import 'package:e_commerce_app/views/login.dart';
import 'package:e_commerce_app/views/seller.dart';
import 'package:flutter/material.dart';

import '../components/product_card.dart';
import '../helper/firebase_helper.dart';

class ECommerce extends StatefulWidget {
  var user;

  ECommerce({this.user});
  @override
  State<ECommerce> createState() => _ECommerceState(user: user);
}

class _ECommerceState extends State<ECommerce> {
  var user;
  _ECommerceState({this.user});

  List<Product> products = List<Product>.empty(growable: true);

  FirebaseHelper firebaseHelper = FirebaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
  }

  getAllProducts() async {
    addNewProduct(String id) {
      firebaseHelper.firestoreGet("products", id).then((doc) {
        Product newProduct = Product(
            id: id,
            name: doc["name"],
            category: doc["category"],
            comments: doc["comments"],
            description: doc["description"],
            price: doc["price"],
            sellerId: doc["sellerId"],
            );
        setState(() {
          products.add(newProduct);
        });
      });
    }

    firebaseHelper.firestore.collection("products").get().then((snapshot) {
      snapshot.docs.forEach((doc) => {addNewProduct(doc.id.toString())});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("Ürünler"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Basket()));
              },
              icon: Icon(Icons.shopping_cart)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Seller()));
              },
              icon: Icon(Icons.add))
          // Container(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: ElevatedButton(
          //       style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.all(Colors.white),
          //       ),
          //       child: Text(
          //         "Basket",
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => Basket()));
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: ListView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ),
      ),
      bottomNavigationBar:Login.admin? Container(
          child: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                StadiumBorder(),
              )),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Admin(),
                        ),
                      );
                },
                icon: Icon(
                  Icons.admin_panel_settings,
                ),
              ))
        ],
      )):null,
    );
  }
}
