import 'package:flutter/material.dart';
import 'package:interview_task/helpers/db_helper.dart';
import 'package:interview_task/model/books_res_model.dart';
import 'package:interview_task/service/search_screen_service.dart';

class SearchScreenController with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<Book> booksList = [];
  Set<int> favoriteBookIds = {};
  bool isLoading = false;

  void clearSearch() {
    searchController.clear();
    booksList = [];
    favoriteBookIds.clear();
    notifyListeners();
  }

  Future<void> fetchBooks() async {
    isLoading = true;
    notifyListeners();

    final response = await SearchScreenService.searchBook(
      query: searchController.text,
    );

    booksList = response?.results ?? [];

    final favIds = await DbHelper.getFavourites();
    favoriteBookIds = favIds.toSet();

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(Book book, BuildContext context) async {
    final bookId = book.id;
    if (bookId == null) return;

    if (favoriteBookIds.contains(bookId)) {
      await DbHelper.removeFavourite(bookId: bookId, context: context);
      favoriteBookIds.remove(bookId);
    } else {
      await DbHelper.addFavourite(bookId: bookId, context: context);
      favoriteBookIds.add(bookId);
    }

    notifyListeners();
  }

  bool isFavorited(int bookId) => favoriteBookIds.contains(bookId);
}
