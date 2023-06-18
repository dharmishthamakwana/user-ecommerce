import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app2/screen/controller/home_controller.dart';
import 'package:firebase_app2/screen/modal/Product_modal.dart';
import 'package:firebase_app2/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeController homeController = Get.put(HomeController());
  List<ProductModal> taskList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: Text("Home"),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Get.toNamed('cart');
          //       },
          //       icon: Icon(Icons.shopping_cart))
          // ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.blueGrey.shade50,
            child: Column(
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 7.h,
                    backgroundImage: NetworkImage(homeController.data['img'] ==
                            null
                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUtcO4YmGkZhf8rEs8DdPZYnLlPCpOF1pTMZMYf1lDHzaQFAqjUKPzRFdZaqDRuBuYKHo&usqp=CAU'
                        : '${homeController.data['img']}'),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(
                  () => Text(
                      homeController.data['name'] == null
                          ? 'makwana'
                          : '${homeController.data['name']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp)),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(
                  () => Text(
                    homeController.data['email'] == null
                        ? "email: makwana@gmail.com"
                        : '${homeController.data['email']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(
                  () => Text(
                      homeController.data['number'] == null
                          ? ''
                          : '${homeController.data['number']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp)),
                ),
                Text("_____________________________________________"),
                InkWell(
                  onTap: () {
                    Get.toNamed('Home');
                  },
                  child: ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      "Home Page",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "My Account",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('orader');
                  },
                  child: ListTile(
                    leading: Icon(Icons.card_travel_rounded),
                    title: Text(
                      "My orader",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.category),
                  title: Text(
                    "Categoryes",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
                ListTile(
                  leading: Icon(Icons.favorite, color: Colors.red),
                  title: Text(
                    "Favorite",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    "Setting",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                ),
                InkWell(
                  onTap: () async {
                    bool msg = await FirebaseHelper.firebaseHelper.signOut();
                    if (msg = true) {
                      Get.offNamed("SignIn");
                      Get.snackbar("true", "$msg");
                    }
                  },
                  child: ListTile(
                    leading: Icon(Icons.device_unknown),
                    title: Text(
                      "Logout",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.login_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  hintText: "Enter the item ...",
                  suffixIcon: Icon(Icons.search_rounded,size: 40,color: Colors.blueGrey.shade300,)
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseHelper.firebaseHelper.read(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      "${snapshot.error}",
                    );
                  } else if (snapshot.hasData) {
                    QuerySnapshot? snapData = snapshot.data;
                    taskList.clear();
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
                      taskList.add(t1);

                      print("$desc,$name,$number,$img,$price");
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              ProductModal p1 = ProductModal(
                                key: taskList[index].key,
                                desc: taskList[index].desc,
                                name: taskList[index].name,
                                number: taskList[index].number,
                                img: taskList[index].img,
                                price: taskList[index].price,
                              );
                              Get.toNamed('product',
                                  arguments: taskList[index]);
                            },
                            onDoubleTap: () async {
                              await FirebaseHelper.firebaseHelper
                                  .deleteData(key: taskList[index]);

                              Get.snackbar("Delete Success", "");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blueGrey.shade200,
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          "${taskList[index].img}"),
                                    ),
                                    Text(
                                      "name: ${taskList[index].name}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "Price:  ${taskList[index].price}",
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "desc: ${taskList[index].desc}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [],
                                    )
                                  ],
                                ),
                              ),
                            ));
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
