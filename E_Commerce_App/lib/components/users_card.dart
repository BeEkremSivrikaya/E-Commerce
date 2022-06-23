import 'dart:ui';

import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/utility/user.dart';
import 'package:e_commerce_app/views/basket.dart';
import 'package:e_commerce_app/views/details.dart';
import 'package:flutter/material.dart';

class UsersCard extends StatefulWidget {
  User? user;
  Function? delete;
  Function? update;
  UsersCard({this.user, this.delete, this.update});

  @override
  State<UsersCard> createState() =>
      _UsersCardState(user: user, delete: delete, update: update);
}

class _UsersCardState extends State<UsersCard> {
  User? user;
  String? imageUrl;
  Function? delete;
  Function? update;
  _UsersCardState({this.user, this.delete, this.update});
  //_UsersCardState({this.product, this.delete});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Details()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red[300], borderRadius: BorderRadius.circular(5)),
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  // child: Image.network(
                  //   product!.imageUrl == null
                  //       ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3s20xEff3_qgR076pYXUZi3CT-54x0o815emvCp-g4d6rRBlhs8F3T1qez0kYjP3nSMc&usqp=CAU"
                  //       : product!.imageUrl!,
                  //   width: 200,
                  //   height: 100,
                  //   fit: BoxFit.contain,
                  // ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(20))),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Kullanıcı Adı: " + user!.name!),
                    ),
                    Row(
                      children: [
                        Container(
                            child: IconButton(
                          onPressed: () {
                            delete!(user);
                          },
                          icon: Icon(Icons.remove_shopping_cart),
                          color: Colors.red,
                        )),
                        Container(
                            child: IconButton(
                          onPressed: () {
                            update!(user);
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.red,
                        )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.amber, borderRadius: BorderRadius.circular(5)),
//           width: MediaQuery.of(context).size.width,
//           height: 100,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.4,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Image.network(
//                     product!.imageUrl == null
//                         ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3s20xEff3_qgR076pYXUZi3CT-54x0o815emvCp-g4d6rRBlhs8F3T1qez0kYjP3nSMc&usqp=CAU"
//                         : product!.imageUrl!,
//                     width: 200,
//                     height: 100,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius:
//                         BorderRadius.horizontal(left: Radius.circular(20))),
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: Text(product!.name!),
//                     ),
//                     Container(
//                       child: Text((product!.price!).toString()),
//                     ),
//                     Container(
//                       child: IconButton(
//                         onPressed: () {
//                           Basket.products.add(product!);
//                         },
//                         icon: Icon(Icons.add_shopping_cart_outlined),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),


