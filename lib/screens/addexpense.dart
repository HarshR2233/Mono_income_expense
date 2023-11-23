import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:income_expense/screens/bottom_navigation_bar.dart';

void main() async {
  runApp(
    MaterialApp(
      home: AddExpense(),
    ),
  );
}

class AddExpense extends StatefulWidget {
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();

  CollectionReference expenseCollection = FirebaseFirestore.instance.collection('expense');

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
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectedDate(picked);
    }
  }

  DocumentReference? lastAddedExpense;

  Future<void> _submitExpense() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      DocumentReference addedExpense = await expenseCollection.add({
        'amount': _amountController.text,
        'name': selectedValue.value,
        'date': Timestamp.fromDate(selectedDate.value),
      });

      lastAddedExpense = addedExpense;

      print('Expense submitted:');
      print('Amount: ${_amountController.text}');
      print('Name: ${selectedValue.value}');
      print('Date: ${selectedDate.value}');
      _amountController.clear();
      selectedValue('Netflix'); // Resetting the value after submission

      Get.offAll(() => CustomBottomNavigationBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                    padding: const EdgeInsets.fromLTRB(25, 80, 0, 0),
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
                      'Add Epense',
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
                padding: const EdgeInsets.fromLTRB(30, 170, 0, 0),
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
                      ),
                    ],
                  ),
                ),
              ),
              const Row(
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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(58, 225, 0, 0),
                    child: Container(
                      width: 300,
                      child: Obx(
                            () => DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.only(right: 10, left: 10),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF438883), width: 1.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF438883), width: 1.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF438883), width: 1.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(10),
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
                            selectedValue(newValue ?? 'Netflix');
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
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
                    padding: const EdgeInsets.fromLTRB(60, 320, 0, 0),
                    child: Container(
                      width: 300,
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        validator: _validateAmount,
                        decoration: const InputDecoration(
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
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 410, 0, 0),
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
                    padding: const EdgeInsets.fromLTRB(60, 440, 0, 0),
                    child: Container(
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF438883),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF438883),
                              width: 1.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: _selectDate,
                          ),
                        ),
                        controller: TextEditingController(text: selectedDate.value.toLocal().toString().split(' ')[0]),
                        onTap: _selectDate,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                    child: ElevatedButton(
                      onPressed: _submitExpense,
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
    );
  }
}

