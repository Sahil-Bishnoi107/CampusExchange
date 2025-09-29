import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomepageIntro extends StatefulWidget {
  const HomepageIntro({Key? key}) : super(key: key);

  @override
  State<HomepageIntro> createState() => _HomepageIntroState();
}

class _HomepageIntroState extends State<HomepageIntro> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate relative dimensions as requested
    final cardHeight = screenHeight * 0.4; // Height is 40% of screen height
    final cardWidth = screenWidth * 0.9;   // Width is 90% of screen width

    return Center(
      child: Container(
        height: cardHeight,
        width: cardWidth,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          // Distributes vertical space evenly between widgets to ensure they fit
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Welcome Back, Sarah!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C2C2E),
              ),
            ),
            const Text(
              'Discover campus treasures or list your own items for sale within the university community.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15, // Slightly smaller to help fit
                color: Color(0xFF8E8E93),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('Post an Item button pressed!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text(
                'Post an Item',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),     
          ],
        ),
      ),
    );
  }
}





class SearchBarWidget extends StatefulWidget {
  final Function(String)? onSearchChanged;
  final String? hintText;
  
  const SearchBarWidget({
    Key? key,
    this.onSearchChanged,
    this.hintText = "Search for items...",
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: widget.onSearchChanged,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[600],
            size: 20,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}




class CategoryCard extends StatelessWidget {
  final String icon;
  final String name;
  final String description;
  final double size;
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.name,
    required this.description,
    required this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth * 0.9 - 20) / 2; 
    
    return Container(
      width: cardWidth*0.8,
      height: cardWidth*0.8, 
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1), 
        border: Border.all(color: const Color.fromRGBO(238, 238, 238, 1)),
        borderRadius: BorderRadius.circular(5)
      ),
      padding: EdgeInsets.all(cardWidth * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: cardWidth * 0.2,
            height: cardWidth * 0.2,
            padding: EdgeInsets.all(size),
            child: SvgPicture.asset(icon,height: size,width: size,color: Colors.blue,),
          ),
          
          SizedBox(height: cardWidth * 0.02),
          Text(
            name,
            style: TextStyle(
              fontSize: cardWidth * 0.1,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          SizedBox(height: cardWidth * 0.02),
          Text(
            description,
            style: TextStyle(
              fontSize: cardWidth * 0.06,
              color: Colors.black54,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}



