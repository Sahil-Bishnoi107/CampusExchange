import 'package:ecommerceapp/providers/AuctionProvider.dart';
import 'package:ecommerceapp/screens/AuctionInfoScreen.dart';
import 'package:ecommerceapp/screens/CreateAuctionPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auctionspage extends StatefulWidget {
  const Auctionspage({super.key});

  @override
  State<Auctionspage> createState() => _AuctionspageState();
}

class _AuctionspageState extends State<Auctionspage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Auctionprovider>().getAuctions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<Auctionprovider>(
      builder: (context, auctionProvider, child) {
        final auctions = auctionProvider.auctions;

        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                AuctionHeader(size: size),
                AuctionSearchBarWidget(size: size),
                Expanded(
                  child: AuctionsList(auctions: auctions, size: size),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAuctionPage()),
              );
            },
            backgroundColor: Colors.blue,
            icon: Icon(Icons.add, color: Colors.white),
            label: Text(
              'Sell',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AuctionHeader extends StatelessWidget {
  final Size size;

  const AuctionHeader({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: size.width * 0.06,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Auctions',
                style: TextStyle(
                  fontSize: size.width * 0.055,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.06),
        ],
      ),
    );
  }
}



class AuctionSearchBarWidget extends StatelessWidget {
  final Size size;

  const AuctionSearchBarWidget({Key? key, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to search page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.005,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.012,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey[600], size: size.width * 0.05),
            SizedBox(width: size.width * 0.03),
            Text(
              'Search auctions...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: size.width * 0.038,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for Search Page - Replace with your actual implementation
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Auctions'),
      ),
      body: Center(
        child: Text('Search Page - Implement your search functionality here'),
      ),
    );
  }
}

class AuctionsList extends StatelessWidget {
  final List<dynamic> auctions;
  final Size size;

  const AuctionsList({Key? key, required this.auctions, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (auctions.isEmpty) {
      return Center(
        child: Text(
          'No auctions available',
          style: TextStyle(
            fontSize: size.width * 0.04,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.01,
      ),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        return AuctionCard(
          auction: auctions[index],
          size: size,
        );
      },
    );
  }
}

class AuctionCard extends StatelessWidget {
  final dynamic auction;
  final Size size;

  const AuctionCard({Key? key, required this.auction, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to auction info page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuctionInfoPage(auction: auction),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    auction.imageUrl,
                    width: double.infinity,
                    height: size.height * 0.2,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: size.height * 0.2,
                        color: Colors.grey[300],
                        child: Icon(Icons.image,
                            size: 50, color: Colors.grey[600]),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: size.height * 0.015,
                  right: size.width * 0.03,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      auction.postedDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.032,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    auction.title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    '\$${auction.currentPrice}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}