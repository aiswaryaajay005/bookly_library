import 'package:interview_task/helpers/api_helper.dart';
import 'package:interview_task/model/books_res_model.dart';

class SearchScreenService {
  static Future<BooksResModel?> searchBook({required String query}) async {
    final resBody = await ApiHelper.getData(
      endpoint: "/books/?search=${query}",
    );
    if (resBody != null) {
      final resModel = booksResModelFromJson(resBody as String);
      return resModel;
    } else {
      // Handle the error case
      print('Error fetching search results');
      return null;
    }
  }
}
