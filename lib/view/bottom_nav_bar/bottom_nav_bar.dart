// lib/view/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:interview_task/controller/bottom_nav_controller.dart';
import 'package:interview_task/view/home_screen/home_screen.dart';
import 'package:interview_task/view/profile_screen/profile_screen.dart';
import 'package:interview_task/view/saved_books_screen/saved_books_screen.dart';
import 'package:interview_task/view/search_screen/search_screen.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const SavedBooksScreen(),
    Builder(
      builder: (context) {
        return ProfileScreen();
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navController = context.watch<BottomNavController>();

    return Scaffold(
      body: _screens[navController.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navController.currentIndex,
        onTap: navController.updateIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourite",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
