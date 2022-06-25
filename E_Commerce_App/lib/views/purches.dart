import 'dart:ffi';

import 'package:e_commerce_app/components/basket_card.dart';
import 'package:e_commerce_app/components/purches_cart.dart';
import 'package:e_commerce_app/utility/account.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/views/basket.dart';
import 'package:e_commerce_app/views/login.dart';
import 'package:flutter/material.dart';

import '../helper/firebase_helper.dart';

class Purches extends StatefulWidget {
  @override
  State<Purches> createState() => _PurchesState();
}

class _PurchesState extends State<Purches> {
  String? imageUrl;

  Account? account = Account();

  @override
  void initState() {
    super.initState();
    getAccount();
  }

  getAccount() async {
    print("account get");
    FirebaseHelper().firestoreGet("accounts", Login.userId).then((doc) => {
          account = Account(
            address: doc["address"],
            moneyAmount: doc["moneyAmount"],
            ownerId: doc["ownerId"],
          ),
          this.setState(() {})
        });
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
                        child: Text("Money Amount : " +
                            account!.moneyAmount.toString()),
                      ),
                      Container(
                        child: Text("Address : " + account!.address!),
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
                                              0.6,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) => {
                                              account!.moneyAmount =
                                                  double.tryParse(
                                                      value.toString())!
                                            },
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
                                                labelText: 'Current Amount :' +
                                                    account!.moneyAmount
                                                        .toString(),
                                                hintText: 'Write Here'),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            FirebaseHelper().firestoreUpdate(
                                                "accounts", Login.userId, {
                                              "moneyAmount":
                                                  account!.moneyAmount
                                            });
                                          },
                                          child: Text("Update Money"))
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
                                      onChanged: (value) =>
                                          {account!.address = value.toString()},
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
                                          labelText: 'Current Address :' +
                                              account!.address!,
                                          hintText: 'Write Here'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      FirebaseHelper().firestoreUpdate(
                                          "accounts",
                                          Login.userId,
                                          {"address": account!.address});
                                    },
                                    child: Container(
                                      width: 150,
                                      child:
                                          Center(child: Text("Update Address")),
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
            onPressed: () {
              if (account!.address == "" || account!.moneyAmount == 0.0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text(
                      "Hesap Bilgilerinizi Giriniz",
                      style: TextStyle(color: Colors.red),
                    ));
                  },
                );
                return;
              }
              if (BasketState.sum > account!.moneyAmount) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text(
                      "Yetersiz Bakiye!",
                      style: TextStyle(color: Colors.red),
                    ));
                  },
                );

                return;
              }
              setState(() {
                account!.moneyAmount = account!.moneyAmount - BasketState.sum;
                Basket.products.clear();
                BasketState.instance!.setState(() {});
              });

              FirebaseHelper().firestoreUpdate("accounts", Login.userId,
                  {"moneyAmount": account!.moneyAmount});
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Siparişiniz Alındı"),
                    content: Text("Ürün adresinize gönderilecektir"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("Tamam")),
                    ],
                  );
                },
              );
            },
            child: Container(
              width: 100,
              child: const Center(child: Text("BUY")),
            ),
          )
        ])));
  }
}
