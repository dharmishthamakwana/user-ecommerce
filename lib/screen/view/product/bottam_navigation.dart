import 'package:firebase_app2/screen/view/product/buy_screen.dart';
import 'package:firebase_app2/screen/view/product/cart_screen.dart';
import 'package:firebase_app2/screen/view/product/home_Screen.dart';
import 'package:firebase_app2/screen/view/userdetail/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../userdetail/user_detailadd_screen.dart';

class Bottam extends StatefulWidget {
  const Bottam({Key? key}) : super(key: key);

  @override
  State<Bottam> createState() => _BottamState();
}

class _BottamState extends State<Bottam> {
  int selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    BuyProduct(),
    User()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Search',
                  backgroundColor: Colors.blueGrey.shade800),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  label: 'cart',
                  backgroundColor: Colors.blueGrey.shade800),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Buy product',
                backgroundColor: Colors.blueGrey.shade800,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.blueGrey.shade800,
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: selectedIndex,
            selectedItemColor: Colors.grey.shade50,
            iconSize: 30,
            onTap: _onItemTapped,
            elevation: 8),
        body: _widgetOptions.elementAt(selectedIndex),
      ),
    );
  }
}
