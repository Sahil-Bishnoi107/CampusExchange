import 'package:ecommerceapp/Models/ProductModel.dart';
import 'package:flutter/material.dart';



class ProductCard extends StatelessWidget {
  final ProductItem item;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.36, // 42% of screen width
        height: screenHeight * 0.32, // 32% of screen height
        margin: EdgeInsets.all(screenWidth * 0.02), // 2% margin
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Container(
              width: double.infinity,
              height: screenHeight * 0.15, // 18% of screen height
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey.shade400,
                        size: screenWidth * 0.08,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey.shade400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Content container
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.03), // 3% padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product name
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: screenWidth * 0.032, // 3.8% of screen width
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price
                        Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.036, // 4.5% of screen width
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4A90E2),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.005), // Small spacing
                        
                        // Condition
                        Text(
                          item.category,
                          style: TextStyle(
                            fontSize: screenWidth * 0.028, // 3.2% of screen width
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
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
}