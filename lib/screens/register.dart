import 'package:flutter/material.dart';

class register extends StatelessWidget {
  const register({super.key});

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
                child: Image.asset('assets/image/Ellipse9.png')
            ),
          ],
        ),
      )
    );
  }
}
