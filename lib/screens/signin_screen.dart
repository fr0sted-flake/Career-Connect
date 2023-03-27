import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:placement_portal/screens/home_screen.dart';
import 'package:placement_portal/screens/signup_screen.dart';
import 'package:placement_portal/reusable_widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = '/login';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  void loginUser() {
    context
        .read<FirebaseAuthMethods>()
        .loginWithEmail(
          email: _emailTextController.text,
          password: _passwordTextController.text,
          context: context,
        )
        .then((value) {
      Navigator.pop((context),
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF9C27B0), Color(0xFF009688)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20,
                        MediaQuery.of(context).size.height * 0.1,
                        20,
                        MediaQuery.of(context).size.height * 0.1),
                    child: Column(children: <Widget>[
                      logoWidget("assets/images/icon.png"),
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90)),
                        child: ElevatedButton(
                          onPressed: () {
                            loginUser();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.black26;
                                }
                                return Colors.white;
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?",
                              style: TextStyle(color: Colors.white70)),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SignUpScreen.routeName);
                            },
                            child: const Text(
                              " Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Text(
                          "Or",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90)),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<FirebaseAuthMethods>()
                                  .signInWithGoogle(context);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.black26;
                                  }
                                  return Colors.white;
                                }),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)))),
                            icon: const FaIcon(FontAwesomeIcons.google,
                                color: Colors.redAccent),
                            label: const Text(
                              'Sign In With Google',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ))
                    ])))));
  }
}
