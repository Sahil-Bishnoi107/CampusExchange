import 'package:ecommerceapp/screens/HomePage.dart';
import 'package:ecommerceapp/screens/SearchPage.dart';
import 'package:ecommerceapp/screens/myitemsscreen.dart';
import 'package:ecommerceapp/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    Homepage(),
    SearchPage(),
    MyItemsScreen(),
    const Center(child: Text('History Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavBar(currentIndex: _currentIndex, onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        }),
      ),
    );
  }
}