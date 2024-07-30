// master_card.dart
import 'package:flutter/material.dart';
import 'package:meter/constant/res/app_color/app_color.dart';

class MasterCard extends StatelessWidget {
  final String cardHolderName;
  final String cardNumber;
  final String cvv;
  final String expiryMonth;
  final String expiryYear;

  MasterCard({
    required this.cardHolderName,
    required this.cardNumber,
    required this.cvv,
    required this.expiryMonth,
    required this.expiryYear,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.credit_card, color: Colors.white, size: 40),
                Spacer(),
                Icon(Icons.sim_card, color: Colors.white, size: 40),
              ],
            ),
            Spacer(),
            Text(
              cardNumber.isNotEmpty ? cardNumber : 'XXXX XXXX XXXX XXXX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardHolderName.isNotEmpty ? cardHolderName : 'Card Holder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  (expiryMonth.isNotEmpty && expiryYear.isNotEmpty)
                      ? '$expiryMonth/$expiryYear'
                      : 'MM/YY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                cvv.isNotEmpty ? 'CVV: $cvv' : 'CVV: XXX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
