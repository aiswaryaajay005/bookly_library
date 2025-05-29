import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreenController with ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  String userName = '';
  String userEmail = '';
  bool isLoading = false;

  Future<void> fetchUserDetails() async {
    try {
      isLoading = true;
      notifyListeners();

      final user = supabase.auth.currentUser;
      if (user == null) {
        log('No user logged in');
        isLoading = false;
        notifyListeners();
        return;
      }

      final response =
          await supabase
              .from('tbl_register')
              .select()
              .eq('id', user.id)
              .single();

      userName = response['user_name'] ?? '';
      userEmail = response['user_email'] ?? '';

      log('Fetched user: $userName - $userEmail');
    } catch (e) {
      log('Fetch User Details Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
