import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: SpinKitThreeBounce(
          color: Color.fromARGB(255, 154, 64, 4),  // You can customize the color
          size: 50.0,  // You can adjust the size as needed
        ),
      ),
    );
  }
}