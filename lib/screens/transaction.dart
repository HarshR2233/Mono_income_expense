import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CharData {
  final int day;
  final double price;

  CharData(this.day, this.price);
}

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  late List<CharData> incomeData;
  late List<CharData> expenseData;

  late List<CharData> selectedData;
  late String selectedDropdownValue;

  DateTime startDate = DateTime(2023, 1, 1);
  DateTime endDate = DateTime(2023, 12, 31);

  @override
  void initState() {
    super.initState();
    incomeData = [];
    expenseData = [];
    selectedData = [];
    selectedDropdownValue = 'Income';
    fetchDataFromFirestore(startDate, endDate);
  }

  Future<void> fetchDataFromFirestore(DateTime startDate, DateTime endDate) async {
    // Fetch income data from 'incomes' collection within the date range
    QuerySnapshot incomeSnapshot = await FirebaseFirestore.instance
        .collection('incomes')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .get();

    incomeData = incomeSnapshot.docs.map((doc) {
      String name = doc['name'];
      String amount = doc['amount'];
      Timestamp dateTimestamp = doc['date'];
      DateTime date = dateTimestamp.toDate();

      return CharData(date.day, double.parse(amount));
    }).toList();

    // Fetch expense data from 'expense' collection within the date range
    QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
        .collection('expense')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .get();

    expenseData = expenseSnapshot.docs.map((doc) {
      String name = doc['name'];
      String amount = doc['amount'];
      Timestamp dateTimestamp = doc['date'];
      DateTime date = dateTimestamp.toDate();

      return CharData(date.day, double.parse(amount));
    }).toList();

    selectedData = incomeData; // Initialize with income data

    setState(() {});
  }

  Future<void> _showFilterDialog() async {
    DateTime? newStartDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (newStartDate != null) {
      DateTime? newEndDate = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: newStartDate,
        lastDate: DateTime(2030),
      );

      if (newEndDate != null) {
        setState(() {
          startDate = newStartDate;
          endDate = newEndDate;
        });
        fetchDataFromFirestore(startDate, endDate);
      }
    }
  }

  final List<String> dropdownItems = [
    'Income',
    'Expense',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF438883),
        title: Text(
          'Statistics',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.04,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showFilterDialog,
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.3, top: screenHeight * 0.0001, right: screenHeight * 0.13),
              child: DropdownButtonFormField<String>(
                value: selectedDropdownValue,
                items: dropdownItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDropdownValue = newValue!;
                    selectedData = (selectedDropdownValue == 'Income') ? incomeData : expenseData;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.02),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF438883),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                ),
                style: TextStyle(
                  fontSize: screenWidth * 0.025,
                  color: Colors.black,
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                  size: 24,
                ),
                elevation: 16,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: screenHeight * 0.5,
              width: screenWidth * 0.9,
              child: SfCartesianChart(
                margin: const EdgeInsets.all(0),
                borderWidth: 0,
                borderColor: Colors.transparent,
                plotAreaBorderWidth: 0,
                primaryXAxis: NumericAxis(
                  minimum: 1,
                  maximum: 31,
                  isVisible: true,
                  interval: 1,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                ),
                primaryYAxis: NumericAxis(
                  minimum: 100,
                  maximum: 40000,
                  isVisible: true,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                ),
                series: <ChartSeries<CharData, int>>[
                  SplineAreaSeries(
                    dataSource: selectedData,
                    xValueMapper: (CharData data, _) => data.day,
                    yValueMapper: (CharData data, _) => data.price,
                    splineType: SplineType.natural,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF438883),
                        (selectedDropdownValue == 'Income') ? Colors.green.shade50 : Colors.red.shade50,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  SplineSeries(
                    color: const Color(0xFF438883),
                    width: 4,
                    markerSettings: const MarkerSettings(
                      color: Color(0xFF438883),
                      borderWidth: 5,
                      isVisible: true,
                      borderColor: Color(0xFF438883),
                    ),
                    dataSource: selectedData,
                    xValueMapper: (CharData data, _) => data.day,
                    yValueMapper: (CharData data, _) => data.price,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
