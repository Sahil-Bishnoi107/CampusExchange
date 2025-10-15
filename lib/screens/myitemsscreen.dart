import 'package:ecommerceapp/Models/ProductModel.dart';
import 'package:ecommerceapp/providers/MyItemsProvider.dart';
import 'package:ecommerceapp/screens/postscreen.dart';
import 'package:ecommerceapp/widgets/ProductWidget.dart';
import 'package:ecommerceapp/widgets/postitembanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyItemsScreen extends StatefulWidget {
  const MyItemsScreen({super.key});

  @override
  State<MyItemsScreen> createState() => _MyItemsScreenState();
}

class _MyItemsScreenState extends State<MyItemsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(height: height * 0.06),
            Text(
              "My Items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height * 0.02),
            Container(height: 1, color: const Color.fromRGBO(200, 200, 200, 1)),
            SizedBox(height: height * 0.02),
            PostItemBanner(
              onPostPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePostScreen()),
              ),
            ),
            SizedBox(height: height * 0.03),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildCategoryCard(
                      context,
                      title: "Sold Items",
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SoldItemsPage(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildCategoryCard(
                      context,
                      title: "Pending Items",
                      icon: Icons.pending_outlined,
                      color: Colors.orange,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PendingItemsPage(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildCategoryCard(
                      context,
                      title: "Purchased Items",
                      icon: Icons.shopping_bag_outlined,
                      color: Colors.blue,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PurchasedItemsPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}

// ============ PENDING ITEMS PAGE ============
class PendingItemsPage extends StatefulWidget {
  const PendingItemsPage({super.key});

  @override
  State<PendingItemsPage> createState() => _PendingItemsPageState();
}

class _PendingItemsPageState extends State<PendingItemsPage> {
  @override
  void initState() {
    super.initState();
    context.read<Myitemsprovider>().getlistofmyitems();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: height * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Pending Items",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 48), // Balance the back button
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(height: 1, color: const Color.fromRGBO(200, 200, 200, 1)),
          SizedBox(height: height * 0.02),
          Expanded(child: PendingProductGrid()),
        ],
      ),
    );
  }
}

class PendingProductGrid extends StatelessWidget {
  const PendingProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Myitemsprovider>(
      builder: (context, itemProvider, child) {
        final items = itemProvider.myItems;

        if (items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pending_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No pending items',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(30.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.76,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ProductWidget(
              item: item,
              onEdit: () => _handleEdit(context, item),
              onDelete: () => itemProvider.deleteItem(item.itemid),
              width: double.infinity,
              height: double.infinity,
            );
          },
        );
      },
    );
  }

  void _handleEdit(BuildContext context, ProductItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing is not available right now'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// ============ SOLD ITEMS PAGE ============
class SoldItemsPage extends StatefulWidget {
  const SoldItemsPage({super.key});

  @override
  State<SoldItemsPage> createState() => _SoldItemsPageState();
}

class _SoldItemsPageState extends State<SoldItemsPage> {
  @override
  void initState() {
    super.initState();
    context.read<Myitemsprovider>().getlistofSolditems();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: height * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Sold Items",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 48),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(height: 1, color: const Color.fromRGBO(200, 200, 200, 1)),
          SizedBox(height: height * 0.02),
          Expanded(child: SoldProductGrid()),
        ],
      ),
    );
  }
}

class SoldProductGrid extends StatelessWidget {
  const SoldProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Myitemsprovider>(
      builder: (context, itemProvider, child) {
        final items = itemProvider.soldItems;

        if (items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No sold items',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(30.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.76,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return SoldProductWidget(
              item: item,
              width: double.infinity,
              height: double.infinity,
            );
          },
        );
      },
    );
  }
}

// ============ PURCHASED ITEMS PAGE ============
class PurchasedItemsPage extends StatefulWidget {
  const PurchasedItemsPage({super.key});

  @override
  State<PurchasedItemsPage> createState() => _PurchasedItemsPageState();
}

class _PurchasedItemsPageState extends State<PurchasedItemsPage> {
  @override
  void initState() {
    super.initState();
    context.read<Myitemsprovider>().getlistofPurchaseditems();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: height * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Purchased Items",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 48),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(height: 1, color: const Color.fromRGBO(200, 200, 200, 1)),
          SizedBox(height: height * 0.02),
          Expanded(child: PurchasedProductGrid()),
        ],
      ),
    );
  }
}

class PurchasedProductGrid extends StatelessWidget {
  const PurchasedProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Myitemsprovider>(
      builder: (context, itemProvider, child) {
        final items = itemProvider.purchasedItems;

        if (items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No purchased items',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(30.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.76,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return PurchasedProductWidget(
              item: item,
              width: double.infinity,
              height: double.infinity,
            );
          },
        );
      },
    );
  }
}

// ============ SOLD PRODUCT WIDGET ============
class SoldProductWidget extends StatelessWidget {
  final ProductItem item;
  final double width;
  final double height;

  const SoldProductWidget({
    Key? key,
    required this.item,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    item.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: item.paid ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.paid ? "Confirmed" : "Pending",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$${item.price}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 2),
                      Text(
                        item.rating.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============ PURCHASED PRODUCT WIDGET ============
class PurchasedProductWidget extends StatelessWidget {
  final ProductItem item;
  final double width;
  final double height;

  const PurchasedProductWidget({
    Key? key,
    required this.item,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    item.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: item.paid ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.paid ? "Confirmed" : "Pending",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\$${item.price}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 2),
                      Text(
                        item.rating.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}