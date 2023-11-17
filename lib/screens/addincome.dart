import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/homescreen.dart';

class AddIncome extends StatelessWidget {
  AddIncome({Key? key}) : super(key: key);

  final TextEditingController dateController = TextEditingController();
  final RxString selectedValue = 'Netflix'.obs;

  List<String> dropdownItems = [
    'Netflix',
    'Youtube',
    'Snapchat',
    'Amazon Prime',
  ];

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dateController.text = picked.toLocal().toString().split(' ')[0];
    }
  }

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
              top: 100,
              left: 355,
              child: Image.asset('assets/image/Group19.png'),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 80, 0, 0),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
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
            Padding(
              padding: EdgeInsets.fromLTRB(30, 170, 0, 0),
              child: Container(
                width: 358,
                height: 500,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 35,
                      offset: Offset(0, 22),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 200, 0, 0),
                  child: Text(
                    'NAME',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: 0.72,
                    ),
                  ),
                ),
              ],
            ),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(58, 225, 0, 0),
                    child: Container(
                      width: 300,
                      child: Obx(
                            () => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            // Your decoration goes here
                          ),
                          elevation: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select game';
                            } else {
                              return null;
                            }
                          },
                          isExpanded: true,
                          hint: const Text("Favourite game"),
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
                            selectedValue.value = newValue ?? 'Netflix';
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 290, 0, 0),
                  child: Text(
                    'AMOUNT',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: 0.72,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 320, 0, 0),
                  child: Container(
                    width: 300,
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF438883),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF438883),
                            width: 1.0,
                          ),
                        ),
                        hintText: 'Enter the Amount',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 400, 0, 0),
                  child: Text(
                    'DATE',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: 0.72,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 430, 0, 0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF438883),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF438883),
                            width: 1.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: _selectDate,
                        ),
                      ),
                      controller: dateController,
                      onTap: _selectDate,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 20, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const HomeScreen());
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF438883)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Color(0xFF438883), width: 1.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
