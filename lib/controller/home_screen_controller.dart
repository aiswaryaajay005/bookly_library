import 'package:flutter/material.dart';
import 'package:interview_task/helpers/db_helper.dart';
import 'package:interview_task/model/books_res_model.dart';
import 'package:interview_task/service/home_screen_service.dart';

class HomeScreenController extends ChangeNotifier {
  List<Book> booksList = [];
  bool isLoading = false;
  Future<void> fetchBooks() async {
    isLoading = true;
    notifyListeners();
    final response = await HomeScreenService.fetchBooks();
    booksList = response?.results ?? [];
    isLoading = false;
    notifyListeners();
  }
}
