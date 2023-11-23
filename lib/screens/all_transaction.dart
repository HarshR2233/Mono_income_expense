import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllTransaction extends StatelessWidget {
  AllTransaction({super.key});

  final CollectionReference incomeCollection =
  FirebaseFirestore.instance.collection('incomes');

  final CollectionReference expenseCollection =
  FirebaseFirestore.instance.collection('expense');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 80, 0, 0),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                  Icons.arrow_back_ios_rounded, color: Colors.black),
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
            padding: const EdgeInsets.only(top: 150),
            child: Center(
              child: FutureBuilder<List<TransactionEntry>>(
                future: _getTransactionHistory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7E78)),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<TransactionEntry> transactionHistory = snapshot.data ??
                        [];

                    return ListView.builder(
                      itemCount: transactionHistory.length,
                      itemBuilder: (context, index) {
                        var entry = transactionHistory[index];

                        return ListTile(
                          leading: Image.asset(
                            entry.name == TransactionType.incomes
                                ? 'assets/image/Frame5.png'
                                : 'assets/image/Frame7.png',
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children to the right
                            children: [
                              Text(
                                entry.name == TransactionType.incomes
                                    ? 'Income'
                                    : 'Expense',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${entry.name == TransactionType.incomes ? '+' : '-'}\$${entry.amount.abs().toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
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
        var date = doc['date'];

        if (date is Timestamp) {
          date = date.toDate().toString();
        }

        if (amount is num) {
          transactionHistory.add(TransactionEntry(
            name: TransactionType.incomes,
            amount: amount.toDouble(),
            date: date ?? '',
          ));
        } else if (amount is String) {
          transactionHistory.add(TransactionEntry(
            name: TransactionType.incomes,
            amount: double.tryParse(amount) ?? 0.0,
            date: date ?? '',
          ));
        }
      }

      for (QueryDocumentSnapshot doc in expenseDocs) {
        var amount = doc['amount'];
        var date = doc['date'];

        if (date is Timestamp) {
          date = date.toDate().toString();
        }

        if (amount is num) {
          transactionHistory.add(TransactionEntry(
            name: TransactionType.expense,
            amount: amount.toDouble(),
            date: date ?? '',
          ));
        } else if (amount is String) {
          transactionHistory.add(TransactionEntry(
            name: TransactionType.expense,
            amount: double.tryParse(amount) ?? 0.0,
            date: date ?? '',
          ));
        }
      }
      transactionHistory.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      print('Error fetching transaction history: $e');
    }

    return transactionHistory;
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
