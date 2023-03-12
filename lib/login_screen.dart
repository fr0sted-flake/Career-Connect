import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placement_portal/Resources/colors.dart';
import 'package:placement_portal/reusable_widgets/reusable_widgets.dart';
import 'package:placement_portal/signup_screen.dart';

import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("9C27B0"),
              hexStringToColor("009688")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.1, 20, MediaQuery.of(context).size.height * 0.1),
                    child: Column(children: <Widget>[
                      logoWidget("assets/images/download.webp"),
                      const SizedBox(
                        height: 30,
                      ),
                      reusableTextField("Enter Email Id", Icons.person_outline,
                          false, _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Password", Icons.lock_outline,
                          true, _passwordTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      signInSignUpButton(context, true, () {
                        FirebaseAuth.instance.signInWithEmailAndPassword
                          (email: _emailTextController.text, password: _passwordTextController.text).then((value) {
                          Navigator.push((context),
                              MaterialPageRoute(builder: (context) => const HomeScreen()));
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                        });
    }),
                      signUpOption(),
                      const Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Text("Or",style: TextStyle(color: Colors.white70),),
                      ),
                      signInWithGoogle(context)
                    ])))));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
}
}


TextEditingController _emailTextController = TextEditingController();
TextEditingController _passwordTextController = TextEditingController();