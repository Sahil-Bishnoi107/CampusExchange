import 'package:flutter/material.dart';

// Item model class
class Item {
  final String id;
  final String imageUrl;
  final String title;
  final double price;
  final ItemStatus status;

  Item({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.status,
  });
}

enum ItemStatus {
  available,
  sold,
  pending,
}

// Reusable Item Card Widget
class ItemCard extends StatefulWidget {
  final Item item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final double width;
  final double height;

  const ItemCard({
    Key? key,
    required this.item,
    this.onEdit,
    this.onDelete,
    this.onTap,
    this.width = 180,
    this.height = 280,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
    with TickerProviderStateMixin {
  late AnimationController _editAnimationController;
  late AnimationController _deleteAnimationController;
  late AnimationController _cardAnimationController;
  
  late Animation<double> _editScaleAnimation;
  late Animation<double> _deleteScaleAnimation;
  late Animation<double> _cardScaleAnimation;
  late Animation<double> _cardOpacityAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    
    // Animation controllers
    _editAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _deleteAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Animations
    _editScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(
      parent: _editAnimationController,
      curve: Curves.easeInOut,
    ));

    _deleteScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(
      parent: _deleteAnimationController,
      curve: Curves.easeInOut,
    ));

    _cardScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeInOut,
    ));

    _cardOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _editAnimationController.dispose();
    _deleteAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  void _onCardTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _cardAnimationController.forward();
  }

  void _onCardTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _cardAnimationController.reverse();
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void _onCardTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _cardAnimationController.reverse();
  }

  void _onEditPressed() {
    _editAnimationController.forward().then((_) {
      _editAnimationController.reverse();
    });
    
   
    
    if (widget.onEdit != null) {
      widget.onEdit!();
    }
  }

  void _onDeletePressed() {
    _deleteAnimationController.forward().then((_) {
      _deleteAnimationController.reverse();
    });
    
   
    
    if (widget.onDelete != null) {
      widget.onDelete!();
    }
  }

  Color _getStatusColor() {
    switch (widget.item.status) {
      case ItemStatus.available:
        return const Color(0xFF2196F3); // Blue
      case ItemStatus.sold:
        return const Color(0xFF757575); // Grey
      case ItemStatus.pending:
        return const Color(0xFFFF9800); // Orange
    }
  }

  String _getStatusText() {
    switch (widget.item.status) {
      case ItemStatus.available:
        return 'Available';
      case ItemStatus.sold:
        return 'Sold';
      case ItemStatus.pending:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cardAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _cardScaleAnimation.value,
          child: Opacity(
            opacity: _cardOpacityAnimation.value,
            child: GestureDetector(
              onTapDown: _onCardTapDown,
              onTapUp: _onCardTapUp,
              onTapCancel: _onCardTapCancel,
              child: Container(
                width: widget.width,
                height: widget.height,
                child: Material(
                  elevation: _isPressed ? 2 : 6,
                  shadowColor: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                // Image
                                Image.network(
                                  widget.item.imageUrl,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            _getStatusColor(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                
                                // Status Badge
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: _getStatusColor().withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      _getStatusText(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Content Section
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                widget.item.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              const SizedBox(height: 8),
                              
                              // Price
                              Text(
                                '\$${widget.item.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              
                              const Spacer(),
                              
                              // Action Buttons
                              Row(
                                children: [
                                  // Edit Button
                                  Expanded(
                                    child: AnimatedBuilder(
                                      animation: _editScaleAnimation,
                                      builder: (context, child) {
                                        return Transform.scale(
                                          scale: _editScaleAnimation.value,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(8),
                                              onTap: _onEditPressed,
                                              child: Container(
                                                height: 36,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF2196F3).withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: const Color(0xFF2196F3).withOpacity(0.3),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 18,
                                                    color: Color(0xFF2196F3),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  
                                  const SizedBox(width: 8),
                                  
                                  // Delete Button
                                  Expanded(
                                    child: AnimatedBuilder(
                                      animation: _deleteScaleAnimation,
                                      builder: (context, child) {
                                        return Transform.scale(
                                          scale: _deleteScaleAnimation.value,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(8),
                                              onTap: _onDeletePressed,
                                              child: Container(
                                                height: 36,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFE53935).withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: const Color(0xFFE53935).withOpacity(0.3),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 18,
                                                    color: Color(0xFFE53935),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
              ),
            ),
          ),
        );
      },
    );
  }
}