import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AllTransaction extends StatelessWidget {
  AllTransaction({super.key});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final CollectionReference incomeCollection = FirebaseFirestore.instance.collection('incomes');
  final CollectionReference expenseCollection = FirebaseFirestore.instance.collection('expense');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7E78),
        title:const Text(
          'Transactions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  // Trigger a refresh by calling setState
                  _refreshIndicatorKey.currentState?.show();
                },
                child: FutureBuilder<List<TransactionEntry>>(
                  future: _getTransactionHistory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7E78)),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    } else {
                      List<TransactionEntry> transactionHistory = snapshot.data ?? [];
                      if (transactionHistory.isEmpty) {
                        return const Center(
                          child: Text(
                            'No transaction history available.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: transactionHistory.length,
                        itemBuilder: (context, index) {
                          var entry = transactionHistory[index]; // Retrieve the transaction entry

                          return Dismissible(
                            key: Key(entry.date),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16.0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.blue,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 16.0),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) async {
                              if (direction == DismissDirection.startToEnd) {

                                await _deleteTransaction(entry);
                              } else if (direction == DismissDirection.endToStart) {

                                _showUpdateDialog(context, entry);

                                _refreshIndicatorKey.currentState?.show();
                              }
                            },
                            child: Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  entry.name == TransactionType.incomes
                                      ? 'assets/image/arrowdown.png'
                                      : 'assets/image/arrowup.png',
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        entry.name == TransactionType.incomes ? 'Income' : 'Expense',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${entry.name == TransactionType.incomes ? '+' : '-'}\$${entry.amount.abs().toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: entry.name == TransactionType.incomes
                                              ? const Color(0xFF2E7E78)
                                              : Colors.redAccent,
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
                                    Text(
                                      entry.date,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showUpdateDialog(BuildContext context, TransactionEntry entry) async {
    TextEditingController amountController = TextEditingController(text: entry.amount.toString());

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Update the transaction details:'),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                double updatedAmount = double.tryParse(amountController.text) ?? 0.0;
                await _updateTransaction(entry, updatedAmount);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
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
          // Extract only the date part
          date = DateFormat('yyyy-MM-dd').format(date.toDate());
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
          // Extract only the date part
          date = DateFormat('yyyy-MM-dd').format(date.toDate());
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

  Future<void> _deleteTransaction(TransactionEntry entry) async {
    try {
      print('Deleting document with ID: ${entry.date}');
      if (entry.name == TransactionType.incomes) {
        await incomeCollection.doc(entry.date).delete();
        print('Income deleted successfully');
      } else if (entry.name == TransactionType.expense) {
        await expenseCollection.doc(entry.date).delete();
        print('Expense deleted successfully');
      }
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }

  Future<void> _updateTransaction(TransactionEntry entry, double updatedAmount) async {
    try {
      if (entry.name == TransactionType.incomes) {
        await incomeCollection.doc(entry.date).update({'amount': updatedAmount});
        print('Income updated successfully');
      } else if (entry.name == TransactionType.expense) {
        await expenseCollection.doc(entry.date).update({'amount': updatedAmount});
        print('Expense updated successfully');
      }
    } catch (e) {
      print('Error updating transaction: $e');
    }
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
