import 'dart:async';

import 'package:e_commerce_app/components/categories_list.dart';
import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/views/admin/admin.dart';
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

  static List<String> categories = ['All','Electronic', 'Book', 'Toy', 'Outfit'];
}

class _ECommerceState extends State<ECommerce> {
  var user;
  _ECommerceState({this.user});

  List<Product> products = List<Product>.empty(growable: true);
  List<Product> productsView = List<Product>.empty(growable: true);

  FirebaseHelper firebaseHelper = FirebaseHelper();

  Timer? timer;
  String category = ECommerce.categories.first;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
    timer =
        Timer.periodic(Duration(seconds: 10), (Timer t) => getAllProducts());
  }

  getAllProducts() async {
    print("object");
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
          if (newProduct.sellerId != Login.userId) {
            bool contain = false;

            products.forEach((product) => {
                  if (product.id == newProduct.id)
                    {
                      contain = true,
                    }
                });
            if (!contain) {
              products.add(newProduct);
              renderCategoryView();
            }
          }
          
        }
        );
      });
    }

    firebaseHelper.firestore.collection("products").get().then((snapshot) {
      snapshot.docs.forEach((doc) => {addNewProduct(doc.id.toString())});
    });
  }

  renderCategoryView() {
    productsView.clear();
    setState(() {
      
      products.forEach((product) => {
        if(category=="All"){
          productsView.add(product)
        }else if (product.category == category) {productsView.add(product),}
          });
    });
  }

  setCategory(String category) {
    this.category = category;
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
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: ListView.builder(
                  itemCount: productsView.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductCard(product: productsView[index]);
                  },
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          color: Color.fromARGB(253, 204, 204, 204),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: ECommerce.categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () => {
                        setCategory(ECommerce.categories[index]),
                        renderCategoryView()
                        },
                      child: Container(
                        width: 100,
                        height: 20,
                        color: Color.fromARGB(255, 87, 186, 247),
                        child: Center(child: Text(ECommerce.categories[index])),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        
      ]),
      bottomNavigationBar: Login.admin
          ? Container(
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
            ))
          : null,
    );
  }
}
