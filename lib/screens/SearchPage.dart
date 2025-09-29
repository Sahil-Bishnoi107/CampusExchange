import 'package:ecommerceapp/providers/MyItemsProvider.dart';
import 'package:ecommerceapp/screens/ItemInfoPage.dart';
import 'package:ecommerceapp/widgets/CategoryFilter.dart';
import 'package:ecommerceapp/widgets/SearchPageItemCard.dart';
import 'package:ecommerceapp/widgets/cards.dart';
import 'package:ecommerceapp/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  List<String> categories = ["All","Electronics", "Clothing","Books","Stationery", "Furniture", "Food", "Others"];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
        height: height,width: width,
        child: Column(
          children: [
            SizedBox(height: height*0.06,),
            CustomSearchBar(
              controller: controller,
              onSearchPressed: () {
              context.read<Myitemsprovider>().vectorSearch(controller.text);
            },),
            Container(margin: EdgeInsets.symmetric(vertical: 10),width: width,height: 1,color: const Color.fromRGBO(210, 210, 210, 1),),
            CategoryFilter(categories: categories),
            Expanded(child: _grid())

          ],
        ),
      ),
    );
  }


  Widget _grid(){
    return Consumer<Myitemsprovider>(
      builder:(context,provider,child) { 
        final sampleItems = provider.searcheditems;
        return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.74,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemCount: sampleItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  
                  child: ProductCard(
                    item: sampleItems[index],
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ItemInfoPage(item: sampleItems[index])));
                    },
                  ),
                );
              },
            ),
      );},
    );
  }
}