import 'package:flutter/material.dart';
import 'package:income_expense/screens/all_transaction.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<PaymentEntry> paymentHistory = [
      PaymentEntry(
          image: 'assets/image/Frame9.png',
          title: 'Upwork',
          date: 'Today',
          amount: '-\$200.00'
      ),
      PaymentEntry(
          image: 'assets/image/Frame2.png',
          title: 'Transfer',
          date: 'Yesterday',
          amount: '-\$20.00'
      ),
      PaymentEntry(
        image: 'assets/image/Frame9(3).png',
        title: 'Youtube',
        date: '31/10/2023',
        amount: '-\$12.00',
      ),
      PaymentEntry(
        image: 'assets/image/Frame9(2).png',
        title: 'Paypal',
        date: '20/10/2023',
        amount: '-\$35.00',
      ),
      PaymentEntry(
        image: 'assets/image/Frame2.png',
        title: 'Recieved',
        date: '19/10/2023',
        amount: '+\$100.00',
      ),
      PaymentEntry(
        image: 'assets/image/Frame3.png',
        title: 'Trnasfer',
        date: '15/10/2023',
        amount: '-\$12.50',
      ),
      PaymentEntry(
        image: 'assets/image/Frame9(2).png',
        title: 'Paypal',
        date: '01/10/2023',
        amount:'+\$100.00',
      ),
      PaymentEntry(
        image: 'assets/image/Frame9(3).png',
        title: 'Youtube',
        date: '30/09/2023',
        amount:'-\$13.00',
      ),
    ];

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
              padding: EdgeInsets.only(left: 20,top: 33),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(45, 210, 0, 0),
              child: Text(
                '\$',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: -1.50,
                ),
              ),
            ),
            Padding(padding: const  EdgeInsets.only(left:0 ,top: 5),
              child: Image.asset(
                'assets/image/Frame5.png',
                width: 110,
                height: 600,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top:295 ,left:70),
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
            Padding(padding: const  EdgeInsets.only(top:5 , left:190),
              child: Image.asset(
                'assets/image/Frame7.png',
                width: 110,
                height: 600,
              ),
            ),
            const Padding(padding: EdgeInsets.only(left:260 ,top:297),
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
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(47, 320, 0, 0),
                  child: Text(
                    '\$ ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(175, 320, 0, 0),
                  child: Text(
                    '\$ ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ],
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
                     Get.to(() => const AllTransaction());
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            Padding( padding: const EdgeInsets.only(left: 5,top: 450),
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Image.asset(paymentHistory[index].image),
                      title:Row(
                        children:[
                          Text(paymentHistory[index].title,
                            style: const  TextStyle(
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(left : 140),
                            child: Text(paymentHistory[index].amount,
                              style: const
                              TextStyle(
                                  fontSize: 19,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(paymentHistory[index].date),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentEntry {
  final String image;
  final String title;
  final String date;
  final String amount;

  PaymentEntry({
    required this.image,
    required this.title,
    required this.date,
    required this.amount,
  });
}
