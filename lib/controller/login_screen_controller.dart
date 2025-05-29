import 'package:flutter/widgets.dart';
import 'package:interview_task/helpers/db_helper.dart';

class LoginScreenController with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  void login({required BuildContext context}) {
    DbHelper.fetchUser(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  void visibilityOff() {
    obscure = !obscure;
    notifyListeners();
  }
}
