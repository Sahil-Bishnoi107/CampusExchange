import 'package:ecommerceapp/Models/ReviewModel.dart';
import 'package:flutter/material.dart';

class Reviewsprovider extends ChangeNotifier {
  int fiveStars = 0;
  int fourStars = 0;
  int threeStars = 0;
  int twoStars = 0;
  int oneStars = 0;
  int totalReviews = 0;
  double averageRating = 0;

  List<Review> reviewList = [
    Review(
      userId: "1",
      userName: "Sophia Carter",
      userImageUrl: "https://i.pravatar.cc/150?img=47",
      rating: 5,
      comment:
          "Absolutely love this product! It's exactly what I was looking for and the quality is top-notch. Highly recommend!",
      reviewDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Review(
      userId: "2",
      userName: "Ethan Bennett",
      userImageUrl: "https://i.pravatar.cc/150?img=12",
      rating: 4,
      comment: "Good quality overall, but delivery was a bit slow.",
      reviewDate: DateTime.now().subtract(const Duration(days: 60)),
    ),
    Review(
      userId: "3",
      userName: "Mia Johnson",
      userImageUrl: "https://i.pravatar.cc/150?img=32",
      rating: 3,
      comment: "Product is okay, but I expected better packaging.",
      reviewDate: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ];

  void fetchReviews(String itemid) {
    fiveStars = 0;
    fourStars = 0;
    threeStars = 0;
    twoStars = 0;
    oneStars = 0;
    totalReviews = 0;
    averageRating = 0;

    if (reviewList.isEmpty) {
      notifyListeners();
      return;
    }

    double totalScore = 0;

    for (var review in reviewList) {
      totalReviews++;
      totalScore += review.rating;

      switch (review.rating.round()) {
        case 5:
          fiveStars++;
          break;
        case 4:
          fourStars++;
          break;
        case 3:
          threeStars++;
          break;
        case 2:
          twoStars++;
          break;
        case 1:
          oneStars++;
          break;
      }
    }

    averageRating = totalReviews > 0 ? totalScore / totalReviews : 0.0;

    notifyListeners();
  }
}
