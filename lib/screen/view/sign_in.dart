import 'package:firebase_app2/screen/controller/home_controller.dart';
import 'package:firebase_app2/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.txtSignInEmail.clear();
    homeController.txtSignInPass.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: homeController.SignInkey,
          child: Stack(
            children: [
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Container(
              //     height: Get.height / 3,
              //     width: Get.width,
              //     child: Image.asset(
              //       "assets/image/1.jpeg",
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
              Container(
                height: Get.height,
                width: Get.width,
                // color: Colors.red,
                margin:
                    EdgeInsets.only(top: Get.width / 1.6, left: Get.width / 12),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 33.sp,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.width / 60),
                          child: Text(
                            "Sign in to your Registered Account.",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: Get.height / 150,
                          width: Get.width / 7,
                          margin: EdgeInsets.only(top: Get.width / 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent.shade100,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.width / 12),
                          child: Text(
                            "Email Address",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: Get.width / 30, right: Get.width / 12),
                            child: TextFormField(
                              controller: homeController.txtSignInEmail,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.blueAccent.shade100,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent.shade100),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent.shade100),
                                    borderRadius: BorderRadius.circular(9)),
                                hintText: "Enter Email Ex. xyz123@gmail.com",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.blueAccent.shade100,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Email";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return "Please Enter Valid Email";
                                }
                                return null;
                              },
                            )),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.width / 15),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.width / 30, right: Get.width / 12),
                          child: Obx(
                            () => TextFormField(
                              controller: homeController.txtSignInPass,
                              keyboardType: TextInputType.name,
                              cursorColor: Colors.blueAccent.shade100,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 20),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent.shade100),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent.shade100),
                                    borderRadius: BorderRadius.circular(9)),
                                hintText: "Enter Password",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.blueAccent.shade100,
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      homeController.SignIn_password_vis.value =
                                          !homeController
                                              .SignIn_password_vis.value;
                                    },
                                    child: Icon(
                                      homeController.SignIn_password_vis.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.blueAccent.shade100,
                                    )),
                              ),
                              obscureText:
                                  homeController.SignIn_password_vis.value,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Password";
                                } else if (value.length < 6) {
                                  return "Please Enter Minimum 6 Letter";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.width / 30, right: Get.width / 9),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                color: Colors.blueAccent.shade100,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (homeController.SignInkey.currentState!
                              .validate()) {
                            var isLogin = await FirebaseHelper.firebaseHelper
                                .signIn(
                                    email: homeController.txtSignInEmail.text,
                                    password: homeController
                                        .txtSignInPass.value.text);
                            Get.offNamed('bottam');
                          }
                        },
                        child: Container(
                          height: Get.height / 18,
                          width: Get.width / 3,
                          margin: EdgeInsets.only(
                              top: Get.width / 12, right: Get.width / 12),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blueAccent.shade100,
                                Colors.blueAccent.shade200,
                              ]),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blueAccent.shade100,
                                    blurRadius: 15,
                                    offset: Offset(0, 0))
                              ],
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.width / 21, right: Get.width / 12),
                        child: Text(
                          "-Or Sign In With",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 9.sp,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.width / 21, right: Get.width / 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Don't Have Account",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 90,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('SignUp');
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
