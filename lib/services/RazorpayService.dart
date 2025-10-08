import 'dart:convert';

import 'package:ecommerceapp/services/ItemServices.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

Future<String> startPayment(int amountInPaise) async {
    final res = await http.post(
      Uri.parse("${baseurl}/api/razorpay/create-order"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"amount": amountInPaise}),
    );
     final body = jsonDecode(res.body);
    String orderId = body['id'];
    return orderId;
}

 void handlePaymentSuccess(PaymentSuccessResponse response) async {
    
    final verifyRes = await http.post(
      Uri.parse("https://yourbackend.com/api/razorpay/verify-payment"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "orderId": response.orderId,
        "paymentId": response.paymentId,
        "signature": response.signature
      }),
    );

    final verifyBody = jsonDecode(verifyRes.body);
    if (verifyBody['status'] == 'success') {
      print("Payment verified");
    } else {
      print("Payment verification failed");
    }
  }

  
  void handlePaymentError(PaymentFailureResponse response) {
    print("Payment failed: ${response.message}");
  }
