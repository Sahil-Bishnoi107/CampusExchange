import 'package:ecommerceapp/providers/MyItemsProvider.dart';
import 'package:ecommerceapp/providers/imagepickerprovider.dart';
import 'package:ecommerceapp/providers/reviewsProvider.dart';
import 'package:ecommerceapp/screens/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://oupujjxocfjhjauajdvl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91cHVqanhvY2ZqaGphdWFqZHZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY4MzY5MTUsImV4cCI6MjA3MjQxMjkxNX0.XqSKUfRwdcLb-VFt38ll8VIy3gRNPa_4sNmCl00xxew',
  );
  await Hive.initFlutter();
  await Hive.openBox('UserData');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
      ChangeNotifierProvider(create: (_) => Myitemsprovider()),
      ChangeNotifierProvider(create: (_) => Reviewsprovider())
    ],
    child: const MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito' 
      ),
      home: LoginPage(),
    );
  }
}