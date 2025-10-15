import 'package:ecommerceapp/Models/ProductModel.dart';
import 'package:ecommerceapp/widgets/ItemInfoCard.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:ecommerceapp/services/RazorpayService.dart';

class ItemInfoPage extends StatefulWidget {
  final ProductItem item;
  const ItemInfoPage({super.key,required this.item});
  

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  late Razorpay razorpay;
  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  }
  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: width,
          child: Column(
            children: [      
              ItemCardWidget(item: widget.item,razorpay: razorpay,)
            ],
          ),
        ),
      ),
    );
  }

}