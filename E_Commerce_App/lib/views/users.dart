import 'package:e_commerce_app/components/user_card.dart';
import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/sections/user_update.dart';
import 'package:e_commerce_app/utility/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  
  FirebaseHelper firebaseHelper = FirebaseHelper();

  List<User> Users = List<User>.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
    
  }
  getAllUsers()async{
    addNewUser(String id) {
      firebaseHelper.firestoreGet("Person", id).then((doc) {
        User user = User(
            id: id,
            name: doc["name"],
            surname: doc["surname"],
            accountId: doc["accountId"],
            eMail: doc["eMail"],
            password: doc["password"],
            telNumber: doc["telNumber"],
            products: doc["products"]
            );
        setState(() {
          Users.add(user);
        });
      });
    }

    firebaseHelper.firestore.collection("Person").get().then((snapshot) {
      print(snapshot);
      snapshot.docs.forEach((doc) => {addNewUser(doc.id.toString())});
    });
  }

  Function? delete(User user){
    firebaseHelper.firestoreDelete("Person", user.id!);
    setState(() {
      Users.remove(user);
    });
    user.products.map((product)=>{
      firebaseHelper.firestoreDelete("products", product.id)
    });
  }
  Function? update(User user){
    showModalBottomSheet(context: context, builder: (BuildContext context) { return UserUpdate(user: user,).build(context);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
      ),

       body: Container(
         child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(top: 16),
              child: ListView.builder(
                itemCount: Users.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return UserCard(user: Users[index], delete: delete, update: update,);
                },
              ),
            ),
          ),
       )
    );
  }
}
