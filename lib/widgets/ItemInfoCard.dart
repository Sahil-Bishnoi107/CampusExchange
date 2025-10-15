import 'package:ecommerceapp/Models/ProductModel.dart';
import 'package:ecommerceapp/screens/Reviews.dart';
import 'package:ecommerceapp/services/RazorpayService.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:hive/hive.dart';

class ItemCardWidget extends StatelessWidget {
  final ProductItem item;
  final Razorpay razorpay;
  

  const ItemCardWidget({super.key, required this.item,required this.razorpay});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; 

    return Expanded(
      child: Stack(
        children: [
          
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: size.height * 0.15, 
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(context),
                _buildImageSection(size,context),
                SizedBox(height: size.height * 0.02),
                _buildTitleAndRating(),
                SizedBox(height: size.height * 0.01),
                _buildPrice(),
                SizedBox(height: size.height * 0.02),
                _buildSellerInfo(),
                SizedBox(height: size.height * 0.02),
                _buildDescription(size),
                SizedBox(height: size.height * 0.02),
               
                _buildExtraInfo(),
              ],
            ),
          ),

         
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                top: size.height * 0.015,
                bottom: size.height * 0.02,
              ),
              child: _buildBottomButtons(razorpay,context),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Top bar
  Widget _buildTopBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.015,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            "Item Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  /// 🔹 Image section
  Widget _buildImageSection(Size size,BuildContext context) {
    return Stack(
      children : [
         SizedBox(
        width: size.width,
        height: size.height * 0.3,
        child: Image.network(
          item.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    Positioned(
      right: size.width*0.04,
      top: size.height*0.01,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsPage(itemid: item.itemid,))),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: Text("Reviews"),
            ),
      )
    
    )
      ]
      );
  }

  /// 🔹 Title & Rating
  Widget _buildTitleAndRating() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20), // wider padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              item.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.star, color: Colors.amber, size: 20),
          Text(
            item.rating.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// 🔹 Price
  Widget _buildPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "\$${item.price.toString()}",
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  /// 🔹 Seller Info
  Widget _buildSellerInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item.imageUrl),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Sahil Bishnoi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text("Seller", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text("View Profile"),
          ),
        ],
      ),
    );
  }

  /// 🔹 Description (with min height)
  Widget _buildDescription(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.15, // ensures bigger description area
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Text(
              item.description,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Extra Info
  Widget _buildExtraInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.local_shipping, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          const Text("Free Shipping", style: TextStyle(color: Colors.grey)),
          const SizedBox(width: 16),
          const Icon(Icons.check_box, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Text("Condition: ${item.condition}",
              style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  /// 🔹 Bottom Buttons
  Widget _buildBottomButtons(Razorpay razorpay,BuildContext context) {

     
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                 String orderId = await startPayment(item.price);
                   var options = {
                     'key': 'rzp_test_XXXX',  
                     'amount': item.price,
                     'order_id': orderId,
                     'name': 'My Test App',
                     'description': 'Test Payment',
                     'prefill': {'contact': '9999999999', 'email': 'test@example.com'}
                     };
              razorpay.open(options);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Add to Cart"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {showPaymentOptionsBottomSheet(context);},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Buy Now",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }


void showPaymentOptionsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero, 
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Payment Method",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
             
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); 
                  // Add your cash payment logic here
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Pay with Cash"),
              ),
              
              const SizedBox(height: 12),
              
             
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                  // Add your online payment logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  "Pay Online",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}
