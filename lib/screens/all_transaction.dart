import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:income_expense/screens/homescreen.dart';

class AllTransaction extends StatelessWidget {
   AllTransaction({super.key});

  final CollectionReference incomeCollection =
  FirebaseFirestore.instance.collection('incomes');

  final CollectionReference expenseCollection =
  FirebaseFirestore.instance.collection('expense');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 80, 0, 0),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(150, 95, 0, 0),
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
            padding: const EdgeInsets.only(left: 150, top: 600),
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
                                ? 'assets/image/income_icon.png'
                                : 'assets/image/expense_icon.png',
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
    );
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
        var date = doc['date']; // Replace with the actual field name for the date

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
        var date = doc['date']; // Replace with the actual field name for the date

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

