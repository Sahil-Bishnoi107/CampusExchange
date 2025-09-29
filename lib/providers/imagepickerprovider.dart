import 'package:flutter/material.dart';

class ImagePickerProvider extends ChangeNotifier{
  String imageUrl = "";
  void updateurl(String newurl){
    print(newurl);
   imageUrl = newurl;
   notifyListeners();
  }
  void resetImage(){
    imageUrl = "";
    notifyListeners();
  }
}