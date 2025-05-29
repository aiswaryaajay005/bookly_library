import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interview_task/utils/app_utils.dart';
import 'package:interview_task/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:interview_task/view/home_screen/home_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class DbHelper {
  static List<Map<String, dynamic>> transactionDetails = [];
  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: 'https://dzhyuvsfxdjwndeeycni.supabase.co',
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6aHl1dnNmeGRqd25kZWV5Y25pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ5NDYzMzgsImV4cCI6MjA2MDUyMjMzOH0.Qu6W9Dcmaqw2dFGF0gNVkZMaIf1alHpszUjz1b90FXo",
    );
  }

  static final SupabaseClient supabase = Supabase.instance.client;
  static Future<void> register({
    required password,
    required cpassword,
    required email,
    required name,
    required BuildContext context,
  }) async {
    try {
      final auth = await supabase.auth.signUp(password: password, email: email);
      final uid = auth.user!.id;
      AppUtils.showSnackBar(
        context: context,
        message: "Registration Successful. Go to Login Page",
      );
      log('Data added successfully');
      if (uid.isNotEmpty || uid != "") {
        addData(
          uid: uid,
          username: name,
          password: password,
          email: email,
          cpassword: cpassword,
        );
      }
    } catch (e) {
      log('Error: $e and enter same password in both fields');
    }
  }

  static Future<void> addData({
    required var uid,
    required String? username,
    required String? password,
    required String? email,
    required String? cpassword,
  }) async {
    if (password == cpassword) {
      try {
        await supabase.from('tbl_register').insert({
          'id': uid,
          'user_name': username,
          'user_email': email,

          'user_password': password,
        });
        log('Data added successfully');
      } catch (e) {
        log('Error: $e');
      }
    }
  }

  static Future<void> fetchUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res == null) {
        AppUtils.showSnackBar(
          message: "Invalid email or Password",
          context: context!,
        );
      }
      Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> addFavourite({
    required int bookId,
    required BuildContext context,
  }) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      await supabase.from('tbl_liked_books').insert({
        'user_id': userId,
        'book_id': bookId,
      });
      log("Book $bookId added to favorites.");
      AppUtils.showSnackBar(
        message: "Book Added to Favourites",
        context: context,
      );
    } catch (e) {
      log("Add Favorite Error: $e");
    }
  }

  static Future<bool> isBookFavorited(int bookId) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return false;

      final response =
          await supabase
              .from('tbl_liked_books')
              .select()
              .eq('user_id', userId)
              .eq('book_id', bookId)
              .maybeSingle();

      return response != null;
    } catch (e) {
      log("Check Favorite Error: $e");
      return false;
    }
  }

  static Future<List<int>> getFavourites() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final response = await supabase
          .from('tbl_liked_books')
          .select('book_id')
          .eq('user_id', userId);

      return (response as List).map((item) => item['book_id'] as int).toList();
    } catch (e) {
      log("Get Favorites Error: $e");
      return [];
    }
  }

  static Future<void> removeFavourite({
    required int bookId,
    required BuildContext context,
  }) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      await supabase
          .from('tbl_liked_books')
          .delete()
          .eq('user_id', userId)
          .eq('book_id', bookId);
      log("Book $bookId removed from favorites.");
      AppUtils.showSnackBar(
        message: "Book Removed from Favourites",
        context: context,
      );
    } catch (e) {
      log("Remove Favorite Error: $e");
    }
  }
}
