import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:income_expense/screens/bottom_navigation_bar.dart';
import 'package:income_expense/screens/login.dart';
import 'package:income_expense/screens/homescreen.dart';

class OnboardingController extends GetxController {
}

class onboarding extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Positioned(
                  child: Image.asset('assets/image/Rectangle.png'),
                ),
                Positioned(
                  top: 9,
                  left: 0,
                  child: Image.asset('assets/image/Oval.png'),
                ),
                Positioned(
                  top: 125,
                  left: 63,
                  child: Image.asset('assets/image/Man.png'),
                ),
                Positioned(
                  top: 575,
                  left: -3,
                  child: Image.asset('assets/image/Manshadow.png'),
                ),
                Positioned(
                  top: 135,
                  left: 60,
                  child: Image.asset('assets/image/Coint.png'),
                ),
                Positioned(
                  top: 185,
                  left: 270,
                  child: Image.asset('assets/image/Donut.png'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 301,
                child: Text(
                  'Spend Smarter Save More',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF438883),
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    letterSpacing: -0.72,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            width: 358,
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFF68AEA9), Color(0xFF3E8681)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return CustomBottomNavigationBar();
                }
                ));
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0.60,
                  letterSpacing: -0.36,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(16),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const login();
                          },
                      ));
                      },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Color(0xFF438883),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
