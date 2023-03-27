import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal.shade200, Colors.lightGreen.shade200],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your Email is:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                Text(
                  user.email!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Provider:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                Text(
                  user.providerData[0].providerId,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Your user ID is:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                Text(
                  user.uid,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                const SizedBox(
                  height: 15,
                ),
                // display the button only when the user email is not verified
                if (!user.emailVerified)
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<FirebaseAuthMethods>()
                          .sendEmailVerification(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.black26;
                          }
                          return Colors.white;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                    child: const Text(
                      'Verify Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signOut(context)
                        .then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route route) => false);
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black26;
                        }
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .deleteAccount(context)
                        .then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route route) => false);
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black26;
                        }
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)))),
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
