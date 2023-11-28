import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Image.asset('assets/image/Rectangle9.png'),
          ),
          Positioned(
            top: screenHeight * 0.01,
            left: screenWidth * 0.005,
            child: Image.asset('assets/image/Ellipse7.png'),
          ),
          Positioned(
            top: screenHeight * 0.01,
            left: screenWidth * 0.05,
            child: Image.asset('assets/image/Ellipse8.png'),
          ),
          Positioned(
            top: screenHeight * 0.01,
            left: screenWidth * 0.12,
            child: Image.asset('assets/image/Ellipse9.png'),
          ),
          Positioned(
            top: screenHeight * 0.11,
            left: screenWidth * 0.80,
            child: Image.asset('assets/image/bell1.png'),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.10, screenHeight * 0.1, 0, 0),
                child: IconButton(
                  onPressed: () {
                    Get.back(); // Navigate back using GetX
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.20, screenHeight * 0.1, 0, 0),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Positioned(
                top: screenHeight * 0.24,
                left: screenWidth * 0.35,
                child: Image.asset('assets/image/Ellipse62.png'),
              ),
              Positioned(
                top: screenHeight * 0.24,
                left: screenWidth * 0.35,
                child: Image.asset('assets/image/Ellipse63.png'),
              ),
              Positioned(
                top: screenHeight * 0.24,
                left: screenWidth * 0.35,
                child: Image.asset('assets/image/Woman 1.png'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.38, left: screenWidth * 0.35),
            child: Text(
              'Harsh Rathod',
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.055,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.41, left: screenWidth * 0.40),
            child: Text(
              '@harsh_rathod',
              style: TextStyle(
                color: Colors.blue,
                fontSize: screenWidth * 0.035,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
