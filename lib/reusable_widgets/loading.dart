import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        value: 0.3,
        color: Colors.greenAccent, //<-- SEE HERE
        backgroundColor: Colors.grey, //<-- SEE HERE
      ),
    );
  }
}
