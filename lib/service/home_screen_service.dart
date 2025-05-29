import 'package:interview_task/helpers/api_helper.dart';
import 'package:interview_task/model/books_res_model.dart';

class HomeScreenService {
  static Future<BooksResModel?> fetchBooks() async {
    final resBody = await ApiHelper.getData(endpoint: "/books");

    if (resBody != null) {
      final resModel = booksResModelFromJson(resBody);
      return resModel;
    } else {
      return null;
    }
  }
}
