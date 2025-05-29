import 'package:flutter/material.dart';
import 'package:interview_task/helpers/db_helper.dart';
import 'package:interview_task/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:interview_task/view/login_screen/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((_) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthWrapper()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bookly",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.green,
              ),
            ),
            Text(
              "Organize, Explore and Enjoy Your Library",
              style: TextStyle(fontSize: 16, color: Colors.purple),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: DbHelper.supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = DbHelper.supabase.auth.currentSession;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading
        }

        if (session != null && session.user != null) {
          return BottomNavBar();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
