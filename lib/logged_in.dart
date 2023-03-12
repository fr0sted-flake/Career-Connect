import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Resources/colors.dart';

class LoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("9C27B0"),
              hexStringToColor("009688")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("See Jobs Posted"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Post Jobs"),
                ),
              ]),
        ),
      ),
    );
  }
}
