import 'dart:async';

import 'package:firebase_app2/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //Only Variable's
  TextEditingController txtSignInEmail = TextEditingController();
  TextEditingController txtSignInPass = TextEditingController();
  TextEditingController txtSignUpEmail = TextEditingController();
  TextEditingController txtSignUpPass = TextEditingController();

  GlobalKey<FormState> SignUpkey = GlobalKey<FormState>();
  GlobalKey<FormState> SignInkey = GlobalKey<FormState>();

  RxBool SignUp_password_vis = true.obs;
  RxBool SignIn_password_vis = true.obs;

  RxMap data = {}.obs;
  RxInt indexForBuyCollection=0.obs;

}