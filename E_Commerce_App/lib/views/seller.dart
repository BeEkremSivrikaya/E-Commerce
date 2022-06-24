import 'dart:io';

import 'package:e_commerce_app/components/categories_list.dart';
import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/views/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/utility/product.dart';

class Seller extends StatefulWidget {
  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  Product? product = Product(sellerId: "1");
  PlatformFile? file;
  FirebaseHelper firebaseHelper = FirebaseHelper();

  onCategoryChange(String category){
    product!.category = category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),*/
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async => {
                        file = await firebaseHelper.selectFile(),
                        setState(() {})
                      },
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: (file != null)
                            ? Image.file(
                                File(file!.path!),
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                "https://i.pinimg.com/originals/9d/e6/c3/9de6c3b37d6d787ef98f2b301670a002.jpg",
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) => {product!.name = value.toString()},
                  decoration: InputDecoration(
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
                      labelText: 'Enter Product Name',
                      hintText: 'Write Here'),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) =>
                      {product!.description = value.toString()},
                  decoration: InputDecoration(
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
                      labelText: 'Enter Product Description',
                      hintText: 'Write Here'),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) =>
                      {product!.price = double.tryParse(value.toString())},
                  decoration: InputDecoration(
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
                      labelText: 'Enter Product Price',
                      hintText: 'Write Here'),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoriesList(onChange: onCategoryChange,)),
              Positioned(
                bottom: 0,
                child: ElevatedButton(
                  onPressed: () {
                    firebaseHelper.uploadProduct(product!, file!);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
                  // TextField(
                  //     decoration: InputDecoration(
                  //   enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(
                  //       color: Colors.blueAccent,
                  //     ),
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   hintText: "Enabled decoration text ...",
                  // )),


                  // InputDecoration(
                  //       border: InputBorder.none,
                  //       hintText: 'password',
                  //       filled: true,
                  //       fillColor: Colors.grey,
                  //       contentPadding: const EdgeInsets.only(
                  //           left: 14.0, bottom: 6.0, top: 8.0),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.red),
                  //         borderRadius: BorderRadius.circular(10.0),
                  //       ),
                  //       enabledBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.grey),
                  //         borderRadius: BorderRadius.circular(10.0),
                  //       ),
                  //     ),