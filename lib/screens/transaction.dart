import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/addincome.dart';
import 'package:income_expense/screens/profile.dart';


class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final TextEditingController dateController = TextEditingController();

  final RxString selectedValue = 'Expense'.obs;

  List<String> dropdownItems = [
    'Expense',
    'Income',
  ];

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
                Get.to(() => Profile()); // Navigate to AddIncome screen using GetX
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
          Padding(padding: const EdgeInsets.fromLTRB(285, 200, 0, 0),
            child:Container(
              width: 100,
              child:Obx(
                () => DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: false,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF438883), width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF438883), width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF438883), width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  elevation: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    } else {
                      return null;
                    }
                  },
                  iconSize: 30,
                  iconEnabledColor: Colors.black,
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 15,
                  ),
                  value: selectedValue.value,
                  items: dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    selectedValue.value = newValue ?? 'Expense';
                  },
                ),
            ),
            ),
          ),
          Padding(padding: const EdgeInsets.fromLTRB(10, 270, 0, 0),
          child: Positioned(
            top: 200,
              left: 10,
              child: Image.asset('assets/image/Map.png')
          ),
          ),
          Padding(padding: const EdgeInsets.only(left:5 ,top: 268),
          child: Positioned(
            top: 200,
            left: 10,
            child: Image.asset('assets/image/Vector1.png'),
          ),
          ),
          Padding(padding: const EdgeInsets.only(left:140 ,top: 313),
            child: Positioned(
              top: 200,
              left: 10,
              child: Image.asset('assets/image/Map1.png'),
            ),
          ),
          Padding(padding: const EdgeInsets.only(left:154 ,top: 328),
            child: Positioned(
              top: 200,
              left: 10,
              child: Image.asset('assets/image/Line1.png'),
            ),
          ),
          Padding(padding: const EdgeInsets.only(left:114 ,top: 258),
            child: Positioned(
              top: 200,
              left: 10,
              child: Image.asset('assets/image/Rectangle 6.png'),
            ),
          ),
          Padding(padding: const EdgeInsets.only(left:350 ,top: 450),
            child: Positioned(
              top: 200,
              left: 10,
              child: Image.asset('assets/image/sort1.png'),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 25,top: 450),
          child: Text(
            'Top Spending',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
              letterSpacing: -0.36,
            ),
          ),
          ),
        ],
      ),
    );
  }
}
