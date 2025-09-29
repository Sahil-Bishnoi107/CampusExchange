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
  void initState() {
    super.initState();
    context.read<Myitemsprovider>().getlistofmyitems();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,width: width,
        child: Column(
          children: [
            SizedBox(height: height*0.06,),
            Text("My Items",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: height*0.02,),
            Container(height: 1,color: const Color.fromRGBO(200, 200, 200, 1),),
            SizedBox(height: height*0.02,),
            PostItemBanner(onPostPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostScreen())),),
            Expanded(child: ProductGrid())
          ],
        ),
      ),
    );
  }
}


class ProductGrid extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const ProductGrid({
    Key? key,
    this.padding,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.76,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<Myitemsprovider>(
      builder: (context, itemProvider, child) {
        final items = itemProvider.myItems;

        if (items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No products available',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Add some products to see them here',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: padding ?? const EdgeInsets.all(30.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
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
  void _handleEdit(BuildContext context,ProductItem item){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editing is not available right now'),
      behavior: SnackBarBehavior.floating,)
    );
  }
 
}