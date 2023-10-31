import 'package:flutter/material.dart';
import 'onboarding.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() =>  onboarding());
    });
  }
}

class splash extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFF438883),
                Color(0xFF438883),
              ],
            ),
          ),
          child: const Center(
            child: Text(
              'mono',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
                letterSpacing: -2,
              ),
            ),
          ),
        ),
    );
  }
}
