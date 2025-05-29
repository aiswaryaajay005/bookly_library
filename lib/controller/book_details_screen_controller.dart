import 'package:flutter/widgets.dart';
import 'package:interview_task/model/books_res_model.dart';
import 'package:interview_task/service/book_details_screen_service.dart';

class BookDetailsScreenController with ChangeNotifier {
  bool isLoading = false;
  Book? bookDetails;

  Future<void> fetchBookDetails({required String bookId}) async {
    isLoading = true;
    notifyListeners();

    try {
      final res = await BookDetailsScreenService().fetchBookDetails(id: bookId);
      debugPrint("Fetched Book: $res");

      if (res != null) {
        bookDetails = res;
      } else {
        debugPrint("Book not found");
      }
    } catch (e) {
      debugPrint("Error fetching book details: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
