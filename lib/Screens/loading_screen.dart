import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoadingScreen();

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Image.asset(
              'assets/images/Icon.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          const SpinKitRing(
            color: Color(0xFFC63E37),
            size: 50,
          )
        ],
      ),
    );
  }
}
