import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTransaction extends StatelessWidget {
  const AllTransaction({super.key});

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
      PaymentEntry(
        image: 'assets/image/Frame2.png',
        title: 'Recieved',
        date: '19/10/2023',
        amount: '+\$100.00',
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
        date: '01/10/2023',
        amount:'+\$100.00',
      ),
    ];
    return Scaffold(
      body:Container(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 80, 0, 0),
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
            Padding( padding: const EdgeInsets.only(left: 5,top: 150),
              child: Container(
                height: 800,
                child: ListView.builder(
                  itemCount: paymentHistory.length,
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
                            child: Text('${paymentHistory[index].amount}',
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
                          Text('${paymentHistory[index].date}'),
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

