import 'dart:convert';

import 'package:interview_task/helpers/api_helper.dart';
import 'package:interview_task/model/books_res_model.dart';

class BookDetailsScreenService {
  Future<Book?> fetchBookDetails({required String id}) async {
    final resBody = await ApiHelper.getData(endpoint: "/books/$id");

    if (resBody != null) {
      return Book.fromJson(jsonDecode(resBody));
    }
    return null;
  }
}
