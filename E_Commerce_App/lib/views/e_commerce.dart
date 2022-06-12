import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/views/basket.dart';
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
            name: doc["name"],
            price: doc["price"],
            id: id,
            description: doc["description"],
            comments: doc["comments"]);
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
              icon: Icon(Icons.shopping_cart))
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
    );
  }
}
