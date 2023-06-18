import 'package:firebase_app2/screen/modal/Product_modal.dart';
import 'package:firebase_app2/screen/view/Splesh_Screen.dart';
import 'package:firebase_app2/screen/view/product/bottam_navigation.dart';
import 'package:firebase_app2/screen/view/product/cart_screen.dart';
import 'package:firebase_app2/screen/view/product/home_Screen.dart';
import 'package:firebase_app2/screen/view/sign_in.dart';
import 'package:firebase_app2/screen/view/sign_up.dart';
import 'package:firebase_app2/screen/view/userdetail/user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'screen/view/product/buy_screen.dart';
import 'screen/view/product/product_detail_screens.dart';
import 'screen/view/userdetail/user_detailadd_screen.dart';

List<ProductModal> p1 = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (p0) => SplashPage(),
          'SignIn': (p0) => SignInPage(),
          'SignUp': (p0) => SignUpPage(),
          'User': (p0) => User(),
          'Home': (p0) => HomeScreen(),
          'product': (p0) => ProductDetail(),
          'cart': (p0) => CartScreen(),
          'buy': (p0) => BuyProduct(),
          'bottam': (p0) => Bottam(),
          'user': (p0) => UserDetail(),
        },
      ),
    ),
  );
}
