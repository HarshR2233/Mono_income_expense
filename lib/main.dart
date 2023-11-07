import 'package:flutter/material.dart';
import 'package:income_expense/screens/onboarding.dart';
import 'package:income_expense/screens/splash_screen.dart';
import 'package:get/get.dart';


void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => splash()),
        GetPage(name: '/onboarding', page: () => onboarding()),
      ],
    ),
  );
}
