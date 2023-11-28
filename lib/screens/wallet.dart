import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.23,
          screenHeight * 0.1,
          0,
          0,
        ),
        child: Text(
          'Hi, Feature not available',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
