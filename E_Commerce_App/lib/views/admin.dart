import 'package:e_commerce_app/utility/user.dart';
import 'package:e_commerce_app/views/e_commerce.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/account.dart';
import '../helper/firebase_helper.dart';

class Admin extends StatefulWidget {
  var user;
  Admin({this.user});
  @override
  State<Admin> createState() => _AdminState(user: user);
}

class _AdminState extends State<Admin> {
  var user;
  _AdminState({this.user})

  List<Account> accounts= List<Account>.empty(growable: true);
  
  FirebaseHelper firebaseHelper = FirebaseHelper();

  @override
  
    void initState() {
    // TODO: implement initState
    super.initState();
    getAllAccounts();
  }

  getAllAccounts() async {
    addNewAccount(String id) {
      firebaseHelper.firestoreGet("accounts", id).then((doc) {
        Account newAccount = Account(
            // ownerId: doc["ownerId"],
            address: doc["address"],
            moneyAmount: doc["moneyAmount"],
            ownerId: id);
            
            
        setState(() {
          accounts.add(newAccount);
        });
      });
    }

    firebaseHelper.firestore.collection("accounts").get().then((snapshot) {
      snapshot.docs.forEach((doc) => {addNewAccount(doc.id.toString())});
    });
  }
  // en son burda kaldım e-commerce sayfası gibi accountları listelemek için 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: ListView.builder(
            //itemCount: Account,
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
