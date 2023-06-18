import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app2/screen/controller/home_controller.dart';
import 'package:firebase_app2/screen/modal/Product_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore fiebaseFirestore = FirebaseFirestore.instance;

  Future<bool> SignUpUser(
      {required String email, required String password}) async {
    bool isSignUp = false;

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      isSignUp = true;
      print(
        "Sign Up Successful With $email",
      );
    }).catchError((error) {
      isSignUp = false;
      print("$error");
    });
    return isSignUp;
  }

  Future<String> signIn({required email, required password}) {
    return firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        return 'Success';
      },
    ).catchError((e) {
      return '$e';
    });
  }

  bool checkUser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<Map> userDetails() async {
    User? user = await firebaseAuth.currentUser;
    String? email = user!.email;
    String? img = user.photoURL;
    String? name = user.displayName;
    String? number = user.phoneNumber;
    print("================================$img");
    Map m1 = {'email': email, 'img': img, 'name': name, 'number': number};
    return m1;
  }

  String getUid() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;
    return uid;
  }

  Future<bool> signOut() async {
    await firebaseAuth.signOut();
    return true;
  }

  Future<void> adduser({
    email,
    name,
    number,
    img,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await fiebaseFirestore.collection("user").add({
      'email': email,
      'name': name,
      'number': number,
      'img': img,
    });
  }

  Future<void> delete(String docid) async {
    await fiebaseFirestore.collection('product').doc(docid).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> user() {
    String uid = getUid();
    return fiebaseFirestore.collection("user").snapshots();
  }

  void update(ProductModal homeModel, String key) {
    fiebaseFirestore.collection('product').doc(key).set({
      "Name": "${homeModel.name}",
      "Price": "${homeModel.price}",
      "number": "${homeModel.number}",
      "desc": "${homeModel.desc}",
      "img": "${homeModel.img}",
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> read() {
    return fiebaseFirestore.collection('product').snapshots();
  }

  Future<void> insert({desc, img, name, number, key, price}) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await fiebaseFirestore.collection("cart").add({
      'desc': desc,
      'img': img,
      'name': name,
      'number': number,
      'price': price,
      'key': key,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readdata() {
    // User? user = firebaseAuth.currentUser;
    // String uid = user!.uid;
    return fiebaseFirestore.collection("cart").snapshots();
  }

  void buydata(ProductModal data) {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    fiebaseFirestore.collection("buy").add({
      'desc': data.desc,
      'img': data.img,
      'name': data.name,
      'number': data.number,
      'price': data.price,
      'key': data.key,
    });
  }
  void Buynowdata(ProductModal data) {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    fiebaseFirestore.collection("buynow").add({
      'desc': data.desc,
      'img': data.img,
      'name': data.name,
      'number': data.number,
      'price': data.price,
      'key': data.key,
    });
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> buyread(){
    return fiebaseFirestore.collection("buy").snapshots();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> buynowread(){
    return fiebaseFirestore.collection("buynow").snapshots();
  }

  Future<void> deleteData({required key}) async {
    var uid = getUid();
    await fiebaseFirestore.collection("cart")
        .doc(key)
        .delete();
  }
  Future<void> deletebuy({required key}) async {
    var uid = getUid();
    await fiebaseFirestore.collection("buy")
        .doc(key)
        .delete();
  }
}
//