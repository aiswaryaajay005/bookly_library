import 'package:flutter/material.dart';
import 'package:interview_task/controller/register_screen_controller.dart';
import 'package:interview_task/utils/app_utils.dart';
import 'package:interview_task/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenState = context.watch<RegisterScreenController>();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Bookly",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.green,
                    ),
                  ),

                  SizedBox(height: 8),
                  Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome aboard! Let's get started by creating your account. Just a few quick steps and you'll be all set!",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: screenState.nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: screenState.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: screenState.passwordController,
                    obscureText: screenState.obscured,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          screenState.obscured
                              ? Icons.visibility_off
                              : Icons.remove_red_eye_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          context
                              .read<RegisterScreenController>()
                              .toggleVisibility(isPasswordField: true);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: screenState.confirmPasswordController,
                    obscureText: screenState.obscure,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          screenState.obscure
                              ? Icons.visibility_off
                              : Icons.remove_red_eye_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          context
                              .read<RegisterScreenController>()
                              .toggleVisibility(isPasswordField: false);
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () async {
                        context.read<RegisterScreenController>().register(
                          context: context,
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
