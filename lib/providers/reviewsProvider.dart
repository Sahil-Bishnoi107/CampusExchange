import 'dart:convert';

import 'package:ecommerceapp/Models/ReviewModel.dart';
import 'package:ecommerceapp/services/ItemServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class Reviewsprovider extends ChangeNotifier {
  int fiveStars = 0;
  int fourStars = 0;
  int threeStars = 0;
  int twoStars = 0;
  int oneStars = 0;
  int totalReviews = 0;
  double averageRating = 0;

  List<Review> reviewList = [
   
  ];

  void fetchReviews(String itemid) async{
    fiveStars = 0;
    fourStars = 0;
    threeStars = 0;
    twoStars = 0;
    oneStars = 0;
    totalReviews = 0;
    averageRating = 0;

    reviewList = [];
    List<Review> templist = [];
    try{
     final url = Uri.parse("${baseurl}/api/Item/reviews/${itemid}");
     final respose = await http.get(url);
     if(respose.statusCode == 200){
     final rawjson = jsonDecode(respose.body);
     for(var v in rawjson){
     final x = Review.fromJson(v);
     templist.add(x);
     }
     reviewList = templist;}
     else{
      print("failed in else");
     }
    }
    catch(e){print("could not load reviews with exception $e");}

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


  //PostReview
  Future<void> postReview(String itemid,int rating,String comment) async{
   final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  final id = user?.id ?? "noi";
  DateTime nowUtc = DateTime.now().toUtc();
  final url = Uri.parse("${baseurl}/api/Item/addreview");
  try{
  final res = await http.post(url,
  headers: {"Content-Type": "application/json"},
  body: jsonEncode({
    "itemid" : itemid,
    "username" : "John Doe",
    "profilepic": "https://randomuser.me/api/portraits/men/1.jpg",
    "userid" : id,
    "rating" : rating,
    "comment" : comment,
    "datetime" : nowUtc.toIso8601String()
  })
  );
  if(res.statusCode == 200){
    print("review posted successfully");
  }
  else{
    print("else fILED TO POST REVIEW with code ${res.statusCode}");
  }}
  catch(e){print("failed to post review with exception $e");}
  }
  
}
