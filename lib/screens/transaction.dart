import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CharData {
  final int day;
  final double price;

  CharData(this.day, this.price);

  int get x => day;
  double get y => price;
}


class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  late List<CharData> incomeData;
  late List<CharData> expenseData;

  bool isLoading = false;

  double findMinXValue(List<CharData> data) {
    return data
        .map((datum) => datum.day)
        .reduce((value, element) => value < element ? value : element)
        .toDouble();
  }

  double findMaxXValue(List<CharData> data) {
    return data
        .map((datum) => datum.day)
        .reduce((value, element) => value > element ? value : element)
        .toDouble();
  }

  double findMinYValue(List<CharData> data) {
    return data
        .map((datum) => datum.price)
        .reduce((value, element) => value < element ? value : element);
  }

  double findMaxYValue(List<CharData> data) {
    return data
        .map((datum) => datum.price)
        .reduce((value, element) => value > element ? value : element);
  }

  late List<CharData> selectedData;
  late String selectedDropdownValue;
  late String selectedFilter;

  DateTime startDate = DateTime(2023, 1, 1);
  DateTime endDate = DateTime(2023, 12, 31);

  @override
  void initState() {
    super.initState();
    incomeData = [];
    expenseData = [];
    selectedData = [];
    selectedDropdownValue = 'Income';
    selectedFilter = 'Days';
    fetchDataFromFirestore(startDate, endDate);
  }

  Future<void> fetchDataFromFirestore(DateTime startDate, DateTime endDate) async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot incomeSnapshot = await FirebaseFirestore.instance
        .collection('incomes')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .orderBy('date')
        .get();

    incomeData = incomeSnapshot.docs.map((doc) {
      String name = doc['name'];
      String amount = doc['amount'];
      Timestamp dateTimestamp = doc['date'];
      DateTime date = dateTimestamp.toDate();

      return CharData(date.day, double.parse(amount));
    }).toList();

    QuerySnapshot expenseSnapshot = await FirebaseFirestore.instance
        .collection('expense')
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .orderBy('date')
        .get();

    expenseData = expenseSnapshot.docs.map((doc) {
      String name = doc['name'];
      String amount = doc['amount'];
      Timestamp dateTimestamp = doc['date'];
      DateTime date = dateTimestamp.toDate();

      return CharData(date.day, double.parse(amount));
    }).toList();

    selectedData =
    (selectedDropdownValue == 'Income') ? incomeData : expenseData;
    applyFilter();

    setState(() {
      isLoading = false;
    });
  }

  void applyFilter() {
    if (selectedFilter == 'Days') {
      selectedData =
      (selectedDropdownValue == 'Income') ? incomeData : expenseData;
    } else if (selectedFilter == 'Weekly') {
      selectedData = aggregateDataBy(selectedData, (data) => data.day ~/ 7,
              (groupedData) {
            int weekDay = groupedData[0].day;
            double totalAmount =
            groupedData.map((data) => data.price).reduce((a, b) => a + b);
            return CharData(weekDay, totalAmount);
          });
    } else if (selectedFilter == 'Monthly') {
      selectedData = aggregateDataBy(selectedData, (data) => data.day ~/ 30,
              (groupedData) {
            int monthDay = groupedData[0].day;
            double totalAmount =
            groupedData.map((data) => data.price).reduce((a, b) => a + b);
            return CharData(monthDay, totalAmount);
          });
    } else if (selectedFilter == 'Yearly') {
      selectedData = aggregateDataBy(selectedData, (data) => data.day ~/ 365,
              (groupedData) {
            int yearDay = groupedData[0].day;
            double totalAmount =
            groupedData.map((data) => data.price).reduce((a, b) => a + b);
            return CharData(yearDay, totalAmount);
          });
    }
  }

  List<CharData> aggregateDataBy(List<CharData> data, int Function(CharData) groupKey,
      CharData Function(List<CharData>) aggregator) {
    Map<int, List<CharData>> groupedData = {};

    for (var datum in data) {
      int key = groupKey(datum);
      if (!groupedData.containsKey(key)) {
        groupedData[key] = [];
      }
      groupedData[key]!.add(datum);
    }

    return groupedData.values.map(aggregator).toList();
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'Days';
                      applyFilter();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedFilter == 'Days'
                        ? const Color(0xFF438883)
                        : Colors.transparent,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Days'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'Weekly';
                      applyFilter();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedFilter == 'Weekly' ? const Color(0xFF438883) : Colors.transparent,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Weekly'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'Monthly';
                      applyFilter();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedFilter == 'Monthly' ? const Color(0xFF438883) : Colors.transparent,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Monthly'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = 'Yearly';
                      applyFilter();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedFilter == 'Yearly' ? const Color(0xFF438883) : Colors.transparent,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Yearly'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 200),
              child: DropdownButton<String>(
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
                    selectedData = (selectedDropdownValue == 'Income')
                        ? incomeData
                        : expenseData;
                    applyFilter();
                  });
                },
                style: TextStyle(
                  fontSize: screenWidth * 0.020,
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
              height: screenHeight * 0.3,
              width: screenWidth * 0.9,
              child: isLoading ? const Center(
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Color(0xFF2E7E78)),
                ),
              ): selectedData.isNotEmpty ? SfCartesianChart(
                margin: const EdgeInsets.all(0),
                borderWidth: 0,
                borderColor: Colors.transparent,
                plotAreaBorderWidth: 0,
                primaryXAxis: NumericAxis(
                  minimum: findMinXValue(selectedData),
                  maximum: findMaxXValue(selectedData),
                  isVisible: false,
                  interval: 1,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                ),
                primaryYAxis: NumericAxis(
                  minimum: findMinXValue(selectedData),
                  maximum: findMaxXValue(selectedData),
                  isVisible: false,
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                ),
                series: <ChartSeries<CharData, int>>[
                  SplineAreaSeries(
                    dataSource: selectedData,
                    xValueMapper: (CharData data, _) => data.day,
                    yValueMapper: (CharData data, _) => data.price,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: false,
                    ),
                    splineType: SplineType.natural,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF438883),
                        (selectedDropdownValue == 'Income')
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  SplineSeries<CharData, int>(
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
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point,
                      dynamic series, int pointIndex,
                      int seriesIndex) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF438883),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xFF438883), blurRadius: 5.0),
                        ],
                      ),
                      child: Text(
                        'Day: ${data.x}\nPrice: ${data.y}',
                        style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ): const Center(
                child:  Text(
                  'No data available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Text(
                      'Top Spending Items',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  for (var item in getTopSpendingItems(selectedData))
                    ListTile(
                      title: Text(
                          '${item.day}: \$${item.price.toStringAsFixed(2)}'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<CharData> getTopSpendingItems(List<CharData> data) {
    List<CharData> sortedData = List.from(data);
    sortedData.sort((a, b) {
      int priceComparison = b.price.compareTo(a.price);
      if (priceComparison == 0) {
        return a.day.compareTo(b.day);
      }
      return priceComparison;
    });
    List<CharData> topItems = sortedData.take(4).toList();
    return topItems;
  }
}
