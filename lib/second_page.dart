import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart';

class second_page extends StatefulWidget {

  String name,email;
  second_page(this.name, this.email);
  @override
  State<second_page> createState() => _second_pageState();
}

class _second_pageState extends State<second_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details"),),
      body: Column(children: [
        Container(child: Text("User Name:${widget.name}"),),
        Container(child: Text("Email ID:${widget.email}"),),
        ElevatedButton(onPressed: () async {
          await GoogleSignIn().signOut();
           await FirebaseAuth.instance.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
               return google_login();
          },));

        }, child: Text("Logout"))
      ]),

    );
  }
}
