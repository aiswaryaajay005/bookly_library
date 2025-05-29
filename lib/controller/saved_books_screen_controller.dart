import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interview_task/helpers/db_helper.dart';
import 'package:interview_task/helpers/api_helper.dart';
import 'package:interview_task/model/books_res_model.dart';

class SavedBooksScreenController with ChangeNotifier {
  bool isLoading = false;
  List<Book> savedBooks = [];

  Future<void> fetchSavedBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      final bookIds = await DbHelper.getFavourites();
      log('Fetched book IDs: $bookIds');

      List<Book> fetchedBooks = [];

      for (int id in bookIds) {
        final response = await ApiHelper.getData(endpoint: '/books/$id');
        if (response != null) {
          final data = jsonDecode(response);
          final book = Book.fromJson(data);
          fetchedBooks.add(book);
        }
      }

      savedBooks = fetchedBooks;
    } catch (e) {
      log("Error loading saved books: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void deleteFavourite({required int bookId, required BuildContext context}) {
    DbHelper.removeFavourite(bookId: bookId, context: context);
    fetchSavedBooks();
    notifyListeners();
  }
}
