import 'package:e_commerce_app/components/basket_card.dart';
import 'package:e_commerce_app/components/purches_cart.dart';
import 'package:e_commerce_app/utility/account.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/views/basket.dart';
import 'package:flutter/material.dart';

import '../helper/firebase_helper.dart';

class Purches extends StatelessWidget {
  Product? product = Product();
  String? imageUrl;
  Account? account = Account();

  getImageUrl() async {
    imageUrl = await FirebaseHelper().downloadFile("files", product!.id!);
  }

  getAccount() async {
    //FirebaseHelper().firestoreGet("accounts", )
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Purches"),
          centerTitle: true,
        ),
        body: Container(
            child: Column(children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    children: [
                      Container(
                        child: const Text("hesap adı"),
                      ),
                      Container(
                        child: const Text("para miktarı"),
                      ),
                      Container(
                        child: const Text("hesap adresi"),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: FloatingActionButton(
                      onPressed: () {
                        showModalBottomSheet(
                            elevation: 2,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Column(children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextField(
                                            // onChanged: (value) =>
                                            //     {product!.name = value.toString()},
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 14.0,
                                                        bottom: 6.0,
                                                        top: 8.0),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blueAccent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                border: InputBorder.none,
                                                labelText: 'Enter Product Name',
                                                hintText: 'Write Here'),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Container(
                                          //width: 100,
                                          child: Center(child: Text("Update")),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 4,

                                      //onChanged: (value) => {product!.name = value.toString()},
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0,
                                              bottom: 40.0,
                                              top: 40.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blueAccent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          border: InputBorder.none,
                                          labelText: 'Enter Product Name',
                                          hintText: 'Write Here'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Container(
                                      width: 150,
                                      child: Center(child: Text("Update")),
                                    ),
                                  )
                                ]),
                              );
                            });
                      },
                      child: const Icon(Icons.edit)),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.only(top: 16),
            child: ListView.builder(
              itemCount: Basket.products.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return PurchesCard(
                  product: Basket.products[index],
                );
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            child: Text(
              "Toplam Tutar: " + BasketState.sum.toString() + " TL",
              style: const TextStyle(fontSize: 15),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Container(
              width: 100,
              child: const Center(child: Text("BUY")),
            ),
          )
        ])));
  }
}
