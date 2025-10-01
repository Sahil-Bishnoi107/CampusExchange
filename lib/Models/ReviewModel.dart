class Review {
  final String userId;
  final String userName;
  final String userImageUrl;
  final double rating;
  final String comment;
  final String datetime;
  

  Review({
    required this.userId,
    required this.userName,
    required this.userImageUrl,
    required this.rating,
    required this.comment,
    required this.datetime,
  });
  
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['userid'] ?? '',
      userName: json['username'] ?? '',
      userImageUrl: json['userimageurl'] ?? '',
      comment: json['comment'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      datetime: DateTime.tryParse(json['reviewdate'] ?? '') ??  json['datetime'] ?? DateTime.now().toIso8601String(),
    );
  }
}