import 'dart:convert';

import 'package:e_commerce_app/components/comment_card.dart';
import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/comment.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/views/basket.dart';
import 'package:e_commerce_app/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Product? product;
  Details({this.product});
  
  @override
  State<Details> createState() => _DetailsState(product: product);
}

class _DetailsState extends State<Details> {
  Product? product;
  String? newComment;
  String? sellerName = "";
  List<dynamic> allComments = List<dynamic>.empty(growable: true);
  _DetailsState({this.product});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllComments();
    getSellerName();
  }
  getSellerName(){
    FirebaseHelper().firestoreGet("Person", product!.sellerId!).then((doc) => {
      this.setState(() {
        sellerName=doc["name"];
      })
      
    });

  }
  getAllComments() async {
    product!.comments.forEach((id) async {
      var comment =
          await FirebaseHelper().firestoreGet("comments", id).then((doc) {
        Comment newComment = Comment(
          comment: doc["comment"],
          userId: doc["user"],
        );
        setState(() {
          allComments.add(newComment);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: size.height * 0.83,
            child: Column(
              children: [
                Center(
                  child: Image.network(
                    product!.imageUrl == null
                        ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIeG_tiD1v1-ighyfzG_7UundOpn_s6CP8gmU8T7YHyyVahUyEbzQCCK4vFAo4N7xFu8A&usqp=CAU"
                        : product!.imageUrl!,
                    width: size.width,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(sellerName!),
                Text(product!.category!),
                Expanded(
                  child: Container(
                    width: size.width,
                    height: 200,
                    child: Column(
                      children: [
                        Text(
                          product!.name!,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          product!.description!,
                        ),

                        Container(
                          height: 240,
                          child: ListView.builder(
                            itemCount: allComments.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CommentCard(
                                comment: allComments[index],
                              );
                            },
                          ),
                        )
                        //Text(product!.comments!)
                      ],
                    ),
                  ),
                ),
                TextField(
                  onChanged: (value) => {newComment = value.toString()},
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(Icons.add_comment),
                          onPressed: () {
                            print(product!.id!);
                            FirebaseHelper().uploadComment(
                                newComment!, product!.id!, Login.userId);
                                setState(() {
                                  allComments.add(Comment(comment: newComment,userId: Login.userId));
                                });
                            // yorumu eklesin algoritması eklenecek.
                            // onChanged:
                            // (value) => {product!.comments = value.toString()};
                          }),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: InputBorder.none,
                      labelText: 'Enter Comment',
                      hintText: 'Write Here'),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          child: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product!.price!.toString() + "TL",
            style: TextStyle(fontSize: 25),
          ),
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                StadiumBorder(),
              )),
              child: IconButton(
                onPressed: () {
                  Basket.products.add(product!);
                },
                icon: Icon(
                  Icons.add_shopping_cart_outlined,
                ),
              ))
        ],
      )),
    );
  }
}
