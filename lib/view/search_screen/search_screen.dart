import 'package:flutter/material.dart';
import 'package:interview_task/controller/search_screen_controller.dart';
import 'package:interview_task/view/book_details_screen/book_details_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final screenState = context.watch<SearchScreenController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: screenState.searchController,
                decoration: InputDecoration(
                  hintText: 'Search for books',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      context.read<SearchScreenController>().fetchBooks();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: (value) {
                  context.read<SearchScreenController>().fetchBooks();
                },
              ),
            ),
            if (screenState.booksList.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text("No results. Try searching."),
              )
            else
              Expanded(
                child:
                    screenState.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
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
                                        (context) =>
                                            BookDetailsScreen(bookId: book.id!),
                                  ),
                                );
                              },

                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.broken_image),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        book.title ?? 'No Title',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        book.authors?.isNotEmpty == true
                                            ? book.authors![0].name ??
                                                'Unknown Author'
                                            : 'Unknown Author',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        screenState.isFavorited(book.id!)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:
                                            screenState.isFavorited(book.id!)
                                                ? Colors.green
                                                : Colors.grey,
                                      ),
                                      onPressed: () {
                                        screenState.toggleFavorite(
                                          book,
                                          context,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
          ],
        ),
      ),
    );
  }
}
