import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:income_expense/screens/bottom_navigation_bar.dart';

void main() async {
  runApp(
    MaterialApp(
      home: AddIncome(),
    ),
  );
}

class AddIncome extends StatefulWidget {
  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();

  CollectionReference incomeCollection = FirebaseFirestore.instance.collection('incomes');

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedValue = 'Netflix'.obs;

  List<String> dropdownItems = ['Netflix', 'Youtube', 'Snapchat', 'Amazon Prime'];

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the amount';
    }
    return null;
  }

  Future<void> _selectDate() async {
    DateTime currentDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: currentDate,
    );
    if (picked != null) {
      selectedDate(picked);
    }
  }


  Future<void> _submitIncome() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await incomeCollection.add({
        'amount': _amountController.text,
        'name': selectedValue.value,
        'date': Timestamp.fromDate(selectedDate.value),
      });
      print('Income submitted:');
      print('Amount: ${_amountController.text}');
      print('Name: ${selectedValue.value}');
      print('Date: ${selectedDate.value}');
      _amountController.clear();
      selectedValue('Netflix');

      Get.offAll(() => const CustomBottomNavigationBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Stack(
              children: [
                Positioned(
                  child: Image.asset('assets/image/Rectangle9.png'),
                ),
                Positioned(
                  top: screenHeight * 0.013,
                  left: screenWidth * 0.009,
                  child: Image.asset('assets/image/Ellipse7.png'),
                ),
                Positioned(
                  top: screenHeight * 0.013,
                  left: screenWidth * 0.045,
                  child: Image.asset('assets/image/Ellipse8.png'),
                ),
                Positioned(
                  top: screenHeight * 0.013,
                  left: screenWidth * 0.12,
                  child: Image.asset('assets/image/Ellipse9.png'),
                ),
                Positioned(
                  top: screenHeight * 0.104,
                  left: screenWidth * 0.840,
                  child: Image.asset('assets/image/Group19.png'),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.05, screenHeight * 0.08, 0, 0),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.20, screenHeight * 0.08, 0, 0),
                      child: Text(
                        'Add Income',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.036, screenHeight * 0.17, 0, 0),
                  child: Container(
                    width: screenWidth * 0.935,
                    height: screenHeight * 0.45,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x14000000),
                          blurRadius: screenWidth * 0.035,
                          offset: Offset(0, screenHeight * 0.022),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.13, screenHeight * 0.2, 0, 0),
                      child: Text(
                        'NAME',
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: screenWidth * 0.00072,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.13, screenHeight * 0.225, 0, 0),
                      child: Container(
                        width: screenWidth * 0.725,
                        child: Obx(
                              () => DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(right: screenWidth * 0.01, left: screenWidth * 0.01),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xFF438883), width: screenWidth * 0.001),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(screenWidth * 0.02),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xFF438883), width: screenWidth * 0.001),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(screenWidth * 0.02),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: const Color(0xFF438883), width: screenWidth * 0.001),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(screenWidth * 0.02),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: screenWidth * 0.001, color: Colors.red),
                                    borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                  ),
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
                                iconSize: screenWidth * 0.03,
                                iconEnabledColor: Colors.black,
                                icon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: screenWidth * 0.015,
                                ),
                                value: selectedValue.value,
                                items: dropdownItems.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  selectedValue(newValue ?? 'Netflix');
                                  },
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.13, screenHeight * 0.29, 0, 0),
                      child: Text(
                        'AMOUNT',
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: screenWidth * 0.00072,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.13, screenHeight * 0.32, 0, 0),
                      child: Container(
                        width: screenWidth * 0.725,
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          validator: _validateAmount,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color(0xFF438883),
                                width: screenWidth * 0.001,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color(0xFF438883),
                                width: screenWidth * 0.001,
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
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.13, screenHeight * 0.41, 0, 0),
                      child: Text(
                        'DATE',
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: screenWidth * 0.00072,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.13, screenHeight * 0.44, 0, 0),
                      child: Container(
                        width: screenWidth * 0.725,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color(0xFF438883),
                                width: screenWidth * 0.001,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color(0xFF438883),
                                width: screenWidth * 0.001,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: _selectDate,
                            ),
                          ),
                          controller: TextEditingController(
                              text: selectedDate.value.toLocal().toString().split(' ')[0]),
                          onTap: _selectDate,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.15, screenHeight * 0.02, 0, 0),
                      child: ElevatedButton(
                        onPressed: _submitIncome,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF438883)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                              side: BorderSide(color: const Color(0xFF438883), width: screenWidth * 0.001),
                            ),
                          ),
                        ),
                        child: const Text(
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
        ),
      ),
    );
  }
}
