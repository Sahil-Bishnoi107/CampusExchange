import 'dart:convert';
import 'package:ecommerceapp/providers/imagepickerprovider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ecommerceapp/Models/AuctionModel.dart';
import 'package:ecommerceapp/services/ItemServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auctionprovider extends ChangeNotifier {
  List<AuctionModel> auctions = [];
  


  Future<void> getAuctions() async{
   final url = Uri.parse("${baseurl}/api/Auction/getAllAuctions");
   try{
    final res = await http.get(url);
    if(res.statusCode == 200){
      final rawlist = jsonDecode(res.body);
      List<AuctionModel> templist = [];
      for(var v in rawlist){
         final x = AuctionModel.fromJson(v);
         templist.add(x);
      }
      auctions = templist;
      print("successfully fetched the data of auctions");
    }
    else{
      print("could not get the auctions with status code ${res.statusCode}");
    }
    notifyListeners();
   }
   catch(e){
    print("could not get data with exception $e");
   }
  }

 Future<void> placeBid(String itemid) async{
  final supabase = Supabase.instance.client;
  final currentuser = supabase.auth.currentUser;
  final id = currentuser!.id;
  final url = Uri.parse("${baseurl}/api/Auction/update");
   try{
    final res = await http.put(url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "userid" : id, "itemid": itemid
    })
    );
    if(res.statusCode == 200){
      print("successfully fetched the data of auctions");
    }
    else{
      print("could not get the auctions with status code ${res.statusCode}");
    }
    notifyListeners();
   }
   catch(e){
    print("could not get data with exception $e");
   }

 }


}

