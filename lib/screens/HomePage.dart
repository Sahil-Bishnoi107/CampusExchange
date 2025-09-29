import 'package:ecommerceapp/widgets/homepagewidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> { 
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return 
      
        SingleChildScrollView(
          child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*0.06,),
              Text("DashBoard",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: height*0.015,),
              SearchBarWidget(),
              SizedBox(height: 30,),
              Container(width:width*0.86, child: Text("Quick Actions",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
              SizedBox(height: 10,),
              options(height, width)
              
            ],
          ),
                ),
        );
  }
}





Widget options(double height,double width){
  return Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Column(children: [
               CategoryCard(icon: "assets/svgs/notebook.svg", name: "Textbooks", description: "Find academic essentials",size: 5,),
               SizedBox(height: 10,),
               CategoryCard(icon: "assets/svgs/furniture.svg", name: "Furniture", description: "Decorate your room",size: 3,)
              ],),
              SizedBox(width: width*0.13,),
              Column(children: [
               CategoryCard(icon: "assets/svgs/shirt.svg", name: "Clothes", description: "Buy at a low price",size: 3,),
               SizedBox(height: 10,),
               CategoryCard(icon: "assets/svgs/laptop.svg", name: "Electronics", description: "Gadgets and tech",size: 2,)
              ],)
            ],);
}


















