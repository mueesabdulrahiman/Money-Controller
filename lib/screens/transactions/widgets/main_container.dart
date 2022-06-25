
import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({
    Key? key,
    required this.screenSize,
    required this.totalBalance,
    required this.tottalIncome,
    required this.totalExpense,
  }) : super(key: key);

  final Size screenSize;
  final double totalBalance;
  final double tottalIncome;
  final double totalExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(8, 8),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-10, -10),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Text(
              'BALANCE',
              style:
                  TextStyle(letterSpacing: 10.0, color: Colors.grey[600]),
            ),
             Text(
              '$totalBalance',
              style: const TextStyle(
                  fontSize: 50.0, fontWeight: FontWeight.w300),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      children:  [ Text('INCOME',style: TextStyle(color: Colors.grey[600]),), Text('\$$tottalIncome', style: TextStyle(color: Colors.green),)],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      children:  [ Text('EXPENSE', style: TextStyle(color: Colors.grey[600]),), Text('\$$totalExpense',  style: TextStyle(color: Colors.red))],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
