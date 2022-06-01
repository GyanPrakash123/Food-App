import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class MyGooglePay extends StatefulWidget {
  final String total;
  MyGooglePay({required this.total});

  @override
  State<MyGooglePay> createState() => _MyGooglePayState();
}

class _MyGooglePayState extends State<MyGooglePay> {
  // var _paymentItems = [

  // ];

// // In your Widget build() method

// In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server or PSP
    print(paymentResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffd1ad17),
      body: GooglePayButton(
        paymentConfigurationAsset: 'sample_payment_configuration.json',
        paymentItems: [
          PaymentItem(
            label: 'Total',
            amount: widget.total,
            status: PaymentItemStatus.final_price,
          )
        ],
        style: GooglePayButtonStyle.black,
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 15.0),
        onPaymentResult: onGooglePayResult,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
