import 'package:flutter/material.dart';
import 'package:interview_task/controller/home_screen_controller.dart';
import 'package:interview_task/helpers/db_helper.dart';
import 'package:interview_task/view/book_details_screen/book_details_screen.dart';
import 'package:interview_task/view/search_screen/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<int, bool> favoritesMap = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().fetchBooks();
      final books = context.read<HomeScreenController>().booksList;
      for (var book in books) {
        if (book.id != null) {
          bool isFav = await DbHelper.isBookFavorited(book.id!);
          setState(() {
            favoritesMap[book.id!] = isFav;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState = context.watch<HomeScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.green,
        title: const Text(
          'Bookly',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          screenState.isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: screenState.booksList.length,
                  itemBuilder: (context, index) {
                    final book = screenState.booksList[index];
                    final imageUrl = book.formats?['image/jpeg'] ?? '';

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BookDetailsScreen(
                                  bookId: screenState.booksList[index].id!,
                                ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.green),
                        ),
                        color: Colors.white,

                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(
                                imageUrl,
                                fit: BoxFit.fill,
                                height: 150,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                book.title ?? 'No Title',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                book.authors?.isNotEmpty == true
                                    ? book.authors![0].name ?? 'Unknown Author'
                                    : 'Unknown Author',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  favoritesMap[book.id] == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  final isFav = favoritesMap[book.id] == true;
                                  if (isFav) {
                                    await DbHelper.removeFavourite(
                                      bookId: book.id!,
                                      context: context,
                                    );
                                  } else {
                                    await DbHelper.addFavourite(
                                      bookId: book.id!,
                                      context: context,
                                    );
                                  }

                                  setState(() {
                                    favoritesMap[book.id!] = !isFav;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                ),
              ),
        ],
      ),
    );
  }
}
