import 'package:flutter/material.dart';
import 'package:income_expense/screens/all_transaction.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final CollectionReference incomeCollection =
  FirebaseFirestore.instance.collection('incomes');

  final CollectionReference expenseCollection =
  FirebaseFirestore.instance.collection('expense');

  final CollectionReference balanceCollection =
  FirebaseFirestore.instance.collection('balance');

  @override
  Widget build(BuildContext context) {

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
              left: 350,
              child: Image.asset('assets/image/bell1.png'),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 33),
              child: Text(
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
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 35),
              child: Text(
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
              padding: const EdgeInsets.fromLTRB(20, 160, 0, 0),
              child: Container(
                width: 374,
                height: 201,
                decoration: ShapeDecoration(
                  color: const Color(0xFF2E7E78),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(45, 186, 0, 0),
              child: Text(
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
                  width: 300,
                  height: 393,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 5),
              child: Image.asset(
                'assets/image/Frame5.png',
                width: 110,
                height: 600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(47, 320, 0, 0),
              child: FutureBuilder<double>(
                future: _getTotalIncome(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    double totalIncome = snapshot.data ?? 0.0;
                    return Text(
                      '\$ ${totalIncome.toStringAsFixed(2)}',
                      // Display total income
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
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
              padding: const EdgeInsets.fromLTRB(238, 320, 0, 0),
              child: FutureBuilder<double>(
                future: _getTotalExpense(),
                builder: (context, expenseSnapshot) {
                  if (expenseSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (expenseSnapshot.hasError) {
                    return Text('Error: ${expenseSnapshot.error}');
                  } else {
                    double totalExpense = expenseSnapshot.data ?? 0.0;

                    return Text(
                      '\$ ${totalExpense.toStringAsFixed(2)}',
                      // Display total income
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
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
              padding: const EdgeInsets.fromLTRB(45, 210, 0, 0),
              child: FutureBuilder<double>(
                future: _getProgrammaticTotalBalance(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    double totalBalance = snapshot.data ?? 0.0;
                    return Text(
                      '\$ ${totalBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
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
            const Padding(
              padding: EdgeInsets.only(top: 295, left: 70),
              child: Text(
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
              padding: const EdgeInsets.only(top: 5, left: 190),
              child: Image.asset(
                'assets/image/Frame7.png',
                width: 110,
                height: 600,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 260, top: 297),
              child: Text(
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 390, 0, 0),
                  child: Text(
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
                  padding: const EdgeInsets.fromLTRB(150, 390, 0, 0),
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
              padding: const EdgeInsets.only(left: 190, top: 600),
              child: SizedBox(
                child: FutureBuilder<List<TransactionEntry>>(
                  future: _getTransactionHistory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<TransactionEntry> transactionHistory = snapshot.data ?? [];

                      return ListView.builder(
                        itemCount: transactionHistory.length,
                        itemBuilder: (context, index) {
                          var entry = transactionHistory[index];

                          return ListTile(
                            leading: Image.asset(
                              entry.type == TransactionType.Income
                                  ? 'assets/image/Frame5.png'
                                  : 'assets/image/Frame7.png',
                            ),
                            title: Row(
                              children: [
                                Text(
                                  entry.type == TransactionType.Income
                                      ? 'Income'
                                      : 'Expense',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 140),
                                  child: Text(
                                    '${entry.amount > 0 ? '+' : '-'}\$${entry.amount.abs().toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry.date),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
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
    // Query Firestore collection 'income' and calculate total income
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
    // Query Firestore collection 'expense' and calculate total expense
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
  Future<List<TransactionEntry>> _getTransactionHistory() async {
    List<TransactionEntry> transactionHistory = [];

    try {
      QuerySnapshot incomeSnapshot = await incomeCollection.get();
      QuerySnapshot expenseSnapshot = await expenseCollection.get();

      List<QueryDocumentSnapshot> incomeDocs = incomeSnapshot.docs;
      List<QueryDocumentSnapshot> expenseDocs = expenseSnapshot.docs;

      for (QueryDocumentSnapshot doc in incomeDocs) {
        var amount = doc['amount'];
        var date = doc['date'];
        //var name = doc['name'];// Replace with the actual field name for the date

        if (amount is num) {
          transactionHistory.add(TransactionEntry(
            type: TransactionType.Income,
            amount: amount.toDouble(),
            date: date ?? '',
          ));
        } else if (amount is String) {
          transactionHistory.add(TransactionEntry(
            type: TransactionType.Income,
            amount: double.tryParse(amount) ?? 0.0,
            date: date ?? '',
          ));
        }
      }

      for (QueryDocumentSnapshot doc in expenseDocs) {
        var amount = doc['amount'];
        var date = doc['date'];
        //var name = doc['name'];
        // Replace with the actual field name for the date

        if (amount is num) {
          transactionHistory.add(TransactionEntry(
            type: TransactionType.Expense,
            amount: amount.toDouble(),
            date: date ?? '',
          ));
        } else if (amount is String) {
          transactionHistory.add(TransactionEntry(
            type: TransactionType.Expense,
            amount: double.tryParse(amount) ?? 0.0,
            date: date ?? '',
          ));
        }
      }
    } catch (e) {
      print('Error fetching transaction history: $e');
    }

    // Sort the transaction history by date
    transactionHistory.sort((a, b) => b.date.compareTo(a.date));

    return transactionHistory;
  }

}

enum TransactionType { Income, Expense }

class TransactionEntry {
  final TransactionType type;
  final double amount;
  final String date;

  TransactionEntry({
    required this.type,
    required this.amount,
    required this.date,
  });
}
