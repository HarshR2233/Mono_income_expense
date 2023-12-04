import 'package:flutter/material.dart';
import 'package:income_expense/screens/onboarding.dart';
import 'package:income_expense/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/background_service.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'f3f64e9f2fff586a01247fd07f82da77f40543c7',
        appId: 'com.example.income_expense',
        messagingSenderId: '438021609629',
        projectId: 'mono-f023e',
      ));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => splash()),
        GetPage(name: '/onboarding', page: () => Onboarding()),
      ],
    ),
  );
  BackgroundService.start();
}
