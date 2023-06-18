import 'package:firebase_app2/screen/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Detail"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: Center(
            child: Column(
          children: [
            Obx(
              () => CircleAvatar(
                radius: 7.h,
                backgroundImage: NetworkImage(homeController.data['img'] == null
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUtcO4YmGkZhf8rEs8DdPZYnLlPCpOF1pTMZMYf1lDHzaQFAqjUKPzRFdZaqDRuBuYKHo&usqp=CAU'
                    : '${homeController.data['img']}'),
              ),
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
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
