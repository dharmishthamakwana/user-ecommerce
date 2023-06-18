import 'package:firebase_app2/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtnumber = TextEditingController();
TextEditingController txtimg=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("User ditels"),backgroundColor: Colors.blueGrey.shade900,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: txtemail,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),

                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: txtname,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: txtnumber,
                decoration: InputDecoration(
                  hintText: "Enter your number",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),

                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: txtimg,
                decoration: InputDecoration(
                  hintText: "Enter your img",
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseHelper.firebaseHelper.adduser(
                      number: txtnumber.text,
                      name: txtname.text,
                      email: txtemail.text,
                      img: txtimg.text,


                    );
                    print("===========================================${txtemail.text}");
                  },
                  child: Text("ADD"))
            ],
          ),
        ),
      ),
    );
  }
}
