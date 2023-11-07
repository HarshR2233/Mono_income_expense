import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/homescreen.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              child: Image.asset('assets/image/Rectangle9.png'),
            ),
            Positioned(
              top: 8,
              left: 3,
              child: Image.asset('assets/image/Ellipse7.png'),
            ),
            Positioned(
              top: 8,
              left: 50,
              child: Image.asset('assets/image/Ellipse8.png'),
            ),
            Positioned(
              top: 8,
              left: 120,
              child: Image.asset('assets/image/Ellipse9.png'),
            ),
            Positioned(
              top: 95,
              left: 350,
              child: Image.asset('assets/image/bell1.png'),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 80, 0, 0),
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => HomeScreen()); // Navigate back using GetX
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                  child: Text(
                    'Add Income',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
                  top: 220,
                  left: 140,
                  child: Image.asset('assets/image/Ellipse62.png'),
                ),
                Positioned(
                  top: 220,
                  left: 140,
                  child: Image.asset('assets/image/Ellipse63.png'),
                ),
                Positioned(
                  top: 230,
                  left: 140,
                  child: Image.asset('assets/image/Woman 1.png'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 350, left: 140),
              child: Text(
                'Harsh Rathod',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 380, left: 150),
              child: Text(
                '@harsh_rathod',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
