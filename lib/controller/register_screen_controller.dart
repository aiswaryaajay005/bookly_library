import 'package:flutter/widgets.dart';
import 'package:interview_task/helpers/db_helper.dart';

class RegisterScreenController with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscured = true;
  bool obscure = true;
  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void register({required BuildContext context}) {
    DbHelper.register(
      password: passwordController.text,
      cpassword: confirmPasswordController.text,
      email: emailController.text,
      name: nameController.text,
      context: context,
    );
    clearFields();
    notifyListeners();
  }

  void toggleVisibility({required bool isPasswordField}) {
    if (isPasswordField) {
      obscured = !obscured;
    } else {
      obscure = !obscure;
    }
    notifyListeners();
  }
}
