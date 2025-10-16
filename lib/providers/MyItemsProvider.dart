import 'dart:convert';

import 'package:ecommerceapp/Models/ProductModel.dart';
import 'package:ecommerceapp/Models/ReviewModel.dart';
import 'package:ecommerceapp/services/ItemServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class Myitemsprovider extends ChangeNotifier {
   List<ProductItem> myItems = [];
   List<ProductItem> searcheditems = []; 
   List<ProductItem> soldItems = [];
   List<ProductItem> purchasedItems = [];
   List<ProductItem> mypurchaseditems = [];
   List<ProductItem> mysolditems = [];

   //GET LIST OF ITEMS
   void getlistofmyitems() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  final id = user?.id ?? "noi";
  
  final url = Uri.parse("$baseurl/api/item/user/pendingitems/$id");
  
  try {
    final response = await http.get(url);
    if(response.statusCode == 200){
      final responebody = jsonDecode(response.body);
      List<ProductItem> templist = [];
      for(var v in responebody){
        final tempitem = ProductItem.fromJson(v);
        templist.add(tempitem);
      }
      myItems = templist;
      notifyListeners();
      
    }
    else{
      print("ERROR: HTTP ${response.statusCode} - ${response.body}");
    }
  }
  catch(e){
    print("EXCEPTION: Failed to fetch the list with exception $e");
  }
}

//DELETE ITEMS
   void deleteItem(String id)async{
     final url = Uri.parse("$baseurl/api/item/$id");
     try{
      final res = await http.delete(url);
      if(res.statusCode == 200){print("item deleted");
      
      }
      else{print("failed to delete the item");}
     }
     catch(e){
      print("Could not delete the Item with Exception $e");
     }
   }

Future<void> vectorSearch(String text) async{
  final url = Uri.parse("$baseurl/api/item/search").replace(
  queryParameters: {'query': text},
    );

  try{
    final response = await http.get(url);
  if(response.statusCode == 200){
    print("vector search successful");
    final rawJson = jsonDecode(response.body);
    List<ProductItem> templist = [];
      for(var v in rawJson){
        final tempitem = ProductItem.fromJson(v);
        templist.add(tempitem);
        print(tempitem.title);
      }
      searcheditems = templist;
      notifyListeners();
  }
  else{
    print("couldnt load search items with satus code ${response.statusCode}");
  }
  }
  catch(e){
    print("could not search the item due to exception $e");
  }
}

// GET LIST OF SOLD ITEMS
   void getlistofSolditems() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  final id = user?.id ?? "noi";
  
  final url = Uri.parse("$baseurl/api/item/user/solditems/$id");
  
  try {
    final response = await http.get(url);
    if(response.statusCode == 200){
      final responebody = jsonDecode(response.body);
      List<ProductItem> templist = [];
      for(var v in responebody){
        final tempitem = ProductItem.fromJson(v);
        templist.add(tempitem);
      }
      soldItems = templist;
      notifyListeners();
      
    }
    else{
      print("ERROR: HTTP ${response.statusCode} - ${response.body}");
    }
  }
  catch(e){
    print("EXCEPTION: Failed to fetch the list with exception $e");
  }
}

   void getlistofPurchaseditems() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  final id = user?.id ?? "noi";
  
  final url = Uri.parse("$baseurl/api/item/user/solditems/$id");
  
  try {
    final response = await http.get(url);
    if(response.statusCode == 200){
      final responebody = jsonDecode(response.body);
      List<ProductItem> templist = [];
      for(var v in responebody){
        final tempitem = ProductItem.fromJson(v);
        templist.add(tempitem);
      }
      purchasedItems = templist;
      notifyListeners();
      
    }
    else{
      print("ERROR: HTTP ${response.statusCode} - ${response.body}");
    }
  }
  catch(e){
    print("EXCEPTION: Failed to fetch the list with exception $e");
  }
}

// GET LIST OF ITEMS PURCHASED BY ME
void getpurchaseditemsbyme() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  final id = user?.id ?? "noi";
  
  final url = Uri.parse("$baseurl/api/item/purchased/$id");
  
  try {
    final response = await http.get(url);
    if(response.statusCode == 200){
      final responebody = jsonDecode(response.body);
      List<ProductItem> templist = [];
      for(var v in responebody){
        final tempitem = ProductItem.fromJson(v);
        templist.add(tempitem);
      }
      mypurchaseditems = templist;
      notifyListeners();
      
    }
    else{
      print("ERROR: HTTP ${response.statusCode} - ${response.body}");
    }
  }
  catch(e){
    print("EXCEPTION: Failed to fetch purchased items with exception $e");
  }
}

// GET LIST OF ITEMS SOLD BY ME
void getsolditemsbyme() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  final id = user?.id ?? "noi";
  
  final url = Uri.parse("$baseurl/api/item/sold/$id");
  
  try {
    final response = await http.get(url);
    if(response.statusCode == 200){
      final responebody = jsonDecode(response.body);
      List<ProductItem> templist = [];
      for(var v in responebody){
        final tempitem = ProductItem.fromJson(v);
        templist.add(tempitem);
      }
      mysolditems = templist;
      notifyListeners();
      
    }
    else{
      print("ERROR: HTTP ${response.statusCode} - ${response.body}");
    }
  }
  catch(e){
    print("EXCEPTION: Failed to fetch sold items with exception $e");
  }
}
  
}