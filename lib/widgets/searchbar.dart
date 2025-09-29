import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onSearchPressed;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? searchButtonColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showSearchButton;

  const CustomSearchBar({
    Key? key,
    this.hintText = 'Search for items...',
    this.onChanged,
    this.onSubmitted,
    this.onSearchPressed,
    this.controller,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.hintColor,
    this.searchButtonColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.showSearchButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(top: 2),
      width: screenWidth * 0.9, // 90% of screen width
      height: screenHeight * 0.05, // 5% of screen height
      margin: margin ?? EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // 5% margin on each side
        vertical: screenHeight * 0.01, // 1% vertical margin
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          // Search Icon
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.03),
            child: Icon(
              Icons.search,
              color: iconColor ?? Colors.grey.shade600,
              size: screenWidth * 0.05, // 5% of screen width
            ),
          ),
          
          // Text Field
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              style: TextStyle(
                color: textColor ?? Colors.black87,
                fontSize: screenWidth * 0.034, // 3.4% of screen width
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: hintColor ?? Colors.grey.shade600,
                  fontSize: screenWidth * 0.034,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.01,
                ),
              ),
            ),
          ),
          
          // Search/Go Button
          if (showSearchButton)
            Container(
              margin: EdgeInsets.only(right: screenWidth * 0.01),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Call onSearchPressed if provided, otherwise call onSubmitted with current text
                    if (onSearchPressed != null) {
                      onSearchPressed!();
                    } else if (onSubmitted != null && controller != null) {
                      onSubmitted!(controller!.text);
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                      vertical: screenHeight * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: searchButtonColor ?? Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: screenWidth * 0.04,
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          'Go',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Usage Example:
class SearchBarExample extends StatefulWidget {
  @override
  _SearchBarExampleState createState() => _SearchBarExampleState();
}

class _SearchBarExampleState extends State<SearchBarExample> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch(String query) {
    print('Searching for: $query');
    // Add your search logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Bar Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          
          // Basic usage with search button
          CustomSearchBar(
            controller: _searchController,
            onSearchPressed: () {
              _performSearch(_searchController.text);
            },
            onSubmitted: _performSearch,
          ),
          
          SizedBox(height: 20),
          
          // Custom styled search bar
          CustomSearchBar(
            hintText: 'Search products...',
            backgroundColor: Colors.white,
            searchButtonColor: Colors.green,
            borderRadius: 25.0,
            onSearchPressed: () {
              print('Custom search pressed');
            },
          ),
          
          SizedBox(height: 20),
          
          // Search bar without button
          CustomSearchBar(
            hintText: 'No button search...',
            showSearchButton: false,
            backgroundColor: Colors.grey.shade100,
          ),
          
          SizedBox(height: 20),
          
          // Alternative design with different colors
          CustomSearchBar(
            hintText: 'Find anything...',
            backgroundColor: Colors.blue.shade50,
            searchButtonColor: Colors.orange,
            iconColor: Colors.blue,
            textColor: Colors.blue.shade800,
            onSearchPressed: () {
              print('Orange button search');
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}