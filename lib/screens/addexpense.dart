import 'package:flutter/material.dart';

void mian(){
  runApp(
    MaterialApp(
      home: AddExpense(),
    )
  );
}

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                child: Image.asset('assets/image/Ellipse9.png')
            ),
          ],
        ),

      ),
    );
  }
}
