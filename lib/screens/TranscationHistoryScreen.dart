import 'package:ecommerceapp/Models/ProductModel.dart';
import 'package:ecommerceapp/widgets/transactionWidget.dart';
import 'package:flutter/material.dart';
class TranscationHistoryPage extends StatelessWidget {
  const TranscationHistoryPage({Key? key}) : super(key: key);

  List<ProductItem> _getSampleProducts() {
    return [
      ProductItem(
        userId: 'user1',
        imageUrl: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f',
        title: 'Organic Chemistry Textbook',
        price: 45,
        description: 'Chemistry textbook',
        address: 'Campus',
        category: 'Chemistry Department',
        itemid: 'ORD-001',
        postedDate: 'Nov 15, 2023',
        condition: 'Good',
        userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        userName: 'John Doe',
        rating: 4.5,
        paid: true,
        date: DateTime(2023, 11, 15),
       
      ),
      ProductItem(
        userId: 'user2',
        imageUrl: 'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04',
        title: 'TI-84 Plus CE Graphing Calculator',
        price: 90,
        description: 'Graphing calculator',
        address: 'Campus',
        category: 'Campus Electronics',
        itemid: 'ORD-002',
        postedDate: 'Oct 28, 2023',
        condition: 'Excellent',
        userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        userName: 'Jane Smith',
        rating: 4.8,
        paid: true,
        date: DateTime(2023, 10, 28),
       
      ),
      ProductItem(
        userId: 'user3',
        imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7',
        title: 'University Branded Hoodie',
        price: 30,
        description: 'University hoodie',
        address: 'Campus',
        category: 'Campus Apparel',
        itemid: 'ORD-003',
        postedDate: 'Oct 1, 2023',
        condition: 'New',
        userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        userName: 'Mike Johnson',
        rating: 4.9,
        paid: true,
        date: DateTime(2023, 10, 1),
       
      ),
      ProductItem(
        userId: 'user4',
        imageUrl: 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1',
        title: 'Portable Bluetooth Speaker',
        price: 25,
        description: 'Bluetooth speaker',
        address: 'Campus',
        category: 'Tech Gadgets Store',
        itemid: 'ORD-004',
        postedDate: 'Sep 10, 2023',
        condition: 'Good',
        userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        userName: 'Sarah Wilson',
        rating: 4.2,
        paid: true,
        date: DateTime(2023, 9, 10),
        
      ),
      ProductItem(
        userId: 'user5',
        imageUrl: 'https://images.unsplash.com/photo-1586281380349-632531db7ed4',
        title: 'Assorted Gel Pen Set (12-pack)',
        price: 12,
        description: 'Gel pens set',
        address: 'Campus',
        category: 'Art Supplies Co.',
        itemid: 'ORD-005',
        postedDate: 'Aug 22, 2023',
        condition: 'New',
        userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        userName: 'David Brown',
        rating: 4.7,
        paid: false,
        date: DateTime(2023, 8, 22),
      
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final products = _getSampleProducts();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Purchase History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return OrderCard(
            product: products[index],
            isPurchased: true,
          );
        },
      ),
    );
  }
}