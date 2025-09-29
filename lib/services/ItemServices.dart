import 'package:ecommerceapp/Models/ProductModel.dart';
import 'package:ecommerceapp/Models/ReviewModel.dart';
import 'package:ecommerceapp/providers/imagepickerprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';


String baseurl = "https://cc213e9ffa11.ngrok-free.app";
Future<void> postItem(String title,String des,int price,String category,String address,BuildContext context,String labels) async{
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;
  final imageurl = context.read<ImagePickerProvider>().imageUrl;
  if(user == null)return;
  final userid = user.id;
  final url = Uri.parse("$baseurl/api/item/create");
  try{
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id" : userid,
        "title": title,
        "des" : des,
        "price" : price,
        "imageurl" : imageurl,
        "category" : category,
        "address" : address,
        "labels" : labels
      })
    );
    if(response.statusCode == 200){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Post created successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
    else{
      print("couldnt post the item  ${response.statusCode}");
    }
  }
  catch(e,stack){
    print("couldnt post the item with exception $e");
    debugPrint("stack: $stack");
  }
}

Future<void> getListofReviews(ProductItem item,String username,String review,int stars) async{
     final url = Uri.parse("$baseurl/api/item/addreview");
     final supabase = Supabase.instance.client;
     final user = supabase.auth.currentUser;
     if(user == null) return ;
     final id =  user.id;
     try{
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: {
         "itemid" : item.itemid,
         "username" : username,
         "comment" : review,
         "rating" : stars,
         "userid":id,
        }
        );
        if(response.statusCode == 200){
          print("successfully posted review");
        }
     }
     catch(e){
      print("failed to post with exception $e");
     }
  }