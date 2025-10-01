class ProductItem {
  final userId;
  final String imageUrl;
  final String title;
  final int price;
  final String description;
  final String address;
  final String category;
  final itemid;
  final postedDate;
  final userName;
  final userImageUrl;
  final condition;
  final double rating;

  ProductItem({
    required this.userId,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    required this.address,
    required this.category,
    required this.itemid,
    required this.postedDate,
    required this.condition,
    required this.userImageUrl,
    required this.userName,
    required this.rating
  });
  factory ProductItem.fromJson(Map<String,dynamic> mp){

    String imageurl = mp['imageurl'] ?? "whatever";
    String title = mp['title'] ?? "Product";
    int price = mp['price'] == null ? 0 : (mp['price'] as num).round();
    String description = mp['description'] ?? "This is a really cool item";
    String address = mp['address'] ?? "Mars";
    String category = mp['category'] ?? "None";
    final userid = mp['userid'] ?? "userid";
    final itemid = mp['itemid'] ?? "itemid";
    final posteddate = "5 September 2025";
    final username = "Sahil Bishnoi";
    final userimageurl = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face';
    final codition = "new";
    final double rating = mp['total_stars'] == null ? 1 : mp['stars_given']/(mp['total_stars']/5) ;
    return ProductItem(imageUrl: imageurl, title: title, price: price,description: description,address: address,category: category,userId: userid,itemid: itemid,postedDate: posteddate,condition: codition,userImageUrl: userimageurl,userName: username,rating: rating);
  }
}