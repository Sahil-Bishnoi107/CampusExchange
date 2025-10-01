import 'package:ecommerceapp/Models/ProductModel.dart';
import 'package:ecommerceapp/screens/Reviews.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ItemCardWidget extends StatelessWidget {
  final ProductItem item;

  const ItemCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 📌 Screen dimensions

    return Expanded(
      child: Stack(
        children: [
          // 🔹 Scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: size.height * 0.15, // space for footer
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
                // 🔹 Extra info now sits above footer
                _buildExtraInfo(),
              ],
            ),
          ),

          // 🔹 Sticky footer (always at bottom)
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
              child: _buildBottomButtons(),
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
  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Buy Now"),
            ),
          ),
        ],
      ),
    );
  }
}
