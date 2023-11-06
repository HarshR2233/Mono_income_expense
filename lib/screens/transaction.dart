import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/addincome.dart';


class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 70, 0, 0),
                child: IconButton(
                  onPressed: () {
                    Get.back(); // Navigate back using GetX
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(80, 70, 0, 0),
                child: Text(
                  'Transactions',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 70, 0, 0),
                child: Image.asset('assets/image/alt1.png'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 140, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => AddIncome()); // Navigate to AddIncome screen using GetX
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF438883)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Color(0xFF438883), width: 1.0),
                  ),
                ),
              ),
              child: const Text(
                'Day',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(125, 140, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => AddIncome()); // Navigate to AddIncome screen using GetX
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF438883)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Color(0xFF438883), width: 1.0),
                  ),
                ),
              ),
              child: const Text(
                'Week',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(215, 140, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => AddIncome()); // Navigate to AddIncome screen using GetX
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF438883)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Color(0xFF438883), width: 1.0),
                  ),
                ),
              ),
              child: const Text(
                'Month',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(320, 140, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => AddIncome()); // Navigate to AddIncome screen using GetX
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF438883)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Color(0xFF438883), width: 1.0),
                  ),
                ),
              ),
              child: const Text(
                'Year',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
