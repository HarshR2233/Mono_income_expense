import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/bottom_navigation_bar.dart';
import 'package:income_expense/screens/login.dart';
import 'package:income_expense/screens/homescreen.dart';

class OnboardingController extends GetxController {}

class Onboarding extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset('assets/image/Rectangle.png'),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset('assets/image/Oval.png'),
                    ),
                    Positioned(
                      top: 50,
                      left: 50,
                      child: Image.asset('assets/image/Man.png'),
                    ),
                    Positioned(
                      top: 500,
                      left: 0,
                      child: Image.asset('assets/image/Manshadow.png'),
                    ),
                    Positioned(
                      top: 60,
                      left: 40,
                      child: Image.asset('assets/image/Coint.png'),
                    ),
                    Positioned(
                      top: 110,
                      left: 260,
                      child: Image.asset('assets/image/Donut.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'Spend Smarter                  Save More',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF438883),
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                        letterSpacing: -0.72,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 64,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: 10,
                ),
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return CustomBottomNavigationBar();
                      },
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
