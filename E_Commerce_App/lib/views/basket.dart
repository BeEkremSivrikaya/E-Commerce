import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/views/purches.dart';
import 'package:flutter/material.dart';
import '../components/basket_card.dart';
import '../helper/firebase_helper.dart';

class Basket extends StatefulWidget {
  var user;

  Basket({this.user});
  @override
  State<Basket> createState() => BasketState(user: user);
  static List<Product> products = List<Product>.empty(growable: true);
}

class BasketState extends State<Basket> {
  var user;
  BasketState({this.user});

  FirebaseHelper firebaseHelper = FirebaseHelper();
  static double sum = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkPrice();
  }

  checkPrice() {
    sum = 0;
    for (int i = 0; i < Basket.products.length; i += 1) {
      sum += Basket.products[i].price!;
    }
  }

  void deleteProduct(Product product) {
    setState(() {
      Basket.products.remove(product);
      checkPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.lime,
        title: Text("Basket"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            padding: EdgeInsets.only(top: 16),
            child: Basket.products.length != 0
                ? ListView.builder(
                    itemCount: Basket.products.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BasketCard(
                        product: Basket.products[index],
                        delete: deleteProduct,
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Sepet Boş",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  )),
      ),
      floatingActionButton: Container(
        // height: 100,
        width: 200,

        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(50)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 10,
          ),
          Text(
            sum.toString() + "TL",
            style: TextStyle(fontSize: 20),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Purches()));
            },
            child: Icon(
              Icons.shopping_cart_checkout,
            ),
          )
        ]),
      ),
    );
  }
}
