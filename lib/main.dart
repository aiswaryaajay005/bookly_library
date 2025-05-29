import 'package:flutter/material.dart';
import 'package:interview_task/controller/book_details_screen_controller.dart';
import 'package:interview_task/controller/bottom_nav_controller.dart';
import 'package:interview_task/controller/home_screen_controller.dart';
import 'package:interview_task/controller/login_screen_controller.dart';
import 'package:interview_task/controller/profile_Screen_controller.dart';
import 'package:interview_task/controller/register_screen_controller.dart';
import 'package:interview_task/controller/saved_books_screen_controller.dart';
import 'package:interview_task/controller/search_screen_controller.dart';
import 'package:interview_task/helpers/db_helper.dart';
import 'package:interview_task/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initSupabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenController()),
        ChangeNotifierProvider(
          create: (context) => BookDetailsScreenController(),
        ),
        ChangeNotifierProvider(create: (context) => SearchScreenController()),
        ChangeNotifierProvider(create: (context) => LoginScreenController()),
        ChangeNotifierProvider(create: (context) => RegisterScreenController()),
        ChangeNotifierProvider(create: (context) => BottomNavController()),
        ChangeNotifierProvider(
          create: (context) => SavedBooksScreenController(),
        ),
        ChangeNotifierProvider(create: (context) => ProfileScreenController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
