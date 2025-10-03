class AuctionModel {
  final String userId;
  final String imageUrl;
  final String title;
  final String description;
  final String address;
  final String category;
  final String itemId;
  final String postedDate;
  final String condition;
  final String userImageUrl;
  final String userName;
  
  final int basePrice;
  final int currentPrice;
  final int increment;
  final String currentBidder;

  AuctionModel({
    required this.userId,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.address,
    required this.category,
    required this.itemId,
    required this.postedDate,
    required this.condition,
    required this.userImageUrl,
    required this.userName,
    required this.basePrice,
    required this.currentPrice,
    required this.increment,
    required this.currentBidder,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> mp) {
    String imageurl = mp['imageurl'] ?? "default_image_url";
    String title = mp['title'] ?? "Auction Item";
    String description = mp['description'] ?? "No description available";
    String address = mp['address'] ?? "Unknown";
    String category = mp['category'] ?? "General";
    final userid = mp['userid'] ?? "userid";
    final itemid = mp['itemid'] ?? "itemid";
    final posteddate = mp['posteddate'] ?? "5 September 2025";
    final username = mp['username'] ?? "Unknown User";
    final userimageurl = mp['userimageurl'] ??
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face';
    final condition = mp['condition'] ?? "new";

    int basePrice = mp['baseprice'] == null ? 0 : (mp['baseprice'] as num).round();
    int currentPrice = mp['currentprice'] == null ? basePrice : (mp['currentprice'] as num).round();
    int increment = mp['increment'] == null ? 0 : (mp['increment'] as num).round();
    String currentBidder = mp['currentbidder'] ?? "No bids yet";

    return AuctionModel(
      imageUrl: imageurl,
      title: title,
      description: description,
      address: address,
      category: category,
      userId: userid,
      itemId: itemid,
      postedDate: posteddate,
      condition: condition,
      userImageUrl: userimageurl,
      userName: username,
      basePrice: basePrice,
      currentPrice: currentPrice,
      increment: increment,
      currentBidder: currentBidder,
    );
  }
}
