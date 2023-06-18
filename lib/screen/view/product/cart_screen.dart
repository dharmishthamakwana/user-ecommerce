import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app2/screen/modal/Product_modal.dart';
import 'package:firebase_app2/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModal> Cartlist = [];

  // ProductModal data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: Text("Cart Screen"),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Get.toNamed("buy");
          //       },
          //       icon: Icon(Icons.add_shopping_cart))
          // ],
        ),
        body: StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.readdata(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
              );
            } else if (snapshot.hasData) {
              QuerySnapshot? snapData = snapshot.data;
              Cartlist.clear();
              for (var x in snapData!.docs) {
                Map? data = x.data() as Map;
                String desc = data['desc'];
                String name = data['name'];
                String img = data['img'];
                String number = data['number'];
                String price = data['price'];
                ProductModal t1 = ProductModal(
                  number: number,
                  name: name,
                  img: img,
                  desc: desc,
                  price: price,
                  key: x.id,
                );
                Cartlist.add(t1);

                print("$desc,$name,$number,$img,$price");
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: Cartlist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      ProductModal p1 = ProductModal(
                        key: Cartlist[index].key,
                        desc: Cartlist[index].desc,
                        name: Cartlist[index].name,
                        number: Cartlist[index].number,
                        img: Cartlist[index].img,
                        price: Cartlist[index].price,
                      );
                      Get.toNamed('now', arguments: Cartlist[index]);
                    },
                    onTap: () async {
                      await FirebaseHelper.firebaseHelper
                          .deleteData(key: Cartlist[index].key);

                      Get.snackbar("Delete Success", "");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey.shade200,
                              radius: 30,
                              backgroundImage:
                                  NetworkImage("${Cartlist[index].img}"),
                            ),
                            Text("name: ${Cartlist[index].name}",
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Price:  ${Cartlist[index].price}",
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "desc: ${Cartlist[index].desc}",
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: Icon(Icons.add),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("1", style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: Icon(Icons.minimize),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey.shade700,
            onPressed: () {
              for (int i = 0; i < Cartlist.length; i++) {

                FirebaseHelper.firebaseHelper.buydata(
                  ProductModal(
                    price: Cartlist[i].price,
                    number: Cartlist[i].number,
                    name: Cartlist[i].name,
                    img: Cartlist[i].img,
                    key: Cartlist[i].key,
                    desc: Cartlist[i].desc,
                  ),
                );
              }
            },
            child: Icon(Icons.add,size: 40,)),
      ),
    );
  }
}
