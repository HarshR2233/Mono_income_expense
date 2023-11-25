import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/model/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


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
    data = [
      CharData(17,20500),
      CharData(18,20684),
      CharData(19,20643),
      CharData(20,20997),
      CharData(21,20883),
      CharData(22,20635),
      CharData(23,20800),
      CharData(24,20500),
      CharData(25,20354),
      CharData(26,20354),
    ];
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
                  minimum: 17,
                  maximum: 26,
                  isVisible: false,
                  interval: 1,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                ),
                primaryYAxis: NumericAxis(
                  minimum: 19000,
                  maximum: 26000,
                  interval: 1000,
                  isVisible: false,
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