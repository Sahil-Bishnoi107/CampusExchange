import 'dart:convert';

import 'package:ecommerceapp/Models/User.dart';
import 'package:ecommerceapp/services/ItemServices.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier{
 UserModel user = UserModel( userId: "anything", username: "User ", email: "campusExchange@xyz.com",address: "Mars",phone: "provide you phone number",university: "-");
 
 //TO GET THE CURRENT USER
 Future<void> getUser() async{
  final supabase = Supabase.instance.client;
  final currentuser = supabase.auth.currentUser;
  final id = currentuser!.id;
  final url = Uri.parse("${baseurl}/api/item/me/${id}");
  try{
    final response = await http.get(url);
    if(response.statusCode == 200){
      final rawjson = jsonDecode(response.body);    
      user = UserModel.fromJson(rawjson);
      print("üser found");
    }
    else{
      print("could not get user with error ${response.statusCode}");
    }
    notifyListeners();
  }
  catch(e){print("failsed to fetch user with exception ${e}");}

 }

}