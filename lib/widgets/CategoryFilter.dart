import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final List<String> categories;
  final Function(int, String)? onCategorySelected;

  const CategoryFilter({
    Key? key,
    required this.categories,
    this.onCategorySelected,
  }) : super(key: key);

  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.04, // 8% of screen height
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // 5% margin on each side
        vertical: screenHeight * 0.01, // 1% vertical margin
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          final category = widget.categories[index];
          
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              if (widget.onCategorySelected != null) {
                widget.onCategorySelected!(index, category);
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                right: screenWidth * 0.03, // 3% spacing between items
              ),
             padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4A90E2) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: isSelected ? const Color(0xFF4A90E2) : Colors.grey.shade100,
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: screenWidth * 0.03, // 3.8% of screen width
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}