import 'package:firebase_app2/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modal/Product_modal.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  ProductModal data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          // leading: IconButton(
          //     onPressed: () {
          //       Get.toNamed("Home");
          //     },
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //     )),
          title: Text("Product Detail"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 330,
              width: double.infinity,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 270,
                      width: double.infinity,
                      child: Image.network(
                        "${data.img}",
                        fit: BoxFit.cover,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.name}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(
                  "\$ ${data.price}",
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Details:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "                     ${data.desc}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 50),
                            backgroundColor: Colors.blueGrey.shade600),
                        onPressed: () {
                          FirebaseHelper.firebaseHelper.insert(
                              desc: data.desc,
                              price: data.price,
                              number: data.number,
                              name: data.name,
                              img: data.img,
                              key: data.key);
                          Get.toNamed('Home');
                        },
                        child:
                            Text("ADD to Cart", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
