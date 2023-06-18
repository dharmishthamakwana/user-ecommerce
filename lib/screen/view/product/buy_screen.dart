import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app2/screen/modal/Product_modal.dart';
import 'package:firebase_app2/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyProduct extends StatefulWidget {
  const BuyProduct({Key? key}) : super(key: key);

  @override
  State<BuyProduct> createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  List<ProductModal> Buylist = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: Text(
            "Buy now",
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.buyread(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
              );
            } else if (snapshot.hasData) {
              QuerySnapshot? snapData = snapshot.data;
              Buylist.clear();
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
                Buylist.add(t1);

                print("$desc,$name,$number,$img,$price");
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: Buylist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      ProductModal p1 = ProductModal(
                        key: Buylist[index].key,
                        desc: Buylist[index].desc,
                        name: Buylist[index].name,
                        number: Buylist[index].number,
                        img: Buylist[index].img,
                        price: Buylist[index].price,
                      );
                      Get.toNamed('now', arguments: Buylist[index]);
                    // onTap: () async {
                    //   await FirebaseHelper.firebaseHelper
                    //       .deletebuy(key: Buylist[index].key);
                    //
                    //   Get.snackbar("Delete Success", "");
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
                                  NetworkImage("${Buylist[index].img}"),
                            ),
                            Text("name: ${Buylist[index].name}",
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Price:  ${Buylist[index].price}",
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "desc: ${Buylist[index].desc}",
                              overflow: TextOverflow.ellipsis,
                            ),
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
      ),
    );
  }
}
