import 'package:flutter/material.dart';
import 'package:income_expense/screens/all_transaction.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _clearCollection(CollectionReference collection) async {
    QuerySnapshot snapshot = await collection.get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;

    for (QueryDocumentSnapshot doc in docs) {
      await doc.reference.delete();
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  final CollectionReference incomeCollection =
  FirebaseFirestore.instance.collection('incomes');

  final CollectionReference expenseCollection =
  FirebaseFirestore.instance.collection('expense');

  final CollectionReference balanceCollection =
  FirebaseFirestore.instance.collection('balance');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
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
              top: 95,
              left: 290,
              child: Image.asset('assets/image/bell1.png'),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05, top: 33),
              child: const Text(
                'Good Morning,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 8,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05, top: 35),
              child: const Text(
                'Harsh Rathod',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 7.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 160, screenWidth * 0.05, 0),
              child: Container(
                width: screenWidth - screenWidth * 0.1,
                height: 201,
                decoration: ShapeDecoration(
                  color: const Color(0xFF2E7E78),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.1, 186, screenWidth * 0.05, 0),
              child: const Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  letterSpacing: -0.32,
                ),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/image/chevron.png',
                  width: screenWidth - screenWidth * 0.1,
                  height: 393,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.10, 315, screenWidth * 0.10, 10),
              child: FutureBuilder<double>(
                future: _getTotalIncome(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7E78)),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    double totalIncome = snapshot.data ?? 0.0;
                    return Text(
                      '\$ ${totalIncome.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -1.50,
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.53, 315, screenWidth * 0.10, 15),
              child: FutureBuilder<double>(
                future: _getTotalExpense(),
                builder: (context, expenseSnapshot) {
                  if (expenseSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7E78)),
                    );
                  } else if (expenseSnapshot.hasError) {
                    return Text('Error: ${expenseSnapshot.error}');
                  } else {
                    double totalExpense = expenseSnapshot.data ?? 0.0;

                    return Text(
                      '\$ ${totalExpense.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -1.50,
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.10, 210, screenWidth * 0.10,  0),
              child: FutureBuilder<double>(
                future: _getProgrammaticTotalBalance(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7E78)),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    double totalBalance = snapshot.data ?? 0.0;
                    return Text(
                      '\$ ${totalBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -1.50,
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.008, top: 0),
              child: Image.asset(
                'assets/image/Frame5.png',
                width: 85,
                height: 600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 292, left: screenWidth * 0.17),
              child: const Text(
                'Income',
                style: TextStyle(
                  color: Color(0xFFD0E5E3),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.80,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: screenWidth * 0.40),
              child: Image.asset(
                'assets/image/Frame7.png',
                width: 110,
                height: 600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.60, top: 292),
              child: const Text(
                'Expenses',
                style: TextStyle(
                  color: Color(0xFFD0E5E3),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.10, 390, 0, 0),
                  child: const Text(
                    'Transaction History',
                    style: TextStyle(
                      color: Color(0xFF222222),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.36,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.2, 390, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => AllTransaction());
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 180, left: screenWidth * 0.6, right: screenWidth * 0.01),
              child: ElevatedButton(
                onPressed: () {
                  _clearData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF438883),
                ),
                child: const Text(
                  'Clear Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<double> _getProgrammaticTotalBalance() async {
    try {
      double totalIncome = await _getTotalIncome();
      double totalExpense = await _getTotalExpense();

      return totalIncome - totalExpense;
    } catch (e) {
      print('Error calculating programmatic total balance: $e');
      return 0.0;
    }
  }

  Future<double> _getTotalIncome() async {
    try {
      QuerySnapshot incomeSnapshot = await incomeCollection.get();
      List<QueryDocumentSnapshot> incomeDocs = incomeSnapshot.docs;

      double totalIncome = 0.0;

      for (QueryDocumentSnapshot doc in incomeDocs) {
        var amount = doc['amount'];

        if (amount is num) {
          totalIncome += amount.toDouble();
        } else if (amount is String) {
          totalIncome += double.tryParse(amount) ?? 0.0;
        }
      }

      return totalIncome;
    } catch (e) {
      print('Error fetching total income: $e');
      return 0.0;
    }
  }

  Future<double> _getTotalExpense() async {
    try {
      QuerySnapshot expenseSnapshot = await expenseCollection.get();
      List<QueryDocumentSnapshot> expenseDocs = expenseSnapshot.docs;

      double totalExpense = 0.0;

      for (QueryDocumentSnapshot doc in expenseDocs) {
        var amount = doc['amount'];

        if (amount is num) {
          totalExpense += amount.toDouble();
        } else if (amount is String) {
          totalExpense += double.tryParse(amount) ?? 0.0;
        }
      }

      return totalExpense;
    } catch (e) {
      print('Error fetching total expense: $e');
      return 0.0;
    }
  }

  Future<void> _clearData() async {
    List<Map<String, dynamic>> backupData = [];

    try {
      backupData = await _backupData();

      await _clearCollection(incomeCollection);

      await _clearCollection(expenseCollection);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Data Cleared Successfully',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: const Color(0xFF438883),
        ),
      );
      setState(() {});
    } catch (e) {
      print('Error clearing data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Error clearing data',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<Map<String, dynamic>>> _backupData() async {
    List<Map<String, dynamic>> backupData = [];

    try {
      QuerySnapshot incomeSnapshot = await incomeCollection.get();
      QuerySnapshot expenseSnapshot = await expenseCollection.get();

      List<QueryDocumentSnapshot> incomeDocs = incomeSnapshot.docs;
      List<QueryDocumentSnapshot> expenseDocs = expenseSnapshot.docs;

      for (QueryDocumentSnapshot doc in incomeDocs) {
        backupData.add(doc.data() as Map<String, dynamic>);
      }

      for (QueryDocumentSnapshot doc in expenseDocs) {
        backupData.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error backing up data: $e');
    }

    return backupData;
  }
}

enum TransactionType { incomes, expense }

class TransactionEntry {
  final TransactionType name;
  final double amount;
  final String date;

  TransactionEntry({
    required this.name,
    required this.amount,
    required this.date,
  });
}
