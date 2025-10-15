import 'package:ecommerceapp/screens/HomePage.dart';
import 'package:ecommerceapp/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

// ✅ Signup with Email (NO navigation here)
Future<void> signUpWithEmail({
  required String email,
  required String password,
}) async {
  final box = Hive.box("UserData");
  try {
    print('Attempting signup for: $email');

    final s.AuthResponse res = await s.Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );

    if (res.user != null) {
      print(' Signup successful for $email');
      if (res.session != null) {
        String jwt = res.session!.accessToken;
        box.put("jwt", jwt);
        box.put("user_email", email);
        print('JWT saved successfully $jwt');
      } else {
        print('ℹ️ Signup successful but no active session (check email confirmation)');
      }
    } else {
      print('❌ Signup failed - no user created');
    }
  } catch (e) {
    print('❌ Signup error: ${e.toString()}');
  }
}

// ✅ Sign in with Email (navigates to Homepage on success)
Future<void> signInWithEmail({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  final box = Hive.box("UserData");
  try {
    print('Attempting signin for: $email');

    final s.AuthResponse res =
        await s.Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (res.user != null && res.session != null) {
      print('✅ Sign in successful!');
      String jwt = res.session!.accessToken;
      box.put("jwt", jwt);
      box.put("user_email", email);
      print('JWT saved successfully $jwt');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Mainscreen()),
      );
    } else {
      print('❌ Sign in failed - no session');
    }
  } catch (e) {
    print('❌ Sign in error: ${e.toString()}');
    if (e.toString().contains('Invalid login credentials')) {
      print('💡 Wrong email or password');
    } else if (e.toString().contains('Email not confirmed')) {
      print('💡 Please confirm your email first');
    }
  }
}

// ✅ Sign in with Google (navigates after success)
Future<void> signInWithGoogle(BuildContext context) async {
  try {
    await s.Supabase.instance.client.auth.signInWithOAuth(
      s.OAuthProvider.google,
    );
    print("✅ Google sign-in flow started");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Mainscreen()),
    );
  } catch (e) {
    print("❌ Google sign-in error: $e");
  }
}

// ✅ Sign in with Facebook (navigates after success)
Future<void> signInWithFacebook(BuildContext context) async {
  try {
    await s.Supabase.instance.client.auth.signInWithOAuth(
      s.OAuthProvider.facebook,
    );
    print("✅ Facebook sign-in flow started");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Mainscreen()),
    );
  } catch (e) {
    print("❌ Facebook sign-in error: $e");
  }
}

Future<void> notavailable() async{
}