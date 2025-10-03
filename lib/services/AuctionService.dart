import 'dart:convert';
import 'package:ecommerceapp/providers/imagepickerprovider.dart';
import 'package:ecommerceapp/services/ItemServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> createAuction(
  String title,
  String description,
  int basePrice,
  int increment,
  String category,
  String address,
  String condition,
  String label,
  BuildContext context,
) async {
  final supabase = Supabase.instance.client;
  final currentuser = supabase.auth.currentUser;
  final id = currentuser!.id;
  try {
 
    final url = Uri.parse("${baseurl}/api/Auction/createAuction");
    final imageurl = context.read<ImagePickerProvider>().imageUrl;
    
    final userId = id;
    

    final body = {
      "userid": userId,
      "title": title,
      "description": description,
      "imageurl": imageurl, 
      "category": category,
      "address": address,
      "baseprice": basePrice,
      "currentprice": basePrice, 
      "increment": increment,
      "currentbidder": null,
      "condition": condition,
      
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Auction created successfully!");
      // You can show snackbar or update provider state
    } else {
      print("Failed to create auction: ${response.body}");
    }
  } catch (e) {
    print("Error creating auction: $e");
  }
}