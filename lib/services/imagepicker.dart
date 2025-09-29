import 'dart:io';
import 'package:ecommerceapp/providers/imagepickerprovider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';

// Simple image picker function that uploads to Cloudinary and returns URL
Future<void> uploadImage({
   String cloudName = "dxh6lmkrf",
   String uploadPreset = "unsigned_preset",
  ImageSource source = ImageSource.gallery,
  required BuildContext context
}) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  
  if (pickedFile == null) {
    return null;
  }
  
  final cloudinary = CloudinaryPublic(cloudName, uploadPreset, cache: false);
  
  try {
    CloudinaryResponse response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        pickedFile.path,
        resourceType: CloudinaryResourceType.Image,
      ),
    );
    
    context.read<ImagePickerProvider>().updateurl(response.secureUrl);
  } catch (e) {
    print("Couldn't upload image: $e");
    return null;
  }
}


