
import 'package:ecommerceapp/Models/AuctionModel.dart';
import 'package:ecommerceapp/providers/AuctionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuctionInfoPage extends StatefulWidget {
  final AuctionModel auction;
  const AuctionInfoPage({super.key, required this.auction});

  @override
  State<AuctionInfoPage> createState() => _AuctionInfoPageState();
}

class _AuctionInfoPageState extends State<AuctionInfoPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AuctionCardWidget(auction: widget.auction),
      ),
    );
  }
}

// AuctionInfoCard Widget
class AuctionCardWidget extends StatefulWidget {
  final AuctionModel auction;
  const AuctionCardWidget({Key? key, required this.auction}) : super(key: key);

  @override
  State<AuctionCardWidget> createState() => _AuctionCardWidgetState();
}

class _AuctionCardWidgetState extends State<AuctionCardWidget> {
  String? myUserId;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  void _getUserId() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      myUserId = user?.id;
    });
  }

  bool get isMyBid {
    return myUserId != null && widget.auction.currentBidder == myUserId;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Consumer<Auctionprovider>(
        builder: (context, value, child) =>  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: size.width * 0.06,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: size.width * 0.04),
                  Expanded(
                    child: Text(
                      'Auction Details',
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        
            // Auction Image
            Container(
              width: double.infinity,
              height: size.height * 0.35,
              child: Image.network(
                widget.auction.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 80, color: Colors.grey[600]),
                  );
                },
              ),
            ),
        
            Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time remaining badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, size: size.width * 0.04, color: Colors.blue),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          'Ends in ${widget.auction.postedDate}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
        
                  SizedBox(height: size.height * 0.02),
        
                  // Title
                  Text(
                    widget.auction.title,
                    style: TextStyle(
                      fontSize: size.width * 0.055,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
        
                  SizedBox(height: size.height * 0.015),
        
                  // Price boxes (Base Price, Bid Increment, Current Price)
                  Row(
                    children: [
                      Expanded(
                        child: PriceBox(
                          label: 'Base Price',
                          amount: widget.auction.basePrice,
                          size: size,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Expanded(
                        child: PriceBox(
                          label: 'Bid',
                          amount: widget.auction.increment,
                          size: size,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                      Expanded(
                        child: PriceBox(
                          label: 'Current',
                          amount: widget.auction.currentPrice,
                          size: size,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
        
                  SizedBox(height: size.height * 0.025),
        
                  // Condition badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: widget.auction.condition == 'new' 
                          ? Colors.green.withOpacity(0.1) 
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.auction.condition.toUpperCase(),
                      style: TextStyle(
                        color: widget.auction.condition == 'new' 
                            ? Colors.green 
                            : Colors.orange,
                        fontSize: size.width * 0.032,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
        
                  SizedBox(height: size.height * 0.02),
        
                  // Description
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    widget.auction.description,
                    style: TextStyle(
                      fontSize: size.width * 0.038,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
        
                  SizedBox(height: size.height * 0.02),
        
                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on, size: size.width * 0.05, color: Colors.grey[600]),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        widget.auction.address,
                        style: TextStyle(
                          fontSize: size.width * 0.038,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
        
                  SizedBox(height: size.height * 0.01),
        
                  // Category
                  Row(
                    children: [
                      Icon(Icons.category, size: size.width * 0.05, color: Colors.grey[600]),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        widget.auction.category,
                        style: TextStyle(
                          fontSize: size.width * 0.038,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
        
                  SizedBox(height: size.height * 0.03),
        
                  // Place Bid Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isMyBid ? null : () {
                        context.read<Auctionprovider>().updatebid(widget.auction.itemId);
                        context.read<Auctionprovider>().placeBid(widget.auction.itemId);
                
                        _showBidDialog(context, size);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isMyBid ? Colors.grey : Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        isMyBid ? 'Bid Placed' : 'Place Bid',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
        
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBidDialog(BuildContext context, Size size) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Place Bid'),
        content: Text(
          'Do you want to place a bid of \$${widget.auction.currentPrice + widget.auction.increment}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement bid placement logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bid placed successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

// Price Box Widget
class PriceBox extends StatelessWidget {
  final String label;
  final int amount;
  final Size size;
  final Color? color;

  const PriceBox({
    Key? key,
    required this.label,
    required this.amount,
    required this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: (color ?? Colors.blue).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (color ?? Colors.blue).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.03,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: size.height * 0.005),
          Text(
            '\$$amount',
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w700,
              color: color ?? Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}