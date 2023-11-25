import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/model/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  late List<CharData> data;

  @override
  void initState(){
    super.initState();
    data = [];
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    // Fetch data from 'incomes' collection
    QuerySnapshot incomeSnapshot =
    await FirebaseFirestore.instance.collection('incomes').get();

    List<CharData> incomeData = incomeSnapshot.docs.map((doc) {
      String name = doc['name']; // Adjust 'name' to your actual field name
      String amount = doc['amount']; // Adjust 'amount' to your actual field name
      Timestamp dateTimestamp = doc['date']; // Adjust 'date' to your actual field name
      DateTime date = dateTimestamp.toDate();

      return CharData(date.day, double.parse(amount));
    }).toList();

    // Fetch data from 'expense' collection
    QuerySnapshot expenseSnapshot =
    await FirebaseFirestore.instance.collection('expense').get();

    List<CharData> expenseData = expenseSnapshot.docs.map((doc) {
      String name = doc['name']; // Adjust 'name' to your actual field name
      String amount = doc['amount']; // Adjust 'amount' to your actual field name
      Timestamp dateTimestamp = doc['date']; // Adjust 'date' to your actual field name
      DateTime date = dateTimestamp.toDate();

      return CharData(date.day, double.parse(amount));
    }).toList();

    data = [...incomeData, ...expenseData];

    setState(() {});
  }

  final TextEditingController dateController = TextEditingController();

  final RxString selectedValue = 'Expense'.obs;

  List<String> dropdownItems = [
    'Expense',
    'Income',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xFF438883) ,
        title: const Text('Statistics',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SfCartesianChart(
                margin: const EdgeInsets.all(0),
                borderWidth: 0,
                borderColor: Colors.transparent,
                plotAreaBorderWidth: 0,
                primaryXAxis: NumericAxis(
                  minimum: 1,
                  maximum: 20,
                  isVisible: true,
                  interval: 1,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                ),
                primaryYAxis: NumericAxis(
                  minimum: 10,
                  maximum: 30000,
                  isVisible: true,
                  interval: 1,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                ),
                series: <ChartSeries<CharData, int>>[
                  SplineAreaSeries(
                    dataSource: data,
                    xValueMapper:(CharData data, _)=> data.day,
                    yValueMapper:(CharData data, _)=>data.price,
                    splineType: SplineType.natural,
                    gradient:LinearGradient(
                      colors: [
                        const Color(0xFF438883),
                        Colors.green.shade50,
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
                    dataSource: data,
                    xValueMapper: (CharData data, _) => data.day,
                    yValueMapper: (CharData data, _) => data.price,
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}