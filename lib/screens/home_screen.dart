import 'package:flutter/material.dart';
import 'package:placement_portal/screens/post_jobs_screen.dart';
import 'package:placement_portal/screens/browse_jobs_screen.dart';
import 'package:placement_portal/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal.shade200, Colors.lightGreen.shade200],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
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
                child: const Text("Your Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 20)),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) => const SeeJobs()));
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        border: Border.all(
                            color: Colors.lightBlueAccent, // Set border color
                            width: 1),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/first.png"),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(30)), // Set rounded corner radius
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 7,
                              color: Colors.black45,
                              offset: Offset(-10, -10))
                        ]),
                    child: Column(
                      children: const [
                        Icon(
                          IconData(0xf0135, fontFamily: 'MaterialIcons'),
                          size: 60,
                          color: Colors.black54,
                        ),
                        Text(
                          "Browse Available Jobs",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: 32),
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const PostJobs()));
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        border: Border.all(
                            color: Colors.lightBlueAccent, // Set border color
                            width: 1),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/second.png"),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(30)), // Set rounded corner radius
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 7,
                              color: Colors.black45,
                              offset: Offset(-10, -10))
                        ]),
                    child: Column(
                      children: const [
                        Icon(
                          IconData(0xf56a, fontFamily: 'MaterialIcons'),
                          size: 60,
                          color: Colors.black54,
                        ),
                        Text(
                          "Post A Job Vacancy",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: 32),
                        ),
                      ],
                    )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
