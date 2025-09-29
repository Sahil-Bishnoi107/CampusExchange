import 'package:flutter/material.dart';

class PostItemBanner extends StatefulWidget {
  final VoidCallback? onPostPressed;
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? buttonColor;

  const PostItemBanner({
    Key? key,
    this.onPostPressed,
    this.title = "Sell your items easily",
    this.subtitle = "Post your items and connect with buyers",
    this.backgroundColor,
    this.textColor,
    this.buttonColor,
  }) : super(key: key);

  @override
  State<PostItemBanner> createState() => _PostItemBannerState();
}

class _PostItemBannerState extends State<PostItemBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPostPressed() {
    setState(() {
      _isPressed = true;
    });

    _animationController.forward().then((_) {
      _animationController.reverse();
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            _isPressed = false;
          });
        }
      });
    });

    if (widget.onPostPressed != null) {
      widget.onPostPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header section with icon and text
                  Row(
                    children: [
                      // Blue circular icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: widget.backgroundColor ?? const Color(0xFF2196F3),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.storefront_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Text content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title!,
                              style: TextStyle(
                                color: widget.textColor ?? Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.subtitle!,
                              style: TextStyle(
                                color: (widget.textColor ?? Colors.black87).withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Full width "Post an Item" button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _isPressed 
                          ? (widget.buttonColor ?? const Color(0xFF2196F3)).withOpacity(0.9)
                          : (widget.buttonColor ?? const Color(0xFF2196F3)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _isPressed ? [] : [
                        BoxShadow(
                          color: (widget.buttonColor ?? const Color(0xFF2196F3)).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: _onPostPressed,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Post an Item',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
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
            ),
          ),
        );
      },
    );
  }
}