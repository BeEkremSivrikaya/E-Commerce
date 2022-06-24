import 'package:e_commerce_app/components/admin/adminproduct_card.dart';
import 'package:e_commerce_app/components/admin/user_card.dart';
import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/sections/product_update.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/utility/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  FirebaseHelper firebaseHelper = FirebaseHelper();

  List<Product> Products = List<Product>.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
  }

  getAllProducts() async {
    addNewProduct(String id) {
      firebaseHelper.firestoreGet("products", id).then((doc) {
        Product product = Product(
          id: id,
          name: doc["name"],
          category: doc["category"],
          comments: doc["comments"],
          description: doc["description"],
          price: doc["price"],
          sellerId: doc["sellerId"],
        );
        setState(() {
          Products.add(product);
        });
      });
    }

    firebaseHelper.firestore.collection("products").get().then((snapshot) {
      snapshot.docs.forEach((doc) => {addNewProduct(doc.id.toString())});
    });
  }

  Function? delete(Product product) {
    firebaseHelper.firestoreDelete("products", product.id!);
    firebaseHelper.deleteProductArray("Person", product.sellerId!, product.id!);
    product.comments
        .forEach((id) => {firebaseHelper.firestoreDelete("comments", id)});
    setState(() {
      Products.remove(product);
    });
  }

  Function? update(Product product) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ProductUpdate(product: product).build(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          centerTitle: true,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(top: 16),
              child: ListView.builder(
                itemCount: Products.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return AdminProductCard(
                    product: Products[index],
                    delete: delete,
                    update: update,
                  );
                },
              ),
            ),
          ),
        ));
  }
}
