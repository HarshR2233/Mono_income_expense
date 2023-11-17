import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:income_expense/screens/addincome.dart';
import 'package:income_expense/screens/addexpense.dart';
import 'homescreen.dart';
import 'transaction.dart';
import 'wallet.dart';
import 'profile.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const Transaction(),
    const Wallet(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentTab],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (int index) {
            setState(() {
              currentTab = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF438883),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        animationAngle: pi,
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: Color(0xFF2E7E78),
        animatedIconTheme: const IconThemeData(size: 22.0),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add, color: Colors.white),
            label: 'Add Income',
            labelStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            labelBackgroundColor: const Color(0xFF2E7E78),
            backgroundColor: const Color(0xFF2E7E78),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddIncome()));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit_note_outlined, color: Colors.white),
            label: 'Add Expense',
            labelStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            labelBackgroundColor: const Color(0xFF2E7E78),
            backgroundColor: const Color(0xFF2E7E78),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddExpense()));
            },
          )
        ],
      ),
    );
  }
}
