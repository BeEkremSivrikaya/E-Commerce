import 'dart:io';

import 'package:e_commerce_app/utility/comment.dart';
import 'package:e_commerce_app/utility/product.dart';
import 'package:e_commerce_app/views/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/utility/user.dart' as app;
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    app.User newUser;
    firestoreGet("Person", user.user!.uid).then((doc) => {
          newUser = app.User(
            name: doc["name"],
            surname: doc["surname"],
            eMail: doc["eMail"],
          ),
          Login.userId = user.user!.uid,
          Login.user = newUser
        });
    return user.user;
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await auth.signOut();
  }

  //kayıt ol fonksiyonu
  Future<User?> createPerson(app.User newUser) async {
    var user = await auth.createUserWithEmailAndPassword(
        email: newUser.eMail!, password: newUser.password!);

    await firestore.collection("Person").doc(user.user!.uid).set({
      "name": newUser.name,
      "surname": newUser.surname,
      "eMail": newUser.eMail,
      "password": newUser.password,
      "telNumber": newUser.telNumber,
      "account": newUser.account
    });
    firestoreAdd("accounts", {
      "ownerId": user.user!.uid,
      "moneyAmount": "0",
      "address": "",
    });
    return user.user;
  }

  Future firestoreAdd(String path, Map<String, dynamic> map) async {
    return firestore.collection(path).add(map);
  }

  Future firestoreGet(String path, String id) async {
    return await firestore.collection(path).doc(id).get();
  }

  Future firestoreGetAll(String path) async {
    return await firestore.collection(path).get();
  }

  uploadProduct(Product product, PlatformFile file) {
    firestoreAdd("products", {
      "id": product.id,
      "name": product.name,
      "comments": [],
      "description": product.description,
      "price": product.price,
      "sellerId": product.sellerId
    }).then((value) => {uploadFile(file, value.id)});
  }

  Future<PlatformFile> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null!;
    PlatformFile pickedFile = result.files.first;
    return pickedFile;
  }

  Future uploadFile(PlatformFile selectedFile, String id) async {
    final path = 'files/${id}';
    final file = File(selectedFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Future<String> downloadFile(String filePath, String id) async {
    final path = filePath + "/" + id;

    final ref = FirebaseStorage.instance.ref().child(path);
    print(await ref.getDownloadURL());
    return await ref.getDownloadURL();
  }

  Future updateArray(
    String path,
    String userId,
    String commentId,
  ) async {
    firestore.collection(path).doc(userId).update({
      "comments": FieldValue.arrayUnion([commentId])
    });
  }

  void uploadComment(String comment, String productId, String userId) {
    firestoreAdd("comments", {"comment": comment, "user": userId})
        .then((value) => {updateArray("products", productId, value.id)});
  }
}