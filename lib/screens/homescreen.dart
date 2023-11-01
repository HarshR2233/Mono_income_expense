import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            const Padding(
                padding: EdgeInsets.only(left: 20),
              child: Text(
                  'Good Morning,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 8,
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(left: 20),
              child: Text(
                'Harsh Rathod',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 7.5,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 160, 0, 0),
              child: Container(
                width: 374,
                height: 201,
                decoration: ShapeDecoration(
                  color: const Color(0xFF2E7E78),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                ),
              ),
            const Padding(
                padding: EdgeInsets.fromLTRB(45, 186, 0, 0),
              child: Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  letterSpacing: -0.32,
                ),
              ),
            ),
            Row(
              children: [
                Image.asset('assets/image/chevron.png',
                  width: 300,
                  height: 393,
                ),
                Image.asset('assets/image/Group8.png',
                  width: 99,
                  height: 50,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(45, 210, 0, 0),
                child: Text(
                  '\$ 2,548.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: -1.50,
                  ),
                )
            ),
            Row(
              children: [
                Image.asset('assets/image/Frame5.png',
                  width: 110,
                  height: 600,
                ),
                  const Text(
                    'Income',
                    style: TextStyle(
                      color: Color(0xFFD0E5E3),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.80,
                      height: 0,
                    ),
                  ),
                Image.asset('assets/image/Frame7.png',
                  width: 110,
                  height: 600,
                ),
                const Text(
                  'Expenses',
                  style: TextStyle(
                    color: Color(0xFFD0E5E3),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.80,
                    height: 0,
                  ),
                ),
              ],
            )
          ],
      ),
    );
  }
}
